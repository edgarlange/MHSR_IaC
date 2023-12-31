output "bucket_name" {
  value = module.s3.bucket_name
}
output "access_keys_id" {
  value = module.iam_ad.access_key_id
}
output "access_key_secret" {
  value = module.iam_ad.access_key_secret
}
output "access_keys_id" {
  value = module.iam_sr.access_key_id
}
output "access_key_secret" {
  value = module.iam_sr.access_key_secret
}
