resource "aws_lambda_permission" "ecr_deploy" {
  source_arn = aws_cloudwatch_event_rule.ecr_deploy.arn
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.update_ecs_service.function_name
  principal = "events.amazonaws.com"
}
