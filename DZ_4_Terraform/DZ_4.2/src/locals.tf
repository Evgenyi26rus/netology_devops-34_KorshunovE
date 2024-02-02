locals {
    env     = "develop"
    project = "platform"
    role_web = "web"
    role_db = "db"
  vm_web_name = "netology-${local.env}-${local.project}-${local.role_web}"
  vm_db_name = "netology-${local.env}-${local.project}-${local.role_db}"
}