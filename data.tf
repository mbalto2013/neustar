
data "aws_vpc" "target_vpc" {
  id = var.vpc_id
}

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}
