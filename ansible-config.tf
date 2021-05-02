resource "local_file" "ansible_inventory" {
  content = templatefile("./templates/inventory-template.yml", {
    ab_server_info      = var.ab_server_info.name
    nginx_server_info   = var.nginx_server_info.name
    nginx_server_ip     = aws_instance.nginx_server.public_ip
    apache_ab_server_ip = aws_instance.ab_server.public_ip
    ssh_keyfile         = local_file.private_key.filename
    ssh_user            = var.aws_instance_common_info.ssh_user
  })
  filename = format("%s/%s", abspath(path.root), "./ansible/inventory.yml")
}

resource "local_file" "ansible_playbook" {
  content = templatefile("./templates/playbook-template.yml", {
    ab_server_info    = var.ab_server_info.name
    nginx_server_info = var.nginx_server_info.name
    nginx_server_ip   = aws_instance.nginx_server.public_ip

  })
  filename = format("%s/%s", abspath(path.root), "./ansible/playbook.yml")
}


