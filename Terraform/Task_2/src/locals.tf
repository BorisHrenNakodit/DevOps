locals {
  name_web="${var.vm_web_vpc_name}_${var.vpc_name}"
  name_db="${var.vm_db_vpc_name}_${var.vpc_name}"
  ssh_connect="${var.vm_metadata.ssh_key.ssh_user}:${file(var.vm_metadata.ssh_key.ssh_path)}"
}