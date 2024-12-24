variable "ecr_repository_name" {
  description = "String of repository name"
  type        = string # This ensures the variable expects a list of strings
}

variable "env" {
  description = "Which environment the infrastructure will be deployed in"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository"
  type        = string
}

# TODO - environmentalise this repo