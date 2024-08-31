locals {
  base_name = "${var.product}-${var.env}-sc"

  region = "eu-west-1"

  vpc_cidr = "10.0.0.0/20"
  azs      = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    environment = var.env
    product     = var.product
    owner       = "DevOps"
    created_by  = "terraform"
  }
}
