resource "aws_route53_record" "ecs_traefik_admin" {
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = var.webapp_subdomain
  type            = "CNAME"
  ttl             = var.ttl
  records         = [data.terraform_remote_state.alb.outputs.alb_dns_name]
  allow_overwrite = "true"
}

resource "aws_route53_record" "ecs_scaps" {
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = var.webapp_subdomain
  type            = "CNAME"
  ttl             = var.ttl
  records         = [data.terraform_remote_state.alb.outputs.alb_dns_name]
  allow_overwrite = "true"
}
