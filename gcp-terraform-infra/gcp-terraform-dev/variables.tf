# Defines input variables used by main.tf

variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources in"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone to deploy resources in"
  type        = string
  default     = "us-central1-a"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "devops-subnet"
}

variable "subnet_ip_range" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
  default     = "devops-vm"
}

variable "machine_type" {
  description = "GCP VM machine type"
  type        = string
  default     = "e2-micro"
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "firewall_name" {
  description = "Name of the Firewall"
  type        = string
}

variable "env" {
  description = "Environment name (dev or prod)"
  type        = string
}
