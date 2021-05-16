terraform {
  required_version = ">= 0.14"
}

module "my_vpc" {
  source = "./modules/vpc"
}