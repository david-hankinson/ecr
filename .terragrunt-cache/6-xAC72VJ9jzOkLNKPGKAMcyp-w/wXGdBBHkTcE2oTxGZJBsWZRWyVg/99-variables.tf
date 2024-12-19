variable "repository_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "env" {
  description = "Which environment the infrastructure will be deployed in"
  type = string
}