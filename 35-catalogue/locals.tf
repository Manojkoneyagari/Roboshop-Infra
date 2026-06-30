locals {

  ami_id = data.aws_ami.myami.id
  vpc_id = data.aws_ssm_parameter.vpc_id.value


  backend_subnet_id = split(",", data.aws_ssm_parameter.backend_subnet_ids.value)[0]
  catalogue_sg_id  = data.aws_ssm_parameter.catalogue_sg.value
  


  common_tags = {
    Project     = var.project
    Environment = var.environment
    Name        = "${local.common_name}"
    Terraform   = "True"
  }

  common_name = "${var.project}-${var.environment}"


}