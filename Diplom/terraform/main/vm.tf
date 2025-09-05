resource "yandex_compute_image" "image" {
    source_family = "debian-12" 
}

resource "yandex_compute_instance" "vms" {
    depends_on = [ yandex_vpc_subnet.kub_subnets ]
    for_each = var.vm

    name        = each.key
    platform_id = each.value.platform_id
    zone        = yandex_vpc_subnet.kub_subnets[each.value.subnet].zone
  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }
  boot_disk {   
    initialize_params {
      size = each.value.hdd_size
      image_id = yandex_compute_image.image.id
      
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.kub_subnets[each.value.subnet].id
    nat = true
  }
  metadata = {
    serial-port-enable = var.ssh_all.ssh_vm.serial_port
    ssh-keys           = local.ssh_connect
    user-data = <<EOF
    users:
      - name: debian
        groups: sudo
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        ssh-authorized-keys:
          - ${file("~/.ssh/id_ansible.pub")}
    EOF
  }
  scheduling_policy {
    preemptible = false
  }
}