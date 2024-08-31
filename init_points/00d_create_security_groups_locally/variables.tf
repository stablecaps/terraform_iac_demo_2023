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

variable "debug_ipaddr" {
  description = "Debuuger IP address for white listing"
  type        = string
}
