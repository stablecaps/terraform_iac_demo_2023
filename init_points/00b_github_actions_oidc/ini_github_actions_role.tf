# TODO: take env out of this?
resource "aws_iam_role" "github_actions" {
  name_prefix        = "github-actions-ecr-role"
  assume_role_policy = data.aws_iam_policy_document.github_actions_oidc.json

  inline_policy {
    name   = "github-action-ecr"
    policy = data.aws_iam_policy_document.github_actions_ecr.json
  }

  # TODO: tighten up these full perms
  managed_policy_arns = local.managed_policy_arns

  lifecycle {
    create_before_destroy = true
  }

  tags = local.tags
}
