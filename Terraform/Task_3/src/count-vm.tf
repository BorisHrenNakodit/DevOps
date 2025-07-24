data "yandex_compute_image" "vm_image" {
  family = var.vm_image_Bubuntu
}

resource "yandex_compute_instance" "vms_copy" {
  count = 2
  name  = "web-${count.index+1}"
  depends_on = [ yandex_compute_instance.vms_dataBase ]
  
  resources {
    cores           =var.count_vms.vm.cores
    memory          =var.count_vms.vm.ram
    core_fraction   =var.count_vms.vm.core_fraction

  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm_image.image_id
    }
  }
  network_interface {
    subnet_id           = yandex_vpc_subnet.develop.id
    security_group_ids  = [yandex_vpc_security_group.example.id]
    nat = false
  } 
  metadata = {
     user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("${var.ssh_all.ssh_path}")}"
    # serial-port-enable = var.ssh_all.ssh_vm.serial_port
    # ssh-keys           = local.ssh_connect
  }
  scheduling_policy {
    preemptible = true
  }
}