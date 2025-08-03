  locals {
    ssh_connect   ="${var.ssh_all.ssh_vm.ssh_user}:${file(var.ssh_all.ssh_vm.ssh_path)}"
    nat_ssh_path  ="${file(var.ssh_all.ssh_vm.ssh_path)}"
    nat_ssh_user  ="${var.ssh_all.ssh_vm.ssh_user}"
    sub_public    ="${yandex_vpc_subnet.test_vps_subnet.id}"
  }
