resource "aws_vpc" "mainvpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    "Name" = "Production"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = "192.168.0.0/18"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "public-us-east-1a"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = "192.168.64.0/18"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "public-us-east-1b"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = "192.168.128.0/18"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-us-east-1a"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.mainvpc.id
  cidr_block        = "192.168.192.0/18"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-us-east-1b"
  }
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.mainvpc.id

  ingress {
    description = "HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table" "private-route-table-1" {
  vpc_id = aws_vpc.mainvpc.id
  route {

    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw1.id
  }
}

resource "aws_route_table" "private-route-table-2" {
  vpc_id = aws_vpc.mainvpc.id
  route {

    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw2.id
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private-route-table-1.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private-route-table-2.id
}

resource "aws_nat_gateway" "ngw1" {
  allocation_id = aws_eip.NAT1.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    "Name" = "NAT 1"
  }
}

resource "aws_nat_gateway" "ngw2" {
  allocation_id = aws_eip.NAT2.id
  subnet_id     = aws_subnet.public2.id

  tags = {
    "Name" = "NAT 2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mainvpc.id
}

resource "aws_eip" "NAT1" {
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "NAT2" {
  depends_on = [aws_internet_gateway.gw]
}
