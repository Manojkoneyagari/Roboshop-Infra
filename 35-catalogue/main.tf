resource "aws_instance" "catalogue" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id              = local.backend_subnet_id
  #key_name = aws_key_pair.deployer.key_name
  key_name = data.aws_key_pair.deployer.key_name



  tags = merge(
    local.common_tags, {
      Name = "${var.project}-${var.environment}-catalogue"
    }
  )
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  connection {
    type        = "ssh"
    host        = aws_instance.catalogue.private_ip
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
      "sudo sh /tmp/ansiblescript.sh catalogue"
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

 resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [ aws_instance.terraform_data ]
}


resource "aws_ami_from_instance" "catalogue_ami" {
  name               = "${local.common_name}-catalogue-${aws_instance.catalogue.id}"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_instance.terraform_data ]

  tags = merge(
    local.common_tags, {
      Name = "${local.common_name}-catalogue-${aws_instance.catalogue.id}",
      purpose = "ami"
    }
  )
}



resource "aws_launch_template" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"

  image_id = aws_ami_from_instance.catalogue_ami.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  key_name = data.aws_key_pair.deployer.key_name
  update_default_version = true 

  vpc_security_group_ids = [local.catalogue_sg_id]

  tag_specifications {
    resource_type = "instance"

    tags =merge(
    local.common_tags, {
      Name = "${local.common_name}-catalogue-${aws_instance.catalogue.id}",
      purpose = "launch_template"
    }
  )
}
}