# TODO: enable auth on dashboard
resource "aws_ecs_task_definition" "traefik" {
  container_definitions = jsonencode([{

    environment = [
      {
        "name"        = local.container_name,
        "environment" = var.env
      }
    ]
    command = [
      "--accesslog=true",
      "--log.level=DEBUG",
      #
      "--api.insecure=true",
      "--api.dashboard=true",
      #
      "--providers.ecs=true",
      "--providers.ecs.region=${var.region}",
      "--providers.ecs.refreshSeconds=60",
      "--providers.ecs.autoDiscoverClusters=false",
      "--providers.ecs.clusters=${data.terraform_remote_state.ecs_cluster.outputs.ecs_cluster_name}",
      #
      "--entrypoints.web.address=:80",
      #
      "--ping=true",
      "--ping.entrypoint=ping",
      "--entryPoints.ping.address=:8082"
    ],
    dockerLabels = {
      "traefik.http.routers.api.rule"        = "Host(`${var.webapp_subdomain}`)",
      "traefik.http.routers.api.entrypoints" = "web",
      "traefik.http.routers.api.service"     = "api@internal",
      #
      # "traefik.enable"                                 = "true",
      # "traefik.http.routers.api.middlewares"           = "admin",
      # "traefik.http.middlewares.admin.basicauth.users" = "admin:$qsr1$$BLeExLJx$TyFhjkswerKbHakOdsWS9/",
    },
    essential = true,
    image     = "${var.traefik_image}:${var.traefik_tag}",
    name      = local.container_name,
    portMappings = [
      { containerPort = 8080 },
      { containerPort = 8082 },
      { containerPort = 80 }
    ],
    logConfiguration : {
      logDriver : "awslogs",
      options : {
        awslogs-create-group : "true",
        awslogs-group : "/aws/ecs/awslogs-traefik-${var.env}",
        awslogs-region : var.region,
        awslogs-stream-prefix : "ecs"
      }
    },
  }])

  # TODO: empirically determine resource footprint
  cpu                      = 256
  task_role_arn            = aws_iam_role.ecs_exec.arn
  execution_role_arn       = aws_iam_role.traefik.arn
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
