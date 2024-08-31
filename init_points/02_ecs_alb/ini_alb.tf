### Setup application load balancer
module "alb" {
  source = "../../local_modules/ec2/alb/alb"

  name            = local.base_name
  security_groups = [data.aws_security_group.this.id, data.terraform_remote_state.secgroups.outputs.ecs_alb_sg_id]
  subnets         = data.aws_subnets.public.ids

  # TODO: change this to true once this goes to production
  lb_delete_protection_sw = false

  tags = local.tags
}

###############################################################
module "target_group_web" {
  source = "../../local_modules/ec2/target_group"

  name_prefix  = var.env == "prod" ? "webpr" : "webdv"
  port         = "8080"
  protocol     = "HTTP"
  target_type  = "ip"
  vpc_id       = var.vpc_id
  health_check = var.health_check

  tags = merge({ Name = "web8080-${var.env}" }, local.tags)
}

###############################################################
resource "aws_lb_listener" "http2https_redirect_listner" {
  load_balancer_arn = module.alb.alb_arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  lifecycle {
    ignore_changes = [default_action]
  }
}

resource "aws_lb_listener" "https443" {
  load_balancer_arn = module.alb.alb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = data.aws_acm_certificate.scaps.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = file("${path.module}/assets/404.html")
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "webapp_subdomain" {
  listener_arn = aws_lb_listener.https443.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = module.target_group_web.arn
  }

  condition {
    host_header {
      values = [var.webapp_subdomain]
    }
  }
}

