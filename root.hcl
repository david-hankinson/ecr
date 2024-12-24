terraform {
  source = "."
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