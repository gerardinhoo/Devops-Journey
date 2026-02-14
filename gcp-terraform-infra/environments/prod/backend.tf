# Prod Environment Backend Configuration

terraform {
  backend "gcs" {
    bucket = "devops-terraform-state-bucket-gerard-20250725"
    prefix = "gcp-terraform/prod"
  }
}
