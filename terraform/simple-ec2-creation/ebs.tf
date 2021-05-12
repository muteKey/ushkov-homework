resource "aws_ebs_volume" "volume" {
  availability_zone = var.ebs_availability_zone
  size = var.volume_size
  tags = {
    Name = "ebs-${var.environment}"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.volume_device_name
  volume_id   = aws_ebs_volume.volume.id
  instance_id = aws_instance.web.id
}
