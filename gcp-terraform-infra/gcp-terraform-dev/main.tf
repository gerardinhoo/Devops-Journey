# Main Terraform setup that provisions a VPC, subnet, firewall, and VM instance in GCP

provider "google" {
   credentials = file("terraform-admin-key.json")
   project    = var.project_id
   region     = var.region
   zone       = var.zone
}

resource "google_compute_network" "vpc_network" {
   name                    = var.vpc_name
   auto_create_subnetworks = false 
}

resource "google_compute_subnetwork" "subnet" {
   name          = var.subnet_name
   ip_cidr_range = var.subnet_ip_range
   region        = var.region
   network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow-ssh" {
   name    = var.firewall_name
   network = google_compute_network.vpc_network.name


   allow {
     protocol = "tcp"
     ports    = ["22"]
 }

   source_ranges = ["0.0.0.0/0"]
   target_tags   = ["ssh"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "${var.vm_name}-${var.env}"  # e.g., devops-vm-dev
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {}
  }

  metadata_startup_script = file("startup.sh")  # Simple and clear

  tags = ["ssh", var.env]  # ["ssh", "dev"] or ["ssh", "prod"]
}

   




