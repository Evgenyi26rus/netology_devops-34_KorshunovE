terraform {
 backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "netology-s3-evgen"
    region = "ru-central1"
    key    = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
