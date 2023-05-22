#instance_in_pub_subnet
resource "aws_instance" "pub_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet.id
  key_name      = "mumbai-awskey"
  vpc_security_group_ids = [aws_security_group.aws_sg.id]

  tags = {
    Name = "${var.name}-pub-inst"
  }
}


#instance_in_prv_subnet
resource "aws_instance" "prv_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id =aws_subnet.private_subnet.id
  key_name      = "mumbai-awskey"
  tags = {
    Name = "${var.name}-prv-inst"
  }
}



#aws_sg_config_1port

resource "aws_security_group" "aws_sg" {
  name        = "${var.name}-sg" 
  description = "Allow SSH"
  vpc_id      = "aws_vpc.prod_vpc.id"

  ingress {
    description      = "TLS from my VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }