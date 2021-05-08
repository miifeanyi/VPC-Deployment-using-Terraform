resource "aws_instance" "private-ec2" {
  ami               = "ami-0d5eff06f840b45e9"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "key-pair"
  subnet_id         = "aws_subnet.private1.id"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.private-ec2-nic.id
  }
}

resource "aws_network_interface" "private-ec2-nic" {
  subnet_id       = aws_subnet.private1.id
  private_ips     = ["192.168.128.12"]
  security_groups = [aws_security_group.allow_web.id]
}
