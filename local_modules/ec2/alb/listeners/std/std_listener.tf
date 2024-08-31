variable "alb_arn" {
  description = "Name of the load balancer"
  type        = string
}

variable "port" {
  description = "Listener port. e.g. 80"
  type        = string
}

variable "target_group_arn" {
  description = "ID of the target group to use"
  type        = string
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = var.alb_arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  # TODO: convert this to a dynamic block
  lifecycle {
    ignore_changes = [default_action]
  }
}

output "arn" {
  value = aws_lb_listener.default.arn
}
