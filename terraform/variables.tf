variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "scoring-service"
}

variable "alarm_email" {
  description = "Email for SNS alarm notifications"
  type        = string
  default     = "prasadamb5403@gmail.com"
}
