variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "security_groups" {
  description = "VPC security groups for the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "VPC subnets for the load balancer"
  type        = list(string)
}

variable "lb_delete_protection_sw" {
  description = "Enable delete protection"
  type        = bool
  default     = false
}


# variable "bucket_log_name" {
# }

variable "tags" {
  default = {}
}

resource "aws_lb" "default" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.lb_delete_protection_sw
  xff_header_processing_mode = "append"

  tags = var.tags
  ##Having trouble with access to the bucket.
  ##Commenting it out for now
  # access_logs {
  #   bucket  = var.bucket_log_name
  #   prefix  = var.name
  #   enabled = true
  # }
}

output "lb_name" {
  value = aws_lb.default.name
}

output "dns_name" {
  value = aws_lb.default.dns_name
}

output "alb_arn" {
  value = aws_lb.default.arn
}

output "zone_id" {
  value = aws_lb.default.zone_id
}
