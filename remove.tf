#1.  Removed via CLI
removed {
  from = aws_s3_bucket.my_new_bucket
  lifecycle {
    destroy = true
  }
}

resource "aws_s3_bucket" "my_new_bucket" {
 bucket = "random-name-9867336"

}