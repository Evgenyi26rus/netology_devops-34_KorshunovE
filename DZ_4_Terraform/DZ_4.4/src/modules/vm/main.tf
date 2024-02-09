terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  labels = length(keys(var.labels)) >0 ? var.labels: {
    "env"=var.env_name

  }
}

#!

#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = var.env_name
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = var.env_name
  zone           = var.subnet_zones
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.subnet_id
}


data "yandex_compute_image" "my_image" {
  family = var.image_family
}

resource "yandex_compute_instance" "vm" {
  count = var.instance_count

  name               = var.env_name
  platform_id        = var.platform
  hostname           = "${var.instance_name}-${count.index}"
  zone               = var.subnet_zones
  service_account_id = var.service_account_id
  description        = "${var.description} {{terraform managed}}"
  scheduling_policy {
    preemptible = var.preemptible
  }

  resources {
    cores         = var.instance_cores
    memory        = var.instance_memory
    core_fraction = var.instance_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.image_id
      type     = var.boot_disk_type
      size     = var.boot_disk_size
    }
  }

 network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.public_ip
    security_group_ids = var.security_group_ids
 }

#network_interface {
#    subnet_id  = var.subnet_id
#    nat        = var.public_ip
#    ip_address = var.known_internal_ip
#    security_group_ids = var.security_group_ids
#  }

  metadata = {
    for k, v in var.metadata : k => v
  }

  labels = {
    for k, v in local.labels : k => v
  }

  allow_stopping_for_update = true

  lifecycle {
    ignore_changes = [
      boot_disk,
    ]
  }
}


