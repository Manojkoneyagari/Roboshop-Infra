data "aws_ssm_parameter" "mongodb_sg" {
  name = "/mongodb/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "redis_sg" {
  name = "/redis/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "mysql_sg" {
  name = "/mysql/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "rabbitmq_sg" {
  name = "/rabbitmq/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "catalogue_sg" {
  name = "/catalogue/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "user_sg" {
  name = "/user/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "cart_sg" {
  name = "/cart/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "shipping_sg" {
  name = "/shipping/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "payment_sg" {
  name = "/payment/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "backend_alb_sg" {
  name = "/backend_alb/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "frontend_sg" {
  name = "/cart/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "frontend_alb_sg" {
  name = "/frontend_alb/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "Bastion_sg" {
  name = "/Bastion/${var.project}/${var.environment}/sg_id"
}

data "http" "my_public_ip" {
  url = "https://ipv4.icanhazip.com"
}
