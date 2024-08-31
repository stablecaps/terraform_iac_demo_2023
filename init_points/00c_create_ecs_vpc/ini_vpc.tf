module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v5.1.2"

  name = local.base_name
  cidr = local.vpc_cidr

  azs            = local.azs
  public_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  #private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]

  vpc_tags = merge({ "Name" = local.base_name }, local.tags)
  tags     = local.tags
}
