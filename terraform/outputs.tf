output "ecr_repository_url" {
  description = "ECR repo URL"
  value       = aws_ecr_repository.scoring_service.repository_url
}

output "alerts_topic_arn" {
  description = "SNS topic ARN"
  value       = aws_sns_topic.alerts_topic.arn
}
