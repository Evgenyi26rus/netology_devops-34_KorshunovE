Основной файл с ДЗ https://github.com/Evgenyi26rus/netology_devops-34_KorshunovE/blob/main/DZ_7_Monitoring/10-monitoring-04-elk/7.3.md

Спасибо за работу, попробуйте добавить в es-hot и es-warm порты 9300:9300 и где нет 9200:9200, в ошибке 9300 используется

----------------------------

[docker-compose.yml](help%2Fdocker-compose.yml)

После того как прописал порты 9200 и 9300 для es-hot и es-warm получаю ошибку:

![7.3.3.2.png](picture%2F7.3.3.2.png)

Закомментировал этот порт, следующий запуск даёт ту же ошибку со вторым портом. Закомментировал второй порт, контейнеры поднялись, но ошибка в браузере та же: Kibana server is not ready yet.

![7.3.3.1.png](picture%2F7.3.3.1.png)

Самое что странное, ошибки в логах после добавления порта 9300, осталась та же:

```
"@timestamp":"2024-05-17T16:48:46.711Z", "log.level": "WARN", "message":"address [172.24.0.2:9300], node [null], requesting [false] discovery result: [][172.24.0.2:9300] connect_timeout[30s]", "ecs.version": "1.2.0","service.name":"ES_ECS","event.dataset":"elasticsearch.server","process.thread.name":"elasticsearch[es-hot][generic][T#3]","log.logger":"org.elasticsearch.discovery.PeerFinder","elasticsearch.node.name":"es-hot","elasticsearch.cluster.name":"es-docker-cluster"}
{"@timestamp":"2024-05-17T16:48:55.505Z", "log.level": "WARN", "message":"master not discovered yet, this node has not previously joined a bootstrapped cluster, and this node must discover master-eligible nodes [es-hot, es-warm] to bootstrap a cluster: have discovered [{es-hot}{yYAqJJ2iR_KGmKZNELw1CQ}{o3Wfb9qVT5aL-h5zeCHe5A}{es-hot}{172.24.0.3}{172.24.0.3:9300}{hms}{8.7.0}]; discovery will continue using [172.24.0.2:9300] from hosts providers and [{es-hot}{yYAqJJ2iR_KGmKZNELw1CQ}{o3Wfb9qVT5aL-h5zeCHe5A}{es-hot}{172.24.0.3}{172.24.0.3:9300}{hms}{8.7.0}] from last-known cluster state; node term 0, last-accepted version 0 in term 0; for troubleshooting guidance, see https://www.elastic.co/guide/en/elasticsearch/reference/8.7/discovery-troubleshooting.html", "ecs.version": "1.2.0","service.name":"ES_ECS","event.dataset":"elasticsearch.server","process.thread.name":"elasticsearch[es-hot][cluster_coordination][T#1]","log.logger":"org.elasticsearch.cluster.coordination.ClusterFormationFailureHelper","elasticsearch.node.name":"es-hot","elasticsearch.cluster.name":"es-docker-cluster"}

```

```
{"@timestamp":"2024-05-17T16:48:46.697Z", "log.level": "WARN", "message":"address [172.24.0.3:9300], node [null], requesting [false] discovery result: [][172.24.0.3:9300] connect_timeout[30s]", "ecs.version": "1.2.0","service.name":"ES_ECS","event.dataset":"elasticsearch.server","process.thread.name":"elasticsearch[es-warm][generic][T#2]","log.logger":"org.elasticsearch.discovery.PeerFinder","elasticsearch.node.name":"es-warm","elasticsearch.cluster.name":"es-docker-cluster"}
{"@timestamp":"2024-05-17T16:48:55.524Z", "log.level": "WARN", "message":"master not discovered yet, this node has not previously joined a bootstrapped cluster, and this node must discover master-eligible nodes [es-hot, es-warm] to bootstrap a cluster: have discovered [{es-warm}{gCrPsTw7Shq1D6ZXxiQXrg}{5Yvv6V47QKK2AJ-th0T-TA}{es-warm}{172.24.0.2}{172.24.0.2:9300}{mw}{8.7.0}]; discovery will continue using [172.24.0.3:9300] from hosts providers and [{es-warm}{gCrPsTw7Shq1D6ZXxiQXrg}{5Yvv6V47QKK2AJ-th0T-TA}{es-warm}{172.24.0.2}{172.24.0.2:9300}{mw}{8.7.0}] from last-known cluster state; node term 0, last-accepted version 0 in term 0; for troubleshooting guidance, see https://www.elastic.co/guide/en/elasticsearch/reference/8.7/discovery-troubleshooting.html", "ecs.version": "1.2.0","service.name":"ES_ECS","event.dataset":"elasticsearch.server","process.thread.name":"elasticsearch[es-warm][cluster_coordination][T#1]","log.logger":"org.elasticsearch.cluster.coordination.ClusterFormationFailureHelper","elasticsearch.node.name":"es-warm","elasticsearch.cluster.name":"es-docker-cluster"}

```

Более детальные логи: 

es-hot > [1.txt](help%2F1.txt)

es-warm > [2.txt](help%2F2.txt)

filebeat > [3.txt](help%2F3.txt)

kibana > [4.txt](help%2F4.txt)

logstash > [5.txt](help%2F5.txt)