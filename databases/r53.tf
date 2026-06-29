resource "aws_route53_record" "mongodb" {
  zone_id = local.zone_id

  name = "mongodb.${local.domain_name}"
  type = "A"
  ttl  = 1

  records = [aws_instance.mongodb.private_ip]
}


resource "aws_route53_record" "redis" {
  zone_id = local.zone_id

  name = "redis.${local.domain_name}"
  type = "A"
  ttl  = 1

  records = [aws_instance.redis.private_ip]
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = local.zone_id

  name = "rabbitmq.${local.domain_name}"
  type = "A"
  ttl  = 1

  records = [aws_instance.rabbitmq.private_ip]
}

resource "aws_route53_record" "mysql" {
  zone_id = local.zone_id

  name = "mysql.${local.domain_name}"
  type = "A"
  ttl  = 1

  records = [aws_instance.mysql.private_ip]
}