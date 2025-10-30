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

# Resource: EC2 Instance
resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(
    var.common_tags,
    { Name = var.instance_name }
  )
}


