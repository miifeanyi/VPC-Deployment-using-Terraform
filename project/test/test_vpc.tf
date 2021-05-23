module "myvpcA" {
  source     = "../../modules/vpc"
  cidr_block = var.cidr_block
}

module "myvpcB" {
  source     = "../../modules/vpc"
  cidr_block = var.cidr_block
}
