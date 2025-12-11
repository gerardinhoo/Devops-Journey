# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend S3
  backend "s3" {
    bucket         = "g-terraform-states-gerard" # Bucket name
    key            = "ec2-basics/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

# Provider Configuration
provider "aws" {
  region = var.aws_region
}

# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch a default public subnet (one that auto-assigns public IPs)
data "aws_subnets" "default_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

# Resource: Security Group (standalone, NOT inside EC2)
resource "aws_security_group" "web_sg" {
  name        = "tf-web-sg"
  description = "Allow SSH (and optional HTTP) to EC2"
  vpc_id      = data.aws_vpc.default.id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr]
  }

  # Optional HTTP 80
  dynamic "ingress" {
    for_each = var.enable_http ? [1] : []
    content {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    { Name = var.instance_name }
  )
}

# Resource: EC2 Instance
resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  # Place instance in a default (public) subnet
  subnet_id = data.aws_subnets.default_public.ids[0]

  # Force public IP attachment
  associate_public_ip_address = true

  # Attach SG correctly (now declared above)
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = merge(
    var.common_tags,
    { Name = var.instance_name }
  )
}
