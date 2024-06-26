resource "aws_cloudwatch_event_rule" "rule_chatbot" {
  name        = var.rule_name
  description = "Event EC2 send notifications for SLACK"

  event_pattern = jsonencode({
    "source": ["aws.ec2"],
    detail-type = ["EC2 Instance State-change Notification"]
    "detail" :{
      "instance-id":["i-0fac74e47a2d9b9cc"],
      "state": ["stopped"]
    }
    })

  tags = var.default_tags
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.rule_chatbot.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_ec2.arn
}

# se a policy ja existir
# data "aws_sns_topic" "existing" {
#   name = "myHelloWorldNotifications"
# }

resource "aws_sns_topic" "aws_ec2" {
  name = "event_ec2"
  tags = var.default_tags
}

resource "aws_sns_topic_subscription" "event_slack_target" {
  topic_arn = aws_sns_topic.aws_ec2.arn
  protocol  = "https"
  endpoint  = "https://global.sns-api.chatbot.amazonaws.com"
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.aws_ec2.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
  
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.aws_ec2.arn]
  }
  
}