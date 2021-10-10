
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  connection {
    type ="ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  provisioner "file" {
    content = "foobar"
    destination = "/home/ubuntu/tuts.txt"
  }
}

output "ip" {
  value = aws_instance.example.public_ip
}