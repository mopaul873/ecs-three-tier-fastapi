# Project: ECS Fargate + Terraform + GitHub Actions CI/CD (FastAPI)

Objective

Deploy a containerized FastAPI application on AWS using a production-style architecture. The solution must be reproducible through Infrastructure as Code and automatically deploy on code changes.

Requirements
Application

A FastAPI app container listening on port 8080

Endpoints:

GET / returns a message

GET /health returns JSON health status

Infrastructure (Terraform)

Networking:

VPC

Public subnets (for ALB)

Private subnets (for ECS tasks)

Internet Gateway (IGW)

NAT Gateway (private subnet outbound internet)

Route tables and associations

Compute/Service:

ECS cluster (Fargate)

Task definition for FastAPI container

ECS service running tasks in private subnets

Security groups (ALB inbound, ECS limited inbound from ALB)

Load balancing:

Application Load Balancer (ALB) in public subnets

Listener + target group

Health checks on /health

Scaling:

ECS service auto scaling (min 1, max 3)

Target tracking policy based on CPU utilization

Terraform remote state:

S3 backend

DynamoDB state locking

CI/CD (GitHub Actions)

On push to main (app changes):

Build Docker image

Tag with commit SHA and latest

Push to Amazon ECR

Force a new deployment in ECS

Wait for service stability

Smoke test /health on ALB DNS

Success criteria

terraform apply creates infrastructure

ALB endpoint responds:

/health returns healthy

/ returns app message

Push to main triggers CI/CD and updates the running service

terraform destroy removes everything cleanly
