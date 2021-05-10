resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1+awGIrgc9vrs0IXfa4SJYzVcNADXt33ttBR/zF7nsv0WVF4DJjQP8kqSmCzE+Ora6ex5r+sd685SWqICFJISgvOCDmOYaRCHoTAeizfXvljI1ZGbHH9D3vfBNJv4/8sWIXHZ6D/9PH7NdkLNfwOsDuMEwLC1B8bcX9VmZyaPhDKgC2OnUOZm0YjH6ghVnpDJmattgRNCCbSpBqTCNbUqC61Xe8gGRttAvp4erBFDdFZQQJVQV8RZV6l5AWmMLY1XMzF5ApzlBqdo18KbD/mChK2QtR5n0KhHoneY1t4OvZHsRi8meotdNJ8Q1/8D95p3+/1r9cla7PEWyHS230wl kirillushkov2010@gmail.com"
}

resource "aws_instance" "web" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  key_name             = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  tags = {
    Name = "HelloWorld-${var.environment}"
  }
}