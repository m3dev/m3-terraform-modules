resource "aws_guardduty_detector" "main" {
  provider = aws.regional
  enable   = var.enable
  tags     = var.tags

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
}
