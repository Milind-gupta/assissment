resource "aws_key_pair" "mgykeypair" {
 key_name = "mgykeypair"
 public_key = file(var.PATH_TO_PUBLIC_KEY)
} 
