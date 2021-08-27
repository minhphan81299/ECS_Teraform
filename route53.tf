data "aws_route53_zone" "main" {
  name = "minhpn08.com"
}

resource "aws_route53_record" "dev-ns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "minhpn08.com"
  type    = "A"
  alias {
    name                   = aws_lb.api.dns_name
    zone_id                = aws_lb.api.zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "server" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "be.minhpn08.com"
  type    = "A"
  alias {
    name                   = aws_lb.api.dns_name
    zone_id                = aws_lb.api.zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "test-ns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "db.minhpn08.com"
  type    = "CNAME"
  records = [aws_db_instance.database.address]
  ttl     = "300"
}

output "mydomain_zoneid" {
  value = data.aws_route53_zone.main.id
}

output "mydomain_name" {
  value = data.aws_route53_zone.main.name
}
