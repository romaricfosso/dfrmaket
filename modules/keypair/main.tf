resource "tls_private_key" "dfritech" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "dfritech" {
  key_name   = var.key_name
  public_key = tls_private_key.dfritech.public_key_openssh

  tags = {
    Name = "${var.key_name}-keypair"
  }
}
resource "local_file" "private_key" {
  content         = tls_private_key.dfritech.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0400"
}

