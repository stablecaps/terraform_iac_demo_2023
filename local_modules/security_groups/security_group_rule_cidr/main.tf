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

variable "cidr_list" {
  description = "CIDR for which this rule applies"
  type        = list(string)
}

resource "aws_security_group_rule" "default" {
  description       = var.description
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = var.protocol
  security_group_id = var.security_group_id
  cidr_blocks       = var.cidr_list
  # lifecycle {
  #   create_before_destroy = true
  # }
}

output "id" {
  value = aws_security_group_rule.default.id
}
