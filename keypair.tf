resource "tls_private_key" "jenkins_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins_key_pair" {
  public_key = tls_private_key.jenkins_private_key.public_key_openssh
  key_name   = "jenkins_key_pair"
}

resource "local_file" "My_File" {
  content  = tls_private_key.jenkins_private_key.private_key_pem
  filename = "${path.root}/keys/jenkins_key_pair.pem"
}
