
variable "default_zone2" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr2" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name2" {
  type        = string
  default     = "develop2"
  description = "VPC network & subnet name"
}

variable "vm_db_family" {
  type = string
  default = "ubuntu-2004-lts"
}

#variable "vm_db_name" {
#  type = string
#  default = "netology-develop-platform-db"
#}

#variable "vm_db_name" {
#  type = object({env = string, project = string, role = string})
#  default = {
#    env     = "develop"
#    project = "platform"
#    role    = "db"
#  }
#}

variable "vm_db_platform_id" {
  type = string
  default = "standard-v1"
}

variable "vms_resources_db" {
  type = object({
    vm_db_resources   = map(number)
     })
  default = {
    vm_db_resources = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
    }
}

variable "vms_ssh_root_key2" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFXcX/skkKcv7hhUrGdQSLU/UrWzBAeJpSQki637qeQv"
  description = "ssh-keygen -t ed25519"
}