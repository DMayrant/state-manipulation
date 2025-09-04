#1. import via cli 
#terraform import aws_s3_bucket.remote_state 'cf-templates-bv9qs0bu6gg2-us-east-1'

resource "aws_s3_bucket" "remote_state" {
  bucket = "cf-templates-bv9qs0bu6gg2-us-east-1"

  tags = {
    ManagedBy = "terraform"
    lifecycle = "Critical"
  }

  lifecycle {
   prevent_destroy = true #good practice to use prevent destroy for remote states
  }
}

#2. import via Import block
import {
  to = aws_s3_bucket_public_access_block.remote_state
  id = "cf-templates-bv9qs0bu6gg2-us-east-1"
}
resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
