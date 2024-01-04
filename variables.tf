variable "alias" {
  description = "Alias"
  type        = string
}
variable "proveedor" {
  description = "Proveedor"
  type        = string
}
variable "area" {
  description = "Area"
  type        = string
}
variable "proyecto" {
  description = "Proyecto"
  type        = string
}
variable "region" {
  description = "Region"
  type        = string
}
variable "aws_profile" {
  description = "AWS Profile"
  type        = string
}
variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}
variable "create_iam_ad" {
  type = bool
}
variable "create_iam_sr" {
  type = bool
}
variable "create_porting_assistant" {
  type = bool
}
variable "create_sr_collector" {
  type = bool
}
variable "create_dms_collector" {
  type = bool
}
variable "create_s3_fleet" {
  type = bool
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}
variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
}
variable "ami_w2022" {
  description = "AMI Windows 2022"
  type        = string
}
variable "ami_appdatcollector" {
  description = "AMI"
  type        = string
}
variable "my_ip" {
  description = "My IP Address"
  type        = string
}
variable "ads_user_name" {
  description = "Applications Discovery Service user name"
  type        = string
}
variable "fac_user_name" {
  description = "Fleet Advisor Collector user name"
  type        = string
}
variable "sr_user_name" {
  description = "Strategy Recommendations user name"
  type        = string
}
variable "key_name_porta" {
  description = "value"
  type        = string
}
variable "key_name_dmsc" {
  description = "value"
  type        = string
}
variable "key_name_mhsr" {
  description = "value"
  type        = string
}
variable "bucket_name" {
  description = "Bucket name"
  type        = string
}
