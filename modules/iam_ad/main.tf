resource "aws_iam_user" "e24x7_ads_user" {
  name = var.ads_user_name
}
resource "aws_iam_access_key" "ads" {
  user    = aws_iam_user.e24x7_ads_user.name
  pgp_key = file("./keys/publicbase64.key")
}
resource "local_file" "access_key_id_ads" {
  content  = aws_iam_access_key.ads.id
  filename = "./access_keys/key_id_ads.txt"
}
resource "local_file" "access_key_secret_ads" {
  content  = aws_iam_access_key.ads.encrypted_secret
  filename = "./access_keys/key_secret_ads.txt"
}
resource "aws_iam_user_policy_attachment" "agent_access" {
  user       = aws_iam_user.e24x7_ads_user.name
  policy_arn = var.ad_agent_access
}
resource "aws_iam_user_policy_attachment" "agentless" {
  user       = aws_iam_user.e24x7_ads_user.name
  policy_arn = var.ad_agentless
}

