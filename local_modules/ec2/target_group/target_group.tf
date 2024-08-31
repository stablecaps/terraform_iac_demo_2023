variable "name_prefix" {
  description = "Name prefix of the target group"
  type        = string
}

variable "port" {
  description = "Target group port. e.g. 80"
  type        = string
}

variable "protocol" {
  description = "Network protocol. e.g. HTTP, HTTPS"
  type        = string
}

variable "target_type" {
  description = "Network protocol. e.g. instance, ip"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}


variable "health_check" {
  description = "HealthCheck Map"
  type        = map(string)
  default = {
    enabled             = "true"
    interval            = "30"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "20"
    healthy_threshold   = "4"
    unhealthy_threshold = "2"
    matcher             = "200"
  }
}


variable "health_check_target" {
  description = "target for the health check"
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Tag set to use"
}

resource "aws_lb_target_group" "this" {
  name_prefix = var.name_prefix
  port        = var.port
  protocol    = var.protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id
  slow_start  = "30"

  # TODO: make this a var map
  stickiness {
    type            = "lb_cookie"
    cookie_duration = "3600"
    enabled         = "true"
  }


  dynamic "health_check" {
    #for_each = try([var.target_groups[count.index].health_check], [])
    for_each = length(var.health_check) > 0 ? [1] : []

    content {
      enabled             = lookup(var.health_check, "enabled", null)
      interval            = lookup(var.health_check, "interval", null)
      path                = lookup(var.health_check, "path", null)
      port                = lookup(var.health_check, "port", null)
      healthy_threshold   = lookup(var.health_check, "healthy_threshold", null)
      unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold", null)
      timeout             = lookup(var.health_check, "timeout", null)
      protocol            = lookup(var.health_check, "protocol", null)
      matcher             = lookup(var.health_check, "matcher", null)
    }
  }

  tags = var.tags
}

output "arn" {
  value = aws_lb_target_group.this.arn
}
