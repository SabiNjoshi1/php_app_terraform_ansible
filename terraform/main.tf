terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
}
##########################################################################
# Configure the AWS Provider
##########################################################################

provider "aws" {
  region = "us-east-2"
  profile = "default"
}

module "vpc" {
  source                        = "./modules/vpc"
}

module "ec2" {
  source                        = "./modules/ec2"
  vpc_id                        =  module.vpc.vpc_id
  public_subnet_id_1            =  module.vpc.public_subnet_id_1
  public_subnet_id_2            =  module.vpc.public_subnet_id_2
}

module "rds" {
  source                        = "./modules/rds"
  vpc_id                        =  module.vpc.vpc_id
  private_subnet_id_3           =  module.vpc.private_subnet_id_3
  private_subnet_id_4           =  module.vpc.private_subnet_id_4
  security_groups_id            =  module.ec2.security_groups_id
}
