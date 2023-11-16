module "s3" {
  source      = "./modules/s3"
  bucket_name = "e24x7-ads-${local.s3-sufix}"
}
module "iam" {
  source                = "./modules/iam"
  ad_agent_access       = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentAccess"
  ad_agentless          = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentlessCollectorAccess"
  mh_strategy_collector = "arn:aws:iam::aws:policy/AWSMigrationHubStrategyCollector"
  cnam_user_name        = "e24x7-adssr-user"
  cnam_bucket_name      = module.s3.cnam_bucket_name
}
module "collector" {
  source      = "./modules/collector"
  vpc_id      = "vpc-07f729a36fd63ea2b"    # <---- VPC ID donde se despliega el collector
  vpc_cidr    = "10.199.0.0/16"            # <---- CIDR del VPC
  subnet_id   = "subnet-034b90e222dbf26ec" # <---- Subnet ID donde se despliega el collector
  subnet_cidr = "10.199.0.0/24"            # <---- CIDR de la Subnet
  ec2_collector_specs = {
    "ami"           = "ami-00f1dcf87ef02c147" # AMI AWSMHubApplicationDataCollector. Propietario 703163444405
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = "186.188.205.168/32" # <---- IP externa Team CNAM
}
module "codeanalysis" {
  source      = "./modules/codeanalysis"
  vpc_id      = "vpc-07f729a36fd63ea2b"
  vpc_cidr    = "10.199.0.0/16"
  subnet_id   = "subnet-034b90e222dbf26ec"
  subnet_cidr = "10.199.0.0/24"
  ec2_codeanalysis_specs = {
    "ami"           = "ami-0fae5ac34f36d5963" # AMI Windows 2019
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = "186.188.205.168/32"
}









