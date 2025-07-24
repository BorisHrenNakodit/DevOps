  locals {
    ssh_connect   ="${var.ssh_all.ssh_vm.ssh_user}:${file(var.ssh_all.ssh_vm.ssh_path)}"
    nat_ssh_path  ="${file(var.ssh_all.ssh_vm.ssh_path)}"
    nat_ssh_user  ="${var.ssh_all.ssh_vm.ssh_user}"
    sub_public    ="${yandex_vpc_subnet.test_vps_subnet.id}"
    sub_privet    ="${yandex_vpc_subnet.test_vps_subnet_privet.id}"
    
    work_pod = [ 
    {
      vm_name       = "publick"
      cpu           = 2
      ram           = 2
      core_fraction = 5
      nat           = "true"
      sub_net       = "${yandex_vpc_subnet.test_vps_subnet.id}"
    },
    {
      vm_name       = "privet"
      cpu           = 2
      ram           = 2
      core_fraction = 5
      disk_volume   = 20
      nat           = "false"
      sub_net       = "${yandex_vpc_subnet.test_vps_subnet_privet.id}"
    } 
    ]
  }
