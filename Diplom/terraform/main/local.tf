locals {
  ssh_connect   ="${var.ssh_all.ssh_vm.ssh_user}:${file(var.ssh_all.ssh_vm.ssh_path)}"
  
}