terraform {
  source = "../../../ecr-module/"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
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
