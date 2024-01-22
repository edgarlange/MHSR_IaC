locals {
  resource_tags = {
    "Proveedor"    = var.proveedor
    "Area"         = var.area
    "Proyecto"     = var.proyecto
    "map-migrated" = var.map_migrated
    "Iac"          = var.iac
    "Deploy ID"    = var.deploy_id
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
