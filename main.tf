module "s3" {
  source      = "./modules/s3"
  bucket_name = "e24x7-adssr-${local.s3-sufix}"
}

module "iam" {
  source                = "./modules/iam"
  ad_agent_access       = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentAccess"
  ad_agentless          = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentlessCollectorAccess"
  mh_strategy_collector = "arn:aws:iam::aws:policy/AWSMigrationHubStrategyCollector"
  cnam_user_name        = "e24x7-adssr-user"
  cnam_bucket_name      = module.s3.cnam_bucket_name
}


