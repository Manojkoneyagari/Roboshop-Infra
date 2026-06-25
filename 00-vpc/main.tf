module "vpc" {
    source = "git::https://github.com/Manojkoneyagari/terraform-infra.git//modules/VPC_Module?ref=main"
    environment = var.environment
    project = var.project
}

