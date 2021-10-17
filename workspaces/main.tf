
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

locals {
  instance_name = "${terraform.workspace}-instance"
}
resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  tags = {
    Name = local.instance_name
  }
}

output "ip" {
  value = aws_instance.example.public_ip
}