terraform {
  backend "s3" {
    bucket = "my_terraform"
    key    = "terraform.tfstate"
    region = "eu-west-1a"
  }
}