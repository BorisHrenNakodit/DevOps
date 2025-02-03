#Network
resource "yandex_vpc_network" "develop" {
  name      = var.vpc_name
  folder_id = var.folder_id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id      = var.folder_id
  name = "test-gateway"
  shared_egress_gateway {}
}
resource "yandex_vpc_route_table" "rt" {
  folder_id      = var.folder_id
  name           = "test-route-table"
  network_id     = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

#Первая подсеть
resource "yandex_vpc_subnet" "vm_web_develop" {
  name           = local.name_web
  zone           = var.vm_web_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_web_default_cidr
  folder_id      = var.folder_id
  route_table_id = yandex_vpc_route_table.rt.id
}


#ID_image
data "yandex_compute_image" "vm_web_ubuntu" {
  family = var.vm_web_image_Bubuntu
}


#Первая машина
resource "yandex_compute_instance" "vm_web_platform" {
  name        = var.vm_web_inst_name
  platform_id = var.vm_web_inst_platfor_id
  zone        = var.vm_web_default_zone

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
    nat       = false
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
  zone        = var.vm_db_default_zone
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
    subnet_id = yandex_vpc_subnet.vm_db_develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vm_metadata.ssh_key.serial_port_enable
    ssh-keys           ="ubuntu:${file("~/.ssh/id_Task2.pub")}"
  }
}  
  

