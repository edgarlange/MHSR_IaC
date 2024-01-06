resource "aws_key_pair" "dmsc_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "dmsc_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "./keys/dmsc-key.pem"
}
resource "aws_instance" "dmscollector" {
  ami                    = var.ec2_dmscollector_specs.ami
  instance_type          = var.ec2_dmscollector_specs.instance_type
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.dmsc_key.key_name
  vpc_security_group_ids = [aws_security_group.sg_dmscollector.id]
  tags                   = { "Name" : "E24x7 DMS-C", "Description" : "Database Migration Service Collector" }
  user_data              = file("${path.module}/user_data.ps1")
}
resource "aws_security_group" "sg_dmscollector" {
  name        = "E24x7-DMSC"
  description = "Allow access from management subnets"
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
