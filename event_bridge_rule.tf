resource "aws_cloudwatch_event_rule" "rule_chatbot" {
  name        = var.rule_name
  description = "Event send notifications for chatbot"

  event_pattern = jsonencode({
        "version": "0",
        "id": "event_id_20240624",
        "detail-type": "EC2 Instance State-change Notification",
        "source": "aws.ec2",
        # "account": "730335411417",
        # "time": "2017-12-22T18:43:48Z",
        "region": "us-east-1",
        "resources": [
            "arn:aws:ec2:us-east-1:730335411417:instance/i-0fac74e47a2d9b9cc"
        ],
        "detail": {
            "instance-id": "0fac74e47a2d9b9cc",
            "state": "stopped"
        }
    })

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