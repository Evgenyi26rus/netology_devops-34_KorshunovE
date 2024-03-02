# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

![5.2.0.4.png](playbook%2Fpicture%2F5.2.0.4.png)

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.

[prod.yml](playbook%2Finventory%2Fprod.yml)

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install). не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!

[jinja2.yml](playbook%2Fgroup_vars%2Ftemplate%2Fjinja2.yml)

3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.

[site.yml](playbook%2Fsite.yml)

4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.

```
        - name: Get Vector distrib
          ansible.builtin.get_url:
            url: "https://packages.timber.io/vector/0.30.0/vector-0.30.0-1.{{ vector_arch }}-unknown-linux-gnu.tar.gz"
            dest: "./vector-0.30.0-1.{{ vector_arch }}-unknown-linux-gnu.tar.gz"
            mode: "0755"
        - name: Create Vector directory
          become: true
          ansible.builtin.file:
            path: /etc/vector
        - name: Unarchive Vector package
          become: true
          ansible.builtin.unarchive:
            src: /tmp/vector-0.30.0-1.{{ vector_arch }}-unknown-linux-gnu.tar.gz
            dest: /etc/vector
            remote_src: true
        - name: Configure vector
          ansible.builtin.template:
            src: "./template/jinja2.yml"
            dest: "/etc/vector/vector.toml"
            mode: "0755"
```

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

![5.2.5.png](playbook%2Fpicture%2F5.2.5.png)

```
Couldn't parse task at site.yml:33 (this task 'ansible.builtin.command' has extra params, which is only allowed in the following modules: import_role, win_command, meta, add_host, script, raw, include_role, import_tasks, group_by, set_fact, include_vars, include_tasks, command, shell, include, win_shell

The error appears to be in '<unicode string>': line 33, column 7, but may
be elsewhere in the file depending on the exact syntax problem.

(could not open file to display line))
{ 'ansible.builtin.command': "clickhouse-client -q 'create database logs;'",
  'changed_when': 'create_db.rc == 0',
  'failed_when': 'create_db.rc != 0 and create_db.rc !=82',
  'name': 'Create database',
  'register': 'create_db',
  'skipped_rules': []}

```

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook). Так же приложите скриншоты выполнения заданий №5-8
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
