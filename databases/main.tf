resource "aws_instance" "mongodb" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id              = local.database_subnet_id
  #key_name = aws_key_pair.deployer.key_name
  key_name = data.aws_key_pair.deployer.key_name



  tags = merge(
    local.common_tags, {
      Name = "${var.project}-${var.environment}-mongodb"
    }
  )
}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]
  connection {
    type        = "ssh"
    host        = aws_instance.mongodb.private_ip
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/id_rsa")
    host_key = null
  }

  provisioner "file" {
    source      = "ansiblescript.sh"
    destination = "/tmp/ansiblescript.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ansiblescript.sh",
      "sudo sh /tmp/ansiblescript.sh mongodb"
    ]
  }

}
/* 
  resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
  #public_key = file(var.pub_key_path)
}
 */

resource "aws_instance" "redis" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id              = local.database_subnet_id
  #key_name = aws_key_pair.deployer.key_name
  key_name = data.aws_key_pair.deployer.key_name



  tags = merge(
    local.common_tags, {
      Name = "${var.project}-${var.environment}-redis"
    }
  )
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]
  connection {
    type        = "ssh"
    host        = aws_instance.redis.private_ip
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/id_rsa")
    host_key = null
  }

  provisioner "file" {
    source      = "ansiblescript.sh"
    destination = "/tmp/ansiblescript.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ansiblescript.sh",
      "sudo sh /tmp/ansiblescript.sh redis"
    ]
  }

}

resource "aws_instance" "rabbitmq" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id              = local.database_subnet_id
  #key_name = aws_key_pair.deployer.key_name
  key_name = data.aws_key_pair.deployer.key_name



  tags = merge(
    local.common_tags, {
      Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )
}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]
  connection {
    type        = "ssh"
    host        = aws_instance.rabbitmq.private_ip
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/id_rsa")
    host_key = null
  }

  provisioner "file" {
    source      = "ansiblescript.sh"
    destination = "/tmp/ansiblescript.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ansiblescript.sh",
      "sudo sh /tmp/ansiblescript.sh rabbitmq"
    ]
  }

}

resource "aws_instance" "mysql" {
  ami                    = ami-05cf1e9f73fbad2e2
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id              = local.database_subnet_id
  #key_name = aws_key_pair.deployer.key_name
  key_name = data.aws_key_pair.deployer.key_name



  tags = merge(
    local.common_tags, {
      Name = "${var.project}-${var.environment}-mysql"
    }
  )
}

resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]
  connection {
    type        = "ssh"
    host        = aws_instance.mysql.private_ip
    user        = "ubuntu"
    private_key = file("/home/ubuntu/.ssh/id_rsa")
    host_key = null
  }

  provisioner "file" {
    source      = "ansiblescript.sh"
    destination = "/tmp/ansiblescript.sh"
  }


  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ansiblescript.sh",
      "sudo sh /tmp/ansiblescript.sh mysql"
    ]
  }

}