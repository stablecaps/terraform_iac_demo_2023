# TODO: possibly change to data if darren wants?
variable "vpc_id" {
  description = "AWS VPC ID. e.g. vpc-9op489p4e66e05588"
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

variable "traefik_image" {
  description = "Traefik image. e.g. 334406042632.dkr.ecr.eu-west-1.amazonaws.com/traefik"
  type        = string
}

variable "traefik_tag" {
  description = "Docker tag. e.g. 3.9.0"
  type        = string
}

variable "webapp_subdomain" {
  description = "Route53 webapp subdomain"
  type        = string
}
