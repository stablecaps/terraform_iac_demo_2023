resource "aws_iam_role" "traefik" {
  name_prefix        = "traefik-${var.env}-task-execution-role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF

  managed_policy_arns = [aws_iam_policy.ecs_task_exec.arn]

  lifecycle {
    create_before_destroy = true
  }
}

# TODO: tighten up resource * security
resource "aws_iam_policy" "ecs_task_exec" {
  name_prefix = "traefik-ecs-perms"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ecs:ListClusters",
          "ecs:DescribeClusters",
          "ecs:ListTasks",
          "ecs:DescribeTasks",
          "ecs:DescribeContainerInstances",
          "ecs:DescribeTaskDefinition",
          "ec2:DescribeInstances",
          "ssm:DescribeInstanceInformation"
        ],
        "Resource" : "*"
      }
    ]
  })

  lifecycle {
    create_before_destroy = true
  }
}


##############
### Ecs exec
# TODO: Darren to confirm whether he want to keep ECS exec after i finish debugging
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html
# https://github.com/aws/aws-cli/issues/6242
resource "aws_iam_role" "ecs_exec" {
  name_prefix        = "ecs-exec-${var.env}-task-role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF

  managed_policy_arns = [aws_iam_policy.ecs_task_exec.arn]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_policy" "ecs_ssm_exec" {
  name_prefix = "ecs-ssm-perms"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:DescribeInstanceInformation",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
          "logs:DescribeLogGroups",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        "Resource" : "*"
      }
    ]
  })

  lifecycle {
    create_before_destroy = true
  }
}

# ecs execute example
# aws ecs execute-command --cluster ecs-scaps-dev-sc \
#     --task task-id \
#     --container traefik-dev \
#     --interactive \
#     --command "/bin/sh"

# enables execute command

# aws ecs update-service --cluster CLUSTER_NAME --service SERVICE_NAME --region REGION --enable-execute-command --force-new-deployment

# adds ARN to environment for easier cli. Does assume only 1 task running for the service, otherwise just manually go to ECS and grab arn and set them for your cli

# TASK_ARN=$(aws ecs list-tasks --cluster CLUSTER_NAME --service SERVICE_NAME --region REGION --output text --query 'taskArns[0]')

# see the task,

# aws ecs describe-tasks --cluster CLUSTER_NAME --region REGION --tasks $TASK_ARN

# exec in

# aws ecs execute-command --region REGION --cluster CLUSTER_NAME --task $TASK_ARN --container CONTAINER --command "sh" --interactive
