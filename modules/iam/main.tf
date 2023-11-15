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
  tags = local.resource_tags
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
          "arn:aws:s3:::${var.cnam_bucket_name}",
          "arn:aws:s3:::${var.cnam_bucket_name}/*"
        ]
      }
    ]
  })
  tags = local.resource_tags
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
  tags = local.resource_tags
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
    }]
  })
  tags = local.resource_tags
}
resource "aws_iam_user" "e24x7_adssr_user" {
  name = var.cnam_user_name
  tags = local.resource_tags
}
resource "aws_iam_user_policy_attachment" "dms_attach" {
  user       = aws_iam_user.e24x7_adssr_user.name
  policy_arn = aws_iam_policy.dms_collector.arn
}
resource "aws_iam_user_policy_attachment" "fleet_attach" {
  user       = aws_iam_user.e24x7_adssr_user.name
  policy_arn = aws_iam_policy.fleet_advisor_s3.arn
}
resource "aws_iam_user_policy_attachment" "porting_attach" {
  user       = aws_iam_user.e24x7_adssr_user.name
  policy_arn = aws_iam_policy.porting_assistant.arn
}
resource "aws_iam_user_policy_attachment" "agent_access" {
  user       = aws_iam_user.e24x7_adssr_user.name
  policy_arn = var.ad_agent_access
}
resource "aws_iam_user_policy_attachment" "agentless" {
  user       = aws_iam_user.e24x7_adssr_user.name
  policy_arn = var.ad_agentless
}
resource "aws_iam_user_policy_attachment" "strategy_collector" {
  user       = aws_iam_user.e24x7_adssr_user.name
  policy_arn = var.mh_strategy_collector
}
resource "aws_iam_access_key" "ads_sr" {
  user    = aws_iam_user.e24x7_adssr_user.name
  pgp_key = file("./keys/publicbase64.key")
}

