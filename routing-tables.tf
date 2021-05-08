#Create one Public route table with a default route to internet gateway
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

#Create private route table
resource "aws_route_table" "private-route-table-1" {
  vpc_id = "aws_vpc.mainvpc.id"
  route {

    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "aws_natgateway.ngw1.id"

  }
}

resource "aws_route_table" "private-route-table-2" {
  vpc_id = "aws_vpc.mainvpc.id"
  route {

    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "aws_natgateway.ngw2.id"

  }
}

#Associate Subnet with Route Table
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
