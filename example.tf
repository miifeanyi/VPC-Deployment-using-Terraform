terraform {
  required_version = ">= 0.14"
}

module "my_vpc" {
  count = 2
  
  source = "./modules/vpc"
  vpcname = "${var.vpcname}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
  vpc_id = "${var.vpc_id}"
}
