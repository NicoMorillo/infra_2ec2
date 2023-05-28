variable "ami" {
  description = "AMI Ubuntu 20"
  type        = string
  default     = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  description = "Instace type"
  type        = string
  default     = "t2.micro"
}

