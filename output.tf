output "bucket_name" {
  value = module.s3.bucket_name
}
output "access_keys_id_ad" {
  value = module.iam_ad.access_key_id
}
output "access_key_secret_ad" {
  value = module.iam_ad.access_key_secret
}
output "access_keys_id_sr" {
  value = module.iam_sr.access_key_id
}
output "access_key_secret_sr" {
  value = module.iam_sr.access_key_secret
}
