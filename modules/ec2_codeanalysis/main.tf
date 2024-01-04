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
  tags                   = merge({ "Name" : "E24x7 PA" }, { "Description" : "Porting Assistant" }, local.resource_tags)
  user_data = templatefile("${path.module}/user_data.ps1", {
    folder     = "C:\temp"
    dotnet6    = "https://download.visualstudio.microsoft.com/download/pr/81531ad6-afa9-4b61-9d05-6a76dce81123/2885d26c1a58f37176fd7859f8cc80f1/dotnet-sdk-6.0.417-win-x64.exe"
    dotnet6exe = "dotnet-sdk-6.0.417-win-x64.exe"
    porting    = "https://s3.us-west-2.amazonaws.com/aws.portingassistant.dotnet.download/latest/windows/Porting-Assistant-Dotnet.exe"
    portingexe = "Porting-Assistant-Dotnet.exe"
  })
}
resource "aws_security_group" "sg_codeanalysis" {
  name        = "E24x7-PA"
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
