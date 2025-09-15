# Country & Weather Dashboard (Java Servlets + JSP)

A tiny Java UI web app to practice **core Java** and **classic Java web** concepts. Enter a country name to see its **flag, capital, population**, and **current weather**. You can also **save favorites** in your session.

Built to master Java basics first. Later we’ll wrap it with DevOps (Maven→Nexus, Jenkins, Docker, SonarQube, Trivy, Tomcat).

---

## ✨ Features

- Search by country name (e.g., `Ghana`, `France`, `United States`)
- Shows flag, capital, population, coordinates
- Fetches **live weather** for the capital (Open-Meteo)
- Add/remove **favorites** (session-based, no database yet)
- Clean **MVC** split: Servlets (controller), POJOs (model), JSP (view)

## 🧰 Tech Stack

- **Language:** Java 17
- **Web:** Servlets + JSP (with **EL/JSTL**)
- **Build:** Maven (WAR packaging)
- **Local server:** Jetty (via `jetty-maven-plugin`)
- **JSON:** Jackson `jackson-databind`
- **Free APIs:**
  - REST Countries — country metadata
  - Open-Meteo — current weather by latitude/longitude

## 📁 Project Structure

```
src/
  main/
    java/
      com/ge/dashboard/
        model/
          CountryInfo.java
          Weather.java
        service/
          CountryService.java
          WeatherService.java
        web/
          SearchServlet.java
    webapp/
      index.jsp
      country.jsp
      favorites.jsp
      styles.css
      WEB-INF/web.xml        # servlet mapping + welcome file
pom.xml
```

> In this repo, CI/CD assets live under `Jenkins-Work/country-weather-dashboard/` (Jenkinsfile, Dockerfile, etc).

## 🏗️ Architecture (MVC)

- **Model:** `CountryInfo`, `Weather` (simple POJOs with getters)
- **Services:** `CountryService` and `WeatherService` use Java `HttpClient` to call the external APIs and Jackson to parse JSON.
- **Controller:** `SearchServlet` handles `/search` GET/POST, wires services, manages session favorites, and forwards to JSPs.
- **View:** JSPs render data using **Expression Language** (EL) and **JSTL** tags (no scriptlets).

---

# ✅ What we added today (CI/CD + Containerized Tomcat)

### 1) Dockerized Tomcat deployment

We package the app into a WAR and ship it inside a Tomcat image.

**Dockerfile** (root of project or in `Jenkins-Work/country-weather-dashboard/`):

```dockerfile
FROM tomcat:9.0-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/country-weather-dashboard.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

Run on a server (e.g., EC2):

```bash
mvn -DskipTests package
docker build -t ge/country-weather:0.1.0 .
docker run -d --name country-weather --restart unless-stopped \
  -p 8082:8080 ge/country-weather:0.1.0
# visit http://<EC2_PUBLIC_IP>:8082/
```

Tomcat listens on **8080 in the container**; we map **host 8082 → container 8080** to avoid clashing with Jenkins (8080).

### 2) Jenkins Pipeline (build → test → analyze → publish → image → scan → deploy)

A **Declarative Jenkinsfile** at:

```
Jenkins-Work/country-weather-dashboard/Jenkinsfile
```

**Parameters**

- `RUN_SONAR` (default: true)
- `RUN_TRIVY` (default: true)
- `PUSH_IMAGE` (default: false)
- `DEPLOY` (default: true)

**Stages**

1. Checkout
2. Tool Versions (prints versions for Java/Maven/Docker)
3. Build & Unit Test (`mvn clean verify`)
4. **SonarQube Analysis** (`mvn sonar:sonar`) + **Quality Gate** (waits for OK)
5. Publish to **Nexus** (`mvn deploy` to `maven-snapshots`)
6. Pull WAR from Nexus (guarantees we use the built artifact)
7. Build Image (Docker)
8. Trivy Scan _(optional)_ — fails the build on **HIGH/CRITICAL**
9. Push Image _(optional to Docker Hub)_
10. Deploy (Dockerized Tomcat) → runs container on port **8082** on the Jenkins node

> Jenkins Tools required: JDK named `jdk17`, Maven named `maven-3.9`. Agent must have Docker and permission to run it (`sudo usermod -aG docker jenkins && sudo systemctl restart jenkins`).

### 3) Credentials (Jenkins → Manage Credentials)

| ID                | Kind                   | Used For                                 |
| ----------------- | ---------------------- | ---------------------------------------- |
| `sonar-token`     | Secret text            | SonarQube `-Dsonar.login` + Quality Gate |
| `nexus-user`      | Username/Password      | `<server>` in `.mvn-settings-nexus.xml`  |
| `dockerhub-creds` | Username/Password      | `docker login` / image push              |
| `slack-bot-token` | Secret text (optional) | Pipeline notifications                   |

### 4) SonarQube setup (quick)

- Create token: **SonarQube UI → User (top-right) → My Account → Security → Generate Token**
- Jenkins global config: **Manage Jenkins → System → SonarQube servers**
  - Name: `SonarQubeServer`
  - Server URL: `http://<EC2_PUBLIC_IP>:9000/`
  - **Server authentication token**: add a **Secret text** credential containing the token
- (Optional) If you analyze CSS/JS with Sonar, install Node.js on the agent (`node -v` must work).

### 5) Nexus setup (quick)

- Repos: `maven-releases` and `maven-snapshots` (hosted), `maven-public` (group).
- Jenkins uses a small `.mvn-settings-nexus.xml` to inject credentials and server IDs during `mvn deploy`.
- We deployed the WAR to **snapshots**, then pulled it back before building the image.

### 6) Quick smoke tests

From the server:

```bash
curl -I http://localhost:8082/
curl -I "http://localhost:8082/search?q=Ghana"
docker ps --format '{{.Names}}\t{{.Ports}}'
```

### 7) Webhook (GitHub → Jenkins)

Trigger pipeline automatically on each push.

**In Jenkins (one-time):**

- _Manage Jenkins → System_ → set **Jenkins URL** to `http://<EC2_PUBLIC_IP>:8080/`
- Job → **Configure** → **Build Triggers** → check **GitHub hook trigger for GITScm polling**

**In GitHub (repo Settings → Webhooks):**

- **Payload URL:** `http://<EC2_PUBLIC_IP>:8080/github-webhook/` (note trailing slash)
- **Content type:** `application/json`
- **Events:** Just the **push** event
- Save → **Redeliver/Ping** to see **200 OK**

Now any commit to `main` automatically builds, analyzes, publishes to Nexus, containerizes, (optionally scans & pushes), and deploys to:

```
http://<EC2_PUBLIC_IP>:8082/
```

### 8) .gitignore / .dockerignore tips

- **.gitignore** (repo): ignore build artifacts & IDE files
  ```
  target/
  *.class
  *.log
  .idea/
  .vscode/
  *.iml
  .DS_Store
  ```
- **.dockerignore**:
  - If your Dockerfile **copies the WAR from `target/`**, do **not** ignore `target/`.
  - If you switch to a **multi-stage Dockerfile**, you can safely ignore `target/`.

---

## 🚀 Getting Started (local dev via Jetty)

```bash
mvn clean package
mvn jetty:run
# open http://localhost:8080/
```

### Package a WAR

```bash
mvn clean package
# → target/country-weather-dashboard.war
```

## 🔌 Endpoints

- `GET /` → `index.jsp` (search form)
- `GET /search?q=<country>` → Finds country + weather and renders `country.jsp`
- `POST /search?action=add|remove&name=<CountryName>` → Manage favorites then redirect to `favorites.jsp`
- `GET /favorites.jsp` → View current favorites (session-based)

## ⚙️ Configuration

- **APIs:** No API keys needed.
- **Port:** Jetty runs on **8080**; containerized Tomcat runs on **8080** inside the container (mapped to 8082 on host).
- **Network:** The server makes outbound HTTP calls to REST Countries and Open-Meteo; ensure your environment allows it.

## 🧯 Troubleshooting

- **SonarQube 401 in `waitForQualityGate`:** verify Jenkins has the correct **Server authentication token** and that the server URL is reachable from Jenkins.
- **"node -v" missing during Sonar CSS/JS step:** install Node.js on the agent if you want front-end rules scanned.
- **Docker COPY fails for WAR:** Build the WAR first (`mvn -DskipTests package`). Ensure `.dockerignore` does not exclude `target/`.
- **Port in use (8080/8082):** Stop old container or change `-p host:container` mapping.
- **Jenkins `mvn` not found:** Use `tools { jdk 'jdk17'; maven 'maven-3.9' }` in the Jenkinsfile or configure Tools in Jenkins.
- **Docker permission denied in Jenkins:** `sudo usermod -aG docker jenkins && sudo systemctl restart jenkins`
- **Webhook not firing:** Check Jenkins URL, GitHub webhook URL `/github-webhook/`, Security Group for port 8080, and job has “GitHub hook trigger” enabled.

## 🗺️ Roadmap (next)

- Add a `/health` endpoint and readiness checks
- Wire **JaCoCo** coverage and publish to Sonar
- Multi-stage Dockerfile to slim the image
- Parameterize deploy port and container name
- Integration tests for the services

## 🙏 Acknowledgements

- Data from **REST Countries** and **Open-Meteo**.
- Jetty Maven Plugin for fast local runs.

## 📜 License

MIT — Feel free to use and adapt for your learning.
