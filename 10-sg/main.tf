module "sg" {
  source      = "git::https://github.com/Manojkoneyagari/SG_Module.git?ref=main"
  environment = var.environment
  project     = var.project
  instances   = var.instances
}

