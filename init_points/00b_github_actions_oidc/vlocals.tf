
locals {

  ### Note env will always be prod for this module
  tags = {
    environment = "prod"
    product     = "Github-Actions"
    owner       = "DevOps"
    created_by  = "terraform"
  }


  # TODO: tighten up these full perms
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
    data.aws_iam_policy.terraform_exec.arn,
    "arn:aws:iam::aws:policy/AWSCertificateManagerReadOnly",
    aws_iam_policy.iam_get_policy.arn,
  ]
}
