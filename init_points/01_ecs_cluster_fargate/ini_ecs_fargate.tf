module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws//modules/cluster"

  version = "5.2.0"

  cluster_name = local.base_name

  create_cloudwatch_log_group = false


  default_capacity_provider_use_fargate = true

  ### Capacity provider
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 0
        base   = 20
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  tags = local.tags
}
