resource "aws_instance" "example" {
 ami = var.AMIS[var.AWS_REGION]
 instance_type = "t3.micro"
 # the VPC subnet
 subnet_id = aws_subnet.milind-public.id
 # the security group
 vpc_security_group_ids = [aws_security_group.allow-ssh.id]
 # the public SSH key
 key_name = aws_key_pair.mgykeypair.key_name
}