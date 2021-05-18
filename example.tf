terraform {
  required_version = ">= 0.14"
}

module "my_vpc_a" {
  source         = "./modules/vpc"
  vpcname        = "vpc_a"
  vpc_cidr_block = "10.0.0.0/16"
}

module "my_vpc_b" {
  source         = "./modules/vpc"
  vpcname        = "vpc_b"
  vpc_cidr_block = "10.1.0.0/16"
}
