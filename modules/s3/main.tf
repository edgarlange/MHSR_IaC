resource "aws_s3_bucket" "cnam_bucket" {
  bucket = var.bucket_name
  tags   = local.resource_tags
}
