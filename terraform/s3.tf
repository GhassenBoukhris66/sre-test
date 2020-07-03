resource "aws_s3_bucket" "image-reseize" {
  bucket = var.s3_bucket_reseized
  acl = "private"
  tags = {
    Name        = "lambda-image-reseize"
    Environment = "Dev"
  }
}
