provider "aws" {
  region  = "us-west-2"
  version = "~> 2.0"
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
  subnet_id                   = "subnet-cc0c60e7"
  associate_public_ip_address = true
  root_block_device {
    volume_type = "standard"
    volume_size = 30
    encrypted   = true
  }
  tags = {
    Name       = "HelloWorld"
    Enviroment = "Dev"
  }
  security_groups = ["sg-bfe0bffd"]
}


