module "myvpcA" {
  source     = "../../modules/vpc"
  cidr_block = "10.0.0.0/23"

  az                         = ["us-east-1a", "us-east-1b"]
  private_subnet_cidr_blocks = ["10.0.0.0/26", "10.0.0.64/26"]
  public_subnet_cidr_blocks  = ["10.0.0.128/26", "10.0.0.192/26"]
}
