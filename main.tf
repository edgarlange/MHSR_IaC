module "s3" {
  source = "./modules/s3"
  # count       = var.create_iam_ad ? 1 : 0
  proveedor   = var.proveedor
  area        = var.area
  proyecto    = var.proyecto
  bucket_name = "${var.bucket_name}-${local.s3-sufix}"
}
module "iam_ad" {
  source = "./modules/iam_ad"
  # count                     = var.create_iam_ad ? 1 : 0
  proveedor       = var.proveedor
  area            = var.area
  proyecto        = var.proyecto
  ad_agent_access = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentAccess"
  ad_agentless    = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentlessCollectorAccess"
  ads_user_name   = var.ads_user_name
}
module "iam_dms" {
  source = "./modules/iam_dms"
  # count                     = var.create_iam_ad ? 1 : 0
  proveedor                 = var.proveedor
  area                      = var.area
  proyecto                  = var.proyecto
  aws_account_id            = var.aws_account_id
  dms_fleet_advisor_service = "dms-fleet-advisor.amazonaws.com"
  fac_user_name             = var.fac_user_name
  bucket_name               = module.s3.bucket_name
}
module "iam_sr" {
  source = "./modules/iam_sr"
  # count                 = var.create_iam_sr ? 1 : 0
  proveedor             = var.proveedor
  area                  = var.area
  proyecto              = var.proyecto
  mh_strategy_collector = "arn:aws:iam::aws:policy/AWSMigrationHubStrategyCollector"
  sr_user_name          = var.sr_user_name
}
module "sr_collector" {
  source      = "./modules/ec2_srcollector"
  count       = var.create_sr_collector ? 1 : 0
  proveedor   = var.proveedor
  area        = var.area
  proyecto    = var.proyecto
  vpc_id      = var.vpc_id
  vpc_cidr    = var.vpc_cidr
  subnet_id   = var.subnet_id
  subnet_cidr = var.subnet_cidr
  ec2_collector_specs = {
    "ami"           = var.ami_appdatcollector
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
  key_pair_name    = var.key_name_mhsr
}
module "code_analysis" {
  source      = "./modules/ec2_codeanalysis"
  count       = var.create_porting_assistant ? 1 : 0
  proveedor   = var.proveedor
  area        = var.area
  proyecto    = var.proyecto
  vpc_id      = var.vpc_id
  vpc_cidr    = var.vpc_cidr
  subnet_id   = var.subnet_id
  subnet_cidr = var.subnet_cidr
  ec2_codeanalysis_specs = {
    "ami"           = var.ami_w2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
  key_pair_name    = var.key_name_porta
}
module "dms_collector" {
  source      = "./modules/ec2_dmscollector"
  count       = var.create_dms_collector ? 1 : 0
  proveedor   = var.proveedor
  area        = var.area
  proyecto    = var.proyecto
  vpc_id      = var.vpc_id
  vpc_cidr    = var.vpc_cidr
  subnet_id   = var.subnet_id
  subnet_cidr = var.subnet_cidr
  ec2_dmscollector_specs = {
    "ami"           = var.ami_w2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
  key_pair_name    = var.key_name_dmsc
}
