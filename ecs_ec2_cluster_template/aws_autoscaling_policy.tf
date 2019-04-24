resource "aws_autoscaling_policy" "main_add_instance" {
  name = "ecs-${var.application_name}-add-instance"
  autoscaling_group_name = "${aws_autoscaling_group.main.name}"

  scaling_adjustment = 1
  adjustment_type    = "ChangeInCapacity"
  cooldown           = 300
}

resource "aws_autoscaling_policy" "main_remove_instance" {
  name = "ecs-${var.application_name}-remove-instance"
  autoscaling_group_name = "${aws_autoscaling_group.main.name}"

  scaling_adjustment = -1
  adjustment_type    = "ChangeInCapacity"
  cooldown           = 300
}
