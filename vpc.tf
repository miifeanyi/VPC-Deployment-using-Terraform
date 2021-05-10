resource "aws_vpc" "mainvpc" {
  cidr_block = var.vpc_cidr_block

  tags = var.resource_tags
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(var.az, count.index)

  tags = var.resource_tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mainvpc.id
}

resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidr_blocks)

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "ngw" {
  count = length(var.public_subnet_cidr_blocks)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = var.resource_tags
}

# resource "aws_subnet" "private1" {
#   vpc_id            = aws_vpc.mainvpc.id
#   cidr_block        = element(var.private_subnet_cidr_blocks, 0)
#   availability_zone = element(var.az, 0)

#   tags = var.resource_tags
# }

# resource "aws_subnet" "private2" {
#   vpc_id            = aws_vpc.mainvpc.id
#   cidr_block        = element(var.private_subnet_cidr_blocks, 1)
#   availability_zone = element(var.az, 1)

#   tags = var.resource_tags
# }

# resource "aws_security_group" "allow_web" {
#   name        = "allow_web_traffic"
#   description = "Allow Web inbound traffic"
#   vpc_id      = aws_vpc.mainvpc.id

#   ingress {
#     description = "HTTPS Traffic"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [var.public_subnet_cidr_blocks]
#   }

#   ingress {
#     description = "HTTP Traffic"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = [var.public_subnet_cidr_blocks]
#   }

#   ingress {
#     description = "SSH Traffic"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [var.public_subnet_cidr_blocks]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = [var.public_subnet_cidr_blocks]
#   }

#   tags = var.resource_tags
# }

# resource "aws_route_table" "public-route-table" {
#   vpc_id = aws_vpc.mainvpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }
# }

# resource "aws_route_table" "private-route-table-1" {
#   vpc_id = aws_vpc.mainvpc.id
#   route {

#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.ngw1.id
#   }
# }

# resource "aws_route_table" "private-route-table-2" {
#   vpc_id = aws_vpc.mainvpc.id
#   route {

#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.ngw2.id
#   }
# }

# resource "aws_route_table_association" "public1" {
#   subnet_id      = aws_subnet.public1.id
#   route_table_id = aws_route_table.public-route-table.id
# }

# resource "aws_route_table_association" "public2" {
#   subnet_id      = aws_subnet.public2.id
#   route_table_id = aws_route_table.public-route-table.id
# }

# resource "aws_route_table_association" "private1" {
#   subnet_id      = aws_subnet.private1.id
#   route_table_id = aws_route_table.private-route-table-1.id
# }

# resource "aws_route_table_association" "private2" {
#   subnet_id      = aws_subnet.private2.id
#   route_table_id = aws_route_table.private-route-table-2.id
# }

# resource "aws_eip" "default" {
#   depends_on = [aws_internet_gateway.gw]
#   count      = 2
#   name       = "NAT-${count.index}"
# }
