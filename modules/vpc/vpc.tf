resource "aws_vpc" "mainvpc" {
  cidr_block = "${var.vpc_cidr_block}"
  
  tags = var.resource_tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mainvpc.id
}

resource "aws_eip" "eip" {
  count = length(var.public_subnet_cidr_blocks)

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "ngw" {
  count = length(var.public_subnet_cidr_blocks)

  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = var.resource_tags
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(var.az, count.index)

  tags = var.resource_tags
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.az, count.index)

  tags = var.resource_tags
}
