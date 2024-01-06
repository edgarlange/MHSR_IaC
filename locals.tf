locals {
  resource_tags = {
    "Proveedor"    = var.proveedor
    "Area"         = var.area
    "Proyecto"     = var.proyecto
    "map-migrated" = var.map_migrated
  }
}
resource "random_string" "sufijo-s3" {
  length  = 8
  special = false
  upper   = false
}
locals {
  s3-sufix = random_string.sufijo-s3.id
}
