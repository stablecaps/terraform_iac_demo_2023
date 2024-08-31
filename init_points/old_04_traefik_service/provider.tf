terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5.0"
    }
  }
  required_version = "= 1.5.1"

  backend "s3" {
    key     = "scaps/ecs/traefik/terraform.tfstate"
    encrypt = "true"
  }
}

provider "aws" {
  region = var.region
}
