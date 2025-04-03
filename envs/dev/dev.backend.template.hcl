region         = "eu-west-1"
bucket         = "terraform-remotestate-stablecaps-dev"
dynamodb_table = "terraform-remotestate-stablecaps-dev"
kms_key_id     = "arn:aws:kms:eu-west-1:$AWS_ACC_NO:key/$KEY_ID"