<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | HealthCheck Map | `map(string)` | <pre>{<br>  "enabled": "true",<br>  "healthy_threshold": "4",<br>  "interval": "30",<br>  "matcher": "200",<br>  "path": "/",<br>  "port": "traffic-port",<br>  "protocol": "HTTP",<br>  "timeout": "20",<br>  "unhealthy_threshold": "2"<br>}</pre> | no |
| <a name="input_health_check_target"></a> [health\_check\_target](#input\_health\_check\_target) | target for the health check | `string` | `"/"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix of the target group | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | Target group port. e.g. 80 | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Network protocol. e.g. HTTP, HTTPS | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tag set to use | `any` | n/a | yes |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | Network protocol. e.g. instance, ip | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
<!-- END_TF_DOCS -->