resource "aws_vpc" "mainvpc" {
  cidr_block = "${lookup(var.cidr_block, count.index)}"
  count = 2

  tags = {
    Name = "${element(var.vpcs, count.index)}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr_blocks)

  vpc_id            = "${module.vpc.vpc_id}"
  cidr_block        = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.az, count.index)
}
