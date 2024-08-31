# TODO: possibly change to data if darren wants?
variable "vpc_id" {
  description = "AWS VPC ID. e.g. vpc-9op489p4e66e05588"
  type        = string
}

variable "subnet_name_tag" {
  description = "Subnet string used in name tag for data block"
  type        = string
}

variable "region" {
  description = "AWS region. e.g. eu-west-1"
  type        = string
}

variable "env" {
  description = "Deployment environment. e.g. dev, uat, prod"
  type        = string
}

variable "product" {
  description = "Product name. e.g. scaps"
  type        = string
}

variable "ssl_policy" {
  description = "ALB "
  type        = string
}

variable "acm_domain" {
  description = "Domain used for getting ACM certificate"
  type        = string
}

variable "webapp_subdomain" {
  description = "Route53 webapp subdomain"
  type        = string
}

variable "health_check" {
  description = "Traefik ping HealthCheck Map - 8082"
  type        = map(string)
  default = {
    enabled             = "true"
    interval            = "30"
    path                = "/ping"
    port                = "80"
    protocol            = "HTTP"
    timeout             = "20"
    healthy_threshold   = "4"
    unhealthy_threshold = "2"
    matcher             = "200"
  }
}

