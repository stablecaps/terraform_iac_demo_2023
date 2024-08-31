resource "aws_iam_role" "scaps" {
  name_prefix        = "scaps-${var.env}-task-execution-role"
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

  managed_policy_arns = [aws_iam_policy.ecs_task_exec.arn, aws_iam_policy.ecs_ssm_exec.arn]

  lifecycle {
    create_before_destroy = true
  }
}

# TODO: tighten up resource * security
resource "aws_iam_policy" "ecs_task_exec" {
  name_prefix = "scaps-ecs-registry-and-logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameters",
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })

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

resource "aws_iam_policy" "private_ecr_auth" {
  name_prefix = "ecs-ssm-perms"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:Decrypt",
          "secretsmanager:GetSecretValue"
        ],
        "Resource" : "*"
      }
    ]
  })

  lifecycle {
    create_before_destroy = true
  }
}
#######################################################
# ecs execute example
# aws ecs execute-command --cluster ecs-vfdb-dev-rr \
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

# https://repost.aws/knowledge-center/ecs-unable-to-pull-secrets