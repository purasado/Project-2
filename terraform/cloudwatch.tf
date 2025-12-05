resource "aws_sns_topic" "alerts_topic" {
  name = "${var.project_name}-alerts"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.alerts_topic.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_metric_filter" "error_count_filter" {
  name           = "${var.project_name}-error-count-filter"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
  pattern        = "ERROR"
  metric_transformation {
    name      = "${var.project_name}-error-count"
    namespace = "Application"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "health_failures" {
  alarm_name          = "${var.project_name}-health-failures"
  alarm_description   = "Alarm when application error count > 0 in 5 minutes"
  namespace           = "Application"
  metric_name         = "${var.project_name}-error-count"
  statistic           = "Sum"
  period              = 60
  evaluation_periods  = 5
  threshold           = 0
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = [aws_sns_topic.alerts_topic.arn]
  ok_actions          = [aws_sns_topic.alerts_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  alarm_description   = "Alarm when CPU > 80% for 5 minutes"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 5
  threshold           = 80
  comparison_operator = "GreaterThanThreshold"

  # You must update dimensions for your environment (ASG or InstanceId)
  dimensions = {
    AutoScalingGroupName = "eks-ng-682e3f94-8acd76a3-6bf3-61c7-a820-ae3886b7c9c2"
  }

  alarm_actions = [aws_sns_topic.alerts_topic.arn]
  ok_actions    = [aws_sns_topic.alerts_topic.arn]
}
