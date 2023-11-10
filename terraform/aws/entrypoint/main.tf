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

module "vpc" {
  source = "../modules/vpc"
}

module "security_group" {
  source = "../modules/security_group"
  vpc_id = module.vpc.vpc_id
}
module "ec2" {
  source                 = "../modules/ec2"
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = module.security_group.security_group_ids
}
