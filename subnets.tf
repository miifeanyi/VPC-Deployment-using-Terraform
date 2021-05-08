resource "aws_subnet" "public1" {
  vpc_id            = "aws_vpc.mainvpc.id"
  cidr_block        = "192.168.0.0/18"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "public-us-east-1a"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = "aws_vpc.mainvpc.id"
  cidr_block        = "192.168.64.0/18"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "public-us-east-1b"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = "aws_vpc.mainvpc.id"
  cidr_block        = "192.168.128.0/18"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-us-east-1a"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = "aws_vpc.mainvpc.id"
  cidr_block        = "192.168.192.0/18"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-us-east-1b"
  }
}
