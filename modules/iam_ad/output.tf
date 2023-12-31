output "access_key_id_ad" {
  value = aws_iam_access_key.ads.id
}
output "access_key_secret_ad" {
  value = aws_iam_access_key.ads.encrypted_secret
}
