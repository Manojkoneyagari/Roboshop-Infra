data "aws_ami" "myami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "database_subnet_ids" {
  name = "/${var.project}/${var.environment}/database_subnet_ids"
}

data "aws_ssm_parameter" "mongodb_sg" {
  name = "/mongodb/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "redis_sg" {
  name = "/redis/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "rabbitmq_sg" {
  name = "/rabbitmq/${var.project}/${var.environment}/sg_id"
}

data "aws_ssm_parameter" "mysql_sg" {
  name = "/mysql/${var.project}/${var.environment}/sg_id"
}



data "aws_key_pair" "deployer" {
  key_name = "deployer-key"
}