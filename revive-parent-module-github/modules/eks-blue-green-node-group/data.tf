data "aws_subnet" "sub_priv1" {
  filter {
    name   = "tag:Name"
    values = ["2024-Prod-revive-private-subnet-1-us-east-1a"]
  }
}

data "aws_subnet" "sub_priv2" {
  filter {
    name   = "tag:Name"
    values = ["2024-Prod-revive-private-subnet-2-us-east-1b"]
  }
}

data "aws_subnet" "sub_priv3" {
  filter {
    name   = "tag:Name"
    values = ["2024-Prod-revive-private-subnet-3-us-east-1c"]
  }
}