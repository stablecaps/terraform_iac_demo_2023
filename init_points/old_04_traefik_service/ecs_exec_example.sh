#!/bin/bash

### From https://github.com/aws/aws-cli/issues/6242#issuecomment-1079214960

# ecs execute example
# aws ecs execute-command --cluster ecs-scaps-dev-sc \
#     --task task-id \
#     --container traefik-dev \
#     --interactive \
#     --command "/bin/sh"

### enables execute command
aws ecs update-service --cluster ecs-scaps-dev-sc --service traefik-dev --region eu-west-1 --enable-execute-command --force-new-deployment

### adds ARN to environment for easier cli. Does assume only 1 task running for the service, otherwise just manually go to ECS and grab arn and set them for your cli
TASK_ARN=$(aws ecs list-tasks --cluster ecs-scaps-dev-sc --service traefik-dev --region eu-west-1 --output text --query 'taskArns[0]')

### see the task,
aws ecs describe-tasks --cluster ecs-scaps-dev-sc --region eu-west-1 --tasks $TASK_ARN

### exec in
aws ecs execute-command --region eu-west-1 --cluster ecs-scaps-dev-sc --task $TASK_ARN --container CONTAINER --command "sh" --interactive