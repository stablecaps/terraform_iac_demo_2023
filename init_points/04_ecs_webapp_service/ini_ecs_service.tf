resource "aws_ecs_service" "this" {
  cluster       = data.terraform_remote_state.ecs_cluster.outputs.ecs_cluster_arn
  desired_count = 1
  launch_type   = "FARGATE"

  name            = local.service_name
  task_definition = resource.aws_ecs_task_definition.scaps.arn

  network_configuration {
    security_groups  = [data.terraform_remote_state.security_groups.outputs.ecs_service_sg_id]
    subnets          = data.aws_subnets.public.ids
    assign_public_ip = false
  }


  deployment_controller {
    type = "ECS"
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  tags = local.tags
}
