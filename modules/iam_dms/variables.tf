variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}
variable "dms_fleet_advisor_service" {
  description = "AWS DMS Fleet Advisor Service name"
  type        = string
}
variable "fac_user_name" {
  description = "Fleet Advisor Collector user name"
  type        = string
}
variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

