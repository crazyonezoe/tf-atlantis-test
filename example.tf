provider "aws" {
  region  = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "zlp-tf-states2"
    key    = "example/ec2.tfstate"
    region = "us-west-1"
  }
}


#ec2 instance using the parameter store in the name of it
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = "subnet-58af2c3e"
  associate_public_ip_address = true
  root_block_device {
    volume_type = "standard"
    volume_size = 8
    encrypted   = true
  }
  tags = {
    Name       = "webserver1"
    Enviroment = "Dev"
  }
  security_groups = ["sg-f73eddbf"]
}


