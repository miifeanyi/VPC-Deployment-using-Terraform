resource "aws_vpc" "mainvpc" {
  cidr_block = var.vpc_cidr_block

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

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.mainvpc.id

  dynamic "ingress" {
    for_each = var.ingress_values
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.public_subnet_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.public_subnet_cidr_blocks
  }
  tags = var.resource_tags
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = var.resource_tags
}

resource "aws_route_table" "private_route_table" {
  count = length(var.private_route_table)

  vpc_id = aws_vpc.mainvpc.id
  route {

    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[count.index].id
  }

  tags = var.resource_tags
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}
