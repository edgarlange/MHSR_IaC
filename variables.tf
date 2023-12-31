variable "alias" {
  description = "Alias Cloud Native and Modernization"
  type        = string
  default     = "cnam"
}
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
  description = "MHSR" # <---- Proyecto
  type        = string
  default     = "MHSR" # <---- Proyecto
}
variable "region" {
  description = "Region"
  type        = string
  default     = "us-west-2" # <---- Region
}
variable "aws_profile" {
  description = "AWS Profile"
  type        = string
  default     = "elange-CNAM-AA" # <---- Default, elange-CNAM-AA, etc
}

variable "create_iam_ad" {
  default = true # <---- Cambia a false para desactivar la creación de Application Discovery Service
}
variable "create_iam_sr" {
  default = true # <---- Cambia a false para desactivar la creación Strategy Recommendations
}
variable "create_porting_assistant" {
  default = true # <---- Cambia a false para desactivar la creación de instancias EC2
}
variable "create_sr_collector" {
  default = true # <---- Cambia a false para desactivar la creación de instancias EC2
}
variable "create_dms_collector" {
  default = true # <---- Cambia a false para desactivar la creación de instancias EC2
}
variable "create_s3_fleet" {
  default = true # <---- Cambia a false para desactivar la creación de instancias EC2
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-07f729a36fd63ea2b" # <---- VPC ID donde se despliega el collector
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.199.0.0/16" # <---- CIDR del VPC
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
  default     = "subnet-034b90e222dbf26ec" # <---- Subnet ID donde se despliega el collector
}
variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
  default     = "10.199.0.0/24" # <---- CIDR de la Subnet
}
variable "ami_w2022" {
  description = "AMI Windows 2022"
  type        = string
  default     = "ami-091f300417a06d788" # AMI Windows 2022 (us-east-1 - ami-0cd601a22ac9e6d79 / us-west-1 - ami-091f300417a06d788)
}
variable "ami_appdatcollector" {
  description = "AMI"
  type        = string
  default     = "ami-00f1dcf87ef02c147" # AMI AWSMHubApplicationDataCollector. Propietario 703163444405 (us-east-1 - ami-0972df9857f16644a / ami-00f1dcf87ef02c147)
}
variable "my_ip" {
  description = "My IP Address"
  type        = string
  default     = "186.188.205.168/32" # <---- IP externa Team CNAM
}
variable "ads_user_name" {
  description = "Applications Discovery Service user name"
  type        = string
  default     = "e24x7-ads-user"
}
variable "sr_user_name" {
  description = "Strategy Recommendations user name"
  type        = string
  default     = "e24x7-sr-user"
}
