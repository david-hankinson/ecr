resource "aws_iam_openid_connect_provider" "this" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # GitHub's OIDC thumbprint
}

resource "aws_iam_role" "this" {
  name = "GitHubActionsECRAdmin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.this.arn
        },
        Action    = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
            "token.actions.githubusercontent.com:sub": "repo:${var.github_repo}/${var.ecr_repository_name}:ref:refs/heads/main"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "this" {
  name = "GitHubActionsECRAdminPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "ecr:*", # All ECR actions (modify based on requirements)
        Resource = [
          data.aws_ecr_repository.this.arn,                             # ECR repository ARN
          "${data.aws_ecr_repository.this.arn}/*"                      # ECR repository images
        ]
      },
      {
        Effect   = "Allow",
        Action   = ["ecr:GetAuthorizationToken"], # Auth for Docker CLI pulls/pushes
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}