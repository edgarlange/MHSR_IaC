resource "aws_s3_bucket" "fleet_bucket" {
  bucket = var.bucket_name
  tags   = local.resource_tags
}
