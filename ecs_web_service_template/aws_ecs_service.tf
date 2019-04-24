resource "aws_ecs_service" "main-non-awsvpc" {
  count = "${var.network_mode == "awsvpc" ? 0 : 1}"

  cluster = "${var.ecs_cluster_id}"
  name = "${var.envname}-${var.application_name}"

  deployment_minimum_healthy_percent = "${var.ecs_deployment_minimum_healthy_percent}"
  desired_count = "${var.ecs_service_desired_count}"
  launch_type = "${var.launch_type}"

  health_check_grace_period_seconds = "${var.health_check_grace_period_seconds}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.main.arn}"
    container_name = "${var.target_container_name}"
    container_port = "${var.target_container_port}"
  }

  task_definition = "${aws_ecs_task_definition.main.arn}"
}

resource "aws_ecs_service" "main-awsvpc" {
  count = "${var.network_mode == "awsvpc" ? 1 : 0}"

  cluster = "${var.ecs_cluster_id}"
  name = "${var.envname}-${var.application_name}"

  deployment_minimum_healthy_percent = "${var.ecs_deployment_minimum_healthy_percent}"
  desired_count = "${var.ecs_service_desired_count}"
  launch_type = "${var.launch_type}"

  health_check_grace_period_seconds = "${var.health_check_grace_period_seconds}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.main.arn}"
    container_name = "${var.target_container_name}"
    container_port = "${var.target_container_port}"
  }

  network_configuration {
    # awsvpc 以外でこのブロックがあると、右記のエラーになる: InvalidParameterException: Network Configuration is not valid for the given networkMode of this task definition.
    # なので resource 定義まるごと分けて対処している... (terraform 0.12 以降であればこのブロックだけを条件分岐で切り替えられるのだが)
    subnets = [
      "${var.subnet_ids}"
    ]

    security_groups = [
      "${concat(list(aws_security_group.container.id), var.additional_security_groups)}"
    ]
  }

  task_definition = "${aws_ecs_task_definition.main.arn}"
}
