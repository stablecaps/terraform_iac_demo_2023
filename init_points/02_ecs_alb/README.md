![terraform_infra](./images/terraform_infra.png)


![terraform_infra](./)


![terraform_infra](./)


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.5.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.5.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ../../local_modules/ec2/alb/alb | n/a |
| <a name="module_target_group_traefik_admin8080"></a> [target\_group\_traefik\_admin8080](#module\_target\_group\_traefik\_admin8080) | ../../local_modules/ec2/target_group | n/a |
| <a name="module_target_group_web"></a> [target\_group\_traefik\_web80](#module\_target\_group\_traefik\_web80) | ../../local_modules/ec2/target_group | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener.http2https_redirect_listner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.webapp_subdomain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.webapp_subdomain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_acm_certificate.scaps](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [terraform_remote_state.secgroups](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Deployment environment. e.g. dev, uat, prod | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | Product name. e.g. scaps | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region. e.g. eu-west-1 | `string` | n/a | yes |
| <a name="input_webapp_subdomain"></a> [scaps\_subdomain](#input\_scaps\_subdomain) | Route53 webapp subdomain | `string` | n/a | yes |
| <a name="input_webapp_subdomain"></a> [traefik\_admin\_subdomain](#input\_traefik\_admin\_subdomain) | Route53 webapp subdomain | `string` | n/a | yes |
| <a name="input_health_check"></a> [traefik\_health\_check](#input\_traefik\_health\_check) | Traefik ping HealthCheck Map - 8082 | `map(string)` | <pre>{<br>  "enabled": "true",<br>  "healthy_threshold": "4",<br>  "interval": "30",<br>  "matcher": "200",<br>  "path": "/ping",<br>  "port": "8082",<br>  "protocol": "HTTP",<br>  "timeout": "20",<br>  "unhealthy_threshold": "2"<br>}</pre> | no |
| <a name="input_health_check_admin"></a> [traefik\_health\_check\_admin](#input\_traefik\_health\_check\_admin) | Traefik rawdata HealthCheck Map - 8080 | `map(string)` | <pre>{<br>  "enabled": "true",<br>  "healthy_threshold": "4",<br>  "interval": "30",<br>  "matcher": "200-499",<br>  "path": "/api/rawdata",<br>  "port": "8080",<br>  "protocol": "HTTP",<br>  "timeout": "20",<br>  "unhealthy_threshold": "10"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC ID. e.g. vpc-9op489p4e66e05588 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | n/a |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | n/a |
| <a name="output_alb_name"></a> [alb\_name](#output\_alb\_name) | n/a |
| <a name="output_target_group_traefik_admin8080_arn"></a> [target\_group\_traefik\_admin8080\_arn](#output\_target\_group\_traefik\_admin8080\_arn) | n/a |
| <a name="output_target_group_web_arn"></a> [target\_group\_traefik\_web80\_arn](#output\_target\_group\_traefik\_web80\_arn) | n/a |
<!-- END_TF_DOCS -->