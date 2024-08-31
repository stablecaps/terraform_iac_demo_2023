module "ecs_service_sg" {
  source      = "../../local_modules/security_groups/security_group"
  vpc_id      = var.vpc_id
  name        = "ecs-${local.base_name}"
  description = "scaps ECS"
  tags        = local.tags
}

module "sg_ecs_r1" {
  source                   = "../../local_modules/security_groups/security_group_rule_source_sg"
  description              = "Web App 8080 rule (default vpc-sg)"
  port                     = "8080"
  security_group_id        = module.ecs_service_sg.id
  source_security_group_id = data.aws_security_group.default.id
}

module "sg_ecs_r1b" {
  source                   = "../../local_modules/security_groups/security_group_rule_source_sg"
  description              = "Web App 8080 rule (alb SG)"
  port                     = "8080"
  security_group_id        = module.ecs_service_sg.id
  source_security_group_id = module.sg_alb.id
}

module "sg_ecs_r1c" {
  source                   = "../../local_modules/security_groups/security_group_rule_source_sg"
  description              = "Web App 8080 rule (self ECS SG)"
  port                     = "8080"
  security_group_id        = module.ecs_service_sg.id
  source_security_group_id = module.ecs_service_sg.id
}
