variable "cidr_block" {
  description = "The CIDR block for the VPC"
default     = "192.168.0.0/16" 
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-${var.latest["ubuntu"]}-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

variable "latest" {
  type = map(any)
  default = {
    "ubuntu"  = "22.04"
  }
}

variable "instance_type" {
  description = "The type of EC2 instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance"
  default = "virginia"
}
