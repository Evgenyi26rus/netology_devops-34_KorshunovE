
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

variable "vm_db_name" {
  type = map(string)
  default = {
    env     = "develop"
    project = "platform"
    role    = "db"
  }
}

variable "vm_db_platform_id" {
  type = string
  default = "standard-v1"
}

variable "vm_db_cores" {
  type = number
  default = 2
}

variable "vm_db_memory" {
  type = number
  default = 2
}

variable "vm_db_core_fraction" {
  type = number
  default = 20
}