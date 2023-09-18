# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
   #Adding Backend as S3 for Remote State Storage
 backend "s3" {
    bucket = "matthews-bucket-91423"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"   
  }
}

provider "aws"{
    region = var.aws_region
    alias = "Mumbai"
}

-----

/* terraform {
    required_providers {
      aws = {
        source = "Hashicorp/aws"
        version = "~> 4.0"
      }
    }    
}

provider "aws"{
    region = "ap-south-1"
    alias = "Mumbai"
} */
