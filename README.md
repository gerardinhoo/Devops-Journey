# 🚀 DevOps Journey

Welcome to my **DevOps learning journey**. A collection of hands-on practice projects to build foundational skills in automation, scripting, and cloud engineering.

---

## 📁 Projects

### 🐚 [Bash Fundamentals](./bash_fundamentals.sh)

A beginner-friendly project focused on mastering Bash scripting essentials.  
Includes examples of:

- Variables and user input
- Arithmetic operations
- Conditional statements
- Loops and functions
- File handling with condition checks

➡️ Detailed README inside: [`bash_fundamentals/README.md`](./bash_fundamentals/README.md)

---

### 🐧 [Linux + EC2 Setup](./linux-ec2-setup)

Hands-on setup of an Ubuntu EC2 instance using AWS, with secure SSH access and development via VS Code Remote.  
Also includes Linux command practice inspired by DevOps workflows.

Includes:

- Launching and connecting to EC2 (SSH + `.pem` key)
- Creating an SSH config for quick access
- Using VS Code Remote - SSH to work on EC2
- Practicing common Linux commands (`pwd`, `ls`, `mkdir`, `rm -rvf`, etc.)

➡️ Detailed README inside: [`linux_devops/README.md`](./linux_devops/README.md)

---

### ☕ [Nexus Demo App (Maven Deployment)](./nexus-demo-app)

A simple Java application created with Maven to demonstrate artifact deployment to a **hosted Nexus repository**.  
Covers full configuration from `pom.xml` to `.m2/settings.xml` and shows how to push `.jar` files to Nexus.

Includes:

- Maven `distributionManagement` configuration
- Nexus credentials setup in `settings.xml`
- Using `mvn clean deploy` to upload builds
- Practical use of Nexus as a private artifact repo

➡️ Detailed README inside: [`nexus-demo-app/README.md`](./nexus-demo-app/README.md)

---

### 📦 [Nexus 3 Installation & Setup](./maven-nexus)

Step-by-step guide to install and configure **Sonatype Nexus Repository Manager 3** on an Ubuntu EC2 instance.

Covers:

- Downloading and extracting Nexus
- Creating a `nexus` system user
- Setting permissions and configuring `nexus.rc`
- Creating a `systemd` service to run Nexus on boot
- Accessing the Nexus UI and retrieving the admin password

➡️ Detailed README inside: [`maven-nexus/README.md`](./maven-nexus/README.md)

---

### ☁️ [GCP Infrastructure with Terraform](./gcp-terraform-infra)

Provisioning and managing infrastructure on Google Cloud using **Terraform**, including:

- Creating a VPC, Subnet, Firewall, and VM Instance
- Writing `main.tf`, `variables.tf`, `terraform.tfvars`, and `outputs.tf`
- Automatically installing Docker on the VM via a `startup.sh` script
- SSH into the VM and verify provisioning
- Understand Terraform state, remote provisioning, and IaC best practices

➡️ Detailed README inside: [`gcp-terraform-infra/README.md`](./gcp-terraform-infra/README.md)

---

---

### 🐳 [Dockerized Node.js App Deployment (EC2)](./simple-node-api)

Containerized and deployed a simple Node.js API to an **Ubuntu EC2 instance** using Docker.  
This project demonstrates containerizing an Express server, exposing it to the public internet, and verifying it live from a browser.

Includes:

- A lightweight Express server (`index.js`)
- Dockerfile to build and run the app
- Exposing port 3000 and verifying container output
- `docker build`, `docker run`, and `docker ps` usage
- Browser-accessible output via EC2 Public IP (`http://<EC2_IP>:3000`)

➡️ Detailed README inside: [`simple-node-api/README.md`](./simple-node-api/README.md)

## 🧠 About

This repository serves as a personal DevOps lab to:

- Practice automation through scripting
- Document and share learning progress
- Prepare for DevOps/SRE job interviews

---

## 📌 What's next?

As I continue learning, this repo will grow to include:

This DevOps Journey is just getting started. Here's what's coming up:

- ✅ Dockerized Node.js app with custom image hosted on Docker Hub
- ✅ Manual EC2 deployment using SSH
- ✅ CI/CD pipeline using GitHub Actions
- 🚀 Monitoring with Prometheus + Grafana
- ☁️ GCP deployment using Terraform (WIP)
- 🔁 Health checks and auto-restarts via CI/CD
- 🐳 Multi-container orchestration with Docker Compose
- ☸️ Kubernetes deployment to GKE
- 📈 Log aggregation and metrics tracking
- 🛡️ Secrets management and environment hardening

Stay tuned as this repo evolves into a full-scale DevOps showcase.

Stay tuned!

---

**Author:** [Gerard Eku](https://github.com/gerardinhoo)
