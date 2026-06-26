resource "aws_instance" "bastion" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id              = local.public_subnet_id
  key_name               = aws_key_pair.deployer.key_name
  iam_instance_profile   = aws_iam_instance_profile.bastion-profile.name



  user_data = templatefile("${path.module}/diskexpand.sh.tftpl", {})

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

    connection {
    type        = "ssh"
    host        = aws_instance.bastion.public_ip
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "file" {
      source      = "~/.ssh/id_rsa"
      destination = "/home/ubuntu/.ssh/id_rsa"
    } 

  tags = merge(
    local.common_tags, {
      Name = "${var.project}-${var.environment}-bastion"
    }
  )
}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
  #public_key = file(var.pub_key_path)
}