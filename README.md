# 🚀 DevOps Projects

![GitHub last commit](https://img.shields.io/github/last-commit/gerardinhoo/Devops-Journey)
![CI](https://img.shields.io/badge/CI-GitHub_Actions-informational)
![IaC](https://img.shields.io/badge/IaC-Terraform-blue)
![Containers](https://img.shields.io/badge/Containers-Docker-blueviolet)

---

A collection of hands-on DevOps and cloud engineering projects covering infrastructure automation, CI/CD pipelines, containerization, observability, and cloud-native deployments across AWS and GCP.

---

## 📊 Project Map

```
flowchart TD
  A[GCP Infra with Terraform] --> B[GitHub Actions Workflows]
  B --> C[Jenkins CI/CD Pipelines]
  C --> D[Dockerized Node.js API]
  D --> E[Flask App in Docker]
  E --> F[Microservices Architecture]
  F --> G[AWS Services]
  G --> H[Nexus 3 + Artifact Management]
  H --> I[Ansible Automation]
  I --> J[Prometheus + Grafana]
  J --> K[Bash Scripting]
  K --> L[Linux + EC2 Provisioning]
```

---

## 📁 Projects

### ☁️ [GCP Infrastructure with Terraform](./gcp-terraform-infra)

Provisioned GCP resources using **Terraform**:

- VPC, subnet, firewall, VM instance
- `main.tf`, `variables.tf`, `terraform.tfvars`, outputs
- Docker auto-install via `startup.sh`
- Remote backend with GCS + Terraform workspaces (dev/prod)

➡️ [Detailed README](./gcp-terraform-infra/README.md)

---

### ⚙️ [GitHub Actions (Node + Docker + GHCR + EC2)](./gh-actions-node-docker)

CI/CD with **GitHub Actions**:

- CI: Node 20, `npm ci`, run tests
- Build & push Docker image to **GitHub Container Registry (GHCR)**
- CD: SSH to **EC2**, upload `compose.yml`, `docker compose up -d`
- Health check with retries and container logs on failure

[**Detailed README →**](./gh-actions-node-docker/README.md)
![CI/CD – gh-actions-node-docker](https://github.com/gerardinhoo/Devops-Journey/actions/workflows/ci-cd-gh-actions-node-docker.yml/badge.svg)

---

### ⚙️ [Jenkins CI/CD Pipelines](./Jenkins-Work)

**Jenkins CI/CD pipelines**:

- Freestyle and Pipeline jobs
- GitHub webhook integration
- Jenkinsfile with build/test/deploy stages
- Trivy scans, SonarQube checks, Slack notifications

➡️ [Detailed README](./Jenkins-Work/README.md)

---

### 🐳 [Dockerized Node.js API](./simple-node-api)

Containerized and deployed a Node.js/Express API to EC2.

- Dockerfile + build/run workflow
- Exposing port 3000 for public access
- Testing with browser & `curl`

➡️ [Detailed README](./simple-node-api/README.md)

---

### 🐍 [Flask App in Docker](./docker-python-flask)

**Flask API** running in Docker, with dev/prod Compose setups.

- `docker build` & `docker run` workflow
- `docker compose up` for multi-env orchestration

➡️ [Detailed README](./docker-python-flask/README.md)

---

### 🧩 [Microservices Architecture](./microservices)

**Monolith → Microservices** refactor via a ShopLite demo app.

- **Monolith**: Node/Express app with users & orders in one codebase
- **Microservices**: Split into `users-svc` & `orders-svc`, wired with Docker Compose
- Added `/health` checks and service dependencies

➡️ [Detailed README](./microservices/README.md)

---

### ☁️ [AWS Services](./aws-services)

AWS core services implementation:

- EC2: Virtual machines for compute workloads
- S3: Object storage for backups, logs, and static websites
- IAM: Identity & Access Management for users and roles
- Lambda: Serverless compute functions
- RDS: Managed relational database service

➡️ [Detailed README](./aws-services/README.md)

---

### 📦 [Nexus 3 Setup](./maven-nexus)

**Nexus 3 installation** on Ubuntu EC2:

- Install & configure Nexus
- Create system service
- Hosted, proxy, and group repositories

➡️ [Detailed README](./maven-nexus/README.md)

---

### ☕ [Nexus Demo App (Maven Deployment)](./nexus-demo-app)

Java/Maven project deployed to **Nexus Repository**.

- `pom.xml` + `settings.xml` configuration
- `mvn clean deploy` to upload artifacts
- Private artifact repository management

➡️ [Detailed README](./nexus-demo-app/README.md)

---

### 🐚 [Bash Scripting](./bash_fundamentals)

Core Bash scripting for automation and system administration:

- Variables and user input
- Arithmetic operations
- Conditionals, loops, and functions
- File handling with condition checks

➡️ [Detailed README](./bash_fundamentals/README.md)

---

### 🐧 [Linux + EC2 Provisioning](./linux_devops)

Ubuntu EC2 instance provisioning with secure SSH access.

- Launching EC2 and connecting via SSH + `.pem`
- Creating an SSH config for quick access
- VS Code Remote-SSH integration

➡️ [Detailed README](./linux_devops/README.md)

---

## 🧠 About

This repo contains end-to-end DevOps projects covering:

- Infrastructure automation with Terraform and Ansible
- CI/CD pipelines with GitHub Actions and Jenkins
- Containerization and deployment with Docker
- Observability with Prometheus and Grafana

---

**Author:** [Gerard Eklu](https://github.com/gerardinhoo)
