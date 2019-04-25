resource "aws_autoscaling_group" "main" {
  name = "ecs-${var.application_name}"

  vpc_zone_identifier = var.subnet_ids

  health_check_type         = "EC2"
  health_check_grace_period = 300

  max_size         = var.autoscaling_max
  desired_capacity = var.autoscalling_desired_capacity
  min_size         = var.autoscaling_min

  # TODO: initial_lifecycle_hook で autoscaling:EC2_INSTANCE_LAUNCHING を通知する

  launch_template {
    id      = aws_launch_template.main.id
    version = aws_launch_template.main.latest_version
  }

  tag {
    propagate_at_launch = true
    key                 = "Name"
    value               = "ecs-${var.application_name}"
  }
  timeouts {
    delete = "15m"
  }
}

