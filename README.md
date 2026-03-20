# 🚀 ECS Fargate + Terraform + CI/CD (FastAPI)

## 📌 Overview

This project demonstrates a production-style deployment of a containerized FastAPI application on AWS using ECS Fargate, Terraform, and GitHub Actions CI/CD.

The infrastructure is fully automated using Infrastructure as Code and designed to be reproducible, scalable, and secure.

---

## 🎯 Objective

Deploy a FastAPI application in a three-tier architecture where:

- Infrastructure is provisioned using Terraform
- Application is containerized using Docker
- CI/CD pipeline automatically builds and deploys changes
- System is scalable and monitored

---

## 🧩 Application

- FastAPI container running on port **8080**

### Endpoints:
- `GET /` → returns application message  
- `GET /health` → returns health status (used for ALB health checks)

---

## 🏗️ Architecture

### Traffic Flow:
1. User sends request to **Application Load Balancer (ALB)**
2. ALB routes traffic to **ECS Fargate tasks**
3. Containerized FastAPI application processes the request
4. Health checks are performed via `/health`

### Components:

#### Networking
- VPC
- Public subnets (ALB)
- Private subnets (ECS tasks)
- Internet Gateway (IGW)
- NAT Gateway (outbound internet for private resources)
- Route tables and associations

#### Compute
- ECS Cluster (Fargate)
- Task definition for FastAPI container
- ECS Service (runs tasks in private subnets)

#### Load Balancing
- Application Load Balancer (ALB)
- Listener + Target Group
- Health checks on `/health`

#### Scaling
- ECS Service Auto Scaling:
  - Min: 1 task
  - Max: 3 tasks
  - Target tracking based on CPU utilization

#### State Management
- Terraform remote state stored in S3
- DynamoDB used for state locking

---

## 🔁 CI/CD Pipeline (GitHub Actions)

On push to `main`:

1. Build Docker image  
2. Tag image (`commit SHA` + `latest`)  
3. Push image to Amazon ECR  
4. Trigger ECS service update  
5. Wait for service stability  
6. Run smoke test on `/health` endpoint  

---

## 🔐 Security & Best Practices

- ECS tasks run in **private subnets**
- ALB is the only public entry point
- Security groups restrict access between layers
- IAM roles follow least privilege principle
- Infrastructure fully managed with Terraform

---

## ✅ Success Criteria

- `terraform apply` successfully provisions infrastructure  
- ALB endpoint responds correctly:
  - `/health` returns healthy status  
  - `/` returns application message  
- CI/CD pipeline automatically deploys updates on push  
- `terraform destroy` removes all resources cleanly  

---

## 🧠 Key Takeaways

- Demonstrates Infrastructure as Code with Terraform  
- Shows end-to-end CI/CD automation  
- Implements secure and scalable cloud architecture  
- Highlights troubleshooting and debugging of cloud deployments  

---

## 🚀 Future Improvements

- Blue/Green deployment strategy  
- Kubernetes (EKS) implementation  
- Enhanced monitoring and alerting  
