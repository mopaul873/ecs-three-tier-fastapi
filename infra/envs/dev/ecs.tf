resource "aws_ecs_cluster" "main" {
  name = "ecs-three-tier-dev-cluster"
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}