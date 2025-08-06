# 🚀 Simple Node API (Dockerized)

This is a simple Express-based Node.js API that responds with a welcome message. It's fully containerized using Docker and deployed on a real Ubuntu EC2 instance. The project is part of my DevOps learning journey practicing containerization, deployment, and remote server hosting.

---

## 🧪 API Endpoint

GET /

### Response:

🚀 Hello from Gerard's Simple Node API!

---

## 🛠️ Tech Stack

- Node.js
- Express.js
- Docker
- EC2 (Ubuntu)
- Security Groups (AWS)
- Remote Deployment with Public IP

---

## 📦 Project Structure

simple-node-api/
├── Dockerfile
├── package.json
├── index.js
└── README.md


---

## 📄 Dockerfile Overview

```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["npm", "start"]

🚀 How to Run (Locally)

# Clone the project
git clone https://github.com/gerardinhoo/simple-node-api.git
cd simple-node-api

# Build Docker image
docker build -t simple-node-api .

# Run the container locally
docker run -p 3000:8080 simple-node-api
Then visit: http://localhost:3000

🌐 How to Deploy on EC2 (Linux)

# Pull image from Docker Hub (after pushing it there)
docker pull gerardinhoo/simple-node-api

# Run the container with port mapping
sudo docker run -d -p 3000:8080 gerardinhoo/simple-node-api
Then visit: http://<YOUR_EC2_PUBLIC_IP>:3000

Ensure port 3000 is open in the EC2 security group (inbound rule).

🧠 What I Learned

How to dockerize a Node.js app

How to push Docker images to Docker Hub

How to run Docker containers on a remote EC2 instance

How to expose services publicly using port forwarding and security groups



🧰 Next Steps
 Add GitHub Actions for CI/CD pipeline

 Auto-build and deploy on Docker push






