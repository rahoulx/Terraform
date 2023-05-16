provider "aws" {
  region = var.region
}

# aws_ec2_config

resource "aws_instance" "apacheinstance" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  associate_public_ip_address = var.pub_ip
  key_name                    = var.key_pair
  #security_groups = ["sg-09ac645ba936eab49"]
  vpc_security_group_ids = [aws_security_group.aws_sg.id] #to_assign_customsg
  iam_instance_profile   = "ec2-s3fullaccess"             #to_assign_role

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }

#used_to_call_file

user_data = file("${path.module}/script.sh")


  tags = var.tag
}

#to_get_O/P_of_instanceIP

output "instance_ip_addr" {
  value = aws_instance.apacheinstance.public_ip
}

#aws_sg_config_1port

resource "aws_security_group" "aws_sg" {
  name        = "security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = "vpc-0b1f07657a4fba9ec"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
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
    Name = "my-demo-tf-sg"
  }
}
