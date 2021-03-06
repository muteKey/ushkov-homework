resource "aws_security_group" "instance-sg" {
   name   = "itea-test-sg"
   vpc_id = aws_vpc.hometask6_vpc.id

   ingress {
     from_port   = 22
     to_port     = 22
     protocol    = "TCP"
     cidr_blocks = ["0.0.0.0/0"]
   }
   ingress {
     from_port   = 1190
     to_port     = 1190
     protocol    = "TCP"
     cidr_blocks = ["10.0.0.0/24"]
   }
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
   tags = {
     Name = "${var.short_name}-sec-group"
   }
 }