variable "vpc_id" {
  description = "VPC ID in PROD"
  default     = "vpc-0d3bf26f6cf25b7fc"
}
variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.23.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.23.0.0/24"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Nessus"
}

variable "region"{
  description = "The region Terraform deploys your instance"
}