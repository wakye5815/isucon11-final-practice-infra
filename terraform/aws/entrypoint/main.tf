locals {
  repository = "wakye5815/isucon11-final-practice-infra"
  region     = "ap-northeast-1"
}

provider "aws" {
  region = local.region
  default_tags {
    tags = {
      Repository = local.repository
    }
  }
}

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
  backend "s3" {
    bucket = "isucon11-final-practice-infra-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}