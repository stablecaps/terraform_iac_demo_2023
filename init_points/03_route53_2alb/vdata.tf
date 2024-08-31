data "aws_route53_zone" "selected" {
  name         = var.r53_domain
  private_zone = false
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    region = "eu-west-1"
    bucket = "terraform-remotestate-stablecaps-${var.env}"
    key    = "scaps/ecs/alb/terraform.tfstate"
  }
}
