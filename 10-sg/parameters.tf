resource "aws_ssm_parameter" "sg_names" {
  count = length(var.instances)
  name        = "/${var.instances[count.index]}/${var.project}/${var.environment}/sg_id"
  description = " storing ${var.instances[count.index]} id in SSM from sg module"
  type        = "String"
  value       = module.sg[count.index].sg_ids

}
