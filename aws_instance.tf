resource "aws_instance" "nginx_server" {
  ami                    = var.aws_instance_common_info.ami
  instance_type          = var.nginx_server_info.instance_type
  key_name               = var.aws_instance_common_info.ssh_key_pair
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ssh_from_current_ip.id, aws_security_group.http_from_ab_server.id]
  tags = {
    Name        = var.nginx_server_info.name
    Owner       = var.nginx_server_info.owner
    Environment = var.nginx_server_info.environment
    Stack       = var.nginx_server_info.stack
    Severity    = var.nginx_server_info.severity
  }
}

resource "aws_instance" "ab_server" {
  ami                    = var.aws_instance_common_info.ami
  instance_type          = var.ab_server_info.instance_type
  key_name               = aws_key_pair.demo_provisioning.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.ssh_from_current_ip.id]
  tags = {
    Name        = var.ab_server_info.name
    Owner       = var.ab_server_info.owner
    Environment = var.ab_server_info.environment
    Stack       = var.ab_server_info.stack
    Severity    = var.ab_server_info.severity
  }
}

resource "null_resource" "ansible_requirements" {
  provisioner "local-exec" {
    command = "cd ansible && ansible-galaxy install -r requirements.yml --roles-path ./roles"
  }

  provisioner "local-exec" {
    command = "cd ansible && ansible-playbook -i inventory.yml playbook.yml --tags install"
  }
  # AWS instances should be up&running before applying the ansible playbooks
  depends_on = [aws_instance.ab_server, aws_instance.nginx_server]
}
