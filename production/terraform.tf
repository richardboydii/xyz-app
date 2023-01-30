terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.48.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
    }
  }
  
  backend "s3" {
    bucket = "xyz-demo-tf-state"
    key    = "xyz-demo-app-state-prod"
    region = "us-east-2"
    dynamodb_table = "xyz-tf-state-db"
  } 
}
