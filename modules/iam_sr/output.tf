output "access_key_id_sr" {
  value = aws_iam_access_key.sr.id
}
output "access_key_secret_sr" {
  value = aws_iam_access_key.sr.encrypted_secret
}
