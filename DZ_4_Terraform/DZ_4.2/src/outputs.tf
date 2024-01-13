output "ip_address_platform" {
  value = "${yandex_compute_instance.platform.network_interface[0].nat_ip_address}"
}

output "ip_address_platform2" {
  value = "${yandex_compute_instance.platform2.network_interface[0].nat_ip_address}"
}

output "instance_name" {
  value = "${yandex_compute_instance.platform.name}"
}

output "instance_name2" {
  value = "${yandex_compute_instance.platform2.name}"
}

output "Идентификатор_FQDN" {
  value = "${yandex_compute_instance.platform.fqdn}"
}

output "Внутренний_FQDN2" {
  value = "${yandex_compute_instance.platform2.fqdn}"
}