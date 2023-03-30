variable "aws_region" {
  type        = string
  description = "AWS Region to use for resourse"
  default     = "us-east-2"
}

variable "aws_vpc_cidr_block" {
  type        = map(string)
  description = "IP block to use for resourse"
}

variable "aws_subnets" {
  type        = list(string)
  description = "IP block subnneting to use for resourse"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "aws_http" {
  type        = number
  description = "port http to use for resourse"
  default = 80

  validation {
    condition     = var.aws_http > 0 && var.aws_http <= 65536
    error_message = "El valor del puerto debe estar comprendido entre 1 y 65536."
  }
}

variable "aws_project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "Pruebas de Uli"
}

variable "aws_billing_code" {
  type        = string
  description = "Billing code for resource tagging"
  default     = "000C0d3UliAAA"
}

variable "aws_traffic_block" {
  type        = list(string)
  description = "Ip block to all traffic to use for resourse"
  default     = ["0.0.0.0/0"]
}

variable "aws_ami" {
  type        = map(string)
  description = "ami to use for resourse"
  default = {
    id   = "ami-0f3c9c466bb525749"
    type = "t2.micro"
  }

}

  variable "aws_vpc_subnets" {
  type        = map(number)
  description = "count subnets"
  }

  variable "aws_instance" {
  type        = map(number)
  description = "count instances"
  }
  
  variable "aws_naming_prefix" {
  type        = string
  description = "set name for prefix"
  default     = "AppUli"
}
/*
  variable "aws_instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}
*/



