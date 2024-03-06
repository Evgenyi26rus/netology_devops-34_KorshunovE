# Проект Ansible-Playbook Clickhouse & Vector

## ОС
Linux distributions: Centos7

## Version
clickhouse_version: "22.3.3.44" . Пакеты для установки: clickhouse-client, clickhouse-server, clickhouse-common-static.

vector_version: "vector-x86_64-unknown-linux-gnu" 

## Configure

Конфигурация Ansible-Playbook представлена в файле [site.yml](playbook%2Fsite.yml). 

Описание использованных хостов и способа подключения в файле [prod.yml](playbook%2Finventory%2Fprod.yml)

Описание версий Программного обеспечения и переменных в файле [vars.yml](playbook%2Fgroup_vars%2Fclickhouse%2Fvars.yml)

Шаблоны конфигурации настроек Vector в файле [jinja2.yml](playbook%2Fgroup_vars%2Ftemplate%2Fjinja2.yml)

## Описание Тasks в Ansible-Playbook [site.yml](playbook%2Fsite.yml):

```name: Install Clickhouse hosts: clickhouse``` - название первой части работ по скачиванию, установки и настройки ПО clickhouse на сервере clickhouse-01.

```handlers: - name: Start clickhouse service``` - команда по перезапуску службы clickhouse

```name: Get clickhouse distrib``` - скачивание дистрибутивов с сайта https://packages.clickhouse.com/
          
```name: Install clickhouse packages``` - установка Пакетов: clickhouse-client, clickhouse-server, clickhouse-common-static

```name: Flush handlers``` - перезагрузка служб clickhouse, после установки
      
```name: Create database``` - создание базы данных Clickhouse

---

```name: Install Vector hosts: clickhouse``` - название второй части работ по скачиванию, установки и настройки ПО Vector на сервере clickhouse-01.

```handlers: name: Start Vector service``` - команда по перезапуску службы Vector

```name: Create vector directory``` - создание директории, в которую будут скачены установочные пакеты

```name: Create vector config directory``` - создание директории, в которую будет перемещён файл с настройками работы Vector [jinja2.yml](playbook%2Fgroup_vars%2Ftemplate%2Fjinja2.yml)

В нём описаны 2 действия:

- в блоке sources - каике логи и откуда собирать
- в блоке sinks - в какую таблицу Clickhouse их складывать

```name: Get Vector distrib``` - скачивание архива с дистрибутивом ПО Vector

```name: Unzip Vector archive``` - распаковка скаченного файла

```name: Install Vector binary``` - копирует исполняемый файл Vector

```name: Check Vector installation``` - проверка бинарного файла на корректность работы

```name: Configure vector``` - копирование нужного файла с настройками конфигурации

```name: Flush handlers``` - перезагрузка служб Vector


## Добавлены 2 тега, для каждого ПО:

tags: clickhouse
tags: Vector