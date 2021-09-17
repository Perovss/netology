resource "aws_route53_zone" "private" {
  name = "perovss-netology.com"

  vpc {
    vpc_id = aws_vpc.netology-vpc.id
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "www.perovss-netology.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_elb.netology-elb.dns_name]
}