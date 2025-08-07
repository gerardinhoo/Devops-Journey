# 🚀 Simple Node API (Dockerized & CI/CD Deployed)

This is a minimal Express-based Node.js API that responds with a welcome message. It's fully Dockerized, pushed to Docker Hub, and deployed to an Ubuntu EC2 instance using **GitHub Actions** CI/CD pipeline.

This project is part of my **DevOps Journey**, where I practiced containerization, CI/CD, remote deployment, and server configuration.

---

## 🔥 Live API Endpoint

```http
GET /

Response:

🚀 Hello from Gerard's Simple Node API!

🛠️ Tech Stack
Node.js + Express.js

Docker (image hosted on Docker Hub)

GitHub Actions (CI/CD)

EC2 (Ubuntu)

SSH Deployment

Security Groups

GCP alternative setup (WIP)

---

📁 Project Structure

simple-node-api/
├── Dockerfile
├── package.json
├── index.js
├── .github/workflows/deploy.yml
├── README.md
└── assets/
    ├── curl-localhost.png
    ├── ec2-browser.png
    ├── github-actions.png


🐳 Dockerfile Overview
Dockerfile

FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["npm", "start"]

💻 Run Locally

# Clone the project
git clone https://github.com/gerardinhoo/simple-node-api.git
cd simple-node-api

# Build Docker image
docker build -t simple-node-api .

# Run container locally
docker run -p 3000:8080 simple-node-api
Open: http://localhost:3000

🚀 CI/CD Deployment to EC2
✅ GitHub Actions Workflow
This project uses GitHub Actions to:

Build Docker image

Push to Docker Hub

SSH into EC2

Pull & deploy the new container

🧪 Sample Workflow (.github/workflows/deploy.yml):

name: Deploy to EC2 via SSH

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up SSH
        uses: webfactory/ssh-agent@v0.7.0
        with:
          ssh-private-key: ${{ secrets.EC2_SSH_KEY }}

      - name: Deploy to EC2
        run: |
          ssh -o StrictHostKeyChecking=no ubuntu@<YOUR_EC2_PUBLIC_IP> << 'EOF'
            cd ~/Devops-Journey/simple-node-api
            git pull origin main
            docker stop simple-node-api || true
            docker rm simple-node-api || true
            docker rmi gerardinhoo/simple-node-api || true
            docker pull gerardinhoo/simple-node-api
            docker run -d -p 80:8080 --name simple-node-api gerardinhoo/simple-node-api
          EOF
🌐 Access on EC2
Make sure port 80 is open in your EC2 security group.

After deployment, access your app at:

http://<YOUR_EC2_PUBLIC_IP>
✅ You should see:

🚀 Hello from Gerard's Simple Node API!

📸 Screenshots

✅ Live in Browser on EC2

![Deployed on EC2](./assets/ec2-browser.png)

✅ GitHub Actions Build + Deploy

![CI/CD successful](./assets/github-actions.png)

📚 What I Learned
✅ How to:

Dockerize a Node.js app

Push Docker images to Docker Hub

Run Docker containers on EC2

Set up SSH-based CI/CD with GitHub Actions

Expose public APIs with security group/firewall configuration

Troubleshoot network/firewall issues on GCP and AWS

🔜 Next Steps
 Add Prometheus + Grafana for monitoring

 Add logging with Winston/Morgan

 Explore multi-stage Docker builds

 Set up GCP VM as a secondary deployment (in progress)
```
