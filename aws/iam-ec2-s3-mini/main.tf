terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Use your existing S3 bucket
data "aws_s3_bucket" "existing" {
  bucket = var.bucket_name
}

# Build the read-only policy for JUST that bucket
data "aws_iam_policy_document" "s3_read" {
  statement {
    sid     = "ListBucket"
    actions = ["s3:ListBucket"]
    resources = [
      data.aws_s3_bucket.existing.arn
    ]
  }

  statement {
    sid     = "ReadObjects"
    actions = ["s3:GetObject"]
    resources = [
      "${data.aws_s3_bucket.existing.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_read" {
  name   = "S3ReadOnly-${var.project_suffix}"
  policy = data.aws_iam_policy_document.s3_read.json
}

# Trust policy for EC2
data "aws_iam_policy_document" "ec2_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create a new role
resource "aws_iam_role" "ec2_role" {
  name               = "ec2-s3-readonly-${var.project_suffix}"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust.json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read.arn
}

resource "aws_iam_instance_profile" "profile" {
  name = "ec2-s3-readonly-${var.project_suffix}"
  role = aws_iam_role.ec2_role.name
}
