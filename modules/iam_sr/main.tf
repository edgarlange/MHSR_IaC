resource "aws_iam_user" "e24x7_sr_user" {
  name = var.sr_user_name
}
resource "aws_iam_access_key" "sr" {
  user    = aws_iam_user.e24x7_sr_user.name
  pgp_key = file("./keys/publicbase64.key")
}
resource "local_file" "access_key_id_sr" {
  content  = aws_iam_access_key.sr.id
  filename = "./access_keys/key_id_sr.txt"
}
resource "local_file" "access_key_secret_sr" {
  content  = aws_iam_access_key.sr.encrypted_secret
  filename = "./access_keys/key_secret_sr.txt"
}
resource "aws_iam_policy" "porting_assistant" {
  name        = "PortingAssistantPolicy"
  path        = "/"
  description = "Porting Assistant policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "EnCorePermission",
        "Effect" : "Allow",
        "Action" : [
          "execute-api:invoke",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:aws:execute-api:us-east-1:492443789615:3dmmp07yx6/*",
          "arn:aws:execute-api:us-east-1:547614552430:8q2itpfg51/*",
          "arn:aws:s3:::aws.portingassistant.dotnet.datastore",
          "arn:aws:s3:::aws.portingassistant.dotnet.datastore/*"
        ]
      }
    ]
  })
}
resource "aws_iam_user_policy_attachment" "porting_attach" {
  user       = aws_iam_user.e24x7_sr_user.name
  policy_arn = aws_iam_policy.porting_assistant.arn
}
resource "aws_iam_user_policy_attachment" "strategy_collector" {
  user       = aws_iam_user.e24x7_sr_user.name
  policy_arn = var.mh_strategy_collector
}

