module "vpc" {
    source = "git::https://github.com/Manojkoneyagari/VPC_Module.git?ref=main"
    environment = var.environment
    project = var.project
}

