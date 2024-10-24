output "master-node" {
  value = [
    for i in yandex_compute_instance.master[*]:
   "name vm = ${i.name}  external-address=${i.network_interface.0.ip_address}  internal-address=${i.network_interface.0.nat_ip_address}"
  ]
}

output "worker-node" {
  value = [
    for i in yandex_compute_instance.worker[*]:
   "name vm = ${i.name}  external-address=${i.network_interface.0.ip_address}  internal-address=${i.network_interface.0.nat_ip_address}"
  ]
}