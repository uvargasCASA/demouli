##################################################################################
# PROVIDERS FILE
##################################################################################

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.57.1"
    }
  }

  cloud {
    organization = "sistemascasa_uli"

    workspaces {
      name = "DevelopmentU"
    }
  }
}

##################################################################################
# PROVIDERS REQUIRED
##################################################################################

provider "random" {
  # Configuration options
}
provider "aws" {
  #access_key = "ACCESS_KEY"
  #secret_key = "SECRET_KEY"
  region = var.aws_region
}