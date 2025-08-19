resource "aws_ecr_repository" "app" {
  name = "final-devops-app"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "final-devops-ecr-repo"
  }
}
