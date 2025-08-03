resource "yandex_vpc_network" "test_vps" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "test_vps_subnet" {
  name = var.vpc_sub_name.sub.sub_public
  zone = var.default_zone
  network_id = yandex_vpc_network.test_vps.id
  v4_cidr_blocks = ["${var.ipmask}"]
}
resource "yandex_vpc_security_group" "ssh" {
  network_id = yandex_vpc_network.test_vps.id
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}