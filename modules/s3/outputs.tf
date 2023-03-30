output "web_bucket" {
  value       = aws_s3_bucket.web_bucket
  description = "FULL BUCKET OBJECT"
  sensitive   = false

}
output "iam_instance_profile" {
  value       = aws_iam_instance_profile.nginx_profile
  description = "FULL INSTANCE PROFILE OBJECT"
  sensitive   = false

}