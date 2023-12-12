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
  cnam_user_name            = "e24x7-adssr-user"
  bucket_name               = module.s3.bucket_name
}
module "sr_collector" {
  source      = "./modules/ec2_srcollector"
  count       = var.create_sr_collector ? 1 : 0
  vpc_id      = "vpc-0fefd1f506f0eda13"    # <---- VPC ID donde se despliega el collector
  vpc_cidr    = "172.19.22.0/23"           # <---- CIDR del VPC
  subnet_id   = "subnet-041d55417ce85e7a7" # <---- Subnet ID donde se despliega el collector
  subnet_cidr = "172.19.23.0/25"           # <---- CIDR de la Subnet
  ec2_collector_specs = {
    "ami"           = "ami-0972df9857f16644a" # AMI AWSMHubApplicationDataCollector. Propietario 703163444405
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = "186.188.205.168/32" # <---- IP externa Team CNAM
}
module "code_analysis" {
  source      = "./modules/ec2_codeanalysis"
  count       = var.create_porting_assistant ? 1 : 0
  vpc_id      = "vpc-0fefd1f506f0eda13"    # <---- VPC ID donde se despliega el collector
  vpc_cidr    = "172.19.22.0/23"           # <---- CIDR del VPC
  subnet_id   = "subnet-041d55417ce85e7a7" # <---- Subnet ID donde se despliega el collector
  subnet_cidr = "172.19.23.0/25"           # <---- CIDR de la Subnet
  ec2_codeanalysis_specs = {
    "ami"           = "ami-0cd601a22ac9e6d79" # AMI Windows 2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = "186.188.205.168/32" # <---- IP externa Team CNAM
}
module "dms_collector" {
  source      = "./modules/ec2_dmscollector"
  count       = var.create_dms_collector ? 1 : 0
  vpc_id      = "vpc-0fefd1f506f0eda13"    # <---- VPC ID donde se despliega el collector
  vpc_cidr    = "172.19.22.0/23"           # <---- CIDR del VPC
  subnet_id   = "subnet-041d55417ce85e7a7" # <---- Subnet ID donde se despliega el collector
  subnet_cidr = "172.19.23.0/25"           # <---- CIDR de la Subnet
  ec2_dmscollector_specs = {
    "ami"           = "ami-0cd601a22ac9e6d79" # AMI Windows 2022
    "instance_type" = "t3.large"
  }
  external_mgmt_ip = "186.188.205.168/32" # <---- IP externa Team CNAM
}
