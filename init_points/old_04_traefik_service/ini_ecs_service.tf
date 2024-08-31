resource "aws_ecs_service" "this" {
  cluster       = data.terraform_remote_state.ecs_cluster.outputs.ecs_cluster_arn
  desired_count = 1
  launch_type   = "FARGATE"

  name            = local.service_name
  task_definition = resource.aws_ecs_task_definition.traefik.arn

  # IMPORTANT!!!!!: confirm whether he want to keep ECS exec after we finish debugging
  enable_execute_command = false

  load_balancer {
    container_name   = local.container_name
    container_port   = 8080
    target_group_arn = data.terraform_remote_state.alb.outputs.target_group_traefik_admin8080_arn
  }

  load_balancer {
    container_name   = local.container_name
    container_port   = 80
    target_group_arn = data.terraform_remote_state.alb.outputs.target_group_web_arn
  }

  network_configuration {
    security_groups = [data.terraform_remote_state.security_groups.outputs.ecs_service_sg_id]
    subnets         = data.aws_subnets.private.ids
  }


  deployment_controller {
    type = "ECS"
  }

  # lifecycle {
  #   ignore_changes = [task_definition, load_balancer, desired_count]
  # }

  tags = local.tags

  # TODO: shall we add deployment_circuit_breaker configuration block?
  # how does it work with blue/green
}
