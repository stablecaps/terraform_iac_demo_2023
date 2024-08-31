data "aws_vpc" "this" {
  id = var.vpc_id
}

data "aws_security_group" "this" {
  name   = "default"
  vpc_id = data.aws_vpc.this.id
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = var.subnet_name_tag
  }
}

# data "aws_acm_certificate" "scaps" {
#   domain      = "stablecaps.com"
#   types       = ["AMAZON_ISSUED"]
#   statuses    = ["ISSUED"]
#   most_recent = true
# }

### Get remote state
# https://stackoverflow.com/questions/61647617/use-terraform-state-output-from-another-project
data "terraform_remote_state" "ecs_cluster" {
  backend = "s3"
  config = {
    region = "eu-west-1"
    bucket = "terraform-remotestate-stablecaps-${var.env}"
    key    = "scaps/ecs/cluster/terraform.tfstate"
  }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    region = "eu-west-1"
    bucket = "terraform-remotestate-stablecaps-${var.env}"
    key    = "scaps/ecs/alb/terraform.tfstate"
  }
}

data "terraform_remote_state" "security_groups" {
  backend = "s3"
  config = {
    region = "eu-west-1"
    bucket = "terraform-remotestate-stablecaps-${var.env}"
    key    = "scaps/ecs/security_groups/terraform.tfstate"
  }
}

