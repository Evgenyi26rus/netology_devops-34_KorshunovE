# Домашнее задание к занятию 4 «Работа с roles»

## Подготовка к выполнению

1. * Необязательно. Познакомьтесь с [LightHouse](https://youtu.be/ymlrNlaHzIY?t=929).
2. Создайте два пустых публичных репозитория в любом своём проекте: vector-role и lighthouse-role.
3. Добавьте публичную часть своего ключа к своему профилю на GitHub.

## Основная часть

Ваша цель — разбить ваш playbook на отдельные roles. 

Задача — сделать roles для ClickHouse, Vector и LightHouse и написать playbook для использования этих ролей. 

Ожидаемый результат — существуют три ваших репозитория: два с roles и один с playbook.

**Что нужно сделать**

1. Создайте в старой версии playbook файл `requirements.yml` и заполните его содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.13"
       name: clickhouse 
   ```
[requirements.yml](playbook%2Frequirements.yml)

2. При помощи `ansible-galaxy` скачайте себе эту роль.
3. Создайте новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.

[clickhouse](playbook%2Froles%2Fclickhouse)

4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. 

#### tasks
Clickhouse: [main.yml](playbook%2Froles%2Fclickhouse%2Ftasks%2Fmain.yml)

LightHouse: https://github.com/Evgenyi26rus/LightHouse/blob/master/tasks/main.yml

Vector: https://github.com/Evgenyi26rus/vector-role/blob/master/tasks/main.yml

#### переменные
Clickhouse:

[main.yml](playbook%2Froles%2Fclickhouse%2Fdefaults%2Fmain.yml)

[main.yml](playbook%2Froles%2Fclickhouse%2Fvars%2Fmain.yml)

LightHouse: 

https://github.com/Evgenyi26rus/LightHouse/blob/master/vars/main.yml

Vector: 

https://github.com/Evgenyi26rus/vector-role/blob/master/defaults/main.yml
https://github.com/Evgenyi26rus/vector-role/blob/master/vars/main.yml

5. Перенести нужные шаблоны конфигов в `templates`.

LightHouse: 

https://github.com/Evgenyi26rus/LightHouse/blob/master/templates/lighthouse.yml.j2

https://github.com/Evgenyi26rus/LightHouse/blob/master/templates/nginx.yml.j2

Vector: 

https://github.com/Evgenyi26rus/vector-role/blob/master/templates/vector.yml.j2


6. Опишите в `README.md` обе роли и их параметры. Пример качественной документации ansible role [по ссылке](https://github.com/cloudalchemy/ansible-prometheus).

Clickhouse: [README.md](playbook%2Froles%2Fclickhouse%2FREADME.md)

LightHouse: https://github.com/Evgenyi26rus/LightHouse/blob/master/README.md

Vector: https://github.com/Evgenyi26rus/vector-role/blob/master/README.md

7. Повторите шаги 3–6 для LightHouse. Помните, что одна роль должна настраивать один продукт.
8. Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в `requirements.yml` в playbook.

LightHouse: https://github.com/Evgenyi26rus/LightHouse

Vector: https://github.com/Evgenyi26rus/vector-role

9. Переработайте playbook на использование roles. Не забудьте про зависимости LightHouse и возможности совмещения `roles` с `tasks`.

[site.yml](playbook%2Fsite.yml)

10. Выложите playbook в репозиторий.
11. В ответе дайте ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
