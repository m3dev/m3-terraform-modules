# Need to replace "${topic_arn}"
data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }

    resources = [
      "$${topic_arn}",
    ]

    sid = "__default_statement_ID"
  }


  # https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/resource-based-policies-cwe.html
  statement {
    sid = "TrustCWEToPublishEventsToMyTopic"
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "events.amazonaws.com"
      ]
    }

    actions = [
      "sns:Publish",
    ]

    resources = [
      "$${topic_arn}",
    ]
  }
}