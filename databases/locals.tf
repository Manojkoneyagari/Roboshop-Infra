locals {

  ami_id = data.aws_ami.myami.id
  vpc_id = data.aws_ssm_parameter.vpc_id.value


  database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]


  mongodb_sg_id  = data.aws_ssm_parameter.mongodb_sg.value
  redis_sg_id    = data.aws_ssm_parameter.redis_sg.value
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg.value
  mysql_sg_id    = data.aws_ssm_parameter.mysql_sg.value


  common_tags = {
    Project     = var.project
    Environment = var.environment
    Name        = "${local.common_name}"
    Terraform   = "True"
  }

  common_name = "${var.project}-${var.environment}"

  zone_id     = "Z07186583IUMEVUQL0IYT"
  domain_name = "manojkoney.store"

}