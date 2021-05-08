#Create the AWS Virtual Private Cloud (VPC)
resource "aws_vpc" "mainvpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    "Name" = "Production"
  }
}

