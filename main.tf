terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  profile = "AWSAdministratorAccess-008971670608"
}

module "aaron_workerpool" {
  source = "github.com/spacelift-io/terraform-aws-spacelift-workerpool-on-ec2?ref=v4.4.0"

  secure_env_vars = {
    SPACELIFT_TOKEN            = var.worker_pool_config
    SPACELIFT_POOL_PRIVATE_KEY = var.worker_pool_private_key
  }

  min_size                   = 1
  max_size                   = 2
  worker_pool_id             = var.worker_pool_id
  security_groups            = var.worker_pool_security_groups
  vpc_subnets                = var.worker_pool_subnets
  ec2_instance_type          = "t3.medium"

  spacelift_api_credentials = {
    api_key_id       = var.spacelift_api_key_id
    api_key_secret   = var.spacelift_api_key_secret
    api_key_endpoint = var.spacelift_api_key_endpoint
  }

  autoscaling_configuration = {
    api_key_id       = var.spacelift_api_key_id
    api_key_secret   = var.spacelift_api_key_secret
    api_key_endpoint = var.spacelift_api_key_endpoint
  }

}
