variable "vpc_id" {
  default = "vpc-dbc2cfbc"
}

variable "aws_instance_common_info" {
  type = map(any)
  default = {
    "ami"          = "ami-042e8287309f5df03"
    "ssh_user"     = "ubuntu"
    "ssh_key_pair" = "demo_provisioning"
  }
}


variable "ab_server_info" {
  type = map(any)
  default = {
    instance_type = "t2.micro"
    stack         = "['apache-bench']"
    name          = "ab-server"
    owner         = "ab-owner@email.com"
    environment   = "prod"
    severity      = "1"
  }
}

variable "nginx_server_info" {
  type        = map(any)
  description = ""
  default = {
    instance_type = "t2.medium"
    stack         = "['nginx']"
    name          = "nginx-server"
    owner         = "nxing-owner@email.com"
    environment   = "qa"
    severity      = "4"
  }
}

variable "aws_security_group_info" {
  type        = map(any)
  description = ""
  default = {
    owner        = "sg-owner@email.com"
    environments = "qa,dev,uat,prod"
  }
}

locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.body)
}
