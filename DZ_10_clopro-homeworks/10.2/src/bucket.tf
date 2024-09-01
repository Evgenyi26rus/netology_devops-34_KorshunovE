# https://yandex.cloud/ru/docs/storage/s3/
# Создание сервисного аккаунта
resource "yandex_iam_service_account" "service-account" {
  name      = "s3-sa"
  description = "SA dlya S3"
  folder_id = var.folder_id
}

# Назначение роли на ресурс
resource "yandex_resourcemanager_folder_iam_member" "s3-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.service-account.id}"
  depends_on = [ yandex_iam_service_account.service-account ]
}

# Создание статических ключей доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.service-account.id
  description        = "static access key for object storage"
  depends_on = [ yandex_iam_service_account.service-account ]
}

# Создание бакета с использованием ключа
resource "yandex_storage_bucket" "bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "netology-s3-evgenyi"
  acl    = "public-read"
  depends_on = [ yandex_iam_service_account_static_access_key.sa-static-key ]
}

# Положить в бакет файл с картинкой.
resource "yandex_storage_object" "picture" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "netology-s3-evgenyi"
  key    = "s3.jpg"
  source = "/home/korshunovi/PycharmProjects/netology_devops-34_KorshunovE/DZ_10_clopro-homeworks/10.2/picture/s3.jpg"
  acl    = "public-read"
  depends_on = [ yandex_storage_bucket.bucket ]
}