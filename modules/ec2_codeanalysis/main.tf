resource "aws_key_pair" "porta_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "porta_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "./keys/porta-key.pem"
}
resource "aws_instance" "porting" {
  ami                    = var.ec2_codeanalysis_specs.ami
  instance_type          = var.ec2_codeanalysis_specs.instance_type
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.porta_key.key_name
  vpc_security_group_ids = [aws_security_group.sg_codeanalysis.id]
  tags                   = merge({ "Name" : "MHSR Code Analisis" }, { "Description" : "Porting Assistant" }, local.resource_tags)
}
resource "aws_security_group" "sg_codeanalysis" {
  name        = "CodeAnalysisSG"
  description = "Code Analysis (Porting Assistant) Group"
  vpc_id      = var.vpc_id
  ingress {
    description = "RDP from Internet"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.external_mgmt_ip, var.subnet_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
