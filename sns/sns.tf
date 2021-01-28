terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "sandbox"
  region  = "us-east-1"
}

resource "aws_sns_topic" "ben_test_topic" {
  name = "ben-test-topic"
}