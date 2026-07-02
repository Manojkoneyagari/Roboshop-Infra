resource "aws_instance" "catalogue" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id              = local.private_subnet_id
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
  depends_on = [ terraform_data.catalogue]
}


resource "aws_ami_from_instance" "catalogue_ami" {
  name               = "${local.common_name}-catalogue-${aws_instance.catalogue.id}"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]

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

resource "aws_lb_target_group" "catalogue" {
  name        = "${var.project}-${var.environment}-catalogue"
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"  #by default it is instance, you can mention "ip" it means it targets only ip address
  vpc_id      = local.vpc_id
  deregistration_delay = 30

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    path = "/health"
    port = 8080
    protocol = "HTTP"
    interval = 20
    timeout = 5
    matcher = "200-299"

  }
}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${var.project}-${var.environment}-catalogue"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 120   #how long the Auto Scaling Group waits before checking the health of a newly launched instance.
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_template {
    id      = aws_launch_template.catalogue.id
    version = "$Latest"
  }
  vpc_zone_identifier       = [local.private_subnet_id]
  target_group_arns = [aws_lb_target_group.catalogue] # Autoscaling launches into specific target group


  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
      instance_warmup        = 120
    }

    triggers = ["launch_template"]
  }


  tag {
    key                 = "Name"
    value               = "${var.project}-${var.environment}-catalogue"
    propagate_at_launch = true
  }


 # with in 15min autoscaling should be successful to launch instances
  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  name                   = "${var.project}-${var.environment}-catalogue"
  adjustment_type        = "TargetTrackingScaling"
  estimated_instance_warmup = 120
   target_tracking_configuration {
      predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
   }
   }
  

resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.backend_alb_listener
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }


  condition {
    host_header {
      values = ["catalogue.backend_alb.${local.domain_name}"]
    }
  }
}