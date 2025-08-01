resource "yandex_compute_instance" "nat-instance" {
  name        = "nat_vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-nat.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.test_vps_subnet.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat                = true
    ip_address         = "192.168.10.254"
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${local.nat_ssh_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${local.nat_ssh_path}"
  }
}

resource "yandex_compute_disk" "boot-disk-nat" {
  name     = "boot-disk-nat"
  type     = "network-hdd"
  zone     = var.zone
  size     = "20"
  image_id = "fd80mrhj8fl2oe87o4e1"
}