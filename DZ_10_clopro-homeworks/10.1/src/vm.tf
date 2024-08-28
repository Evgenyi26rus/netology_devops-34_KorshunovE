data "yandex_compute_image" "nat" {
  family = "nat-instance-ubuntu"
}

resource "yandex_compute_instance" "platform" {
  name        = var.nat.vm_name
  platform_id = var.nat.platform_id
  resources {
    cores         = var.nat.cpu
    memory        = var.nat.ram
    core_fraction = var.nat.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat.image_id
      type = "network-hdd"
      size = var.nat.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
    ip_address = "192.168.10.254"
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys       = local.vms_ssh_root_key
  }
}


data "yandex_compute_image" "vm1" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm1" {
  name        = "test-public"
  platform_id = var.nat.platform_id
  resources {
    cores         = var.nat.cpu
    memory        = var.nat.ram
    core_fraction = var.nat.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm1.image_id
      type = "network-hdd"
      size = var.nat.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys       = local.vms_ssh_root_key
  }
}


data "yandex_compute_image" "vm2" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "vm2" {
  name        = "test-private"
  platform_id = var.nat.platform_id
  resources {
    cores         = var.nat.cpu
    memory        = var.nat.ram
    core_fraction = var.nat.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm2.image_id
      type = "network-hdd"
      size = var.nat.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys       = local.vms_ssh_root_key
  }
}



# data "yandex_compute_image" "ubuntu" {
#   family = "ubuntu-2004-lts"
# }
#
# resource "yandex_compute_instance" "for_each" {
#   for_each = { for key, value in var.each_vm : key => value }
#   name        = each.value.vm_name
#   platform_id = each.value.platform_id
#   resources {
#     cores         = each.value.cpu
#     memory        = each.value.ram
#     core_fraction = each.value.core_fraction
#   }
#   boot_disk {
#     initialize_params {
#       image_id = data.yandex_compute_image.ubuntu.image_id
#       type = "network-hdd"
#       size = each.value.disk
#     }
#   }
#
#   scheduling_policy {
#     preemptible = true
#   }
#
#   network_interface {
#     subnet_id = each.value.subnet_id
#     nat       = each.value.network_interface-nat
#   }
#
#   metadata = {
#     serial-port-enable = 1
#     ssh-keys           = local.vms_ssh_root_key
#   }
# }
