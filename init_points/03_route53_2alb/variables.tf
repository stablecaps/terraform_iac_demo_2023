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

variable "r53_domain" {
  description = "Route53 domain anme"
  type        = string
}


variable "webapp_subdomain" {
  description = "Route53 webapp subdomain"
  type        = string
}

variable "ttl" {
  description = "Route53 CNAME ttl"
  type        = number
}
