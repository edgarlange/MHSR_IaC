variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}
variable "ad_agent_access" {
  description = "Application Discovery Agent Access - Managed policy - ARN"
  type        = string
}
variable "ad_agentless" {
  description = "Application Discovery Agentless Collector Access - Managed policy - ARN"
  type        = string
}
variable "ads_user_name" {
  description = "Application Discovery Service user name"
  type        = string
}

