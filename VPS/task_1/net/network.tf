resource "yandex_vpc_network" "test_vps" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "test_vps_subnet" {
  name = var.vpc_sub_name.sub.sub_public
  zone = var.zone
  network_id = yandex_vpc_network.test_vps.id
  v4_cidr_blocks = ["${var.ipmask}"]
}

resource "yandex_vpc_subnet" "test_vps_subnet_privet" {
  name = var.vpc_sub_name.sub.sub_privet
  zone = var.zone
  network_id = yandex_vpc_network.test_vps.id
  v4_cidr_blocks = ["${var.ipmask_privet}"]
  route_table_id = yandex_vpc_route_table.free.id
}
