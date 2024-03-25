# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Подготовка к выполнению

1. Получить бесплатную версию Jira - https://www.atlassian.com/ru/software/jira/work-management/free (скопируйте ссылку в адресную строку). Вы можете воспользоваться любым(в том числе бесплатным vpn сервисом) если сайт у вас недоступен. Кроме того вы можете скачать [docker образ](https://hub.docker.com/r/atlassian/jira-software/#) и запустить на своем хосте self-managed версию jira.
2. Настроить её для своей команды разработки.
3. Создать доски Kanban и Scrum.

![6.1.3.1.png](picture%2F6.1.3.1.png)

![6.1.3.2.png](picture%2F6.1.3.2.png)

4. [Дополнительные инструкции от разработчика Jira](https://support.atlassian.com/jira-cloud-administration/docs/import-and-export-issue-workflows/).

## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

![6.1.0.1.png](picture%2F6.1.0.1.png)

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

![6.1.0.2.png](picture%2F6.1.0.2.png)

![6.1.0.3.png](picture%2F6.1.0.3.png)

**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done. 

```commandline

Evgenyi закрыл(а) PROEK-4 - найти ошибку в html коде 2
Ошибка5 minutes ago
Evgenyi изменил(а) статус на Готово в PROEK-4 - найти ошибку в html коде 2
Ошибка5 minutes ago
Evgenyi изменил(а) статус на On test. в PROEK-4 - найти ошибку в html коде 2
Ошибка5 minutes ago
Evgenyi изменил(а) статус на Done fix в PROEK-4 - найти ошибку в html коде 2
Ошибка5 minutes ago
Evgenyi изменил(а) статус на On fix в PROEK-4 - найти ошибку в html коде 2
Ошибка5 minutes ago
Evgenyi изменил(а) статус на Done develop в PROEK-4 - найти ошибку в html коде 2
Ошибка5 minutes ago
Evgenyi изменил(а) статус на On develop в PROEK-4 - найти ошибку в html коде 2
Ошибка5 minutes ago
Evgenyi обновил(а) Rank из PROEK-4 - найти ошибку в html коде 2
Ошибка7 minutes ago
Evgenyi обновил(а) Sprint из PROEK-4 - найти ошибку в html коде 2
Ошибка7 minutes ago
Evgenyi открыл(а) PROEK-4 - найти ошибку в html коде 2
Ошибка11 minutes ago
Evgenyi изменил(а) статус на Готово в PROEK-4 - найти ошибку в html коде 2
Ошибка13 minutes ago
Evgenyi изменил(а) статус на On test. в PROEK-4 - найти ошибку в html коде 2
Ошибка13 minutes ago
Evgenyi изменил(а) статус на Done fix в PROEK-4 - найти ошибку в html коде 2
Ошибка13 minutes ago
Evgenyi изменил(а) статус на On fix в PROEK-4 - найти ошибку в html коде 2
Ошибка13 minutes ago
Evgenyi изменил(а) статус на Done develop в PROEK-4 - найти ошибку в html коде 2
Ошибка13 minutes ago
Evgenyi изменил(а) статус на On develop в PROEK-4 - найти ошибку в html коде 2
Ошибка13 minutes ago
Evgenyi создал(а) PROEK-4 - найти ошибку в html коде 2
Ошибка13 minutes ago
```
![6.1.1.png](picture%2F6.1.1.png)

2. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 


```commandline
Evgenyi закрыл(а) PROEK-3 - zadacha k Epik123
Задача9 minutes ago
Evgenyi изменил(а) статус на Готово в PROEK-3 - zadacha k Epik123
Задача9 minutes ago
Evgenyi изменил(а) статус на On test в PROEK-3 - zadacha k Epik123
Задача9 minutes ago
Evgenyi изменил(а) статус на Done develop в PROEK-3 - zadacha k Epik123
Задача9 minutes ago
Evgenyi изменил(а) статус на On develop в PROEK-3 - zadacha k Epik123
Задача9 minutes ago
Evgenyi обновил(а) Sprint из PROEK-3 - zadacha k Epik123
Задача10 minutes ago
Evgenyi открыл(а) PROEK-3 - zadacha k Epik123
Задача15 minutes ago
Evgenyi изменил(а) статус на Готово в PROEK-3 - zadacha k Epik123
Задача18 minutes ago
Evgenyi изменил(а) статус на On test в PROEK-3 - zadacha k Epik123
Задача18 minutes ago
Evgenyi изменил(а) статус на Done develop в PROEK-3 - zadacha k Epik123
Задача18 minutes ago
Evgenyi изменил(а) статус на On develop в PROEK-3 - zadacha k Epik123
Задача18 minutes ago
Пользователь Evgenyi изменил Связать на «This issue blocks PROEK-2» в PROEK-3 - zadacha k Epik123
Задача19 minutes ago
Evgenyi создал(а) PROEK-3 - zadacha k Epik123
Задача
```
![6.1.2.png](picture%2F6.1.2.png)

3. При проведении обеих задач по статусам используйте kanban. 
4. Верните задачи в статус Open.
5. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.

![6.1.5.png](picture%2F6.1.5.png)

6. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.

[bug (1).xml](picture%2Fbug%20%281%29.xml)

[proekt1 Workflow.xml](picture%2Fproekt1%20Workflow.xml)


