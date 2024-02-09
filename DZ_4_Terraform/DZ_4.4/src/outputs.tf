#output "yandex_vpc_subnet" {
#  value = module.vpc_dev
#}

output "vpc_network" {
        value = module.vpc_dev.network_id
}

output "vpc_subnet" {
        value = module.vpc_dev.subnet_id
}