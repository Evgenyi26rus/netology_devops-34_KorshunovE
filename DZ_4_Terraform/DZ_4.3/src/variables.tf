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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "each_vm" {
  type = list(object({
    vm_name = string
    platform_id = string
    cpu = number
    ram = number
    core_fraction = number
    disk= number
  }))
  default = [
    { vm_name = "main"
      platform_id = "standard-v1"
      cpu = 2
      ram = 1
      core_fraction = 5
      disk = 13
    },
    {  vm_name = "replica"
      platform_id = "standard-v1"
      cpu = 4
      ram = 2
      core_fraction = 5
      disk = 20
      }
  ]
}
