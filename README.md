# Terraform IaC Demo 2023

## Overview
This demo repo handles the deployment of the scaps product. Briefly this involves the following:

1. Create an ECS fargate cluster
2. Create an ALB with relevant listener & target groups
3. Create an ECS service & task definition to run.

It also contains terraform files that:
1. Creates a remote s3 & terraform backend
2. Create a role that can be used by github actions for CI/CD

## Information flow

* Note that scaps & the traefik admin panel have security groups in which your IP address needs to be whitelisted.
* Additionally, scaps requires password authentication
* TBF: password protect trafik dashboard and `/api/rawdata`

##### Route53 --> ALB --> Listeners --> Target Groups --> ECS-Traefik-Service --> scaps-Service

## Access

#### NOTE: Your IP needs to be added to ALB security group to access services!!

**scaps:** scaps.stablecaps.co
**traefik admin panel:** scapsad.stablecaps.co/dashboard/

-------------------------------

## Terraform methodology:
Please see the following link for an explanation of the terraform method used in this project.

[Terraform method used](https://github.com/stablecaps/demo_terraform_and_serverless)

## Terraform helper script
A helper script is provided to make executing the terraform work cycle easier.

##### Options:

```
./xxx_tfhelper.sh terraform_v1.5.1 [autoapprove] [env] [action]

### Set autoapprove to <yes> if you are a boss!

### tf init
./xxx_tfhelper.sh terraform_v1.5.1 no prod init

### tf plan
./xxx_tfhelper.sh terraform_v1.5.1 no prod plan

### tf apply
./xxx_tfhelper.sh terraform_v1.5.1 no prod apply

### tf init & apply
./xxx_tfhelper.sh terraform_v1.5.1 no prod full
```

## Init Points

These are the several entrypoints in the `init_points` folder. These are numbered according to the order in which they should be run. There are some special folders prefixed with `00_`

0. init_points/00_terraform_backend_setup_CAREFUL

This creates the terraform backend using dynamodDB and s3. It only needs to be run once at the start of the project! Be very careful modifying this as you could nuke all the terraform backend configs!!!

1. **`init_points/00_create_security_groups_locally:`** Create scaps security groups using local aws credentials rather than give the Github actions runner permissions to do this. Reduce blast radius, you savvy?

2. **`init_points/00_github_actions_oidc:`** Give permissions to Github runner using openidc connect provider. More secure. Note that the IAM role ARN must be entered into the build pipeline yamls located in this repo at `.github/workflows/terraform_deploy_scaps_ecs.yml` and the scaps app repo located at `.github/workflows/docker-build-test-push-2ecr.yml`

3. **`init_points/01_ecs_cluster_fargate:`** Sets up the scaps ECS Fargate cluster

4. **`init_points/02_ecs_alb:`**  Sets up an application load balancer with HTTPS. It has two target groups that direct traefik to ECS-traefik & ECS-scaps.

5. **`init_points/03_route53_2alb:`** Sets up two domains:
    * scapsad.stablecaps.co: admin panel
    * scaps.stablecaps.co: scaps app
6. **`init_points/04_traefik_service:`** Sets up traefik service on ECS and registers it on ALB

7. **`init_points/05a_rds_scaps:`** Sets up a AWS mysql RDS service.

8. **`init_points/05b_rds_jumpbox:`** Sets up a EC2 jumpbox that can be utilised by devs to access the AWS mysql RDS service.

9. **`init_points/05c_ecs_scaps_service:`** Sets up scaps service on ECS and registers it on ALB. Note this service has password protection.

## How to deploy service

1. Go to github actions
2. Find the following workflow: [Deploy scaps to ECS](https://github.com/stablecaps/scaps_infra/actions/workflows/terraform_deploy_scaps_ecs.yml)
3. Press `Run Workflow` and enter in the scaps docker tag that you want to deploy fron [ECR](https://eu-west-1.console.aws.amazon.com/ecr/repositories/private/334406042632/scaps?region=eu-west-1). Note that the tag corresponds to the short commit hash of the last successful merge into main. Images are created from the [scaps app repo](https://github.com/stablecaps/scaps). More specifically via the following [github actions pipeline](https://github.com/stablecaps/scaps/actions/workflows/docker-build-test-push-2ecr.yml). HAve a look at that pipeline in the `Build, tag, and push image to Amazon ECR` stage. Press `cntrl+f` to find the string `naming to ***.dkr.ecr.eu-west-1.amazonaws.com/scaps`, the docker tag will be after the colon `:`. e.g. with `#11 naming to ***.dkr.ecr.eu-west-1.amazonaws.com/scaps:0c5a8f1 done`, `0c5a8f1` is the tag.