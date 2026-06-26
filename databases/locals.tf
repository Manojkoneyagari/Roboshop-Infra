locals {

  ami_id           = data.aws_ami.myami.id
  vpc_id           = data.aws_ssm_parameter.vpc_id.value
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
  bastion_sg_id    = data.aws_ssm_parameter.bastion_sg.value


  common_tags = {
    Project     = var.project
    Environment = var.environment
    Name        = "${local.common_name}"
    Terraform   = "True"
  }

  common_name = "${var.project}-${var.environment}"

}