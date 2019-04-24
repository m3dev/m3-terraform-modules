resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.envname}-${var.application_name}-ecs-instance"
  role = "${aws_iam_role.ecs_instance_role.name}"
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.envname}-${var.application_name}-ecs-instance-role"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_instance_role_assune.json}"
}

resource "aws_iam_role_policy_attachment" "ecs_service_role" {
  role = "${aws_iam_role.ecs_instance_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_role_policy_attachment" "ecs_service_ec2_role" {
  role = "${aws_iam_role.ecs_instance_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ssm_role" {
  role = "${aws_iam_role.ecs_instance_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}


resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  role = "${aws_iam_role.ecs_instance_role.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_logs_agent.arn}"
}
