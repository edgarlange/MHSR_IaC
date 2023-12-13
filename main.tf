module "s3" {
  source = "./modules/s3"
  # count       = var.create_s3_fleet ? 1 : 0
  bucket_name = "e24x7-dms-fleet-${local.s3-sufix}"
}
module "iam" {
  source                    = "./modules/iam"
  ad_agent_access           = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentAccess"
  ad_agentless              = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentlessCollectorAccess"
  mh_strategy_collector     = "arn:aws:iam::aws:policy/AWSMigrationHubStrategyCollector"
  dms_fleet_advisor_service = "dms-fleet-advisor.amazonaws.com"
  cnam_user_name            = var.cnam_user_name
  bucket_name               = module.s3.bucket_name
}
module "sr_collector" {
  source      = "./modules/ec2_srcollector"
  count       = var.create_sr_collector ? 1 : 0
  vpc_id      = var.vpc_id
  vpc_cidr    = var.vpc_cidr
  subnet_id   = var.subnet_id
  subnet_cidr = var.subnet_cidr
  ec2_collector_specs = {
    "ami"           = var.ami_appdatcollector
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
}
module "code_analysis" {
  source      = "./modules/ec2_codeanalysis"
  count       = var.create_porting_assistant ? 1 : 0
  vpc_id      = var.vpc_id
  vpc_cidr    = var.vpc_cidr
  subnet_id   = var.subnet_id
  subnet_cidr = var.subnet_cidr
  ec2_codeanalysis_specs = {
    "ami"           = var.ami_w2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
}
module "dms_collector" {
  source      = "./modules/ec2_dmscollector"
  count       = var.create_dms_collector ? 1 : 0
  vpc_id      = var.vpc_id
  vpc_cidr    = var.vpc_cidr
  subnet_id   = var.subnet_id
  subnet_cidr = var.subnet_cidr
  ec2_dmscollector_specs = {
    "ami"           = var.ami_w2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
}
