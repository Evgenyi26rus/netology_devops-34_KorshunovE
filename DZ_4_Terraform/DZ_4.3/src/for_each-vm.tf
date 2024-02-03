data "yandex_compute_image" "ubuntu2" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "for_each" {
  for_each = { for key, value in var.each_vm : key => value }
  name        = "${each.value.vm_name}"
  platform_id = "${each.value.platform_id}"
  resources {
    cores         = "${each.value.cpu}"
    memory        = "${each.value.ram}"
    core_fraction = "${each.value.core_fraction}"
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = "${each.value.disk}"
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = local.vms_ssh_root_key
  }

}