resource "aws_iam_role" "lambda_execution" {
  name_prefix = "${var.name_prefix}lambda_execution"
  assume_role_policy = data.aws_iam_policy_document.lambda_execution_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_execution_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}


resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "update_ecs_service" {
  role = aws_iam_role.lambda_execution.name
  policy_arn = aws_iam_policy.update_ecs_service.arn
}

resource "aws_iam_policy" "update_ecs_service" {
  name = "${var.name_prefix}update_ecs_service"
  policy = data.aws_iam_policy_document.update_ecs_service.json
}

resource "random_id" "sid" {
  byte_length = 8
}

data "aws_iam_policy_document" "update_ecs_service" {
  statement {
    sid = random_id.sid.hex
    actions = [
      "ecs:UpdateService"
    ]
    resources = [
      var.ecs_service_arn
    ]
  }
}
