locals {
  tags = {
    environment = var.env
    owner       = "DevOps"
    created_by  = "terraform"
  }

  base_name = "terraform-remotestate-stablecaps-${var.env}"

}
