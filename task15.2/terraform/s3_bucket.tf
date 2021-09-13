
resource "aws_s3_bucket" "b" {
  bucket = "perovss-netology"
  acl    = "public-read"

  tags = {
    Name    = "My bucket"
  }
}

resource "aws_s3_bucket_object" "img" {
  bucket = aws_s3_bucket.b.id
  key    = "netology.jpg"
  source = "files/netology.jpg"
  acl    = "public-read"

  etag = filemd5("files/netology.jpg")
}

data "aws_s3_bucket" "b" {
  bucket = aws_s3_bucket.b.id
}

data "aws_s3_bucket_object" "img" {
  bucket = aws_s3_bucket.b.id
  key    = aws_s3_bucket_object.img.id
}