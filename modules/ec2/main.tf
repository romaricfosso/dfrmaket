
resource "aws_iam_instance_profile" "this" {
  name = "wordpress-instance-profile"
  role = var.iam_instance_role_name
}

resource "aws_autoscaling_group" "wordpress" {
  name                      = "wordpress-asg"
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.wordpress.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "wordpress-ec2"
    propagate_at_launch = true
  }

  lifecycle {
    prevent_destroy = false
  }

  # tags = var.tags
}
resource "aws_autoscaling_attachment" "alb_target_group" {
  autoscaling_group_name = aws_autoscaling_group.wordpress.name
  lb_target_group_arn    = var.alb_target_group_arn
}
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "wordpress-scale-out"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.wordpress.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "wordpress-scale-in"
  autoscaling_group_name = aws_autoscaling_group.wordpress.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 30.0
  }
}
