variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}
variable "wwama_user_name" {
  description = "Windows Web Application Migration Assistant user name"
  type        = string
}
variable "beanstalk_access" {
  description = "ARN Policy"
  type        = string
}
variable "iam_readonly" {
  description = "ARM Policy"
}
variable "s3_full" {
  description = "ARM Policy"
}
