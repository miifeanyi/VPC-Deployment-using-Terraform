resource "aws_eip" "NAT1" {
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "NAT2" {
  depends_on = [aws_internet_gateway.gw]
}
