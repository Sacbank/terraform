# Create a security group for the Private EC2 instance
resource "aws_security_group" "Priv_instance_sg" {
  name        = "Priv_instance_sg"
  description = "Security group for the EC2 instance"

  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.public_instance.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private-Instance-SG"
  }   
}

# Create a security group for the Public EC2 instance
resource "aws_security_group" "Pub_instance_sg" {
  name        = "Pub_instance_sg"
  description = "Security group for the EC2 instance"

  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public-Instance-SG"
  }   
}
