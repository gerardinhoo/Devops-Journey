# Create a custom Docker network
resource "docker_network" "app_net" {
  name = "tf-app-network"
}

# Pull an Nginx image
resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

# Run a container based on that image
resource "docker_container" "web" {
  name    = "tf-nginx"
  image   = docker_image.nginx_image.name
  restart = "always"

  networks_advanced {
    name = docker_network.app_net.name
  }

  ports {
    internal = 80
    external = 8080
  }
}


