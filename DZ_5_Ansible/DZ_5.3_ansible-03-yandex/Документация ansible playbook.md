# Проект Ansible-Playbook Clickhouse & Vector

## ОС
Linux distributions: Centos7

## Version
clickhouse_version: "22.3.3.44" . Пакеты для установки: clickhouse-client, clickhouse-server, clickhouse-common-static.

vector_version: "vector-x86_64-unknown-linux-gnu" 

lighthouse_vcs: "https://github.com/VKCOM/lighthouse.git"

## Configure

Конфигурация Ansible-Playbook представлена в файле  [site.yml](playbook%2Fsite.yml)

Описание использованных хостов и способа подключения в файле [prod.yml](playbook%2Finventory%2Fprod.yml)

Описание версий Программного обеспечения и переменных в файлах:

- clickhouse [vars.yml](playbook%2Fgroup_vars%2Fclickhouse%2Fvars.yml)
- vector [vars.yml](playbook%2Fgroup_vars%2Fvector%2Fvars.yml)
- lighthouse [vars.yml](playbook%2Fgroup_vars%2Flighthouse%2Fvars.yml)


Шаблон конфигурации настроек Vector в файле [vector.yml.j2](playbook%2Ftemplate%2Fvector.yml.j2)

Шаблон конфигурации настроек lighthouse в файле [lighthouse.yml.j2](playbook%2Ftemplate%2Flighthouse.yml.j2)

Шаблон конфигурации настроек nginx в файле [nginx.yml.j2](playbook%2Ftemplate%2Fnginx.yml.j2)

## Описание Тasks в Ansible-Playbook [site.yml](playbook%2Fsite.yml):

```name: Install Clickhouse hosts: clickhouse``` - название первой части работ по скачиванию, установки и настройки ПО clickhouse на сервере clickhouse.

```handlers: - name: Start clickhouse service``` - команда по перезапуску службы clickhouse

```name: Get clickhouse distrib``` - скачивание дистрибутивов с сайта https://packages.clickhouse.com/
          
```name: Install clickhouse packages``` - установка Пакетов: clickhouse-client, clickhouse-server, clickhouse-common-static

```name: Flush handlers``` - перезагрузка служб clickhouse, после установки
      
```name: Create database``` - создание базы данных Clickhouse

---

```name: Install Vector hosts: clickhouse``` - название второй части работ по скачиванию, установки и настройки ПО Vector на сервере vector.

```handlers: name: Start Vector service``` - команда по перезапуску службы Vector

```name: Create vector directory``` - создание директории, в которую будут скачены установочные пакеты

```name: Create vector config directory``` - создание директории, в которую будет перемещён файл с настройками работы Vector [vector.yml.j2](playbook%2Ftemplate%2Fvector.yml.j2)

В нём описаны 2 действия:

- в блоке sources - каике логи и откуда собирать
- в блоке sinks - в какую таблицу Clickhouse их складывать

```name: Get Vector distrib``` - скачивание архива с дистрибутивом ПО Vector

```name: Unzip Vector archive``` - распаковка скаченного файла

```name: Install Vector binary``` - копирует исполняемый файл Vector

```name: Check Vector installation``` - проверка бинарного файла на корректность работы

```name: Configure vector``` - копирование нужного файла с настройками конфигурации

```name: Flush handlers``` - перезагрузка служб Vector

---
```name: Install nginx hosts: lighthouse``` - название третьей части работ по скачиванию, установки и настройки ПО Nginx на сервере lighthouse.

```handlers: name: start-nginx``` - команда по страту службы nginx

```name: reload-nginx``` - команда по перезапуску службы nginx

```name: NGINX | Install epel-release``` - установка Пакета: epel-release

```name: Nginx | Install Nginx``` - установка Пакета: Nginx

```name: Nginx | Create config``` - создание директории, в которую будет перемещён файл с настройками работы Nginx [nginx.yml.j2](playbook%2Ftemplate%2Fnginx.yml.j2)

```notify: start-nginx``` - запуск службы nginx

---
```name: Install lighthouse hosts: lighthouse``` - название четвёртой части работ по скачиванию, установки и настройки ПО lighthouse на сервере lighthouse.

```handlers: name: reload-nginx``` - команда по перезапуску службы nginx

```name: Lighthouse | Install Dependencies``` - установка Пакета: git

```name: Create Lighthouse directory``` - создание директории /var/www/lighthouse, куда будет клонированы рабочие файлы Lighthouse из Git

```name: Lighthouse | Clone from Git``` - клонирование репозитория с Lighthouse

```name: Lighthouse | Create lighthouse config``` - создание директории, в которую будет перемещён файл с настройками работы lighthouse [lighthouse.yml.j2](playbook%2Ftemplate%2Flighthouse.yml.j2)

```notify: reload-nginx``` - перезапуск службы nginx


## Добавлены 4 тега, для каждого ПО:

tags: clickhouse
tags: Vector
tags: nginx
tags: lighthouse