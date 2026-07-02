variable "project" {
  type    = string
  default = "Roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}


variable "instances" {
  type = list(any)
  default = {

    catalogue = {
      rule_priority = 10
    }
    user = {
      rule_priority = 20
    }
    cart = {
      rule_priority = 30
    }
    shipping = {
      rule_priority = 40
    }
    payment = {
      rule_priority = 50
    }
     frontend = {
      rule_priority = 10
    }
  }
    
}