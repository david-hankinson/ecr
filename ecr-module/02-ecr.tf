module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = var.ecr_repository_name

  repository_read_write_access_arns = [aws_iam_role.this.arn]
  create_lifecycle_policy           = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
  repository_force_delete = true
  # depends_on              = [aws_iam_policy.this, aws_iam_role.this, aws_iam_role_policy_attachment.this, aws_iam_openid_connect_provider.this]
}