terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "mypydemo-bucket" {
	# checkov:skip=CKV_AWS_18: ADD REASON, this is test bucket.
	# checkov:skip=CKV_AWS_145: ADD REASON, this is test bucket.
	# checkov:skip=CKV_AWS_144: ADD REASON, this is test bucket.
	# checkov:skip=CKV_AWS_19: ADD REASON, this is test bucket.
	# checkov:skip=CKV_AWS_21: ADD REASON, this is test bucket.
  bucket = "mypydemo"

  tags = {
    Name        = "mypydemo-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "mypydemo-acl" {
  bucket = aws_s3_bucket.mypydemo-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "mypydemo_block_pub_access" {
  bucket = aws_s3_bucket.mypydemo-bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}