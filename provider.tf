terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }
  backend "s3" {
    bucket = "mar292024"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account}:role/TerraformAdminRole"
  }
  default_tags {
    tags = {
      Project = var.project-tag
      Environment = var.environment
      Deployment = "Terraform"
    }
  }
}

provider "aws" {
  alias = "mgmt"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::941598205732:role/Terraformrole"
  }  
}
