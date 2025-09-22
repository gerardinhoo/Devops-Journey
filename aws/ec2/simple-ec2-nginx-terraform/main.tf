provider "aws" {
  region = var.region
}

# Default VPC (so we don't create networking from scratch)
data "aws_vpc" "default" {
  default = true
}

# Security Group: allow SSH(22) + HTTP(80)
resource "aws_security_group" "web_sg" {
  name        = "${var.project}-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project}-sg"
    Project = var.project
  }
}

# Amazon Linux 2023 AMI
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# User data: install nginx and drop a simple page
locals {
  user_data = <<-EOF
    #!/bin/bash
    set -eux
    dnf -y update
    dnf -y install nginx
    systemctl enable --now nginx
    cat >/usr/share/nginx/html/index.html <<'HTML'
    <!doctype html>
    <html>
      <head><meta charset="utf-8"><title>EC2 Nginx (AL2023)</title></head>
      <body style="font-family:system-ui;max-width:680px;margin:40px auto;">
        <h1>✅ EC2 Up via Terraform</h1>
        <p>AMI: Amazon Linux 2023 • Host: $(hostname) • Time: $(date)</p>
      </body>
    </html>
    HTML
  EOF
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name != "" ? var.key_name : null
  user_data              = local.user_data

  tags = {
    Name    = "${var.project}-instance"
    Project = var.project
  }
}
