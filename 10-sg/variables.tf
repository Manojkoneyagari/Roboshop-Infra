variable "project" {
  type    = string
  default = "Roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "instances" {
  type = list(any)
  default = [
    "mongodb", "redis", "mysql", "rabbitmq",
    "catalogue", "user", "cart", "shipping", "payment",
    "backend_alb",
    "frontend", "frontend_alb",
    "Bastion"
  ]
}