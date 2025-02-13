resource "yandex_compute_disk" "disk_count" {
  count = 3
  name  = "disk_${count.index}"
  type  = var.disk_type
  size  = 10+count.index
  image_id = var.disk_image
}

resource "yandex_compute_instance" "vm_storage" {
  name = "storage"
  depends_on = [ yandex_compute_disk.disk_count ]
  boot_disk {
    initialize_params {
        size     = 10
        image_id = data.yandex_compute_image.vmDB_image.image_id
    }
  }
  dynamic "secondary_disk" {
   for_each = "${yandex_compute_disk.disk_count.*.id}"
   content {
     disk_id = yandex_compute_disk.disk_count["${secondary_disk.key}"].id
   }
  }
  resources {
   cores         = 2
   memory        = 2
   core_fraction = 5
  }
  


  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = true
  }
  metadata = {
    serial-port-enable = var.ssh_all.ssh_vm.serial_port
    ssh-keys           = local.ssh_connect
  }
  scheduling_policy {
    preemptible = true
  }

}