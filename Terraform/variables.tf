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


