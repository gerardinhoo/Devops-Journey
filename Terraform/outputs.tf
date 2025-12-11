output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.web_server.id
}


output "public_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.web_server.public_ip
}


output "arn" {
  description = "ARN of the instance"
  value       = aws_instance.web_server.arn
}

