resource "aws_iam_role" "ecs_task_role" {
  name_prefix = "${var.envname}-${var.application_name}-task-role"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policies" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = var.policy_arn
}

