output "ecs_cluster_arn" {
  value = module.ecs_cluster.arn
}

output "ecs_cluster_name" {
  value = module.ecs_cluster.name
}

output "autoscaling_capacity_providers" {
  value = module.ecs_cluster.autoscaling_capacity_providers
}