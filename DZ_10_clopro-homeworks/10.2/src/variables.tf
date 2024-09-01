###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "Develop"
  description = "VPC network"
}

variable "subnet_name" {
  type        = string
  default     = "public"
  description = "Subnet name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "subnet_private" {
  type        = string
  default     = "private"
  description = "Subnet name"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "route-table" {
  type        = string
  default     = "private-route-table"
  description = "Route-table"
}



variable "gvm" {
  type = object({
    vm_name = string
    platform_id = string
    cpu = number
    ram = number
    core_fraction = number
    disk= number
  })
  default = ({
        vm_name = "nat"
        platform_id   = "standard-v1"
        cpu           = 2
        ram           = 1
        core_fraction = 5
        disk          = 10
    })
}


# variable "each_vm" {
#   type = list(object({
#     vm_name = string
#     platform_id = string
#     cpu = number
#     ram = number
#     core_fraction = number
#     disk= number
#     subnet_id= string
#     network_interface-nat= string
#   }))
#   default = [
#     { vm_name = "test-public"
#       platform_id = "standard-v1"
#       cpu = 2
#       ram = 1
#       core_fraction = 5
#       disk = 15
#       subnet_id= "yandex_vpc_subnet.public.id"
#       network_interface-nat= "true"
#     },
#     {  vm_name = "test-private"
#       platform_id = "standard-v1"
#       cpu = 2
#       ram = 1
#       core_fraction = 5
#       disk = 15
#       subnet_id= "yandex_vpc_subnet.private.id"
#       network_interface-nat= "false"
#       }
#   ]
# }
