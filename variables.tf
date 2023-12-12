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
  description = "REC"
  type        = string
  default     = "REC"
}
variable "aws_profile" {
  description = "AWS Profile"
  type        = string
  default     = "elange-GCC-AA" # <---- Default, elange-CNAM-AA, etc
}
variable "create_porting_assistant" {
  default = true # <---- Cambia a false para desactivar la creación de instancias EC2
}
variable "create_sr_collector" {
  default = true # <---- Cambia a false para desactivar la creación de instancias EC2
}
variable "create_dms_collector" {
  default = false # <---- Cambia a false para desactivar la creación de instancias EC2
}
variable "create_s3_fleet" {
  default = true # <---- Cambia a false para desactivar la creación de instancias EC2
}
