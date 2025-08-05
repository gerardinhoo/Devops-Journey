#!/bin/bash

# Update the system
apt-get update

# Install Docker and Git
apt-get install -y docker.io git

# Enable Docker to start on boot
systemctl enable docker
systemctl start docker

# Clone your DevOps Journey repo into user's home directory
sudo -u gerardeklu git clone https://github.com/gerardinhoo/Devops-Journey.git /home/gerardeklu/Devops-Journey

# Set permissions (in case some files need owner fix)
chown -R gerardeklu:gerardeklu /home/gerardeklu/Devops-Journey