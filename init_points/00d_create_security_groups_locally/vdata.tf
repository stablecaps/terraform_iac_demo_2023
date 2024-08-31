data "aws_vpc" "this" {
  id = var.vpc_id
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.this.id
}