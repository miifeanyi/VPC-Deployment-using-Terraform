resource "aws_nat_gateway" "ngw1" {
  allocation_id = "aws_eip.NAT1.id"
  subnet_id     = "aws_subnet.public1.id"

  tags = {
    "Name" = "NAT 1"
  }
}

resource "aws_nat_gateway" "ngw2" {
  allocation_id = "aws_eip.NAT2.id"
  subnet_id     = "aws_subnet.public2.id"

  tags = {
    "Name" = "NAT 2"
  }
}
