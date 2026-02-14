# Prod Environment Configuration
# Calls the gcp-environment module with prod-specific values

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file("${path.module}/../../terraform-admin-key.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

module "environment" {
  source = "../../modules/gcp-environment"

  environment       = var.environment
  name_prefix       = var.name_prefix
  region            = var.region
  zone              = var.zone
  subnet_cidr       = var.subnet_cidr
  machine_type      = var.machine_type
  ssh_source_ranges = var.ssh_source_ranges
  startup_script    = file("${path.module}/../../startup.sh")
}
