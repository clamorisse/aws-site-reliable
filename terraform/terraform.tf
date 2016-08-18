// ----------------------------------------
//     Infrastructure for a site  
//        reliable wordpress       
// ----------------------------------------

// ------------ VARIABLES -----------------

variable "aws-region"          { }

variable "app-name"            { }

variable "ec2"                 { }
variable "number"              { }
variable "ec2-type"            { }
variable "key-name"            { default = "server-key" }
variable "amazon-linux-ami"    { default = "ami-6869aa05"}
# variable "public_ip"           { default = true }
# variable "user_data_m"        { }
# variable "user_data_w"        { }

variable "vpc-cidr"            { }

variable "igw-name"            { }

variable "az-pub"              { }
variable "cidr-pub"            { }
variable "name-pub-subnet"     { }

variable "env"                 { }

// -----------------------------------------


# Provider defaults settings

  provider "aws" {
  region = "${var.aws-region}"
  profile = "default"
}

# CREATE VPC

module "vpc" {
  source = "modules/network/vpc"

  name   = "${var.app-name}-vpc"
  cidr   = "${var.vpc-cidr}" 
}

# CREATE SG HTTP, HTTPS, SSH

resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "Allows hhtp, https and ssh traffic"
  vpc_id      = "${module.vpc.vpc_id}"

# HTTP

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# HTTPS

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# SSH

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

# CREATE PUBLIC SUBNETS

module "public_subnet" {
  source = "modules/network/subnet" 

  vpc_id            = "${module.vpc.vpc_id}"
  cidr_block        = "${var.cidr-pub}"
  availability_zone = "${var.az-pub}"
  name              = "${var.app-name}-${var.name-pub-subnet}"
}

# CREATE PUBLIC INSTANCES

module "instance" "manager" {
  source = "modules/compute"

  name                        = "${var.ec2}"
  ami                         = "${var.amazon-linux-ami}"
  number                      = "${var.number}"
  instance_type               = "t2.micro"
  public_ip                   = true
  key_name                    = "${var.key-name}"
  subnet_id                   = "${module.public_subnet.subnet_ids}"
#  user_data                   = "${template_file.webserver_userdata.rendered}"
  instance_sg_ids             = "${aws_security_group.web_server_sg.id}"
}


