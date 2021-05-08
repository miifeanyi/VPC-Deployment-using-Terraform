resource "aws_nat_gateway" "ngw1" {
  #The Allocation ID of the elastic IP address
  allocation_id = "aws_eip.NAT1.id"

  #Public subnet in which to place the gateway
  subnet_id = "aws_subnet.public1.id"

  tags = {
    "Name" = "NAT 1"
  }
}

resource "aws_nat_gateway" "ngw2" {
  #The Allocation ID of the elastic IP address
  allocation_id = "aws_eip.NAT2.id"

  #Public subnet in which to place the gateway
  subnet_id = "aws_subnet.public2.id"

  tags = {
    "Name" = "NAT 2"
  }
}
