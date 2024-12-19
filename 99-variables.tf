variable "repository_name" {
  description = "String of repository name"
  type        = string # This ensures the variable expects a list of strings
}


variable "security_groups" {
  type = map(object({
    description = string
    tags        = map(string)
  }))
  description = "Map of security group configurations"
}

variable "env" {
  description = "Which environment the infrastructure will be deployed in"
  type = string
}