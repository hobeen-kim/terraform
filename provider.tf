provider "aws" {
  region  = "ap-northeast-2"
  profile = "private"
}

terraform {
    backend "s3" { # 강의는 
      bucket         = "hb-class101-tfstate" # s3 bucket 이름
      key            = "study/terraform/terraform.tfstate" # s3 내에서 저장되는 경로를 의미합니다.
      region         = "ap-northeast-2"  
      encrypt        = true
      dynamodb_table = "hb-terraform-lock"
    }
}

# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "hb-class101-tfstate"
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "hb-terraform-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}