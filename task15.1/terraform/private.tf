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

resource "aws_instance" "instance2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name  = aws_key_pair.my_key.key_name
  count = 1

  subnet_id = aws_subnet.private.id
  security_groups = [ aws_security_group.netology-sg.id ]

  tags = {
    Name = "instance2"
  }

}