module "my_vpcA" {
  source     = "../../modules/vpc"
  vpc_name   = "testvpc"
  cidr_block = "10.0.0.0/17"
}

module "my_vpcB" {
  source     = "../../modules/vpc"
  vpc_name   = "dev_vpc"
  cidr_block = "10.0.128.0/17"
}
