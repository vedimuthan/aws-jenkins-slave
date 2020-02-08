resource "aws_instance" "jenkins_test_instance"{
  ami        = var.ami-id
  instance_type   = var.aws_instance_type
  key_name        = aws_key_pair.jenkins_key_pair.id
  user_data=data.template_file.user_data_script.rendered

  lifecycle {
    create_before_destroy = true
  }
}
