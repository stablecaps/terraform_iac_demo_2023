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
| [aws_lb_listener.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_certificate.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_certificates"></a> [additional\_certificates](#input\_additional\_certificates) | additional certificates for the load balancer | `list(string)` | `[]` | no |
| <a name="input_alb_arn"></a> [alb\_arn](#input\_alb\_arn) | Name of the load balancer | `string` | n/a | yes |
| <a name="input_certificate"></a> [certificate](#input\_certificate) | ARN of the certificate for SSL | `string` | n/a | yes |
| <a name="input_elb_security_policy"></a> [elb\_security\_policy](#input\_elb\_security\_policy) | Load balancer security policy. Defaults to ELBSecurityPolicy-TLS13-1-2-2021-06 | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | ID of the target group to use | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
<!-- END_TF_DOCS -->