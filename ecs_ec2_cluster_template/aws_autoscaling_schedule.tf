resource "aws_autoscaling_schedule" "autoscaling_shutdown" {
  count                  = var.autoscaling_scaledown_between_utc[0] == "" ? 0 : 1
  scheduled_action_name  = "ecs-${var.application_name}-autoscaling-shutdown"
  autoscaling_group_name = aws_autoscaling_group.main.name

  recurrence = var.autoscaling_scaledown_between_utc[0]

  min_size         = var.autoscaling_scaledown_min
  desired_capacity = var.autoscaling_scaledown_desired_capacity
  max_size         = var.autoscaling_scaledown_max
}

resource "aws_autoscaling_schedule" "autoscaling_restart" {
  count                  = var.autoscaling_scaledown_between_utc[1] == "" ? 0 : 1
  scheduled_action_name  = "ecs-${var.application_name}-autoscaling-restart"
  autoscaling_group_name = aws_autoscaling_group.main.name

  recurrence = var.autoscaling_scaledown_between_utc[1]

  min_size         = var.autoscaling_min
  desired_capacity = var.autoscalling_desired_capacity
  max_size         = var.autoscaling_max
}

