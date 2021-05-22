variable "aws_region" {
  default = "us-east-1"
}

variable "cidr_block" {
  default = "10.0.0.0/23"  
}

variable "vpc_name" {
  type = string
  default = "testvpc"
}

locals {
  name = "test"
}
