resource "aws_launch_template" "app" {
  name_prefix   = "app-launch-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ec2_security_group_id]
  key_name               = var.key_name

  user_data = base64encode(file("${path.module}/user_data.sh"))

  lifecycle {
    create_before_destroy = true
  }

  iam_instance_profile {
  name = var.instance_profile_name
}


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name  = "ec2-instance"
      Owner = "André Santos"
    }
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                      = "app-asg"
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = var.private_subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = var.target_group_arns

  tag {
    key                 = "Owner"
    value               = "André Santos"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name  = "ec2-ssm-role"
    Owner = "André Santos"
  }
}

resource "aws_iam_role_policy_attachment" "attach_ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}
