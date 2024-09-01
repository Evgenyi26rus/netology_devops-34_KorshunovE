# https://terraform-provider.yandexcloud.net/Resources/compute_instance_group

data "yandex_compute_image" "lamp" {
  family = "lamp"
}

resource "yandex_iam_service_account" "gvm-sa" {
  name        = "gvm-sa"
  description = "SA dlya group vm"
  folder_id = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "group-editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.gvm-sa.id}"
  depends_on = [ yandex_iam_service_account.gvm-sa ]
}

resource "yandex_compute_instance_group" "lamp-instance" {
  name = "lamp"
  folder_id   = var.folder_id
  service_account_id = yandex_iam_service_account.gvm-sa.id
  deletion_protection = false
  depends_on          = [yandex_resourcemanager_folder_iam_member.group-editor]
  instance_template {
    platform_id = var.gvm.platform_id
    resources {
      cores         = var.gvm.cpu
      memory        = var.gvm.ram
      core_fraction = var.gvm.core_fraction
    }

    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        type     = "network-hdd"
        size     = var.gvm.disk
      }
    }

    scheduling_policy {
      preemptible = true
    }

    network_interface {
      network_id = "${yandex_vpc_network.develop.id}"
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
      nat        = true
    }

    metadata = {
      serial-port-enable = 1
      ssh-keys           = local.vms_ssh_root_key
#       user_data = file("${path.module}/picture.sh")
      user-data  = <<EOF
#!/bin/bash
cd /var/www/html
echo '<html><head><title>Picture from S3</title></head> <body><h1>Netology DZ</h1><img src="http://${yandex_storage_bucket.bucket.bucket_domain_name}/s3.jpg"/></body></html>' > index.html
EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 3
    max_expansion   = 2
    max_deleting    = 3
  }

  health_check {
    interval = 60
    timeout  = 20
    tcp_options {
      port = 80
    }
  }

  load_balancer {
    target_group_name = "lamp-group"
  }
}