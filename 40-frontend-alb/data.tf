

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "frontend_alb_sg" {
  name = "/frontend_alb/${var.project}/${var.environment}/sg_id"
}
data "aws_route53_zone" "backend" {
  name         = "manojkoney.store" # Replace with your registered domain name
  private_zone = false
}