variable "environment" {
  description = "Enviroment of the VPC"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Which project the VPC belong to"
  type        = string
  default     = "infra-project"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_limit" {
  description = "Number of AZ"
  type        = number
  default     = 2
}
