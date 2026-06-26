resource "aws_instance" "mongodb" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id              = local.database_subnet_id
  key_name = aws_key_pair.deployer.key_name



  tags = merge(
    local.common_tags, {
      Name = "${var.project}-${var.environment}-bastion"
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
    private_key = file("~/.ssh/id_rsa")
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

  resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
  #public_key = file(var.pub_key_path)
}
