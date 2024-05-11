7. Склонируйте себе [репозиторий](https://github.com/influxdata/sandbox/tree/master) и запустите TICK-стэк, 
используя технологии docker и docker-compose.

В виде решения на это упражнение приведите скриншот веб-интерфейса ПО chronograf (`http://localhost:8888`). 

P.S.: если при запуске некоторые контейнеры будут падать с ошибкой - проставьте им режим `Z`, например
`./data:/var/lib:Z`
#
8. Перейдите в веб-интерфейс Chronograf (http://localhost:8888) и откройте вкладку Data explorer.
        
    - Нажмите на кнопку Add a query
    - Изучите вывод интерфейса и выберите БД telegraf.autogen
    - В `measurments` выберите cpu->host->telegraf-getting-started, а в `fields` выберите usage_system. Внизу появится график утилизации cpu.
    - Вверху вы можете увидеть запрос, аналогичный SQL-синтаксису. Поэкспериментируйте с запросом, попробуйте изменить группировку и интервал наблюдений.

Для выполнения задания приведите скриншот с отображением метрик утилизации cpu из веб-интерфейса.
#
9. Изучите список [telegraf inputs](https://github.com/influxdata/telegraf/tree/master/plugins/inputs). 
Добавьте в конфигурацию telegraf следующий плагин - [docker](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker):
```
[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
```

Дополнительно вам может потребоваться донастройка контейнера telegraf в `docker-compose.yml` дополнительного volume и 
режима privileged:
```
  telegraf:
    image: telegraf:1.4.0
    privileged: true
    volumes:
      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    links:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"
```

После настройке перезапустите telegraf, обновите веб интерфейс и приведите скриншотом список `measurments` в 
веб-интерфейсе базы telegraf.autogen . Там должны появиться метрики, связанные с docker.

Факультативно можете изучить какие метрики собирает telegraf после выполнения данного задания.

-----------------------------------------------

Здравствуйте, Евгений

У вас в тексте есть кусок манифеста для телеграф

1
2
3
4
5
..
telegraf:
    ...
    privileged: true
...
А в репозитории github.com...l#L23-#L42 такой инструкции нет

-------------------- Доработка ---------------------------
https://github.com/Evgenyi26rus/netology_devops-34_KorshunovE/blob/main/DZ_7_Monitoring/10-monitoring-02-systems/DZ_7.1.md

При дополнении конфигурационного файла, ситуация осталась прежней:

[docker-compose.yml](sandbox%2Fdocker-compose.yml)

![7.1.8 dor 1.png](picture%2F7.1.8%20dor%201.png)

![7.1.8. dor 1.1.png](picture%2F7.1.8.%20dor%201.1.png)

Поправил права для unix:///var/run/docker.sock:, осталась одна ошибка, с которой не пойму куда копать, в интернете толком ответа не нашёл:

```commandline

korshunovi@korshunovi:~/PycharmProjects/netology_devops-34_KorshunovE/DZ_7_Monitoring/10-monitoring-02-systems/sandbox$ sudo docker logs sandbox_telegraf_1
2024-05-11T08:21:46Z I! Loading config: /etc/telegraf/telegraf.conf
2024-05-11T08:21:46Z W! DeprecationWarning: Option "container_names" of plugin "inputs.docker" deprecated since version 1.4.0 and will be removed in 2.0.0: use 'container_name_include' instead
2024-05-11T08:21:46Z W! DeprecationWarning: Option "perdevice" of plugin "inputs.docker" deprecated since version 1.18.0 and will be removed in 2.0.0: use 'perdevice_include' instead
2024-05-11T08:21:46Z I! Starting Telegraf 1.30.2 brought to you by InfluxData the makers of InfluxDB
2024-05-11T08:21:46Z I! Available plugins: 233 inputs, 9 aggregators, 31 processors, 24 parsers, 60 outputs, 6 secret-stores
2024-05-11T08:21:46Z I! Loaded inputs: cpu docker influxdb syslog system
2024-05-11T08:21:46Z I! Loaded aggregators: 
2024-05-11T08:21:46Z I! Loaded processors: 
2024-05-11T08:21:46Z I! Loaded secretstores: 
2024-05-11T08:21:46Z I! Loaded outputs: influxdb
2024-05-11T08:21:46Z I! Tags enabled: host=telegraf-getting-started
2024-05-11T08:21:46Z W! Deprecated inputs: 0 and 2 options
2024-05-11T08:21:46Z I! [agent] Config: Interval:5s, Quiet:false, Hostname:"telegraf-getting-started", Flush Interval:5s
2024-05-11T08:21:46Z W! [outputs.influxdb] When writing to [http://influxdb:8086]: database "telegraf" creation failed: 401 Unauthorized
2024-05-11T08:21:46Z I! [inputs.syslog] Listening on tcp://127.0.0.1:6514
2024-05-11T08:21:50Z E! [inputs.influxdb] Error in plugin: 404 Not Found
2024-05-11T08:21:51Z E! [outputs.influxdb] E! [outputs.influxdb] Failed to write metric (will be dropped: 401 Unauthorized): 
2024-05-11T08:21:55Z E! [inputs.influxdb] Error in plugin: 404 Not Found
2024-05-11T08:21:56Z E! [outputs.influxdb] E! [outputs.influxdb] Failed to write metric (will be dropped: 401 Unauthorized): 
2024-05-11T08:22:00Z E! [inputs.influxdb] Error in plugin: 404 Not Found
```

Возможно причина в сплывающей ошибке с хостом, которого нет, но не понятно почему он отсутствует, настройки все стандартные.

![7.1.9 dor 1.2.png](picture%2F7.1.9%20dor%201.2.png)