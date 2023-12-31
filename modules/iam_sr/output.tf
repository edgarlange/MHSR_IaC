output "access_key_id" {
  value = aws_iam_access_key.sr.id
}
output "access_key_secret" {
  value = aws_iam_access_key.sr.encrypted_secret
}
