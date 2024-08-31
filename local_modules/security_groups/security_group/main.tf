variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "name" {
  description = "security group name "
  type        = string
}

variable "description" {
  description = "Security group description"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = map(string)
}

resource "aws_security_group" "default" {
  name_prefix = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge({ Name = var.name }, var.tags)

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}


output "id" {
  value = aws_security_group.default.id
}

output "arn" {
  value = aws_security_group.default.arn
}
