resource "aws_ecr_repository" "app" {
  name                 = "ecs-three-tier-fastapi"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "ecs-three-tier-fastapi"
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}