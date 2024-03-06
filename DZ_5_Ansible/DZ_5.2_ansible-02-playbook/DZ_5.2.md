# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

![5.2.0.4.png](picture%2F5.2.0.4.png)

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.

[prod.yml](playbook%2Finventory%2Fprod.yml)

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install). не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!

[jinja2.yml](playbook%2Fgroup_vars%2Ftemplate%2Fjinja2.yml)

3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.

[site.yml](playbook%2Fsite.yml)

4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.

```
   tasks:
    - block:
      - name: Create vector directory
        ansible.builtin.file:
          path: "{{ vector_workdir }}"
          state: directory
      - name: Create vector config directory
        ansible.builtin.file:
            path: "{{ vector_config }}"
            state: directory
      - name: Get Vector distrib
        ansible.builtin.get_url:
          url: "https://packages.timber.io/vector/0.30.0/vector-0.30.0-x86_64-unknown-linux-gnu.tar.gz"
          dest: "{{ vector_workdir }}/vector-0.30.0-x86_64-unknown-linux-gnu.tar.gz"
      - name: Unzip Vector archive
        ansible.builtin.unarchive:
          remote_src: true
          src: "{{ vector_workdir }}/vector-0.30.0-x86_64-unknown-linux-gnu.tar.gz"
          dest: "{{ vector_workdir }}"
      - name: Install Vector binary
        become: true
        ansible.builtin.copy:
          remote_src: true
          src: "{{ vector_workdir }}/vector-x86_64-unknown-linux-gnu/bin/vector"
          dest: "/usr/bin/"
          mode: 0777
          owner: root
          group: root
      - name: Check Vector installation
        ansible.builtin.command: "vector --version"
        register: var_vector
        failed_when: var_vector.rc != 0
        changed_when: var_vector.rc == 0
      - name: Configure vector
        ansible.builtin.template:
          src: "./group_vars/template/jinja2.yml"
          dest: "{{ vector_config }}/jinja2.yml"
          mode: 0777       
```

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

![5.2.5.png](picture%2F5.2.5.png)

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
Решение этой ошибки так и не нашёл. Но далее в процессе она ни на что не повлияла.

Помимо неё в процессе было выявлено множество ошибок, в течении некоторого времени, решение нашлось.

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.

![5.2.6.png](picture%2F5.2.6.png)

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

![5.2.7.1.png](picture%2F5.2.7.1.png)

![5.2.7.2.png](picture%2F5.2.7.2.png)

![5.2.7.3.png](picture%2F5.2.7.3.png)

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

```
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_5_Ansible/DZ_5.2_ansible-02-playbook/playbook$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] *************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *********************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "centos", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "centos", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ****************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] *****************************************************************************************************************************************************************************************************

TASK [Create database] ****************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *****************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create vector directory] ********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create vector config directory] *************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get Vector distrib] *************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Unzip Vector archive] ***********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install Vector binary] **********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Check Vector installation] ******************************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Configure vector] ***************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] *****************************************************************************************************************************************************************************************************

PLAY RECAP ****************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=12   changed=1    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0 
```

9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook). Так же приложите скриншоты выполнения заданий №5-8

[Документация ansible playbook.md](%D0%94%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20ansible%20playbook.md)

10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

