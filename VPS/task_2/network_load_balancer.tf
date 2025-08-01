data "yandex_compute_instance_group" "grou_vm" {
  instance_group_id = yandex_compute_instance_group.web_group.id

}
resource "yandex_lb_target_group" "lb_group_ip" {
  name = "web"
  region_id = "ru-central1"
  
  # добавление узлов через цикл
  dynamic "target" {
    for_each = data.yandex_compute_instance_group.grou_vm.instances
    content {
        subnet_id = target.value.network_interface[0].subnet_id 
        address   = target.value.network_interface[0].ip_address
    }
}
    # добавление узлов вручную
#   }
#   target {
#     subnet_id = yandex_vpc_subnet.test_vps_subnet.id
#     address = data.yandex_compute_instance_group.grou_vm.instances[1].network_interface[0].ip_address
#   }
#   target {
#     subnet_id = yandex_vpc_subnet.test_vps_subnet.id
#     address   = data.yandex_compute_instance_group.grou_vm.instances[2].network_interface[0].ip_address
#   }
}

resource "yandex_lb_network_load_balancer" "balanc" {
  name = "balancer-monkey"
  listener {
    name= "monkey"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.lb_group_ip.id
    healthcheck {
      name = "mo-key"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
