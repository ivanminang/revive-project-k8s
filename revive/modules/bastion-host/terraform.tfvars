aws_region                    = "us-east-1"
ec2_instance_ami              = ""
ec2_instance_type             = "t2.micro"
sg_name                       = "bastion-sg"
instance_name                 = "bastion-host"
# vpc_id                        = ""
# vpc_id                        = "vpc-068852590ea4b093b"
subnet_id                     = "subnet-096d45c28d9fb4c14"
root_volume_size              = 10
instance_count                = 1
enable_termination_protection = false
key_name         = "revive_bastion_keypair"
allowed_ports = [
  22,
  80,
  8080
]
tags = {
  "id"             = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    "environment"    = "Prod"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
}
