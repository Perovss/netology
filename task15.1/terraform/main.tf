provider "aws"{
  region="us-east-2"
}
resource "aws_vpc" "netology-vpc" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name = "netology-vpc"
  }
}