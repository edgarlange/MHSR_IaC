variable "aws_account_id" {
  description = "Account ID"
  type        = string
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
variable "external_mgmt_ip" {
  description = "Ingress traffic"
  type        = string
}
variable "ec2_codeanalysis_specs" {
  description = "Parametros de la instancia"
  type        = map(string)
}
variable "key_pair_name" {
  description = "Key pair"
  type        = string
}
