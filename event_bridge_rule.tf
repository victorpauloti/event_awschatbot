resource "aws_cloudwatch_event_rule" "rule_chatbot" {
  name        = var.rule_name
  description = "Event EC2 send notifications for chatbot"

  event_pattern = jsonencode(
    {
    detail-type = [
      "EC2 Instance State-change Notification" 
      ]
    }
    )

  tags = var.default_tags
}

# resource "aws_cloudwatch_event_target" "sns" {
#   rule      = aws_cloudwatch_event_rule.console.name
#   target_id = "SendToSNS"
#   arn       = aws_sns_topic.aws_logins.arn
# }

# resource "aws_sns_topic" "aws_logins" {
#   name = "aws-console-logins"
# }

# resource "aws_sns_topic_policy" "default" {
#   arn    = aws_sns_topic.aws_logins.arn
#   policy = data.aws_iam_policy_document.sns_topic_policy.json
# }

# data "aws_iam_policy_document" "sns_topic_policy" {
#   statement {
#     effect  = "Allow"
#     actions = ["SNS:Publish"]

#     principals {
#       type        = "Service"
#       identifiers = ["events.amazonaws.com"]
#     }

#     resources = [aws_sns_topic.aws_logins.arn]
#   }
# }