variable "project_name" {
  description = "Name of the project"
  default     = "startify"
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "db_username" {
  description = "Database username"
  default     = "startify_user"
}

variable "db_password" {
  description = "Database password"
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  default     = "startify_dbase"
}