variable "alb_arn" {
  description = "Name of the load balancer"
  type        = string
}

variable "target_group_arn" {
  description = "ID of the target group to use"
  type        = string
}

variable "certificate" {
  description = "ARN of the certificate for SSL"
  type        = string
}

variable "additional_certificates" {
  description = "additional certificates for the load balancer"
  type        = list(string)
  default     = []
}

# TODO: check if this policy is ok or switch to ELBSecurityPolicy-TLS13-1-2-2021-06
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html
variable "elb_security_policy" {
  description = "Load balancer security policy. Defaults to ELBSecurityPolicy-TLS13-1-2-2021-06"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

resource "aws_lb_listener" "default" {
  load_balancer_arn = var.alb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.elb_security_policy
  certificate_arn   = var.certificate

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}



resource "aws_lb_listener_certificate" "default" {
  count           = length(var.additional_certificates)
  listener_arn    = aws_lb_listener.default.arn
  certificate_arn = element(var.additional_certificates, count.index)
}

output "arn" {
  value = aws_lb_listener.default.arn
}
