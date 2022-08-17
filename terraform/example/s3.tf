resource "aws_s3_bucket" "default" {
  bucket_prefix = "${local.prefix}-"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.default.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "default2" {
  bucket_prefix = "${local.prefix}-2-"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "default2" {
  bucket = aws_s3_bucket.default2.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "default3" {
  bucket_prefix = "${local.prefix}-3-"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "default3" {
  bucket = aws_s3_bucket.default3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
