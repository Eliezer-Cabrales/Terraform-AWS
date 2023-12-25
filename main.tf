provider "aws" {
  region     = "eu-west-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {
  description = "Access key for AWS"
  type        = string
}

variable "aws_secret_key" {
  description = "Secret key for AWS"
  type        = string
}

variable "secret" {
  description = "secreto encriptado"
  type        = string
  default     = "cabrales.eliezer@gmail.com"
}


locals {
  tarjetita = "ajolotito_bonito"
}


resource "aws_instance" "instancia_terraform" {

  ami                = "ami-02476eb835fc66157"
  instance_type      = "t2.micro"
  key_name           = "terraform2"
  subnet_id          = module.mi_vpc.subnet_public_id
  vpc_security_group_ids = module.mi_vpc.security_group_idsss
  tags = {
    Name = local.tarjetita
  }

}

module "mi_vpc" {
  source = "./vpc"

  vpc_name            = "MiVPC"
  cidr_block          = "10.0.0.0/16"
  subnet_public_cidr  = "10.0.1.0/24"
  subnet_private_cidr = "10.0.2.0/24"
}











