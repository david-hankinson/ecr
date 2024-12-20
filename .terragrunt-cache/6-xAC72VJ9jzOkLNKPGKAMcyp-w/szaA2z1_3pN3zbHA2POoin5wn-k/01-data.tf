data "aws_caller_identity" "current" {}
data "aws_ecr_repository" "this" {
  name = module.ecr.repository_name

  depends_on = [module.ecr]
}