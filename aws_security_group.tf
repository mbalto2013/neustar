resource "aws_security_group" "ssh_from_current_ip" {
  name        = "ssh_from_current_ip"
  description = "Allow SSH traffic from your current IP"
  vpc_id      = data.aws_vpc.target_vpc.id

  ingress {
    description = "Allows SSH traffic from your current"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name         = ""
    Owner        = "${var.aws_security_group_info.owner}"
    Environments = "${var.aws_security_group_info.environments}"
  }
}


resource "aws_security_group" "http_from_ab_server" {
  name                   = "http_from_ab_server"
  description            = "Allows HTTP traffic from the ApacheBench server"
  vpc_id                 = data.aws_vpc.target_vpc.id
  revoke_rules_on_delete = true

  ingress {
    description = "Allows HTTP traffic from the ApacheBench server"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.ab_server.public_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name         = "http_from_ab_server"
    Owner        = "${var.aws_security_group_info.owner}"
    Environments = "${var.aws_security_group_info.environments}"
  }
}