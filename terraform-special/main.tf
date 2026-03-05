# Providers
# Multiple Providers

# terraform {
#   required_providers {
#     local = {
#       source = "hashicorp/local"
#     }
#     random = {
#       source = "hashicorp/random"
#     }
#   }
# }

provider "aws" {
  region     = "us-east-2"
  access_key = ""
  secret_key = ""
}

resource "aws_iam_user" "admin-user" {
  name = "Marcel"
  tags = {
    Description = "Technical Team Leader"
  }
}

# resource "local_file" "world_cup26" {
#   filename = var.filename
#   content  = "The AMI ID generated is ${random_id.server.hex}"
# }

# resource "random_shuffle" "my_car" {
#   input = var.input
# }

# resource "random_id" "server" {
#   keepers = {
#     ami_id = var.ami_id
#   }
#   byte_length = 8
# }

# output "server_id" {
#   value       = random_id.server.hex
#   description = "The value of the server ID"
# }

# output "file_name" {
#   value     = local_file.world_cup26
#   sensitive = true
# }
