# Dev Environment Outputs

output "vm_name" {
  description = "Name of the VM instance"
  value       = module.environment.vm_name
}

output "vm_external_ip" {
  description = "External IP address of the VM"
  value       = module.environment.vm_external_ip
}

output "vm_zone" {
  description = "Zone where the VM is deployed"
  value       = module.environment.vm_zone
}

output "vpc_name" {
  description = "Name of the VPC network"
  value       = module.environment.vpc_name
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = module.environment.subnet_name
}
