variable "listener_arn" {
}

variable "priority" {
}

variable "target_group_arn" {
}

variable "path_pattern" {
}

resource "aws_lb_listener_rule" "default" {
  listener_arn = var.listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    path_pattern {
      values = [var.path_pattern]
    }
  }
}

output "arn" {
  value = aws_lb_listener_rule.default.arn
}
