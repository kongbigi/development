
provider "aws" {
  region = var.region
}
data "aws_vpc" "usec-prod-vpc" {
  id = var.vpc_id
}
resource "aws_security_group" "Usec-nessus-PROD" {
  name = "Usec-nessus-PROD"
  vpc_id = data.aws_vpc.usec-prod-vpc.id

  # SSH access from the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.69.0.0/16"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.69.0.0/16"]
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.69.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Usec-nessus" {
  ami                         = "ami-032f024b09fc9a2f5"
  instance_type               = "t3.medium"
  root_block_device {
    volume_size=30
  }
  subnet_id                   = "subnet-02b853eea9f10e391"
  vpc_security_group_ids      = [aws_security_group.Usec-nessus-PROD.id]
  associate_public_ip_address = false

  tags = {
    Name = "prod-nessus.unzer.cloud"
  }
}

output "id" {
  value = aws_instance.Usec-nessus.private_ip
}
