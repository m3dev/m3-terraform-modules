resource "aws_guardduty_detector" "main" {
  provider = aws.regional
  enable   = var.enable

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency

  tags = var.tags
}
