vpc_id          = "vpc-9op489p4e66e05588"
subnet_name_tag = "scaps-dev-sc-public-eu-west-1*"
region          = "eu-west-1"
env             = "dev"
product         = "scaps"

### assuming we need a compute optoimised spot instance. Set to t3a during testing
instance_type = "t3a.nano"

### ALB


### ECS service (scaps)
docker_image = "115588969956.dkr.ecr.eu-west-1.amazonaws.com/simple-docker-webapp"
docker_tag   = "1.0.0"


### Route53
acm_domain       = "sremechanix.tech"
webapp_subdomain = "scapsad-dev.sremechanix.tech"
webapp_subdomain  = "scaps-dev.sremechanix.tech"
ttl              = 60


