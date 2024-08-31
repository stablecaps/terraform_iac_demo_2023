### creating terraform backend **without** s3 repication. Will enable versioning
### No lifecycle rules implemented (e.g. noncurrent_version_transitions)

# TODO: warning these are not created with deletion protection (have raised a bug)
# but it may be an idea to fork this module repo and amke the changes ourselves as i think the module maybe unmaintained
# https://github.com/nozaq/terraform-aws-remote-state-s3-backend/issues/115
module "remote_state" {
  source  = "nozaq/remote-state-s3-backend/aws"
  version = "1.5.0"

  ### s3 settings
  override_s3_bucket_name = true
  s3_bucket_name          = local.base_name

  enable_replication      = false
  s3_bucket_force_destroy = false

  noncurrent_version_transitions = []


  ### DynamoDb settings
  # NOTE: no deletion protection option. Have opened request to add to module
  # https://github.com/nozaq/terraform-aws-remote-state-s3-backend/issues/115
  dynamodb_table_name                    = local.base_name
  dynamodb_table_billing_mode            = "PAY_PER_REQUEST"
  dynamodb_enable_server_side_encryption = true

  ### kms
  kms_key_alias = local.base_name

  ### Iam: Defaults are fine because we should use name prefix


  providers = {
    aws         = aws
    aws.replica = aws.replica # not used but required
  }
}
