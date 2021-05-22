module "my_vpcA" {
  source     = "../../modules/vpc"
  vpc_name   = "testvpc"
  cidr_block = "10.0.0.0/23"
}

module "my_vpcB" {
  source     = "../../modules/vpc"
  vpc_name   = "dev_vpc"
  cidr_block = "10.0.1.0/24"
}
