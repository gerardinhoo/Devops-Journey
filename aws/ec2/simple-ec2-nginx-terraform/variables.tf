variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = ""
  type        = string
  default     = ""
}

variable "project" {
  description = "Tagging prefix"
  type        = string
  default     = "ec2-nginx-lab"
}
