# 🐳 Simple Flask App — Dockerized

This project is a **basic Flask application** containerized with **Docker** and deployed on an **AWS EC2 instance**.  
It serves as part of my **DevOps Journey**, focusing on learning Docker, containerization, and deployment workflows.

---

## **📌 Features**
- Simple **Flask** application returning a greeting message
- Fully **containerized** using Docker
- Deployed on an **AWS EC2 instance**
- Bound to port **5000** and exposed publicly via **security group rules**

---

## **🛠 Tech Stack**
- **Language:** Python 3.11
- **Framework:** Flask
- **Containerization:** Docker
- **Cloud Hosting:** AWS EC2 (Ubuntu)
- **Port Binding:** 5000 → open in AWS Security Group

---

## **🚀 Getting Started**

### **Clone the Repository**
```bash
git clone https://github.com/<your-username>/Devops-Journey.git
cd Devops-Journey/docker-python-flask
```

# 🐳 Running with Docker
- **1.Build the Image:**
```bash
docker build -t flask-app .
```

- **2.Run the Container**
```bash
docker run -d -p 5000:5000 flask-app
```

- **3.Access the App**
```bash
Visit: http://localhost:5000
```

# ☁️ Deploying on AWS EC2

### Launch an EC2 Instance

 - OS: Ubuntu 22.04 (or later)
 - Instance Type: t2.micro (free tier)
 - Open port 5000 in the Security Group inbound rules

### Install Docker on EC2
```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
```

### Build & Run on EC2
```bash
git clone https://github.com/<your-username>/Devops-Journey.git
cd Devops-Journey/docker-python-flask
docker build -t flask-app .
docker run -d -p 5000:5000 flask-app
```

### Test on Public IP
```bash
http://<ec2-public-ip>:5000
```

# 🧰 Project Structure

Devops-Journey/docker-python-flask
```bash
│── app.py              # Flask application
│── Dockerfile          # Docker image definition
│── requirements.txt    # Python dependencies
└── README.md           # Project documentation
```

# 📌 Next Steps

✅ Add Docker Compose for multi-container setup (Flask + PostgreSQL / MongoDB)
✅ Set up environment variables securely
✅ Implement CI/CD pipeline with GitHub Actions
✅ Integrate monitoring with Prometheus + Grafana

Grafana

# 📜 License

This project is part of my DevOps Learning Journey. Feel free to fork and learn!


