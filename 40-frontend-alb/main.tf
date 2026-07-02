resource "aws_lb" "frontend_alb" {
  name               = "${var.project}-${var.environment}-frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb-sg-id]
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false

 
  tags = merge (
    local.common_tags, {
      Name = "${var.project}-${var.environment}-frontend_alb"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "fixed-response"

    fixed_response {

      content_type = "text/plain"
      message_body = "<h1>Hi, I am from HTTP frontend ALB</h1>"
      status_code = "200"
    }
  }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = local.zone_id
  name    = "${var.project}.${local.domain_name}" # The sub-domain you want to use
  type    = "A"

  alias {
    name                   = aws_lb.frontend_alb.dns_name
    zone_id                = aws_lb.frontend_alb.zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}