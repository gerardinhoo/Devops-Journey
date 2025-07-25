# ☕ Nexus Demo App

This is a basic Java application generated using Maven's `quickstart` archetype. It was used to demonstrate artifact deployment to a private Nexus 3 repository hosted on an AWS EC2 instance.

---

## 🔧 Technologies Used

- Java 8 (OpenJDK)
- Apache Maven
- Nexus Repository Manager 3

---

## 🧪 How to Build the App

From the project root, run:

```bash
mvn clean install
This will compile the app and create a .jar file inside the target/ directory.

🚀 Deploy to Nexus
This project is configured to deploy artifacts to a hosted Nexus repository (maven-releases).

🔹 pom.xml Configuration
Make sure your pom.xml includes the following:

xml
Copy
Edit
<distributionManagement>
  <repository>
    <id>nexus</id>
    <url>http://<your-ec2-ip>:8081/repository/maven-releases/</url>
  </repository>
</distributionManagement>
Replace <your-ec2-ip> with your actual public IP address of the EC2 instance running Nexus.

🔹 settings.xml Authentication
Add your Nexus credentials to ~/.m2/settings.xml:

<servers>
  <server>
    <id>nexus</id>
    <username>admin</username>
    <password>your-password</password>
  </server>
</servers>

🔹 Deploy the Artifact
Run the following command:

bash
Copy
Edit
mvn clean deploy
Once successful, the .jar and .pom files will be uploaded to your Nexus repository and visible in the UI:

➡️ http://<your-ec2-ip>:8081/#browse/browse:maven-releases

🎯 Project Purpose
This app serves as a DevOps-ready artifact for practicing:

Private artifact repository management

Maven-to-Nexus deployments

Building blocks of real-world CI/CD pipelines

Author
Gerard Eku
github.com/gerardinhoo
