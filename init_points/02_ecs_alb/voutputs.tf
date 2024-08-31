output "alb_name" {
  value = module.alb.lb_name
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "target_group_web_arn" {
  value = module.target_group_web.arn
}

