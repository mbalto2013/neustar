resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "demo_provisioning" {
  key_name   = "demo_provisioning"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key" {
  sensitive_content = tls_private_key.key.private_key_pem
  filename          = format("%s/%s/%s", abspath(path.root), ".ssh", "demo-ssh-key.pem")
  file_permission   = "0600"
}