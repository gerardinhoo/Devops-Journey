# 🐧 DevOps Journey: EC2 + Linux Setup (with VS Code)

This repository documents how I set up an AWS EC2 instance, connected to it securely using SSH and Visual Studio Code, and practiced essential Linux commands as the foundation for my DevOps journey.

---

## 🔧 What You'll Find in This Repo

- Setup guide for AWS EC2 (Ubuntu) instance
- Secure SSH access using `.pem` key and config file
- Connecting and coding on EC2 via VS Code Remote - SSH
- Practicing core Linux commands in a structured way
- Organized exercises and script files inside `linux_basics/`

---

## 🪴 Step 1: Launch an AWS EC2 Instance (Ubuntu)

1. **Login to AWS** → Navigate to [EC2 Dashboard](https://console.aws.amazon.com/ec2)
2. Click **Launch Instance**
3. Choose:
   - **Ubuntu Server 22.04 LTS (x86)** (or similar)
   - Instance type: `t2.micro` (Free Tier)
4. **Create a new key pair**:
   - Name: `new-key-general`
   - File type: `.pem`
   - Download and save it safely (e.g., in `~/Downloads/`)
5. Under **Security Group** settings:
   - Allow SSH (Port 22)
   - Set **Source** to “My IP” for safety
6. Launch the instance and copy its **Public IPv4 address**

---

## 🔐 Step 2: Secure Your SSH Key Locally

Open your terminal and run:

```bash
chmod 400 ~/Downloads/new-key-general.pem
