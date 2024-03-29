resource "aws_iam_user" "e24x7_fac_user" {
  name = var.fac_user_name
}
resource "aws_iam_access_key" "fac" {
  user    = aws_iam_user.e24x7_fac_user.name
  pgp_key = file("./keys/publicbase64.key")
}
resource "local_file" "access_key_id_fac" {
  content  = aws_iam_access_key.fac.id
  filename = "./access_keys/${var.aws_account_id}/key_id_fac.txt"
}
resource "local_file" "access_key_secret_fac" {
  content  = aws_iam_access_key.fac.encrypted_secret
  filename = "./access_keys/${var.aws_account_id}/key_secret_fac.txt"
}
resource "aws_iam_policy" "service_linked_role_policy" {
  name        = "DMSFleetAdvisorCreateServiceLinkedRolePolicy"
  path        = "/"
  description = "DMS Fleet Advisor create Service-Linked Role policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "arn:aws:iam::*:role/aws-service-role/dms-fleet-advisor.amazonaws.com/AWSServiceRoleForDMSFleetAdvisor*",
        "Condition" : { "StringLike" : { "iam:AWSServiceName" : "dms-fleet-advisor.amazonaws.com" } }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:AttachRolePolicy",
          "iam:PutRolePolicy"
        ],
        "Resource" : "arn:aws:iam::*:role/aws-service-role/dms-fleet-advisor.amazonaws.com/AWSServiceRoleForDMSFleetAdvisor*"
      }
    ]
  })
}
resource "aws_iam_service_linked_role" "dms_fleet_advisor" {
  aws_service_name = var.dms_fleet_advisor_service
}
resource "aws_iam_policy" "dms_collector" {
  name        = "DMSCollectorPolicy"
  path        = "/"
  description = "DMS Collector policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : [
        "dms:DescribeFleetAdvisorCollectors",
        "dms:ModifyFleetAdvisorCollectorStatuses",
        "dms:UploadFileMetadataList"
      ],
      "Resource" : "*"
    }]
  })
}
resource "aws_iam_policy" "fleet_advisor_s3" {
  name        = "FleetAdvisorS3Policy"
  path        = "/"
  description = "Fleet Advisor S3 policy"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject*",
          "s3:GetBucket*",
          "s3:List*",
          "s3:DeleteObject*",
          "s3:PutObject*"
        ],
        "Resource" : [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}
resource "aws_iam_role" "fleet_advisor_s3" {
  name = "FleetAdvisorS3Role"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Sid" : "",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : [
          "dms.amazonaws.com",
          "dms-fleet-advisor.amazonaws.com"
        ]
      },
      "Action" : "sts:AssumeRole"
      # "Condition" : {
      #   "ArnLike" : {
      #     "aws:SourceArn" : {
      #       "Fn::Sub" : "arn:aws:dms:*::*"
      #     }
      #   }
      # }
    }]
  })
}
resource "aws_iam_role_policy_attachment" "fleet_policy_attach" {
  role       = aws_iam_role.fleet_advisor_s3.name
  policy_arn = aws_iam_policy.fleet_advisor_s3.arn
}
resource "aws_iam_user_policy_attachment" "dms_attach" {
  user       = aws_iam_user.e24x7_fac_user.name
  policy_arn = aws_iam_policy.dms_collector.arn
}
resource "aws_iam_user_policy_attachment" "fleet_attach" {
  user       = aws_iam_user.e24x7_fac_user.name
  policy_arn = aws_iam_policy.fleet_advisor_s3.arn
}

