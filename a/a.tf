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

resource "aws_sqs_queue" "ben_test_a_queue" {
  name                      = "ben-test-a-queue"
}