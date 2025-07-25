# 📦 Nexus 3 OSS Installation & Setup Guide


This guide documents how to install and configure [Sonatype Nexus Repository Manager OSS 3.79.1-04](https://download.sonatype.com/nexus/3/nexus-3.79.1-04-linux-x86_64.tar.gz) on an Ubuntu EC2 instance.

Nexus is used to host private artifact repositories, commonly for Java artifacts built with Maven.

---

## 🧰 Prerequisites

- Ubuntu 22.04+ EC2 instance (t3.small or larger recommended)
- Port **8081** opened in EC2 security group
- Basic Linux shell access (SSH)
- Java 8 and `wget` installed

---

## 🔧 Nexus 3 Installation Steps

### 1️⃣ Download Nexus

```bash
wget https://download.sonatype.com/nexus/3/nexus-3.79.1-04-linux-x86_64.tar.gz

## Install Nexus
tar -xvzf nexus-3.79.1-04-linux-x86_64.tar.gz

## Create a Dedicated Nexus User
sudo useradd -M -d /opt/nexus nexus
sudo passwd nexus  # Set a password

## Move Nexus Files to /opt
sudo mv nexus-3.79.1-04 /opt/nexus
sudo mv sonatype-work /opt/sonatype-work

## Configure Nexus to Run as nexus User
sudo nano /opt/nexus/bin/nexus.rc

Add this line:
run_as_user="nexus"

## Start Nexus Manually (First Time Check)
cd /opt/nexus/bin
sudo -u nexus ./nexus start

## Create a systemd Service
sudo nano /etc/systemd/system/nexus.service

Paste the following:
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target

## Enable and Start Nexus as a Service
sudo systemctl daemon-reexec
sudo systemctl enable nexus
sudo systemctl start nexus

## Get Default Admin Password
cat /opt/sonatype-work/nexus3/admin.password
Then log in at:
➡️ http://<your-ec2-ip>:8081
Username: admin
Password: (paste the value from the file above)

Author
Gerard Eku
github.com/gerardinhoo
