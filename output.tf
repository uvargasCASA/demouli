output "name" {
  value       = "http://${aws_lb.nginx.dns_name}"
  description = "DNS FOR INSTANCE CREATED"
  sensitive   = false

}