#NAT Gateway - this is used to enable instances in a private subnet to connect to the internet. 
#We need to allocate a public static IP address for the NAT Gateway. We will use elastic IP address service to achive this.
#use depends_on to set an explicit dependency on the internet gateway. We will use two NAT gateways to make it highly available 
#placing them in different availabilty zones

resource "aws_eip" "NAT1" {
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "NAT2" {
  depends_on = [aws_internet_gateway.gw]
}
