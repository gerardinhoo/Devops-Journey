# Expose Key Info from the Terraform setup which is helpul for Debugging, CI/CD/ Monitoring

output "vm_name" {
   description = "Name of the virtual machine" 
   value       = google_compute_instance.vm_instance.name
}

output "vm_external_ip" {
   description = "External IP address of the VM"
   value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "vm_zone" {
   description = "The zone where the VM is deployed"
   value       =  google_compute_instance.vm_instance.zone
}