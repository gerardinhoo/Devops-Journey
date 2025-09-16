# 🚀 DevOps Journey

![GitHub last commit](https://img.shields.io/github/last-commit/gerardinhoo/Devops-Journey)
![CI](https://img.shields.io/badge/CI-GitHub_Actions-informational)
![IaC](https://img.shields.io/badge/IaC-Terraform-blue)
![Containers](https://img.shields.io/badge/Containers-Docker-blueviolet)

---

Welcome to my **DevOps learning journey**. This is a collection of hands-on projects to build and showcase skills in automation, scripting, CI/CD, and cloud engineering.

---

## 📊 Visual Roadmap

```
flowchart TD
  A[Start: Bash Fundamentals] --> B[Linux + EC2 Setup]
  B --> C[Nexus 3 Setup]
  C --> D[Nexus Demo App (Maven Deployment)]
  D --> E[GCP Infra with Terraform]
  E --> F[Dockerized Node.js API]
  F --> G[Flask App in Docker]
  G --> H[Microservices Journey]
  H --> I[Jenkins Work]
  I --> J[GitHub Actions Workflows]
  J --> K[AWS Services]
  K --> L[Kubernetes Deployments]
  L --> M[Ansible Automation]
  M --> N[Prometheus + Grafana]
  N --> O[Python Automation Scripts]
  O --> P[Centralized Logging & Observability]
  P --> Q[Secrets Management]
```

---

## 📁 Projects

### 🐚 [Bash Fundamentals](./bash_fundamentals)

Mastering the essentials of Bash scripting:

- Variables and user input
- Arithmetic operations
- Conditionals, loops, and functions
- File handling with condition checks

➡️ [Detailed README](./bash_fundamentals/README.md)

---

### 🐧 [Linux + EC2 Setup](./linux_devops)

Hands-on setup of an Ubuntu EC2 instance with secure SSH access and Linux practice.

- Launching EC2 and connecting via SSH + `.pem`
- Creating an SSH config for quick access
- VS Code Remote-SSH integration
- Practicing Linux commands (`pwd`, `ls`, `mkdir`, `rm -rvf`, etc.)

➡️ [Detailed README](./linux_devops/README.md)

---

### ☕ [Nexus Demo App (Maven Deployment)](./nexus-demo-app)

A simple Java/Maven project deployed to **Nexus Repository**.

- `pom.xml` + `settings.xml` configuration
- Using `mvn clean deploy` to upload artifacts
- Demonstrating private artifact repository management

➡️ [Detailed README](./nexus-demo-app/README.md)

---

### 📦 [Nexus 3 Setup](./maven-nexus)

Step-by-step **Nexus 3 installation** on Ubuntu EC2:

- Install & configure Nexus
- Create system service
- Hosted, proxy, and group repositories

➡️ [Detailed README](./maven-nexus/README.md)

---

### ☁️ [GCP Infrastructure with Terraform](./gcp-terraform-infra)

Provisioning GCP resources using **Terraform**:

- VPC, subnet, firewall, VM instance
- `main.tf`, `variables.tf`, `terraform.tfvars`, outputs
- Docker auto-install via `startup.sh`
- Remote backend with GCS + Terraform workspaces (dev/prod)

➡️ [Detailed README](./gcp-terraform-infra/README.md)

---

### 🐳 [Dockerized Node.js API](./simple-node-api)

Containerizing and deploying a Node.js/Express API to EC2.

- Dockerfile + build/run workflow
- Exposing port 3000 for public access
- Testing with browser & `curl`

➡️ [Detailed README](./simple-node-api/README.md)

---

### 🐍 [Flask App in Docker](./docker-python-flask)

Tiny **Flask API** running in Docker, with dev/prod Compose setups.

- `docker build` & `docker run` basics
- `docker compose up` for multi-env orchestration

➡️ [Detailed README](./docker-python-flask/README.md)

---

### 🧩 [Microservices Journey](./microservices)

Learning **Monolith → Microservices** via a ShopLite demo app.

- **Monolith**: Node/Express app with users & orders in one codebase
- **Microservices**: Split into `users-svc` & `orders-svc`, wired with Docker Compose
- Added `/health` checks and service dependencies

➡️ [Detailed README](./microservices/README.md)

---

### ⚙️ [Jenkins Work](./Jenkins-Work)

Exploring **Jenkins CI/CD pipelines**:

- Freestyle and Pipeline jobs
- GitHub webhook integration
- Jenkinsfile with build/test/deploy stages
- Future: Trivy scans, SonarQube checks, Slack notifications

➡️ [Detailed README](./Jenkins-Work/README.md)

---

### ⚙️ [Github Actions](./gh-actions-node-docker)

CI/CD with **Github Actions CI/CD pipelines**:

- GitHub webhook integration
- Github Workflow with build/test/deploy stages

➡️ [Detailed README](./Jenkins-Work/README.md)

---

## 🧠 About

This repo serves as my **DevOps lab** to:

- Practice automation, IaC, and CI/CD
- Document hands-on progress
- Build a portfolio for DevOps/SRE interviews

---

## 📌 Roadmap

### ✅ Completed

- Bash scripting fundamentals
- Linux + EC2 setup
- Nexus 3 setup + artifact deployment
- GCP infra with Terraform (VM + Docker provisioning)
- Node.js app containerized + deployed to EC2
- Flask app containerized + Docker Compose (dev/prod)
- Monolith → Microservices refactor (users/orders services)
- Jenkins setup + initial pipelines
- GitHub Actions workflows for CI/CD

### 🚧 In Progress

- AWS Services (Cloud Computing)

### 🎯 Planned

- AWS services (EC2, S3, IAM, Lambda, RDS)
- Kubernetes deployments (EKS/GKE)
- Ansible automation (config management)
- Prometheus + Grafana monitoring stack
- Python automation scripts
- Centralized logging (EFK/ELK, OpenTelemetry)
- Secrets management (Vault, cloud-native solutions)

---

**Author:** [Gerard Eku](https://github.com/gerardinhoo)
