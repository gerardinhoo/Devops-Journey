terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker",
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0.0"
}

# Uses local docker daemon automatically
provider "docker" {}
