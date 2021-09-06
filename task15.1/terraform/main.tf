provider "aws"{
  #access_key = "AKIAZVZYY2MI7DRM5TKU"
  #secret_key = "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"
  region="us-east-2"
}
resource "aws_vpc" "netology-vpc" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name = "netology-vpc"
  }
}