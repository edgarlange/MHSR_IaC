output "access_key_id" {
  value = aws_iam_access_key.ads.id
}
output "access_key_secret" {
  value = aws_iam_access_key.ads.encrypted_secret
}
