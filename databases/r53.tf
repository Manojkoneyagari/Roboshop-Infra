resource "aws_route53_record" "mongodb" {
  zone_id  = local.zone_id

  name = "mongodb.${local.domain_name}"
  type = "A"
  ttl  = 1

  records = [aws_instance.mongodb.private_ip]
}