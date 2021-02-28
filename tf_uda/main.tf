terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.30.0"
    }
  }
}

# AWS provider with alias definitions for primary region
provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}

## Primary VPC
resource "aws_vpc" "primary-vpc" {
  provider             = aws.primary
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.udc_default_tags,
    {
      Name = "primary-vpc"
    }
  )
}

