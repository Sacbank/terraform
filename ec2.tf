# Create the EC2 instance
resource "aws_instance" "private_instance" {
  ami             = data.aws_ami.ubuntu.id  # Using the latest Ubuntu AMI
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.private_subnet.id
  key_name        = var.key_name
  security_groups = [aws_security_group.Priv_instance_sg.id]
  associate_public_ip_address = false  # This prevents the instance from having a public IP address
  disable_api_termination = true # Enable termination protection for the instance
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  # Root volume configuration
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    encrypted             = true
    kms_key_id            = "alias/aws/ebs" # Use the default AWS managed KMS key for encryption
    delete_on_termination = true
  }

  tags = {
    Name = "Private_Instance"
  }
}

# Create an Bastion EC2 instance with a public IP
resource "aws_instance" "public_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  key_name        = var.key_name
  security_groups = [aws_security_group.Pub_instance_sg.id]
  associate_public_ip_address = true
  disable_api_termination = true 
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  # Root volume configuration
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    encrypted             = true
    kms_key_id            = "alias/aws/ebs"
    delete_on_termination = true
  }

  tags = {
    Name = "Public_Instance"
  }
}
