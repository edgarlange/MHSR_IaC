resource "aws_iam_user" "e24x7_mx_user" {
  name = var.mx_user_name
}
resource "aws_iam_access_key" "mx" {
  user    = aws_iam_user.e24x7_mx_user.name
  pgp_key = file("./keys/publicbase64.key")
}
resource "local_file" "access_key_id_mx" {
  content  = aws_iam_access_key.mx.id
  filename = "./access_keys/${var.aws_account_id}/key_id_mx.txt"
}
resource "local_file" "access_key_secret_mx" {
  content  = aws_iam_access_key.mx.encrypted_secret
  filename = "./access_keys/${var.aws_account_id}/key_secret_mx.txt"
}
resource "aws_iam_policy" "microservice_extractor" {
  name        = "MicroserviceExtractorPolicy"
  path        = "/"
  description = "Microservice Extractor policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ApplicationTransformationAccess",
        "Effect" : "Allow",
        "Action" : [
          "application-transformation:*"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "KMSPermissions",
        "Effect" : "Allow",
        "Action" : [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:CreateGrant",
          "kms:GenerateDataKey"
        ],
        "Resource" : "arn:aws:kms:::*",
        "Condition" : {
          "ForAnyValue:StringLike" : {
            "kms:ResourceAliases" : "alias/application-transformation*"
          }
        }
      },
      {
        "Sid" : "S3Access",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:CreateBucket",
          "s3:ListBucket",
          "s3:PutBucketOwnershipControls",
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ],
        "Resource" : ["arn:aws:s3:::*"],
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceAccount" : "${var.aws_account_id}"
          }
        }
      }
    ]
  })
}
resource "aws_iam_user_policy_attachment" "microservice_attach" {
  user       = aws_iam_user.e24x7_mx_user.name
  policy_arn = aws_iam_policy.microservice_extractor.arn
}

