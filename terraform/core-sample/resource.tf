resource "aws_ecr_repository" "main" {
  name = "${var.project_name}-repository"

  tags = {
    Name = "${var.project_name}-repository"
  }
}