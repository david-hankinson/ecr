terraform {
  source = "../ecr-module"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  # Environment
  env = include.env.locals.env
  ecr_repository_name = "ecr-rails-bank-trx-reporting"
  github_repo = "david-hankinson/rails-bank-trx-reporting"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "ecr-state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket  = "rails-bank-trx-reporting-ecr"
    key     = "ecr.terraform.tfstate"
    region  = "ca-central-1"
    encrypt = true
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "> 4.0"
      }
    }
}
EOF
}