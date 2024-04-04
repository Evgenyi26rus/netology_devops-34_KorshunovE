Основное описание работ ДЗ:

[DZ_6.4.md](DZ_6.4.md)

При обновлении до версии 3.9, не получается тест с молекулой:

![6.4.dorabotka1.png](picture%2F6.4.dorabotka1.png)

При запуске в jenkins:

~~~
Started by user admin
Running as SYSTEM
Building remotely on agent (linux) in workspace /opt/jenkins_agent/workspace/Freestyle
The recommended git tool is: NONE
using credential 40eecbb7-8e90-4fd1-a85f-1b34b695973a
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Freestyle/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/Evgenyi26rus/vector-role.git # timeout=10
Fetching upstream changes from https://github.com/Evgenyi26rus/vector-role.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/Freestyle@tmp/jenkins-gitclient-ssh8182316781829967667.key
Verifying host key using known hosts file
You're using 'Known hosts file' strategy to verify ssh host keys, but your known_hosts file does not exist, please go to 'Manage Jenkins' -> 'Security' -> 'Git Host Key Verification Configuration' and configure host key verification.
 > git fetch --tags --progress https://github.com/Evgenyi26rus/vector-role.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
Checking out Revision d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 # timeout=10
Commit message: "Create Jenkinsfile"
 > git rev-list --no-walk d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 # timeout=10
[Freestyle] $ /bin/sh -xe /tmp/jenkins15617358423531824949.sh
+ molecule test
/tmp/jenkins15617358423531824949.sh: /home/jenkins/.local/bin/molecule: /usr/bin/python3: bad interpreter: No such file or directory
Build step 'Execute shell' marked build as failure
Finished: FAILURE
~~~

В разделе Вопросы и ответы, пишут про отсутствие в роли директории molecule, тестировал на другой роли с  директорией molecule - ошибка та же.