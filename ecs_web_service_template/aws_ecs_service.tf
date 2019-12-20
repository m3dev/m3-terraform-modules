resource "aws_ecs_service" "main-non-awsvpc" {
  count = var.network_mode == "awsvpc" ? 0 : 1

  cluster = var.ecs_cluster_id
  name    = "${var.envname}-${var.application_name}"

  deployment_maximum_percent         = var.ecs_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.ecs_deployment_minimum_healthy_percent
  desired_count                      = var.ecs_service_desired_count
  launch_type                        = var.launch_type

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = var.target_container_name
    container_port   = var.target_container_port
  }

  task_definition = aws_ecs_task_definition.main.arn
}

resource "aws_ecs_service" "main-awsvpc" {
  count = var.network_mode == "awsvpc" ? 1 : 0

  cluster = var.ecs_cluster_id
  name    = "${var.envname}-${var.application_name}"

  deployment_maximum_percent         = var.ecs_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.ecs_deployment_minimum_healthy_percent
  desired_count                      = var.ecs_service_desired_count
  launch_type                        = var.launch_type

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = var.target_container_name
    container_port   = var.target_container_port
  }

  network_configuration {
    # awsvpc 以外でこのブロックがあると、右記のエラーになる: InvalidParameterException: Network Configuration is not valid for the given networkMode of this task definition.
    # なので resource 定義まるごと分けて対処している... (terraform 0.12 以降であればこのブロックだけを条件分岐で切り替えられるのだが)
    subnets = var.subnet_ids

    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibilty in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    security_groups = [
      concat(
        [aws_security_group.container.id],
        var.additional_security_groups,
      ),
    ]
  }

  task_definition = aws_ecs_task_definition.main.arn
}

