output "access_key_id_fac" {
  value = aws_iam_access_key.fac.id
}
output "access_key_secret_fac" {
  value = aws_iam_access_key.fac.encrypted_secret
}
