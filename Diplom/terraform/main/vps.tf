resource "yandex_vpc_network" "kub_network" {
  name = "kub_network"
}

resource "yandex_vpc_subnet" "kub_subnets" {
    for_each = tomap(var.vps)
      name = each.key
      network_id  = yandex_vpc_network.kub_network.id
      v4_cidr_blocks = each.value.v4_cidr_blocks
      zone  = each.value.zone
}