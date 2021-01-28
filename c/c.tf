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

data "aws_iam_policy_document" "ben-test-c-queue-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "arn:aws:sqs:us-east-1:703347463263:ben-test-c-queue",
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "arn:aws:sns:us-east-1:703347463263:ben-test-topic",
      ]
    }
  }
}

resource "aws_sqs_queue" "ben_test_c_queue" {
  name                      = "ben-test-c-queue"
  policy   = data.aws_iam_policy_document.ben-test-c-queue-policy.json
}

resource "aws_sns_topic_subscription" "b_to_c_event_subscription" {
  topic_arn = "arn:aws:sns:us-east-1:703347463263:ben-test-topic"
  protocol  = "sqs"
  endpoint  = "arn:aws:sqs:us-east-1:703347463263:ben-test-c-queue"
  filter_policy = "${jsonencode(map("service",list("b")))}"
}