#Module Networking
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~>3.0"

  name = local.name
  cidr = var.aws_vpc_cidr_block[terraform.workspace]

  azs             = slice(data.aws_availability_zones.available.names,0,(var.aws_vpc_subnets[terraform.workspace]))
  public_subnets  = [for subnet in range(var.aws_vpc_subnets[terraform.workspace]):cidrsubnet(var.aws_vpc_cidr_block[terraform.workspace],8,subnet)]
  enable_dns_hostnames = true
  map_public_ip_on_launch = true
  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}  

# SECURITY GROUPS #
# Nginx security group for instances
resource "aws_security_group" "nginx-sg" {
  name   = "${local.name_prefix}-nginx_sg"
  vpc_id = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })

  # HTTP access from anywhere
  ingress {
    from_port   = var.aws_http
    to_port     = var.aws_http
    protocol    = "tcp"
    cidr_blocks = [var.aws_vpc_cidr_block[terraform.workspace]]
  }
      # SSH access from anywhere
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.aws_traffic_block
  }

}

# LoadBalancer security group 2
resource "aws_security_group" "nginx-lb-sg" {
  name   = "${local.name_prefix}-nginx_lb_sg"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = local.name
  }

  # HTTP access from anywhere
  ingress {
    from_port   = var.aws_http
    to_port     = var.aws_http
    protocol    = "tcp"
    cidr_blocks = var.aws_traffic_block
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.aws_traffic_block
  }
}