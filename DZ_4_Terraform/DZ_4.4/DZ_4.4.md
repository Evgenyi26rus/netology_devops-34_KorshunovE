# Домашнее задание к зан
ятию «Продвинутые методы работы с Terraform»


### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности.  

[main.tf](src%2Fmain.tf)

В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.

[cloud-init.yml](src%2Fcloud-init.yml)

![4.4.1.4.png](picture%2F4.4.1.4.png)

[variables.tf](src%2Fvariables.tf)

2. Добавьте в файл cloud-init.yml установку nginx.

[cloud-init.yml](src%2Fcloud-init.yml)

3. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```, 

![4.4.1.1.png](picture%2F4.4.1.1.png)
 
скриншот консоли ВМ yandex cloud с их метками. 

![4.4.1.2.png](picture%2F4.4.1.2.png)

Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm

![4.4.1.3.png](picture%2F4.4.1.3.png)

------

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.

```
module "vpc_dev" {
  source       = "./modules/vm"
  env_name     = "develop"
  subnet_zones = "ru-central1-a"
  subnet_id   = ["10.0.1.0/24"]
  }
```

[main.tf](src%2Fmain.tf)

2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.

[main.tf](src%2Fmain.tf)

[main.tf](src%2Fmodules%2Fvm%2Fmain.tf)

3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  

![4.4.2.3.png](picture%2F4.4.2.3.png)

![4.4.2.3.2.png](picture%2F4.4.2.3.2.png)

[outputs.tf](src%2Fmodules%2Fvm%2Foutputs.tf)

[outputs.tf](src%2Foutputs.tf)

4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.

Этот пункт не получился, т.к. получаю ошибку при отправке в яндекс запросов с сетью и 2 ВМ, скриншоты ниже:

![4.4.2.4-1.png](picture%2F4.4.2.4-1.png)

![4.4.2.4-2.png](picture%2F4.4.2.4-2.png)

![4.4.2.4-3.png](picture%2F4.4.2.4-3.png)

Ошибка на скрингшоте выше, при этом создаётся только сеть:

![4.4.2.4-4.png](picture%2F4.4.2.4-4.png)

На ошибку потратил кучу времени, по итогу причину не нашёл, в интернете толком ничего на этот счёт не нашёл.

[main.tf](src%2Fmain.tf)

[main.tf](src%2Fmodules%2Fvm%2Fmain.tf)

5. Сгенерируйте документацию к модулю с помощью terraform-docs.
 
[123.md](src%2F123.md)

Пример вызова

```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```

### Задание 3
1. Выведите список ресурсов в стейте.

```
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_4_Terraform/DZ_4.4/src$ terraform state list
2024-02-09T21:52:15.328+0300 [INFO]  Terraform version: 1.5.7
2024-02-09T21:52:15.328+0300 [DEBUG] using github.com/hashicorp/go-tfe v1.26.0
2024-02-09T21:52:15.328+0300 [DEBUG] using github.com/hashicorp/hcl/v2 v2.16.2
...
 - write new snapshots to terraform.tfstate
 - create any backup at terraform.tfstate.backup
2024-02-09T21:52:15.564+0300 [TRACE] statemgr.Filesystem: reading initial snapshot from terraform.tfstate
2024-02-09T21:52:15.564+0300 [TRACE] statemgr.Filesystem: read snapshot with lineage "8ae382c9-02c1-6a4c-4200-0d737fdb4a5b" serial 227
data.template_file.cloudinit
module.vpc_dev.data.yandex_compute_image.my_image
module.vpc_dev.yandex_compute_instance.vm[0]
module.vpc_dev.yandex_vpc_network.develop
module.vpc_dev.yandex_vpc_subnet.develop

```

2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.

```
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_4_Terraform/DZ_4.4/src$ terraform state rm module.vpc_dev
2024-02-09T21:56:15.987+0300 [INFO]  Terraform version: 1.5.7
2024-02-09T21:56:15.991+0300 [DEBUG] using github.com/hashicorp/go-tfe v1.26.0
2024-02-09T21:56:15.991+0300 [DEBUG] using github.com/hashicorp/hcl/v2 v2.16.2
...
2024-02-09T21:56:16.512+0300 [TRACE] statemgr.Filesystem: reading latest snapshot from terraform.tfstate
2024-02-09T21:56:16.512+0300 [TRACE] statemgr.Filesystem: read snapshot with lineage "8ae382c9-02c1-6a4c-4200-0d737fdb4a5b" serial 227
Removed module.vpc_dev.data.yandex_compute_image.my_image
Removed module.vpc_dev.yandex_compute_instance.vm[0]
Removed module.vpc_dev.yandex_vpc_network.develop
Removed module.vpc_dev.yandex_vpc_subnet.develop
2024-02-09T21:56:16.513+0300 [TRACE] states.SyncState: pruning module.vpc_dev because it is empty
```

4. Импортируйте всё обратно. Проверьте terraform plan. Изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.

```
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_4_Terraform/DZ_4.4/src$ terraform import 'module.vpc_dev.yandex_compute_instance.vm[0]' fhmjvcmhcgqm68hgnr4o
...
2024-02-09T22:07:25.583+0300 [TRACE] statemgr.Filesystem: creating backup snapshot at terraform.tfstate.backup
2024-02-09T22:07:25.583+0300 [TRACE] statemgr.Filesystem: state has changed since last snapshot, so incrementing serial to 233
2024-02-09T22:07:25.583+0300 [TRACE] statemgr.Filesystem: writing snapshot at terraform.tfstate

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

2024-02-09T22:07:25.586+0300 [TRACE] statemgr.Filesystem: removing lock metadata file .terraform.tfstate.lock.info
2024-02-09T22:07:25.586+0300 [TRACE] statemgr.Filesystem: unlocking terraform.tfstate using fcntl flock


```


```
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_4_Terraform/DZ_4.4/src$ terraform import 'module.vpc_dev.yandex_vpc_network.develop' enp1jflacbpu0be79bnh
...
2024-02-09T22:07:53.350+0300 [TRACE] graphNodeImportState: import module.vpc_dev.yandex_vpc_network.develop "enp1jflacbpu0be79bnh" produced instance object of type yandex_vpc_network
2024-02-09T22:07:53.350+0300 [TRACE] provider.terraform-provider-yandex_v0.107.0: Received request: tf_proto_version=6.3 tf_provider_addr=yandex-cloud/yandex tf_rpc=ValidateDataResourceConfig tf_req_id=53774d88-c64e-db95-35af-f8767c159af5 @caller=github.com/hashicorp/terraform-plugin-go@v0.18.0/tfprotov6/tf6server/server.go:620 @module=sdk.proto tf_data_source_type=yandex_compute_image timestamp=2024-02-09T22:07:53.350+0300
module.vpc_dev.yandex_vpc_network.develop: Import prepared!
  Prepared yandex_vpc_network for import
2024-02-09T22:07:53.350+0300 [TRACE] provider.terraform-provider-yandex_v0.107.0: Sending request downstream: tf_data_source_type=yandex_compute_image tf_provider_addr=yandex-cloud/yandex tf_rpc=ValidateDataResourceConfig @caller=github.com/hashicorp/terraform-plugin-go@v0.18.0/tfprotov6/internal/tf6serverlogging/downstream_request.go:20 @module=sdk.proto tf_proto_version=6.3 tf_req_id=53774d88-c64e-db95-35af-f8767c159af5 timestamp=2024-02-09T22:07:53.350+0300
....
024-02-09T22:07:53.625+0300 [TRACE] statemgr.Filesystem: state has changed since last snapshot, so incrementing serial to 234
2024-02-09T22:07:53.625+0300 [TRACE] statemgr.Filesystem: writing snapshot at terraform.tfstate

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

2024-02-09T22:07:53.628+0300 [TRACE] statemgr.Filesystem: removing lock metadata file .terraform.tfstate.lock.info
2024-02-09T22:07:53.628+0300 [TRACE] statemgr.Filesystem: unlocking terraform.tfstate using fcntl flock

```


```
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_4_Terraform/DZ_4.4/src$ terraform import 'module.vpc_dev.yandex_vpc_subnet.develop' e9bu6uc766e33hcaaarm
...
2024-02-09T22:09:49.314+0300 [TRACE] provider.terraform-provider-yandex_v0.107.0: Served request: tf_resource_type=yandex_vpc_subnet tf_rpc=ImportResourceState tf_proto_version=6.3 @module=sdk.proto tf_provider_addr=yandex-cloud/yandex tf_req_id=169246c5-080f-e5ed-be34-fc0ee45c33db @caller=github.com/hashicorp/terraform-plugin-go@v0.18.0/tfprotov6/tf6server/server.go:864 timestamp=2024-02-09T22:09:49.314+0300
2024-02-09T22:09:49.314+0300 [TRACE] graphNodeImportState: import module.vpc_dev.yandex_vpc_subnet.develop "e9bu6uc766e33hcaaarm" produced instance object of type yandex_vpc_subnet
module.vpc_dev.yandex_vpc_subnet.develop: Import prepared!
  Prepared yandex_vpc_subnet for import
2024-02-09T22:09:49.314+0300 [TRACE] vertex "module.vpc_dev.yandex_vpc_subnet.develop (import id \"e9bu6uc766e33hcaaarm\")": expanding dynamic subgraph
2024-02-09T22:09:49.314+0300 [TRACE] vertex "module.vpc_dev.yandex_vpc_subnet.develop (import id \"e9bu6uc766e33hcaaarm\")": entering dynamic subgraph

...
2024-02-09T22:09:49.559+0300 [TRACE] statemgr.Filesystem: state has changed since last snapshot, so incrementing serial to 235
2024-02-09T22:09:49.559+0300 [TRACE] statemgr.Filesystem: writing snapshot at terraform.tfstate

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

2024-02-09T22:09:49.562+0300 [TRACE] statemgr.Filesystem: removing lock metadata file .terraform.tfstate.lock.info
2024-02-09T22:09:49.562+0300 [TRACE] statemgr.Filesystem: unlocking terraform.tfstate using fcntl flock

```

```
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_4_Terraform/DZ_4.4/src$ terraform state list
2024-02-09T22:10:55.021+0300 [INFO]  Terraform version: 1.5.7
2024-02-09T22:10:55.021+0300 [DEBUG] using github.com/hashicorp/go-tfe v1.26.0
2024-02-09T22:10:55.021+0300 [DEBUG] using github.com/hashicorp/hcl/v2 v2.16.2
...
2024-02-09T22:10:55.263+0300 [TRACE] Meta.Backend: backend <nil> does not support operations, so wrapping it in a local backend
2024-02-09T22:10:55.263+0300 [TRACE] backend/local: state manager for workspace "default" will:
 - read initial snapshot from terraform.tfstate
 - write new snapshots to terraform.tfstate
 - create any backup at terraform.tfstate.backup
2024-02-09T22:10:55.263+0300 [TRACE] statemgr.Filesystem: reading initial snapshot from terraform.tfstate
2024-02-09T22:10:55.263+0300 [TRACE] statemgr.Filesystem: read snapshot with lineage "8ae382c9-02c1-6a4c-4200-0d737fdb4a5b" serial 235
data.template_file.cloudinit
module.vpc_dev.data.yandex_compute_image.my_image
module.vpc_dev.yandex_compute_instance.vm[0]
module.vpc_dev.yandex_vpc_network.develop
module.vpc_dev.yandex_vpc_subnet.develop

```

![4.4.3.png](picture%2F4.4.3.png)

## Дополнительные задания (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   Они помогут глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.  
  
Пример вызова
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.

### Задание 5*

1. Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с одним или несколькими(2 по умолчанию) хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster: передайте имя кластера и id сети.
2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user: передайте имя базы данных, имя пользователя и id кластера при вызове модуля.
3. Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2-х серверов.
4. Предоставьте план выполнения и по возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого. Используйте минимальную конфигурацию.

### Задание 6*
1. Используя готовый yandex cloud terraform module и пример его вызова(examples/simple-bucket): https://github.com/terraform-yc-modules/terraform-yc-s3 .
Создайте и не удаляйте для себя s3 бакет размером 1 ГБ(это бесплатно), он пригодится вам в ДЗ к 5 лекции.

### Задание 7*

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web-интерфейс и авторизации terraform в vault используйте токен "education".
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create
Path: example  
secret data key: test 
secret data value: congrats!  
4. Считайте этот секрет с помощью terraform и выведите его в output по примеру:
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

Можно обратиться не к словарю, а конкретному ключу:
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
5. Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform. 

### Задание 8*
Попробуйте самостоятельно разобраться в документаци и с помощью terraform remote state разделить root модуль на два отдельных root-модуля: создание VPC , создание ВМ . 

### Правила приёма работы

В своём git-репозитории создайте новую ветку terraform-04, закоммитьте в эту ветку свой финальный код проекта. Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-04.

В качестве результата прикрепите ссылку на ветку terraform-04 в вашем репозитории.

**Важно.** Удалите все созданные ресурсы.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 




