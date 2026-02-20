terraform {
  backend "s3" {
    bucket         = "mopaul873-ecs3tier-tfstate-2026"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mopaul873-ecs3tier-tfstate-locks"
    encrypt        = true
  }
}