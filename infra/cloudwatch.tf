resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/final-devops"
  retention_in_days = 7
}
