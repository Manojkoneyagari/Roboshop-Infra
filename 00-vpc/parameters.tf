resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.project}/${var.environment}/vpc_id"
  description = " storing vpc_id in SSM from vpc module"
  type        = "String"
  value       = module.vpc.vpc_id

  tags = merge ( local.common_tags,
    {
     Name = "${local.common_Name}-vpc_id"
  }
  )
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/${var.project}/${var.environment}/public_subnet_ids"
  description = " storing public_subnet_ids in SSM from vpc module"
  type        = "String"
  value       = join(",",module.vpc.public_subnet_ids)
  overwrite = true

  tags = merge ( local.common_tags,
    {
     Name = "${local.common_Name}-public_subnet_ids"
  }
  )
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/${var.project}/${var.environment}/private_subnet_ids"
  description = " storing private_subnet_ids in SSM from vpc module"
  type        = "String"
  value       = join(",",module.vpc.private_subnet_ids)
  overwrite = true

  tags = merge ( local.common_tags,
    {
     Name = "${local.common_Name}-private_subnet_ids"
  }
  )
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name        = "/${var.project}/${var.environment}/database_subnet_ids"
  description = " storing database_subnet_ids in SSM from vpc module"
  type        = "String"
  value       = join(",",module.vpc.database_subnet_ids)
  overwrite = true

  tags = merge ( local.common_tags,
    {
     Name = "${local.common_Name}-database_subnet_ids"
  }
  )
}