variable "description" {
  description = "description of the security group rule"
  type        = string
}

variable "port" {
  description = "port for this rule"
  type        = string
}

variable "protocol" {
  description = "the protocol we're using for this rule"
  type        = string
  default     = "TCP"
}

variable "security_group_id" {
  description = "The rule belongs to this security group"
  type        = string
}

variable "source_security_group_id" {
  description = "source_security_group_id for which this rule applies"
  type        = string
}

resource "aws_security_group_rule" "default" {
  description              = var.description
  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = var.protocol
  security_group_id        = var.security_group_id
  source_security_group_id = var.source_security_group_id
  lifecycle {
    create_before_destroy = true
  }
}

output "id" {
  value = aws_security_group_rule.default.id
}
