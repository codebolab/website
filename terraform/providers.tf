terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket  = "codebolab-terraform-states"
    key     = "codebolab/website/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
