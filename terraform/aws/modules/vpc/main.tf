module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name                 = "isucon11-final-practice-infra-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["ap-northeast-1a"]
  public_subnets       = ["10.0.10.0/24"]
  enable_dns_hostnames = true
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnets[0]
}
