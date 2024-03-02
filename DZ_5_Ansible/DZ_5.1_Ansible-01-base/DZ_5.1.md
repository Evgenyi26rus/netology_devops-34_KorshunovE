# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.

![5.1.0.1.png](picture%2F5.1.0.1.png)

2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.

![5.1.1.png](picture%2F5.1.1.png)

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.

[examp.yml](playbook%2Fgroup_vars%2Fall%2Fexamp.yml)

![5.1.2.png](picture%2F5.1.2.png)

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

```
docker run -dit --rm --name ubuntu pycontribs/ubuntu:latest
docker run -dit --rm --name centos7 centos:latest
```
![5.1.3.png](picture%2F5.1.3.png)

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

![5.1.4.png](picture%2F5.1.4.png)

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.

Deb: 
[examp.yml](playbook%2Fgroup_vars%2Fdeb%2Fexamp.yml)

El:
[examp.yml](playbook%2Fgroup_vars%2Fel%2Fexamp.yml)

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

![5.1.6.png](picture%2F5.1.6.png)

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

![5.1.7.png](picture%2F5.1.7.png)

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

![5.1.8.png](picture%2F5.1.8.png)

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

![5.1.9.png](picture%2F5.1.9.png)

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

[prod.yml](playbook%2Finventory%2Fprod.yml)

![5.1.10.png](picture%2F5.1.10.png)

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

![5.1.11.png](picture%2F5.1.11.png)

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.
