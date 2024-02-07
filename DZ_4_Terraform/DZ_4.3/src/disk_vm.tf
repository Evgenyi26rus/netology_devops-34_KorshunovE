resource "yandex_compute_disk" "disk_vm" {
  name = "disk-${count.index}"
  size = 1
  count = 3
}

resource "yandex_compute_instance" "storage_vm" {
  name        = "${var.disk_vm.vm_name}"
  platform_id = "${var.disk_vm.platform_id}"
  resources {
    cores         = "${var.disk_vm.cpu}"
    memory        = "${var.disk_vm.ram}"
    core_fraction = "${var.disk_vm.core_fraction}"
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
  for_each = yandex_compute_disk.disk_vm[*].id
  content {
    disk_id = secondary_disk.value
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