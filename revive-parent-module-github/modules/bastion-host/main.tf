resource "aws_instance" "bastion-host" {
  count                   = var.instance_count
  ami                     = data.aws_ami.k8s-bastion_ami.id
  instance_type           = var.ec2_instance_type
  key_name                = aws_key_pair.revive_bastion.key_name
  vpc_security_group_ids  = [aws_security_group.sg.id]
  subnet_id               = data.aws_subnet.sub_pub1.id
  disable_api_termination = var.enable_termination_protection

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-${var.instance_name}-${count.index + 1}", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

resource "aws_key_pair" "revive_bastion" {
  key_name   = var.key_name
  public_key = tls_private_key.revive_bastion_key.public_key_openssh
}

resource "local_file" "revive_bastion" {
  content  = tls_private_key.revive_bastion_key.private_key_pem
  filename = "revivebastionkeypair"
}
resource "tls_private_key" "revive_bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


