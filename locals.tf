locals {
  resource_tags = {
    "Proveedor" = var.proveedor
    "Area"      = var.area
  }
}
resource "random_string" "sufijo-s3" {
  length  = 8
  special = false
  upper   = false
}
locals {
  s3-sufix = "${var.alias}-${random_string.sufijo-s3.id}"
}
