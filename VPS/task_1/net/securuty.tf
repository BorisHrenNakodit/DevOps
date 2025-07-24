resource "yandex_vpc_route_table" "free" {
  network_id = yandex_vpc_network.test_vps.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254" 
  }
}

resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = "security_g"
  network_id = yandex_vpc_network.test_vps.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
  
  ingress {
    protocol = "ICMP"
    description = "ping"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}