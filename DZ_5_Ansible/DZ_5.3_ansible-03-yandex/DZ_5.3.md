# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.

![5.3.0.png](picture%2F5.3.0.png)

2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.

[site.yml](playbook%2Fsite.yml)

[vars.yml](playbook%2Fgroup_vars%2Flighthouse%2Fvars.yml)

[lighthouse.yml.j2](playbook%2Ftemplate%2Flighthouse.yml.j2)

2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.

[site.yml](playbook%2Fsite.yml)

[vars.yml](playbook%2Fgroup_vars%2Flighthouse%2Fvars.yml)

[nginx.yml.j2](playbook%2Ftemplate%2Fnginx.yml.j2)

4. Подготовьте свой inventory-файл `prod.yml`.

[prod.yml](playbook%2Finventory%2Fprod.yml)

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

[Документация ansible playbook.md](%D0%94%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F%20ansible%20playbook.md)

10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

![5.3.png](picture%2F5.3.png)

```commandline
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_5_Ansible/DZ_5.3_ansible-03-yandex/playbook$ ansible-lint site.yml
Couldn't parse task at site.yml:32 (this task 'ansible.builtin.command' has extra params, which is only allowed in the following modules: group_by, raw, add_host, include, set_fact, import_role, command, win_command, meta, import_tasks, win_shell, include_tasks, include_vars, script, shell, include_role

The error appears to be in '<unicode string>': line 32, column 7, but may
be elsewhere in the file depending on the exact syntax problem.

(could not open file to display line))
{ 'ansible.builtin.command': "clickhouse-client -q 'create database logs;'",
  'changed_when': 'create_db.rc == 0',
  'failed_when': 'create_db.rc != 0 and create_db.rc !=82',
  'ignore_errors': True,
  'name': 'Create database',
  'register': 'create_db',
  'skipped_rules': []}
korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_5_Ansible/DZ_5.3_ansible-03-yandex/playbook$ ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: Found both group and host with same name: vector
[WARNING]: Found both group and host with same name: lighthouse
[WARNING]: Found both group and host with same name: clickhouse

PLAY [Install Clickhouse] *************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************************************************************
ok: [clickhouse]

TASK [Get clickhouse distrib] *********************************************************************************************************************************************************************************************
changed: [clickhouse] => (item=clickhouse-client)
changed: [clickhouse] => (item=clickhouse-server)
failed: [clickhouse] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *********************************************************************************************************************************************************************************************
changed: [clickhouse]

TASK [Install clickhouse packages] ****************************************************************************************************************************************************************************************
fatal: [clickhouse]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system"]}

PLAY RECAP ****************************************************************************************************************************************************************************************************************
clickhouse                 : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0   

korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_5_Ansible/DZ_5.3_ansible-03-yandex/playbook$ ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: clickhouse
[WARNING]: Found both group and host with same name: vector
[WARNING]: Found both group and host with same name: lighthouse

PLAY [Install Clickhouse] *************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************************************************************
ok: [clickhouse]

TASK [Get clickhouse distrib] *********************************************************************************************************************************************************************************************
changed: [clickhouse] => (item=clickhouse-client)
changed: [clickhouse] => (item=clickhouse-server)
failed: [clickhouse] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *********************************************************************************************************************************************************************************************
changed: [clickhouse]

TASK [Install clickhouse packages] ****************************************************************************************************************************************************************************************
changed: [clickhouse]

TASK [Flush handlers] *****************************************************************************************************************************************************************************************************

RUNNING HANDLER [Start clickhouse service] ********************************************************************************************************************************************************************************
changed: [clickhouse]

TASK [Create database] ****************************************************************************************************************************************************************************************************
fatal: [clickhouse]: FAILED! => {"changed": false, "cmd": ["clickhouse-client", "-q", "create database logs;"], "delta": "0:00:00.055480", "end": "2024-03-16 17:49:51.797639", "failed_when_result": true, "msg": "non-zero return code", "rc": 210, "start": "2024-03-16 17:49:51.742159", "stderr": "Code: 210. DB::NetException: Connection refused (localhost:9000). (NETWORK_ERROR)", "stderr_lines": ["Code: 210. DB::NetException: Connection refused (localhost:9000). (NETWORK_ERROR)"], "stdout": "", "stdout_lines": []}
...ignoring

PLAY [Install Vector] *****************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************************************************************
ok: [vector]

TASK [Create vector directory] ********************************************************************************************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/home/centos/vector",
-    "state": "absent"
+    "state": "directory"
 }

changed: [vector]

TASK [Create vector config directory] *************************************************************************************************************************************************************************************
ok: [vector]

TASK [Get Vector distrib] *************************************************************************************************************************************************************************************************
changed: [vector]

TASK [Unzip Vector archive] ***********************************************************************************************************************************************************************************************
changed: [vector]

TASK [Install Vector binary] **********************************************************************************************************************************************************************************************
changed: [vector]

TASK [Check Vector installation] ******************************************************************************************************************************************************************************************
changed: [vector]

TASK [Configure vector] ***************************************************************************************************************************************************************************************************
--- before
+++ after: /home/korshunovi/.ansible/tmp/ansible-local-192633x1wu4466/tmpo2yb_mlj/vector.yml.j2
@@ -0,0 +1,17 @@
+---
+vector_config:
+  sources:
+    sample_file:
+      type: file
+      read_from: beginning
+      ignore_older_secs: 600
+      include:
+        - /var/log/**/*.log
+
+  sinks:
+    to_clickhouse:
+      type: clickhouse
+      inputs:
+        - my-source-or-transform-id
+      endpoint: http://localhost:8123
+      table: mytable
\ No newline at end of file

changed: [vector]

TASK [Flush handlers] *****************************************************************************************************************************************************************************************************

PLAY [Install nginx] ******************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [NGINX | Install epel-release] ***************************************************************************************************************************************************************************************
changed: [lighthouse]

TASK [Nginx | Install Nginx] **********************************************************************************************************************************************************************************************
changed: [lighthouse]

TASK [Nginx | Create config] **********************************************************************************************************************************************************************************************
--- before: /etc/nginx/nginx.conf
+++ after: /home/korshunovi/.ansible/tmp/ansible-local-192633x1wu4466/tmp8pn8gcy8/nginx.yml.j2
@@ -1,9 +1,5 @@
-# For more information on configuration, see:
-#   * Official English Documentation: http://nginx.org/en/docs/
-#   * Official Russian Documentation: http://nginx.org/ru/docs/
-
-user nginx;
-worker_processes auto;
+user root;
+worker_processes 1;
 error_log /var/log/nginx/error.log;
 pid /run/nginx.pid;
 
@@ -52,33 +48,4 @@
         location = /50x.html {
         }
     }
-
-# Settings for a TLS enabled server.
-#
-#    server {
-#        listen       443 ssl http2;
-#        listen       [::]:443 ssl http2;
-#        server_name  _;
-#        root         /usr/share/nginx/html;
-#
-#        ssl_certificate "/etc/pki/nginx/server.crt";
-#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
-#        ssl_session_cache shared:SSL:1m;
-#        ssl_session_timeout  10m;
-#        ssl_ciphers HIGH:!aNULL:!MD5;
-#        ssl_prefer_server_ciphers on;
-#
-#        # Load configuration files for the default server block.
-#        include /etc/nginx/default.d/*.conf;
-#
-#        error_page 404 /404.html;
-#            location = /40x.html {
-#        }
-#
-#        error_page 500 502 503 504 /50x.html;
-#            location = /50x.html {
-#        }
-#    }
-
-}
-
+}
\ No newline at end of file

changed: [lighthouse]

RUNNING HANDLER [start-nginx] *********************************************************************************************************************************************************************************************
changed: [lighthouse]

PLAY [Install lighthouse] *************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Lighthouse | Install Dependencies] **********************************************************************************************************************************************************************************
changed: [lighthouse]

TASK [Create Lighthouse directory] ****************************************************************************************************************************************************************************************
--- before
+++ after
@@ -1,6 +1,6 @@
 {
-    "group": 0,
-    "owner": 0,
+    "group": 994,
+    "owner": 997,
     "path": "/var/www/lighthouse",
-    "state": "absent"
+    "state": "directory"
 }

changed: [lighthouse]

TASK [Lighthouse | Clone from Git] ****************************************************************************************************************************************************************************************
>> Newly checked out d701335c25cd1bb9b5155711190bad8ab852c2ce
changed: [lighthouse]

TASK [Lighthouse | Create lighthouse config] ******************************************************************************************************************************************************************************
--- before
+++ after: /home/korshunovi/.ansible/tmp/ansible-local-192633x1wu4466/tmppbwz9bj3/lighthouse.yml.j2
@@ -0,0 +1,11 @@
+server {
+  listen        80;
+  server_name   localhost;
+
+  access_log    /var/log/nginx/lighthouse.log main;
+
+  location / {
+    root  /var/www/lighthouse;
+    index index.html;
+  }
+}
\ No newline at end of file

changed: [lighthouse]

RUNNING HANDLER [reload-nginx] ********************************************************************************************************************************************************************************************
changed: [lighthouse]

PLAY RECAP ****************************************************************************************************************************************************************************************************************
clickhouse                 : ok=5    changed=3    unreachable=0    failed=0    skipped=0    rescued=1    ignored=1   
lighthouse                 : ok=11   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector                     : ok=8    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
