# variable "aws_region" {
#   default = "us-east-1"
# }

variable "cidr_block" {
  type = map
  default = {
    "0" = "10.16.0.0/20"
    "1" = "10.16.16.0/20"
  }
}

variable "vpcs" {
  type    = list
  default = ["dev_vpc", "test_vpc"]
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.16.32.0/20", "10.16.48.0/20", "10.16.64.0/20", "10.16.80.0/20"]
}
