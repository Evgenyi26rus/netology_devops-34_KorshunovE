#создаем облачную сеть
#создаем подсеть
module "vpc_dev" {
  source       = "./modules/vm"
  env_name     = "develop"
  subnet_zones = "ru-central1-a"
  subnet_id   = ["10.0.1.0/24"]
  }

#module "test-vm" {
#  source         = "./modules/vm"
#  labels         = {"project"="marketing"}
#  env_name       = "develop"
#  network_id     = module.vpc_dev.network_id
#  subnet_zones   = "ru-central1-a"
#  subnet_id     = [module.vpc_dev.subnet_id]
#  instance_name  = "web"
#  instance_count = 1
#  image_family   = "ubuntu-2004-lts"
#  public_ip      = true
#
#  metadata = {
#    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
#    serial-port-enable = 1
#  }
#
#}
#
#module "example-vm" {
#  source         = "./modules/vm"
#  labels         = {"project"="analytics"}
#  env_name       = "stage"
#  network_id     = module.vpc_dev.network_id
#  subnet_zones   = "ru-central1-a"
#  subnet_id     = [module.vpc_dev.subnet_id]
#  instance_name  = "web-stage"
#  instance_count = 1
#  image_family   = "ubuntu-2004-lts"
#  public_ip      = true
#
#  metadata = {
#    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
#    serial-port-enable = 1
#  }
#
#}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars     = {
    ssh-authorized-keys = file(var.ssh-authorized-keys)
  }
}
