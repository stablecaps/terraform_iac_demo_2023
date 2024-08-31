variable "listener_arn" {
}

variable "priority" {
}

variable "target_group_arn_A" {
}

variable "target_group_arn_B" {
}

variable "tg_weight_A" {
}

variable "tg_weight_B" {
}

variable "stickiness_duration" {
  default = 3600
}


# variable "path_pattern" {
# }


resource "aws_alb_listener_rule" "default" {
  listener_arn = var.listener_arn
  priority     = var.priority

  condition {
    source_ip {
      values = ["0.0.0.0/0"]
    }
  }
  #   condition {
  #     path_pattern {
  #       values = ["/blahblah/*"]
  #     }
  #   }
  action {
    type = "forward"
    forward {
      target_group {
        arn    = var.target_group_arn_A
        weight = var.tg_weight_A
      }

      target_group {
        arn    = var.target_group_arn_B
        weight = var.tg_weight_A
      }

      stickiness {
        enabled  = true
        duration = var.stickiness_duration
      }
    }
  }
}


output "arn" {
  value = aws_alb_listener_rule.default.arn
}
