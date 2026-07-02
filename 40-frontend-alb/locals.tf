locals {

  ami_id           = data.aws_ssm_parameter.vpc_id
  vpc_id           = data.aws_ssm_parameter.vpc_id.value
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  frontend_alb-sg-id= data.aws_ssm_parameter.frontend_alb_sg.value


  common_tags = {
    Project     = var.project
    Environment = var.environment
    Name        = "${local.common_name}"
    Terraform   = "True"
  }

  common_name = "${var.project}-${var.environment}"
  zone_id = data.aws_route53_zone.backend.zone_id
  domain_name = data.aws_route53_zone.backend.name
}