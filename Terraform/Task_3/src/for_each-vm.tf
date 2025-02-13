data "yandex_compute_image" "vmDB_image" {
  family =var.vm_image_Bubuntu  
}


resource "yandex_compute_instance" "vms_dataBase"{
  for_each = { for vm in var.each_vm : vm.vm_name=>vm}
  name     = each.value.vm_name
    
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params{
      size        = each.value.disk_volume
      image_id    = data.yandex_compute_image.vmDB_image.image_id
    }    
  } 
  network_interface {
    subnet_id     = yandex_vpc_subnet.develop.id
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
