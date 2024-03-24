data "aws_subnet" "sub_pub1" {
  filter {
    name   = "tag:Name"
    values = ["2024-Prod-revive-public-subnet-1-us-east-1a"]
  }
}

data "aws_subnet" "sub_pub2" {
  filter {
    name   = "tag:Name"
    values = ["2024-Prod-revive-public-subnet-2-us-east-1b"]
  }
}

data "aws_subnet" "sub_pub3" {
  filter {
    name   = "tag:Name"
    values = ["2024-Prod-revive-public-subnet-3-us-east-1c"]
  }
}