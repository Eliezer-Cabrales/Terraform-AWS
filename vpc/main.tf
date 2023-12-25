variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block de la VPC"
  type        = string
}

variable "subnet_public_cidr" {
  description = "CIDR block de la subnet publica"
  type        = string
}

variable "subnet_private_cidr" {
  description = "CIDR block de la subnet privada"
  type        = string
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_cidr
  availability_zone       = "eu-west-1a" 
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-subnet-public"
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_private_cidr
  availability_zone       = "eu-west-1a"  
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.vpc_name}-subnet-private"
  }
}
resource "aws_security_group" "subnet_sg" {
  name        = "subnet_sg"
  description = "Grupo de Seguridad para Acceso SSH"
  vpc_id      =  aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "mi_igw" {
  vpc_id = aws_vpc.main.id  
  tags = {
    Name = "mi_igw"
  }
}

resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0" 
  gateway_id             = aws_internet_gateway.mi_igw.id
}



output "internet_gateway" {
  value = aws_internet_gateway.mi_igw.id
}
output "security_group_idsss" {
  value = [aws_security_group.subnet_sg.id]
}

output "subnet_public_id" {
  value = aws_subnet.subnet_public.id
}

output "subnet_private_id" {
  value = aws_subnet.subnet_private.id
}