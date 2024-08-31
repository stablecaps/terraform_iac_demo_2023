data "aws_iam_policy_document" "github_actions_oidc" {
  statement {
    sid     = "GithubActionsRepoAssume"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = ["repo:stablecaps/*"]
    }
  }
}

data "aws_iam_policy_document" "github_actions_ecr" {
  statement {
    sid = "RepoReadWriteAccess"
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]
    resources = [
      "arn:aws:ecr:eu-west-1:334406042632:repository/*"
    ]
  }

  statement {
    sid       = "GetAuthorizationToken"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }
}

############################################
resource "aws_iam_policy" "iam_get_policy" {
  name_prefix = "githubactions_getiam"
  path        = "/"
  policy      = data.aws_iam_policy_document.iam_get_poldoc.json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "iam_get_poldoc" {
  statement {
    sid = "iamGetPassRole"
    actions = [
      "iam:GetRole",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListRolePolicies"
    ]
    resources = [
      "arn:aws:iam::334406042632:policy/scaps-ecs-registry-and-logs*",
      "arn:aws:iam::334406042632:policy/traefik-ecs-perms*",
      "arn:aws:iam::334406042632:policy/ecs-ssm-perms*",
      "arn:aws:iam::334406042632:role/ecs-exec-prod-task-role*",
      "arn:aws:iam::334406042632:role/traefik-prod-task-execution-role*",
      "arn:aws:iam::334406042632:role/scaps-prod-task-execution-role*",
    ]
  }
}
