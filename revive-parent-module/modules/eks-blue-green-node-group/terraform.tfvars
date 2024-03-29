aws_region = "us-east-1"

control_plane_name = ""
# private_subnets = {
#   us-east-1a = "subnet-096d45c28d9fb4c14"
#   us-east-1b = "subnet-05f285a35173783b0"
#   us-east-1c = "subnet-0fe3255479ad7c3a4"
# }

eks_version  = "1.24"
# node_min     = "4"
# desired_node = "4"
# node_max     = "6"

blue_node_color  = "blue"
green_node_color = "green"

# blue  = false
# green = true

ec2_ssh_key               = "revive_bastion_keypair"
deployment_nodegroup      = "blue_green"
capacity_type             = "ON_DEMAND"
ami_type                  = "AL2_x86_64"
instance_types            = "t2.micro"
disk_size                 = "10"
shared_owned              = "shared"
enable_cluster_autoscaler = "true"

tags = {
  "id"             = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    "environment"    = "Prod"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
}
