# Домашнее задание к занятию 4. «Оркестрация группой Docker-контейнеров на примере Docker Compose»



## Задача 1


Создайте собственный образ любой операционной системы (например, debian-11) с помощью Packer версии 1.7.0 . Перед выполнением задания изучите ([инструкцию!!!](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart)). В инструкции указана минимальная версия 1.5, но нужно использовать 1.7, так как там есть нужный нам функционал

![3.4.1(1).png](3.4.1%281%29.png)

![3.4.1 (2).png](3.4.1%20%282%29.png)

## Задача 2

**2.1.** Создайте вашу первую виртуальную машину в YandexCloud с помощью web-интерфейса YandexCloud.        

![3.4.2(1).png](3.4.2%281%29.png)
![3.4.2(2).png](3.4.2%282%29.png)

**2.2.*** **(Необязательное задание)**      
Создайте вашу первую виртуальную машину в YandexCloud с помощью Terraform (вместо использования веб-интерфейса YandexCloud).
Используйте Terraform-код в директории ([src/terraform](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/terraform)).


**Так и не получилось выполнить это подзадание**, всё время получал ошибку с id диском, диски создавал разные, ошибка не уходила. Детальнее ниже:

![3.4.2(4 ошибка).png](3.4.2%284%20%D0%BE%D1%88%D0%B8%D0%B1%D0%BA%D0%B0%29.png)

## Задача 3

С помощью Ansible и Docker Compose разверните на виртуальной машине из предыдущего задания систему мониторинга на основе Prometheus/Grafana.
Используйте Ansible-код в директории ([src/ansible](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/ansible)).

Чтобы получить зачёт, вам нужно предоставить вывод команды "docker ps" , все контейнеры, описанные в [docker-compose](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/docker-compose.yaml),  должны быть в статусе "Up".

![3.4.3.png](3.4.3.png)

## Задача 4

1. Откройте веб-браузер, зайдите на страницу http://<внешний_ip_адрес_вашей_ВМ>:3000.
2. Используйте для авторизации логин и пароль из [.env-file](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/.env).
3. Изучите доступный интерфейс, найдите в интерфейсе автоматически созданные docker-compose-панели с графиками([dashboards](https://grafana.com/docs/grafana/latest/dashboards/use-dashboards/)).
4. Подождите 5-10 минут, чтобы система мониторинга успела накопить данные.

Столкнулся с ошибкой (Status: 500. Message: parse "": empty url). Смена версии графаны не помогла, контейнеры работают более 30 минут, перезагрузка ноды, перезаливка Ansible-код не помогла, везде отображается эта ошибка:

![3.4.4.png](3.4.4.png)