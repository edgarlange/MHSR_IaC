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
  description = "CNAM Ingress"
  type        = string

}
variable "ec2_collector_specs" {
  description = "Parametros de la instancia"
  type        = map(string)

}
variable "key_pair_name" {
  type    = string
  default = "mhsr_key"
}
