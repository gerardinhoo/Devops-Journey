output "nginx_container_name" {
  value = docker_container.web
}

output "nginx_url" {
  value = "http://localhost:8080"
}
