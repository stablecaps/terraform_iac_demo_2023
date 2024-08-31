locals {

  tags = {
    environment   = var.env
    product       = var.product
    owner         = "stablecaps"
    created_by    = "terraform"
    service_name  = local.service_name
    image_version = var.traefik_tag
  }

  service_name   = "traefik-${var.env}"
  container_name = "traefik-${var.env}"

}
