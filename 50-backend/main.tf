module "backend" {
  for_each = var.instances
  source      = "git::https://github.com/Manojkoneyagari/Backend_Module.git?ref=main"
  environment = var.environment
  project     = var.project
  instance_type  = var.instance_type
  rule_priority = each.value.rule_priority
  component = each.key
}

