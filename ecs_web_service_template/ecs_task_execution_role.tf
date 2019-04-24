# ECS task execution role: https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task_execution_IAM_role.html
resource "aws_iam_role" "ecs_task_execution_role" {
  # "name_prefix" cannot be longer than 32 characters, name is limited to 64
  name_prefix = "${var.envname}-${var.application_name}-taskexec"

  assume_role_policy = "${data.aws_iam_policy_document.ecs_task_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_managed_policy" {
  role = "${aws_iam_role.ecs_task_execution_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_additional" {
  role = "${aws_iam_role.ecs_task_execution_role.name}"
  policy_arn = "${aws_iam_policy.ecs_task_execution_role_additional.arn}"
}

resource "aws_iam_policy" "ecs_task_execution_role_additional" {
  name_prefix = "${var.envname}-${var.application_name}-task-execution-role"
  policy = "${data.aws_iam_policy_document.ecs_task_execution_role_additional.json}"
}

data "aws_iam_policy_document" "ecs_task_execution_role_additional" {
  statement {
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_more_policy" {
  role = "${aws_iam_role.ecs_task_execution_role.name}"
  # Use dummy policy to avoid "computed" count issue of terraform.
  policy_arn = "${(var.task_execution_policy_arn == "") ? aws_iam_policy.ecs_task_execution_role_more_policy_dummy.arn : var.task_execution_policy_arn}"
}

resource "aws_iam_policy" "ecs_task_execution_role_more_policy_dummy" {
  name_prefix = "${var.envname}-${var.application_name}-dummy-policy-ter"
  policy = "${data.aws_iam_policy_document.ecs_task_execution_role_more_policy_dummy.json}"
}

data "aws_iam_policy_document" "ecs_task_execution_role_more_policy_dummy" {
  statement {
    actions = [
      "dummy:dummy"
    ]
    resources = [
      "*"
    ]
  }
}