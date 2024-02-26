resource "aws_iam_user" "e24x7_wwama_user" {
  name = var.wwama_user_name
}
resource "aws_iam_access_key" "wwama" {
  user    = aws_iam_user.e24x7_wwama_user.name
  pgp_key = file("./keys/publicbase64.key")
}
resource "local_file" "access_key_id_wwama" {
  content  = aws_iam_access_key.wwama.id
  filename = "./access_keys/${var.aws_account_id}/key_id_wwama.txt"
}
resource "local_file" "access_key_secret_wwama" {
  content  = aws_iam_access_key.wwama.encrypted_secret
  filename = "./access_keys/${var.aws_account_id}/key_secret_wwama.txt"
}
resource "aws_iam_user_policy_attachment" "beanstalk_access" {
  user       = aws_iam_user.e24x7_wwama_user.name
  policy_arn = var.beanstalk_access
}
resource "aws_iam_user_policy_attachment" "iam_readonly" {
  user       = aws_iam_user.e24x7_wwama_user.name
  policy_arn = var.iam_readonly
}
resource "aws_iam_user_policy_attachment" "s3_full" {
  user       = aws_iam_user.e24x7_wwama_user.name
  policy_arn = var.s3_full
}
