locals {
    common_tags = {
        Name = "${local.common_Name}"
        project = var.project
        environment = var.environment
    }
   common_Name = "${var.project}-${var.environment}"
}