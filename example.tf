terraform {
  required_version = ">= 0.14"
}

module "my_vpc" {
  count = 2
  source = "./modules/vpc"
}