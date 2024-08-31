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
| [aws_alb_listener_rule.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | n/a | `any` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | n/a | `any` | n/a | yes |
| <a name="input_stickiness_duration"></a> [stickiness\_duration](#input\_stickiness\_duration) | n/a | `number` | `3600` | no |
| <a name="input_target_group_arn_A"></a> [target\_group\_arn\_A](#input\_target\_group\_arn\_A) | n/a | `any` | n/a | yes |
| <a name="input_target_group_arn_B"></a> [target\_group\_arn\_B](#input\_target\_group\_arn\_B) | n/a | `any` | n/a | yes |
| <a name="input_tg_weight_A"></a> [tg\_weight\_A](#input\_tg\_weight\_A) | n/a | `any` | n/a | yes |
| <a name="input_tg_weight_B"></a> [tg\_weight\_B](#input\_tg\_weight\_B) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
<!-- END_TF_DOCS -->