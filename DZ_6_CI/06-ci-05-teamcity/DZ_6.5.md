# Домашнее задание к занятию 11 «Teamcity»

## Подготовка к выполнению

1. В Yandex Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`.
2. Дождитесь запуска teamcity, выполните первоначальную настройку.
3. Создайте ещё один инстанс (2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`.
4. Авторизуйте агент.
5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity).

https://github.com/Evgenyi26rus/example-teamcity

6. Создайте VM (2CPU4RAM) и запустите [playbook](infrastructure).

![6.5.0.1.png](picture%2F6.5.0.1.png)

## Основная часть

![6.5.1.0.png](picture%2F6.5.1.0.png)

1. Создайте новый проект в teamcity на основе fork.

![6.5.1.png](picture%2F6.5.1.png)

2. Сделайте autodetect конфигурации.
3. Сохраните необходимые шаги, запустите первую сборку master.

![6.5.3.1.png](picture%2F6.5.3.1.png)

![6.5.3.2.png](picture%2F6.5.3.2.png)

4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.

![6.5.4.png](picture%2F6.5.4.png)

5. Для deploy будет необходимо загрузить [settings.xml](teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.
6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.

https://github.com/Evgenyi26rus/example-teamcity/blob/master/pom.xml

7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.

![6.5.7.png](picture%2F6.5.7.png)

8. Мигрируйте `build configuration` в репозиторий.

https://github.com/Evgenyi26rus/example-teamcity/tree/master/.teamcity/Netology

![6.5.8.png](picture%2F6.5.8.png)

9. Создайте отдельную ветку `feature/add_reply` в репозитории.
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.

https://github.com/Evgenyi26rus/example-teamcity/blob/master/src/main/java/plaindoll/Welcomer.java

11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.

https://github.com/Evgenyi26rus/example-teamcity/blob/master/src/test/java/plaindoll/WelcomerTest.java

12. Сделайте push всех изменений в новую ветку репозитория.
13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.

Тесты прошли не успешно, из-за ошибок в в задании 10-11 и ошибок в версии сохранений для Нексуса. После того как поправил ошибки, всё в итоге выполнилось. На тот момент картина была следующей:

![6.5.13.png](picture%2F6.5.13.png)

14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.

![6.5.15.png](picture%2F6.5.15.png)

16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.

По умолчанию в настройках уже стоял `.jar`.

17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.

![6.5.17.1.png](picture%2F6.5.17.1.png)

![6.5.17.2.png](picture%2F6.5.17.2.png)

![6.5.17.3.png](picture%2F6.5.17.3.png)

18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
19. В ответе пришлите ссылку на репозиторий.

https://github.com/Evgenyi26rus/example-teamcity

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
