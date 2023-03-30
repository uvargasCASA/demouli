resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

locals {
  common_tags = {
    service  = local.service_name
    owner    = "sistemascasa"
    comments = "with load balancer"
  }
  name           = "web de uli"
  name_prefix    = "${var.aws_naming_prefix}-${terraform.workspace}"
  service_name   = "instancia de prueba"
  project        = var.aws_project
  description    = var.aws_billing_code
  s3_bucket_name = lower("WebProject${random_integer.rand.result}-${terraform.workspace}")
}
