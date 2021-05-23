# variable "aws_region" {
#   default = "us-east-1"
# }

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/23"
}

variable "vpcs" {
  type    = string
  default = "dev_vpc"
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/26", "10.0.0.64/26"]
}
variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.128/26", "10.0.0.192/26"]
}

variable "public_route_table" {
  type    = list(any)
  default = ["public_route_table_1", "public_route_table_2"]
}

variable "private_route_table" {
  type    = list(any)
  default = ["private_route_table_1", "private_route_table_2"]
}

variable "ingress_values" {
  type    = list(number)
  default = [443, 80, 22]
}
