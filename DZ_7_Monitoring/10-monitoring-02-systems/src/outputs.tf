output "ip_address_platform" {
  value = "${yandex_compute_instance.platform.network_interface[0].nat_ip_address}"
}

output "instance_name" {
  value = "${yandex_compute_instance.platform.name}"
}

output "Идентификатор_FQDN" {
  value = "${yandex_compute_instance.platform.fqdn}"
}

