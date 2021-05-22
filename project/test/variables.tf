variable "aws_region" {
  default = "us-east-1"
}

variable "cidr_block" {
  default = "10.0.0.0/23"
}

variable "vpc_name" {
  type    = string
  default = "testvpc"
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.128/25", "10.0.1.128/25"]
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/25", "10.0.1.0/25"]
}

variable "public_route_table" {
  type    = list(any)
  default = ["public_route_table_1", "public_route_table_2"]
}

variable "private_route_table" {
  type    = list(any)
  default = ["private_route_table_1", "private_route_table_2"]
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "resource_tags" {
  type = map(string)
  default = {
    project     = "VPC-deployment",
    environment = "dev"
  }
}

variable "ingress_values" {
  type    = list(number)
  default = [443, 80, 22]
}