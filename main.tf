module "s3" {
  source      = "./modules/s3"
  count       = var.create_iam_dmsc ? 1 : 0
  bucket_name = "${var.bucket_name}-${local.s3-sufix}"
}
module "s3_mx" {
  source         = "./modules/s3_mx"
  count          = var.create_code ? 1 : 0
  bucket_name_mx = "${var.bucket_name_mx}-${local.s3-sufix}"
}
module "iam_ad" {
  source          = "./modules/iam_ad"
  count           = var.create_iam_ad ? 1 : 0
  aws_account_id  = var.aws_account_id
  ad_agent_access = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentAccess"
  ad_agentless    = "arn:aws:iam::aws:policy/AWSApplicationDiscoveryAgentlessCollectorAccess"
  ads_user_name   = var.ads_user_name
}
module "iam_dms" {
  source                    = "./modules/iam_dms"
  count                     = var.create_iam_dmsc ? 1 : 0
  aws_account_id            = var.aws_account_id
  dms_fleet_advisor_service = "dms-fleet-advisor.amazonaws.com"
  fac_user_name             = var.fac_user_name
  bucket_name               = one(module.s3[*].bucket_name)
}
module "iam_mx" {
  source         = "./modules/iam_mx"
  count          = var.create_code ? 1 : 0
  aws_account_id = var.aws_account_id
  mx_user_name   = var.mx_user_name
  bucket_name_mx = one(module.s3_mx[*].bucket_name_mx)
}
module "iam_wwama" {
  source           = "./modules/iam_wwama"
  count            = var.create_wwama ? 1 : 0
  aws_account_id   = var.aws_account_id
  wwama_user_name  = var.wwama_user_name
  beanstalk_access = "arn:aws:iam::aws:policy/AdministratorAccess-AWSElasticBeanstalk"
  iam_readonly     = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  s3_full          = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
module "iam_sr" {
  source                = "./modules/iam_sr"
  count                 = var.create_iam_sr ? 1 : 0
  aws_account_id        = var.aws_account_id
  mh_strategy_collector = "arn:aws:iam::aws:policy/AWSMigrationHubStrategyCollector"
  sr_user_name          = var.sr_user_name
}
module "cast_highlight" {
  source         = "./modules/ec2_casthighlight"
  count          = var.create_casth ? 1 : 0
  aws_account_id = var.aws_account_id
  vpc_id         = var.vpc_id
  subnet_id      = var.subnet_id
  subnet_cidr    = var.subnet_cidr
  ec2_casthighlight_specs = {
    "ami"           = var.ami_w2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
  key_pair_name    = var.key_name_casth
}
module "sr_collector" {
  source         = "./modules/ec2_srcollector"
  count          = var.create_sr_collector ? 1 : 0
  aws_account_id = var.aws_account_id
  vpc_id         = var.vpc_id
  vpc_cidr       = var.vpc_cidr
  subnet_id      = var.subnet_id
  ec2_collector_specs = {
    "ami"           = var.ami_appdatcollector
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
  key_pair_name    = var.key_name_mhsr
}
module "wwama" {
  source         = "./modules/ec2_wwama"
  count          = var.create_wwama ? 1 : 0
  aws_account_id = var.aws_account_id
  vpc_id         = var.vpc_id
  subnet_id      = var.subnet_id
  subnet_cidr    = var.subnet_cidr
  ec2_wwama_specs = {
    "ami"           = var.ami_w2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
  key_pair_name    = var.key_name_wwama
}
module "code_analysis" {
  source         = "./modules/ec2_codeanalysis"
  count          = var.create_code ? 1 : 0
  aws_account_id = var.aws_account_id
  vpc_id         = var.vpc_id
  vpc_cidr       = var.vpc_cidr
  subnet_id      = var.subnet_id
  subnet_cidr    = var.subnet_cidr
  srcollector_sg = one(module.sr_collector[*].srcollector_sg)
  ec2_codeanalysis_specs = {
    "ami"           = var.ami_w2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
  key_pair_name    = var.key_name_porta
}
module "dms_collector" {
  source         = "./modules/ec2_dmscollector"
  count          = var.create_dms_collector ? 1 : 0
  aws_account_id = var.aws_account_id
  vpc_id         = var.vpc_id
  vpc_cidr       = var.vpc_cidr
  subnet_id      = var.subnet_id
  subnet_cidr    = var.subnet_cidr
  ec2_dmscollector_specs = {
    "ami"           = var.ami_w2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = var.my_ip
  key_pair_name    = var.key_name_dmsc
}
