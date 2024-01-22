resource "aws_key_pair" "mhsr_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "mhsr_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "./keys/${var.aws_account_id}/mhsr-key.pem"
}
resource "aws_instance" "collector" {
  ami                    = var.ec2_collector_specs.ami
  instance_type          = var.ec2_collector_specs.instance_type
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.mhsr_key.key_name
  vpc_security_group_ids = [aws_security_group.sg_collector.id]
  tags                   = { "Name" : "E24x7 MHSR-ADC", "Description" : "MHSR Application Data Collector" }
}
resource "aws_security_group" "sg_collector" {
  name        = "E24x7-MHSRADC"
  description = "Allow access from management subnets"
  vpc_id      = var.vpc_id
  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external_mgmt_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
