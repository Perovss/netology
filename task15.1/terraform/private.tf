resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.netology-vpc.id
  cidr_block = "172.31.64.0/19"
  availability_zone = "us-east-2c"

  tags = {
    Name = "private"
  }
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "netology-nat-gw" {
  subnet_id = aws_subnet.public.id
  allocation_id = aws_eip.nat_gateway.id

  tags = {
    Name = "netology-nat-gw"
  }
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.netology-vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.netology-nat-gw.id
    }

  tags = {
    Name = "private-route"
  }
}

resource "aws_route_table_association" "netology-rta2" {
     subnet_id      = aws_subnet.private.id
     route_table_id = aws_route_table.private-route.id
}

resource "aws_key_pair" "my_key2" {
  key_name   = "my_key2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtofkxZqdUOafqSoMtSte1ND+Vw/4qWB5V9gMopKYSJadoR+PYUTcDcQ+TRCRSWfk58n4yEDHoMA1I+M6J13kC2wjh1P8Cwe39/9N+PV0JuJWC0+5Jxj4meGnqKmX0TbDhi2jxbN6PTL36wR9TpGh53URO0Y/lWnyH1DAhIgWwgo0SCTrkL93LDNF3D9rAEZAtasdmFnrFgciMa2i8be8eicORKwUWz9x+4WnSKc0xWlNp1qezUUAQloGTrR7c7aLXlplmQk+cQAqzEf2tMwbx/XAuYg4AjS16G+kjX7lfKz+GGJfgOcKRmRvi6VGHUxAPmXBMOrC5VZqnGONRnfNC99rCyMNNL/LTzdEGRW+KP4e331SBkA1C1WndV/9eSVQnSPvE7FFT906aDWyibQTYAi0x1AFOSN/FOSG/HkeKQqdQ0+y4JjOy3Xrye0KrHg41CPJ/Tx4t0bzHUB0zf7Kll3d8Y0tLxXH5kPRam2/k/wtJFMw0BeDY1u0j+FXTa3U= serge@Lenovo"
}

resource "aws_instance" "instance2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name  = aws_key_pair.my_key2.key_name
  count = 1

  subnet_id = aws_subnet.private.id
  security_groups = [ aws_security_group.netology-sg.id ]

  tags = {
    Name = "instance2"
  }

}