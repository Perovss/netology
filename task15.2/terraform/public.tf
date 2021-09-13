resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.netology-vpc.id
  cidr_block = "172.31.32.0/19"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public"
  }
}
resource "aws_internet_gateway" "netology-gw" {
  vpc_id = aws_vpc.netology-vpc.id
  tags = {
    Name = "netology-gw"
  }
}
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.netology-vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.netology-gw.id
    }
  tags = {
    Name = "public-route"
  }
}
resource "aws_route_table_association" "netology-rta1" {
     subnet_id      = aws_subnet.public.id
     route_table_id = aws_route_table.public-route.id
}


# resource "aws_instance" "instance-1" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"
#   key_name  = aws_key_pair.my_key.key_name
#   count = 1
#   subnet_id = aws_subnet.public.id
#   associate_public_ip_address = true
#   security_groups = [ aws_security_group.netology-sg.id ]

#   tags = {
#     Name = "instance-1"
#   }
# }
resource "aws_security_group" "netology-sg" {
  name   = "netology-sg"
  vpc_id = aws_vpc.netology-vpc.id

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.netology-sg.id
}

resource "aws_security_group_rule" "icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.netology-sg.id
}
