Основной файл с ДЗ https://github.com/Evgenyi26rus/netology_devops-34_KorshunovE/blob/main/DZ_7_Monitoring/10-monitoring-04-elk/7.3.md

Спасибо за работу, попробуйте добавить в es-hot и es-warm порты 9300:9300 и где нет 9200:9200, в ошибке 9300 используется

----------------------------

Посмотрите пример от эластика, github.com...ompose.yml

У вас es-hot стоит первым в списке мастеров, но deends_on es:warm (github.com...se.yml#L37)

Но это было изначально в предложенном файле, потому вряд ли поможет. Давайте накинем памяти 1гб (www.elastic.co...mpose-file это доки от эластика)

----------------------------

Кибана не может подключиться к эластику - illegal_argument_exception: node [es-hot] does not have the remote cluster client role enabled. Попробуйте добавить ноде роль в node.roles remote_cluster_client - это в docker-compose (discuss.elastic.co...ole/266294)

----------------------------

Вроде что-то получилось:

![7.3.2.5.png](picture%2F7.3.2.5.png)

![7.2.3.6.png](picture%2F7.2.3.6.png)

![7.2.3.7.png](picture%2F7.2.3.7.png)

Более детальные логи: 

es-hot > [1.txt](help%2F1.txt)

es-warm > [2.txt](help%2F2.txt)

filebeat > [3.txt](help%2F3.txt)

kibana > [4.txt](help%2F4.txt)

logstash > [5.txt](help%2F5.txt)