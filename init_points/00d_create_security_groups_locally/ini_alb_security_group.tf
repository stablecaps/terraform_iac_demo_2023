module "sg_alb" {
  source      = "../../local_modules/security_groups/security_group"
  vpc_id      = var.vpc_id
  name        = "alb-${local.base_name}"
  description = "scaps ALB SG"
  tags        = local.tags
}

module "sg_alb_r1" {
  source            = "../../local_modules/security_groups/security_group_rule_cidr"
  description       = "HTTP 80 rule (external debugger)"
  port              = "80"
  security_group_id = module.sg_alb.id
  cidr_list         = [var.debug_ipaddr]
}

module "sg_alb_r2" {
  source            = "../../local_modules/security_groups/security_group_rule_cidr"
  description       = "HTTPS 443 rule (external debugger)"
  port              = "443"
  security_group_id = module.sg_alb.id
  cidr_list         = [var.debug_ipaddr]
}

module "sg_alb_r3" {
  source                   = "../../local_modules/security_groups/security_group_rule_source_sg"
  description              = "HTTP 80 rule - (default vpc-sg)"
  port                     = "80"
  security_group_id        = module.sg_alb.id
  source_security_group_id = data.aws_security_group.default.id
}

module "sg_alb_r4" {
  source                   = "../../local_modules/security_groups/security_group_rule_source_sg"
  description              = "HTTPS 443 - (default vpc-sg)"
  port                     = "443"
  security_group_id        = module.sg_alb.id
  source_security_group_id = data.aws_security_group.default.id
}
