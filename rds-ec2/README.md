# RDS + EC2 (Amazon Linux) Demo

This project demonstrates deploying a simple **Node.js + Express app** on an **Amazon Linux EC2 instance** that connects securely to a **MySQL database running on Amazon RDS**.

---

## 🚀 What It Covers

- Launching an **Amazon Linux EC2** instance and setting up Node.js.
- Creating an **RDS MySQL** instance (with private access).
- Configuring **Security Groups**:
  - EC2 SG allows SSH (22) + HTTP (80).
  - RDS SG allows MySQL (3306) from EC2 SG only.
- Building a Node.js/Express app that:
  - Connects to RDS MySQL using environment variables.
  - Exposes endpoints:
    - `/` → returns current DB time.
    - `/messages` → lists seeded messages from the DB.
- Using `.env` for secrets (ignored via `.gitignore`).

---

## 🛠 Setup

### 1. Install dependencies

```bash
npm init -y
npm install express mysql2 dotenv
```

### 2. Environment variables (`.env`)

```bash
DB_HOST=<your-rds-endpoint>
DB_USER=admin
DB_PASS=<your-password>
DB_NAME=devopsdb
PORT=80
```

> `.env` is ignored by git (`.gitignore`).

### 3. Run the app

```bash
sudo node app.js
```

Visit:

- `http://<EC2-PUBLIC-IP>/`
- `http://<EC2-PUBLIC-IP>/messages`

---

## ✅ Key Takeaways

- RDS endpoints are DNS names (not IPs).
- Best practice: allow RDS traffic only from EC2 SG, not the whole internet.
- Amazon Linux 2023 is optimized for AWS workloads.
- `.env` keeps credentials out of source control.

---

## 📂 Project Structure

```
rds-ec2/
├── app.js
├── package.json
├── package-lock.json
├── .gitignore
└── README.md
```
