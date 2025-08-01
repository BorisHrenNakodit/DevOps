data "yandex_compute_image" "publick_image" {
  family = "debian-11-oslogin"
}

resource "yandex_compute_instance" "work_vm" {
  for_each = {for vm in local.work_pod:vm.vm_name=>vm}
  name = each.value.vm_name

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.publick_image.image_id
    }
  }
  network_interface{
    subnet_id = each.value.sub_net
    nat       = each.value.nat
  }
  metadata = {
    serial-port-enable = var.ssh_all.ssh_vm.serial_port
    ssh-keys           = local.ssh_connect
  }
  scheduling_policy {
    preemptible = true
  }

  }
