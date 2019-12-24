resource "aws_guardduty_detector" "main" {
  provider = aws.regional

  enable = var.enable
}
