resource "aws_lb" "backend_alb" {
  name               = "${var.project}-${var.environment}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb-sg-id]
  subnets            = local.private_subnet_ids

  enable_deletion_protection = true

 
  tags = merge (
    local.common_tags, {
      Name = "${var.project}-${var.environment}-backend_alb"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "fixed-response"

    fixed_response {

      content_type = "text/plain"
      message_body = "<h1>Hi, I am from HTTP Backend ALB</h1>"
      status_code = "200"
    }
  }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = local.zone_id
  name    = "backend_alb.${local.domain_name}" # The sub-domain you want to use
  type    = "A"

  alias {
    name                   = aws_lb.backend_alb.dns_name
    zone_id                = local.zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}