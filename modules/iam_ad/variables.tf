variable "proveedor" {
  description = "Escala 24x7"
  type        = string
  default     = "Escala 24x7"
}
variable "area" {
  description = "Cloud Native and Modernization"
  type        = string
  default     = "Cloud Native and Modernization"
}
variable "proyecto" {
  description = "REC"
  type        = string
  default     = "REC"
}
variable "dms_fleet_advisor_service" {
  description = "AWS DMS Fleet Advisor Service name"
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
variable "bucket_name" {
  description = "Bucket name"
  type        = string
}

