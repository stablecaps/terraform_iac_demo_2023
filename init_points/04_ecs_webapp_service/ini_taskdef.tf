resource "aws_ecs_task_definition" "scaps" {
  container_definitions = jsonencode([{
    environment : [
      {
        "name"        = local.container_name,
        "environment" = var.env
      }
    ],
    essential = true,
    image     = "${var.docker_image}:${var.docker_tag}",
    name      = local.container_name,
    portMappings = [
      { containerPort = 8080 }
    ],
    logConfiguration : {
      logDriver : "awslogs",
      options : {
        awslogs-create-group : "true",
        awslogs-group : "/aws/ecs/awslogs-${var.product}-${var.env}",
        awslogs-region : var.region,
        awslogs-stream-prefix : "ecs"
      }
    },
  }])

  # TODO: empirically determine resouce footprint
  cpu                      = 256
  execution_role_arn       = resource.aws_iam_role.scaps.arn
  family                   = local.container_name
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  tags = local.tags
}
