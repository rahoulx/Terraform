#instance_in_pub_subnet
resource "aws_instance" "pub_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet.id
  key_name      = "mumbai-awskey"
  vpc_security_group_ids      = ["default"]

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
  vpc_security_group_ids      = ["default"]
  tags = {
    Name = "${var.name}-prv-inst"
  }
}