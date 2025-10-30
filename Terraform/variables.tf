# Core Inputs
variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID to use for the instance (Amazon Linux 2023 in my region: us-east-2)"
  type        = string
  # ID from the console
  default = "ami-083b3f53cbda7e5a4"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "terraform-demo-instance"
}

variable "common_tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "tf-ec2-lab"
    Owner       = "Gerard"
    Environment = "dev"
  }
}


# Name of an EXISTING EC2 key pair in your AWS account (do not commit the .pem)
variable "key_pair_name" {
  description = "Existing EC2 key pair name to use for SSH"
  type        = string
  default     = "gerard-amazonlinux-key"
}

# CIDR allowed to SSH (use YOUR_IP/32 for security)
variable "ssh_ingress_cidr" {
  description = "CIDR allowed for SSH ingress (use x.x.x.x/32)"
  type        = string
  default     = "0.0.0.0/0" # tighten to your IP before prod
}

# Optional: open HTTP 80 for quick tests (nginx, etc.)
variable "enable_http" {
  description = "Whether to open port 80"
  type        = bool
  default     = false
}



