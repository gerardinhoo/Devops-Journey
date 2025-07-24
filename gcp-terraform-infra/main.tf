# Main Terraform setup that provisions a VPC, subnet, firewall, and VM instance in GCP

provider "google" {
   credentials = file("terraform-admin-key.json")
   project    = var.project_id
   region     = var.region
   zone      = var.region
}

resource "google_compute_network" "vpc_network" {
   name                    = var.network_name
   auto_create_subnetworks = false 
}

resource "google_compute_subnetwork" "subnet" {
   name          = var.subnet_name
   ip_cidr_range = var.subnet_ip_range
   region        = var.region
   network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow-ssh" {
   name    = "allow-ssh"
   network = google_compute_network.vpc_network.name


   allow {
     protocol = "tcp"
     ports    = ["22"]
 }

   source_ranges = ["0.0.0.0/0"]
   target_tags   = ["ssh"]
}

resource "google_compute_instance" "vm_instance" {
   name         = var.vm_name
   machine_type = var.machine_type
   zone         = var.zone

   boot_disk {
      initialize_params {
         image = "debian-cloud/debian-11"
      }
   }

   network_interface {
      network    = google_compute_network.vpc_network.id
      subnetwork = google_compute_network.subnet.id

      access_config  {} # This enables a ip_cidr_range
   }

   metadata_startup_script = fileexists("startup.sh") ? file("startup.sh") : ""
   tags = ["ssh"]
}
   




