locals {

  tags = {
    environment   = var.env
    product       = var.product
    owner         = "stablecaps"
    created_by    = "terraform"
    service_name  = local.service_name
    image_version = var.docker_tag
  }

  service_name   = "${var.product}-${var.env}"
  container_name = "${var.product}-${var.env}"

}
