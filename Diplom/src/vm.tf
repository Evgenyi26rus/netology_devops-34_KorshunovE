data "template_file" "cloudinit" {
 template = file("${path.module}/cloud-init.yml")
 vars = {
   ssh_public_key = local.vms_ssh_root_key
   ssh_private_key = local.vms_ssh_private_key
 }
}
data "yandex_compute_image" "vm" {
#  family = "ubuntu-2404-lts"
  family = "ubuntu-2404-lts-oslogin"
}

# 1 Master node
resource "yandex_compute_instance" "master" {
  name        = "master"
  platform_id = var.ks.platform_id
  hostname    = "master"
  resources {
    cores         = var.ks.cpu
    memory        = var.ks.ram
    core_fraction = var.ks.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm.image_id
      type = "network-hdd"
      size = var.ks.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public-a.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    #ssh-keys           = "ubuntu:${local.vms_ssh_root_key}"
    ssh-keys           = local.vms_ssh_root_key
    #user-data          = data.template_file.cloudinit.rendered
  }
}

# 2 Worker node
resource "yandex_compute_instance" "worker" {
  count = 2
  name        = "worker-${count.index+1}"
  platform_id = var.ks.platform_id
  zone        = var.default_zone-b
  hostname    = "worker-${count.index+1}"
  resources {
    cores         = var.ks.cpu
    memory        = var.ks.ram
    core_fraction = var.ks.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm.image_id
      type = "network-hdd"
      size = var.ks.disk
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public-b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = local.vms_ssh_root_key
  }
}
