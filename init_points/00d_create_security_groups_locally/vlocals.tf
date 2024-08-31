locals {

  tags = {
    environment = var.env
    product     = var.product
    owner       = "DevOps"
    created_by  = "terraform"
  }

  base_name = "${var.product}-${var.env}-sc"
}
