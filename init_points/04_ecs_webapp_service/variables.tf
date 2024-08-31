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

variable "docker_image" {
  description = "Docker image. e.g. 115588969956.dkr.ecr.eu-west-1.amazonaws.com/simple-docker-webapp"
  type        = string
}

variable "docker_tag" {
  description = "Docker tag. e.g. 3.9.0"
  type        = string
}

variable "webapp_subdomain" {
  description = "Route53 webapp subdomain"
  type        = string
}

variable "log_rention_days" {
  description = "Days to retain webapp logs"
  type        = number
}

