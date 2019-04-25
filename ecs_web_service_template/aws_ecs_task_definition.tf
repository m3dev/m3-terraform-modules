resource "aws_ecs_task_definition" "main" {
  family = "${var.envname}-${var.application_name}"

  requires_compatibilities = [
    var.launch_type,
  ]

  cpu    = var.cpu
  memory = var.memory_mb

  network_mode = var.network_mode

  task_role_arn = aws_iam_role.ecs_task_role.arn

  # Fargate 起動タイプを使用するタスクの場合、Amazon ECR からコンテナイメージをプルしたり、現在この起動タイプでサポートされている唯一のログオプションである awslogs ログドライバーを使用したりするには、タスク実行ロールが必要です。
  # https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task_execution_IAM_role.html
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = var.container_definitions

  volume {
    name = var.volume_name
  }
}

