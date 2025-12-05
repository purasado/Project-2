data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "scoring_service" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration { scan_on_push = true }
  tags = { Name = "${var.project_name}-ecr" }
}
