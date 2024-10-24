resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public-a" {
  name           = var.subnet_name
  zone           = var.default_zone-a
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
#   route_table_id = yandex_vpc_route_table.private-route-table.id
}

resource "yandex_vpc_subnet" "public-b" {
  name           = var.subnet_name-b
  zone           = var.default_zone-b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr-b
}


