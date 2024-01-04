resource "aws_iam_user" "e24x7_ads_user" {
  name = var.ads_user_name
  tags = local.resource_tags
}
resource "aws_iam_access_key" "ads" {
  user    = aws_iam_user.e24x7_ads_user.name
  pgp_key = file("./keys/publicbase64.key")
}
resource "aws_iam_user_policy_attachment" "agent_access" {
  user       = aws_iam_user.e24x7_ads_user.name
  policy_arn = var.ad_agent_access
}
resource "aws_iam_user_policy_attachment" "agentless" {
  user       = aws_iam_user.e24x7_ads_user.name
  policy_arn = var.ad_agentless
}

