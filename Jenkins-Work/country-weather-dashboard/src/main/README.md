# Country & Weather Dashboard (Java Servlets + JSP)

A tiny Java UI web app to practice **core Java** and **classic Java web** concepts. Enter a country name to see its **flag, capital, population**, and **current weather**. You can also **save favorites** in your session.

Built to master Java basics first. Later we’ll wrap it with DevOps (Maven→Nexus, Jenkins, Docker, SonarQube, Trivy, Tomcat).

---

## ✨ Features

- Search by country name (e.g., `Ghana`, `France`, `United States`)
- Shows flag, capital, population, coordinates
- Fetches **live weather** for the capital (Open‑Meteo)
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
  - Open‑Meteo — current weather by latitude/longitude

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

## 🏗️ Architecture (MVC)

- **Model:** `CountryInfo`, `Weather` (simple POJOs with getters)
- **Services:** `CountryService` and `WeatherService` use Java `HttpClient` to call the external APIs and Jackson to parse JSON.
- **Controller:** `SearchServlet` handles `/search` GET/POST, wires services, manages session favorites, and forwards to JSPs.
- **View:** JSPs render data using **Expression Language** (EL) and **JSTL** tags (no scriptlets).

## 🚀 Getting Started

### Prerequisites

- Java 17+ (`java -version`)
- Maven 3.9+ (`mvn -v`)
- (Optional but recommended) VS Code with:
  - Extension Pack for Java
  - Maven for Java

### Run Locally (Jetty)

```bash
mvn clean package
mvn jetty:run
```

Open: <http://localhost:8080/>

Try a search like **Ghana** or **Togo**.

> The app uses a classic `web.xml` mapping for the servlet. If you change URLs or move the servlet, update `WEB-INF/web.xml` accordingly.

### Package a WAR

```bash
mvn clean package
# → target/country-weather-dashboard.war
```

You can deploy this WAR to any Servlet container (e.g., Tomcat 9/JDK17).

## 🔌 Endpoints

- `GET /` → `index.jsp` (search form)
- `GET /search?q=<country>` → Finds country + weather and renders `country.jsp`
- `POST /search?action=add|remove&name=<CountryName>` → Manage favorites then redirect to `favorites.jsp`
- `GET /favorites.jsp` → View current favorites (session-based)

## ⚙️ Configuration

- **APIs:** No API keys needed.
- **Port:** Jetty runs on **8080** by default (see `pom.xml` plugin config).
- **Network:** The server makes outbound HTTP calls to REST Countries and Open‑Meteo; ensure your environment allows it.

## 🧪 Testing (starter)

Add JUnit tests under `src/test/java` for:

- Parsing helpers
- Service methods (mocking HTTP responses)
- Simple servlet tests (using mock request/response)

Maven already includes `junit-jupiter` in `pom.xml`.

## 🧯 Troubleshooting

### 404 on `/search`

- Ensure `src/main/webapp/WEB-INF/web.xml` contains the mapping:
  ```xml
  <servlet>
    <servlet-name>SearchServlet</servlet-name>
    <servlet-class>com.ge.dashboard.web.SearchServlet</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>SearchServlet</servlet-name>
    <url-pattern>/search</url-pattern>
  </servlet-mapping>
  ```
- In `index.jsp`, the form should use the context path:
  ```jsp
  <form action="${pageContext.request.contextPath}/search" method="get">
  ```

### “private access” compile errors

Use getters in Java and JSP EL, e.g. `c.getLat()` in Java; `${country.lat}` in JSP (EL calls `getLat()` under the hood).

### JSTL / tag errors

Make sure `pom.xml` has:

```xml
<dependency>
  <groupId>javax.servlet</groupId>
  <artifactId>jstl</artifactId>
  <version>1.2</version>
</dependency>
```

## 🗺️ Roadmap (next)

- Add timeouts/retries in `HttpClient`
- Improve error states on the UI (API down, invalid country)
- Unit tests for services + JSP tag rendering
- (DevOps phase) Nexus publish, Jenkins pipeline, Docker (Tomcat base), Trivy, SonarQube, deployment

## 🙏 Acknowledgements

- Data from **REST Countries** and **Open‑Meteo**.
- Jetty Maven Plugin for fast local runs.

## 📜 License

MIT — Feel free to use and adapt for your learning.
