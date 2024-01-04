output "access_keys_id_ad" {
  value = module.iam_ad.access_key_id_ad
}
output "access_key_secret_ad" {
  value = module.iam_ad.access_key_secret_ad
}
output "access_keys_id_sr" {
  value = module.iam_sr.access_key_id_sr
}
output "access_key_secret_sr" {
  value = module.iam_sr.access_key_secret_sr
}
output "access_keys_id_fac" {
  value = module.iam_dms.access_key_id_fac
}
output "access_key_secret_fac" {
  value = module.iam_dms.access_key_secret_fac
}
