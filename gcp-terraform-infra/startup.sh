#!/bin/bash

# Update the package index 
sudo apt-get update -y

# Install Prerequisite packages 
sudo apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

# Add Docker’s official GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# Update package index again (with Docker repo)
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start docker
sudo systemctl enable docker
sudo systemctl start docker

# Install git
sudo apt install git