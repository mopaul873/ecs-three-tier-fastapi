# ALB Security Group: allow inbound HTTP from anywhere, outbound to anywhere
resource "aws_security_group" "alb_sg" {
  name        = "ecs-three-tier-dev-alb-sg"
  description = "Allow HTTP inbound from internet"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-three-tier-dev-alb-sg"
  }
}

# ECS Tasks Security Group: allow inbound app traffic only from ALB SG
resource "aws_security_group" "ecs_tasks_sg" {
  name        = "ecs-three-tier-dev-ecs-tasks-sg"
  description = "Allow inbound from ALB only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "App from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-three-tier-dev-ecs-tasks-sg"
  }
}

# RDS Security Group: allow inbound DB only from ECS tasks SG (we'll use 5432 for Postgres later)
resource "aws_security_group" "rds_sg" {
  name        = "ecs-three-tier-dev-rds-sg"
  description = "Allow DB inbound from ECS tasks only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Postgres from ECS tasks"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_tasks_sg.id]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-three-tier-dev-rds-sg"
  }
}