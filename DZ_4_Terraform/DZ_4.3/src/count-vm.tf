data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "platform" {
  depends_on = [yandex_compute_instance.for_each]
  count = 2
  name        = "web-${count.index+1}"
  platform_id = "${var.count_vm.platform_id}"
  resources {
    cores         = "${var.count_vm.cpu}"
    memory        = "${var.count_vm.ram}"
    core_fraction = "${var.count_vm.core_fraction}"
      }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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