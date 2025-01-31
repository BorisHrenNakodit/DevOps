#Network
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#Первая подсеть
resource "yandex_vpc_subnet" "vm_web_develop" {
  name           = local.name_web
  zone           = var.vm_web_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_web_default_cidr
}


#ID_image
data "yandex_compute_image" "vm_web_ubuntu" {
  family = var.vm_web_image_Bubuntu
}


#Первая машина
resource "yandex_compute_instance" "vm_web_platform" {
  name        = var.vm_web_inst_name
  platform_id = var.vm_web_inst_platfor_id
  resources {
    cores         = var.vms_resources.web.core
    memory        = var.vms_resources.web.ram
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm_db_ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vm_web_develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vm_metadata.ssh_key.serial_port_enable
    ssh-keys           =local.ssh_connect
  }

}

data "yandex_compute_image" "vm_db_ubuntu" {
  family = var.vm_db_image_Bubuntu
}




#Вторая подсеть
resource "yandex_vpc_subnet" "vm_db_develop" {
  name           = local.name_db
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
}

#Вторая машина  
resource "yandex_compute_instance" "vm_db_platform" {
  name        = var.vm_db_inst_name
  platform_id = var.vm_db_inst_platfor_id
  resources {
    cores         = var.vms_resources.db.core
    memory        = var.vms_resources.db.ram
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm_db_ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vm_web_develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vm_metadata.ssh_key.serial_port_enable
    ssh-keys           ="ubuntu:${file("~/.ssh/id_Task2.pub")}"
  }
}  
  

