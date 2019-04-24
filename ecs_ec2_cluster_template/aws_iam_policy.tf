resource "aws_iam_policy" "cloudwatch_logs_agent" {
  name_prefix = "${var.envname}-${var.application_name}-logs-agent"
  description = "Allow CloudWatch logs agent to send logs from ECS instance '${var.ecs_cluster_id}'"

  policy = "${data.aws_iam_policy_document.cloudwatch_logs_agent.json}"
}

data "aws_iam_policy_document" "cloudwatch_logs_agent" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "ecs_instance_role_assune" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }

  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "ecs.amazonaws.com"
      ]
    }
  }
}
