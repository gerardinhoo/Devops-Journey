#!/bin/bash

# Update packages
apt-get update -y

# Install Docker and Git
apt-get install -y docker.io git

# Enable and start Docker
systemctl enable docker
systemctl start docker
