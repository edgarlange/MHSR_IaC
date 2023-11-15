output "access_key_id" {
  value = aws_iam_access_key.ads_sr.id
}
output "access_key_secret" {
  value = aws_iam_access_key.ads_sr.encrypted_secret
}
