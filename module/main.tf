resource "aws_instance" "web" {
  ami                         = var.ami
  instance_type               = var.type
  subnet_id                   = var.subnet
  associate_public_ip_address = var.ip
  root_block_device {
    volume_type = var.vol_type
    volume_size = var.vol_size
    encrypted   = var.vol_encrypt
  }
  tags = {
    Name       = var.name
    Enviroment = var.env
  }
  security_groups = [var.sg]
}


variable "ami" {
  type = string
}
variable "type" {
  default = "t3.micro"
  type    = string
}
variable "subnet" {
  type = string
}
variable "ip" {
  type = bool
}
variable "vol_type" {
  type = string
}
variable "vol_size" {
  default = 16
  type    = number
}
variable "vol_encrypt" {
  default = true
  type    = bool
}
variable "sg" {
  type = string
}
variable "name" {
  type = string
}
variable "env" {
  type = string
}
