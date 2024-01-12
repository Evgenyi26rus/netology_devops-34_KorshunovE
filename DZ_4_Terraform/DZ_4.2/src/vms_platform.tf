
variable "default_zone2" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


variable "vm_db_family" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "vm_db_name" {
  type = string
  default = "netology-develop-platform-db"
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