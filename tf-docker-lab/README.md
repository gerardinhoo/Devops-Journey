
# 🚀 Terraform Local Docker Lab  
*A simple project demonstrating how to use Terraform to provision and manage local Docker resources.*

---

## 📌 Overview  
This mini-project shows how Terraform can be used **outside of cloud environments** to manage infrastructure on a local machine.  
Using the Terraform **Docker provider**, this project:

- Creates a Docker network  
- Pulls the official `nginx` image  
- Runs an Nginx container attached to the network  
- Exposes it on port **8080**  
- Output the container name and local URL  

This demonstrates Infrastructure as Code using Terraform for **local infrastructure**, not just AWS/GCP/Azure.

---

## 🧱 Project Structure

```
tf-docker-lab/
├── main.tf
├── providers.tf
├── outputs.tf
└── README.md
```

---

## 🛠 Requirements

Make sure you have:

- **Terraform v1.0+**
- **Docker Desktop running** (Mac/Windows) or Docker Engine (Linux)
- Local Docker daemon reachable at `/var/run/docker.sock`

Verify Docker is running:

```bash
docker ps
```

---

## ⚙️ What Terraform Creates

### 1️⃣ Docker Network
```hcl
resource "docker_network" "app_net" {
  name = "tf-app-network"
}
```

### 2️⃣ Docker Image (nginx:latest)
```hcl
resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}
```

### 3️⃣ Docker Container
```hcl
resource "docker_container" "web" {
  name  = "tf-nginx"
  image = docker_image.nginx_image.name

  networks_advanced {
    name = docker_network.app_net.name
  }

  ports {
    internal = 80
    external = 8080
  }
}
```

### 4️⃣ Outputs
```hcl
nginx_container_name = tf-nginx
nginx_url            = http://localhost:8080
```

---

## 🚀 How to Run this Project

### 1. Initialize Terraform
```bash
terraform init
```

### 2. See what Terraform will create
```bash
terraform plan
```

### 3. Apply the configuration
```bash
terraform apply
```

Type **yes** when prompted.

### 4. Test the Nginx container
Open your browser:

```
http://localhost:8080
```

Or curl it:

```bash
curl http://localhost:8080
```

You should see the Nginx welcome page HTML.

---

## 🧹 Clean Up

To remove all Docker resources created by Terraform:

```bash
terraform destroy
```

---

## 📚 What This Project Demonstrates

- Understanding Terraform **beyond cloud providers**  
- Using Terraform to manage **local infrastructure**  
- Working with the **Docker provider (kreuzwerker/docker)**  
- Applying IaC concepts to Docker: image, network, container  
- End-to-end Terraform workflow: init → plan → apply → destroy  

A learning exercise project showing IaC skills.

---

## 👨‍💻 Author  
**Gerard Eklu**  
Terraform | Docker | DevOps | Cloud Engineer  
