terraform {
  source = "./ecr"
}

inputs = {
  # Environment
  env = "dev"
  ecr_repository_name = "ecr-rails-bank-trx-reporting"
  github_repo = "david-hankinson/rails-bank-trx-reporting"
}

# generate "provider" {
#   path = "provider.tf"
#   if_exists = "overwrite_terragrunt"
#
#   contents = <<EOF
# provider "aws" {
#       version = "~> 4.0"
#     }
# }
# EOF
# }
#
# remote_state {
#   backend = "s3"
#   generate = {
#     path      = "state.tf"
#     if_exists = "overwrite_terragrunt"
#   }
#
#   config = {
#     bucket  = "rails-bank-trx-reporting-ecr"
#     key     = "terraform.tfstate"
#     region  = "ca-central-1"
#     encrypt = true
#   }
# }