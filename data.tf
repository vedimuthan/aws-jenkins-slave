data "template_file" "user_data_script"{
  template = "${file("${path.module}/userdata/userdata.sh")}"

  vars={
    jen=var.jen
    MASTER_URL=var.master-url
    MASTER_USERNAME=var.master-username
    MASTER_PASSWORD=var.master-password
    NUM_EXECUTORS=var.num-of-executors
    USER=var.jenkins-user
    LABELS=var.labels
  }
}
