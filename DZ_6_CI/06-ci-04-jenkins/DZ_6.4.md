# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.

![6.4.0.1.png](picture%2F6.4.0.1.png)

2. Установить Jenkins при помощи playbook.

![6.4.0.2.png](picture%2F6.4.0.2.png)

3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

![6.4.0.4.png](picture%2F6.4.0.4.png)


## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

Установленное ПО:

![6.4.1.0.png](picture%2F6.4.1.0.png)

Во всех этапах задания получаю одну и ту же ошибку, которую так и не смог победить:

~~~
Started by user admin
Running as SYSTEM
Building remotely on agent (linux) in workspace /opt/jenkins_agent/workspace/Freestyle Job
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential 3ef3fd5e-3b0c-4407-858c-fc4b05ea9059
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Freestyle Job/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/Evgenyi26rus/vector-role.git # timeout=10
Fetching upstream changes from https://github.com/Evgenyi26rus/vector-role.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/Freestyle Job@tmp/jenkins-gitclient-ssh15476629155307798453.key
Verifying host key using known hosts file
You're using 'Known hosts file' strategy to verify ssh host keys, but your known_hosts file does not exist, please go to 'Manage Jenkins' -> 'Security' -> 'Git Host Key Verification Configuration' and configure host key verification.
 > git fetch --tags --progress https://github.com/Evgenyi26rus/vector-role.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision aee07494098e319e7b0d8abf1c68ed1d85e6d2fc (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f aee07494098e319e7b0d8abf1c68ed1d85e6d2fc # timeout=10
Commit message: "add jenkins file"
 > git rev-list --no-walk aee07494098e319e7b0d8abf1c68ed1d85e6d2fc # timeout=10
[Freestyle Job] $ /bin/sh -xe /tmp/jenkins1479052972023288763.sh
+ molecule test
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
/home/jenkins/.local/lib/python3.6/site-packages/requests/__init__.py:104: RequestsDependencyWarning: urllib3 (1.26.18) or chardet (5.0.0)/charset_normalizer (2.0.12) doesn't match a supported version!
  RequestsDependencyWarning)
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/jenkins/.cache/ansible-compat/f78241/modules:/home/jenkins/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/jenkins/.cache/ansible-compat/f78241/collections:/home/jenkins/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/jenkins/.cache/ansible-compat/f78241/roles:/home/jenkins/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/jenkins/.ansible/roles/evgeniy.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
/bin/sh: ansible-lint.: command not found
/bin/sh: line 1: yamllint.: command not found
WARNING  Retrying execution failure 127 of: a n s i b l e - l i n t . 
 y a m l l i n t . 

CRITICAL Lint failed with error code 127
WARNING  An error occurred during the test sequence action: 'lint'. Cleaning up.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
Build step 'Execute shell' marked build as failure
Finished: FAILURE
~~~

Использовал разные варианты команд:

![6.4.1.1.2.png](picture%2F6.4.1.1.2.png)

![6.4.1.1.3.png](picture%2F6.4.1.1.3.png)

![6.4.1.1.png](picture%2F6.4.1.1.png)

2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

![6.4.1.2.png](picture%2F6.4.1.2.png)

![6.4.1.2.1.png](picture%2F6.4.1.2.1.png)

Общая ошибка везде:

/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
/home/jenkins/.local/lib/python3.6/site-packages/requests/__init__.py:104: RequestsDependencyWarning: urllib3 (1.26.18) or chardet (5.0.0)/charset_normalizer (2.0.12) doesn't match a supported version!
  RequestsDependencyWarning)
CRITICAL 'molecule/default/molecule.yml' glob failed.  Exiting.

```commandline
Started by user admin
Obtained Jenkinsfile from git https://github.com/Evgenyi26rus/vector-role.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent in /opt/jenkins_agent/workspace/Declarative Pipeline Job
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential c8e40cf3-972a-46fb-a7df-703e41b79d24
Fetching changes from the remote Git repository
Checking out Revision d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 (refs/remotes/origin/master)
Commit message: "Create Jenkinsfile"
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Declarative Pipeline Job/.git # timeout=10
 > git config remote.origin.url https://github.com/Evgenyi26rus/vector-role.git # timeout=10
Fetching upstream changes from https://github.com/Evgenyi26rus/vector-role.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/Declarative Pipeline Job@tmp/jenkins-gitclient-ssh13298470138751284097.key
Verifying host key using known hosts file
You're using 'Known hosts file' strategy to verify ssh host keys, but your known_hosts file does not exist, please go to 'Manage Jenkins' -> 'Security' -> 'Git Host Key Verification Configuration' and configure host key verification.
 > git fetch --tags --progress https://github.com/Evgenyi26rus/vector-role.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 # timeout=10
 > git rev-list --no-walk d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (First)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
Warning: CredentialId "git_https" could not be found.
Fetching changes from the remote Git repository
Checking out Revision d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 (refs/remotes/origin/master)
Commit message: "Create Jenkinsfile"
[Pipeline] }
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Declarative Pipeline Job/.git # timeout=10
 > git config remote.origin.url https://github.com/Evgenyi26rus/vector-role.git # timeout=10
Fetching upstream changes from https://github.com/Evgenyi26rus/vector-role.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
 > git fetch --tags --progress https://github.com/Evgenyi26rus/vector-role.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D master # timeout=10
 > git checkout -b master d47a4fa3c07b2e1ac528206f4a1e0ff84c5f8f57 # timeout=10
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Second)
[Pipeline] sh
+ pip3 install ansible-lint yamllint
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: ansible-lint in /home/jenkins/.local/lib/python3.6/site-packages (5.4.0)
Requirement already satisfied: yamllint in /home/jenkins/.local/lib/python3.6/site-packages (1.28.0)
Requirement already satisfied: pyyaml in /usr/local/lib64/python3.6/site-packages (from ansible-lint) (6.0.1)
Requirement already satisfied: packaging in /usr/local/lib/python3.6/site-packages (from ansible-lint) (21.3)
Requirement already satisfied: typing-extensions in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (4.1.1)
Requirement already satisfied: enrich>=1.2.6 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (1.2.7)
Requirement already satisfied: rich>=9.5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (12.6.0)
Requirement already satisfied: wcmatch>=7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (8.3)
Requirement already satisfied: tenacity in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (8.2.2)
Requirement already satisfied: ruamel.yaml<1,>=0.15.34 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-lint) (0.18.3)
Requirement already satisfied: setuptools in /usr/local/lib/python3.6/site-packages (from yamllint) (59.6.0)
Requirement already satisfied: pathspec>=0.5.3 in /home/jenkins/.local/lib/python3.6/site-packages (from yamllint) (0.9.0)
Requirement already satisfied: commonmark<0.10.0,>=0.9.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->ansible-lint) (0.9.1)
Requirement already satisfied: pygments<3.0.0,>=2.6.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->ansible-lint) (2.14.0)
Requirement already satisfied: dataclasses<0.9,>=0.7 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->ansible-lint) (0.8)
Requirement already satisfied: ruamel.yaml.clib>=0.2.7 in /home/jenkins/.local/lib/python3.6/site-packages (from ruamel.yaml<1,>=0.15.34->ansible-lint) (0.2.8)
Requirement already satisfied: bracex>=2.1.1 in /home/jenkins/.local/lib/python3.6/site-packages (from wcmatch>=7.0->ansible-lint) (2.2.1)
Requirement already satisfied: pyparsing!=3.0.5,>=2.0.2 in /usr/local/lib/python3.6/site-packages (from packaging->ansible-lint) (3.1.2)
[Pipeline] sh
+ pip install 'molecule[lint]'
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: molecule[lint] in /home/jenkins/.local/lib/python3.6/site-packages (3.6.1)
Requirement already satisfied: ansible-compat>=1.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (1.0.0)
Requirement already satisfied: Jinja2>=2.11.3 in /usr/local/lib/python3.6/site-packages (from molecule[lint]) (3.0.3)
Requirement already satisfied: packaging in /usr/local/lib/python3.6/site-packages (from molecule[lint]) (21.3)
Requirement already satisfied: PyYAML>=5.1 in /usr/local/lib64/python3.6/site-packages (from molecule[lint]) (6.0.1)
Requirement already satisfied: click<9,>=8.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (8.0.4)
Requirement already satisfied: rich>=9.5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (12.6.0)
Requirement already satisfied: cookiecutter>=1.7.3 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (1.7.3)
Requirement already satisfied: pluggy<2.0,>=0.7.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (1.0.0)
Requirement already satisfied: dataclasses in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (0.8)
Requirement already satisfied: click-help-colors>=0.9 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (0.9.4)
Requirement already satisfied: importlib-metadata in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (4.2.0)
Requirement already satisfied: enrich>=1.2.7 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (1.2.7)
Requirement already satisfied: cerberus!=1.3.3,!=1.3.4,>=1.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (1.3.5)
Requirement already satisfied: paramiko<3,>=2.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (2.12.0)
Requirement already satisfied: yamllint in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (1.28.0)
Requirement already satisfied: flake8>=3.8.4 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (5.0.4)
Requirement already satisfied: pre-commit>=2.10.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[lint]) (2.17.0)
Requirement already satisfied: subprocess-tee>=0.3.5 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-compat>=1.0.0->molecule[lint]) (0.3.5)
Requirement already satisfied: cached-property~=1.5 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-compat>=1.0.0->molecule[lint]) (1.5.2)
Requirement already satisfied: six>=1.10 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[lint]) (1.16.0)
Requirement already satisfied: python-slugify>=4.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[lint]) (6.1.2)
Requirement already satisfied: poyo>=0.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[lint]) (0.5.0)
Requirement already satisfied: binaryornot>=0.4.4 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[lint]) (0.4.4)
Requirement already satisfied: requests>=2.23.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[lint]) (2.26.0)
Requirement already satisfied: jinja2-time>=0.2.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[lint]) (0.2.0)
Requirement already satisfied: pyflakes<2.6.0,>=2.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from flake8>=3.8.4->molecule[lint]) (2.5.0)
Requirement already satisfied: pycodestyle<2.10.0,>=2.9.0 in /home/jenkins/.local/lib/python3.6/site-packages (from flake8>=3.8.4->molecule[lint]) (2.9.1)
Requirement already satisfied: mccabe<0.8.0,>=0.7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from flake8>=3.8.4->molecule[lint]) (0.7.0)
Requirement already satisfied: typing-extensions>=3.6.4 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule[lint]) (4.1.1)
Requirement already satisfied: zipp>=0.5 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule[lint]) (3.6.0)
Requirement already satisfied: MarkupSafe>=2.0 in /usr/local/lib64/python3.6/site-packages (from Jinja2>=2.11.3->molecule[lint]) (2.0.1)
Requirement already satisfied: cryptography>=2.5 in /usr/local/lib64/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule[lint]) (40.0.2)
Requirement already satisfied: bcrypt>=3.1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule[lint]) (4.0.1)
Requirement already satisfied: pynacl>=1.0.1 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule[lint]) (1.5.0)
Requirement already satisfied: importlib-resources<5.3 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[lint]) (5.2.3)
Requirement already satisfied: identify>=1.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[lint]) (2.4.4)
Requirement already satisfied: cfgv>=2.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[lint]) (3.3.1)
Requirement already satisfied: virtualenv>=20.0.8 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[lint]) (20.16.2)
Requirement already satisfied: nodeenv>=0.11.1 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[lint]) (1.6.0)
Requirement already satisfied: toml in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[lint]) (0.10.2)
Requirement already satisfied: commonmark<0.10.0,>=0.9.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule[lint]) (0.9.1)
Requirement already satisfied: pygments<3.0.0,>=2.6.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule[lint]) (2.14.0)
Requirement already satisfied: pyparsing!=3.0.5,>=2.0.2 in /usr/local/lib/python3.6/site-packages (from packaging->molecule[lint]) (3.1.2)
Requirement already satisfied: setuptools in /usr/local/lib/python3.6/site-packages (from yamllint->molecule[lint]) (59.6.0)
Requirement already satisfied: pathspec>=0.5.3 in /home/jenkins/.local/lib/python3.6/site-packages (from yamllint->molecule[lint]) (0.9.0)
Requirement already satisfied: chardet>=3.0.2 in /home/jenkins/.local/lib/python3.6/site-packages (from binaryornot>=0.4.4->cookiecutter>=1.7.3->molecule[lint]) (5.0.0)
Requirement already satisfied: cffi>=1.12 in /usr/local/lib64/python3.6/site-packages (from cryptography>=2.5->paramiko<3,>=2.5.0->molecule[lint]) (1.15.1)
Requirement already satisfied: arrow in /home/jenkins/.local/lib/python3.6/site-packages (from jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule[lint]) (1.2.3)
Requirement already satisfied: text-unidecode>=1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from python-slugify>=4.0.0->cookiecutter>=1.7.3->molecule[lint]) (1.3)
Requirement already satisfied: certifi>=2017.4.17 in /home/jenkins/.local/lib/python3.6/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule[lint]) (2024.2.2)
Requirement already satisfied: urllib3<1.27,>=1.21.1 in /home/jenkins/.local/lib/python3.6/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule[lint]) (1.26.18)
Requirement already satisfied: charset-normalizer~=2.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule[lint]) (2.0.12)
Requirement already satisfied: idna<4,>=2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule[lint]) (3.6)
Requirement already satisfied: platformdirs<3,>=2 in /home/jenkins/.local/lib/python3.6/site-packages (from virtualenv>=20.0.8->pre-commit>=2.10.1->molecule[lint]) (2.4.0)
Requirement already satisfied: filelock<4,>=3.2 in /home/jenkins/.local/lib/python3.6/site-packages (from virtualenv>=20.0.8->pre-commit>=2.10.1->molecule[lint]) (3.4.1)
Requirement already satisfied: distlib<1,>=0.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from virtualenv>=20.0.8->pre-commit>=2.10.1->molecule[lint]) (0.3.8)
Requirement already satisfied: pycparser in /usr/local/lib/python3.6/site-packages (from cffi>=1.12->cryptography>=2.5->paramiko<3,>=2.5.0->molecule[lint]) (2.21)
Requirement already satisfied: python-dateutil>=2.7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from arrow->jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule[lint]) (2.9.0.post0)
[Pipeline] sh
+ pip install 'molecule[docker,lint]'
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: molecule[docker,lint] in /home/jenkins/.local/lib/python3.6/site-packages (3.6.1)
Requirement already satisfied: paramiko<3,>=2.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (2.12.0)
Requirement already satisfied: click<9,>=8.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (8.0.4)
Requirement already satisfied: pluggy<2.0,>=0.7.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (1.0.0)
Requirement already satisfied: rich>=9.5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (12.6.0)
Requirement already satisfied: click-help-colors>=0.9 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (0.9.4)
Requirement already satisfied: Jinja2>=2.11.3 in /usr/local/lib/python3.6/site-packages (from molecule[docker,lint]) (3.0.3)
Requirement already satisfied: ansible-compat>=1.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (1.0.0)
Requirement already satisfied: enrich>=1.2.7 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (1.2.7)
Requirement already satisfied: cookiecutter>=1.7.3 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (1.7.3)
Requirement already satisfied: packaging in /usr/local/lib/python3.6/site-packages (from molecule[docker,lint]) (21.3)
Requirement already satisfied: PyYAML>=5.1 in /usr/local/lib64/python3.6/site-packages (from molecule[docker,lint]) (6.0.1)
Requirement already satisfied: importlib-metadata in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (4.2.0)
Requirement already satisfied: cerberus!=1.3.3,!=1.3.4,>=1.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (1.3.5)
Requirement already satisfied: dataclasses in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (0.8)
Requirement already satisfied: molecule-docker>=1.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (1.1.0)
Requirement already satisfied: yamllint in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (1.28.0)
Requirement already satisfied: pre-commit>=2.10.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (2.17.0)
Requirement already satisfied: flake8>=3.8.4 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule[docker,lint]) (5.0.4)
Requirement already satisfied: subprocess-tee>=0.3.5 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-compat>=1.0.0->molecule[docker,lint]) (0.3.5)
Requirement already satisfied: cached-property~=1.5 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-compat>=1.0.0->molecule[docker,lint]) (1.5.2)
Requirement already satisfied: binaryornot>=0.4.4 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[docker,lint]) (0.4.4)
Requirement already satisfied: requests>=2.23.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[docker,lint]) (2.26.0)
Requirement already satisfied: python-slugify>=4.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[docker,lint]) (6.1.2)
Requirement already satisfied: six>=1.10 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[docker,lint]) (1.16.0)
Requirement already satisfied: jinja2-time>=0.2.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[docker,lint]) (0.2.0)
Requirement already satisfied: poyo>=0.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule[docker,lint]) (0.5.0)
Requirement already satisfied: pycodestyle<2.10.0,>=2.9.0 in /home/jenkins/.local/lib/python3.6/site-packages (from flake8>=3.8.4->molecule[docker,lint]) (2.9.1)
Requirement already satisfied: mccabe<0.8.0,>=0.7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from flake8>=3.8.4->molecule[docker,lint]) (0.7.0)
Requirement already satisfied: pyflakes<2.6.0,>=2.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from flake8>=3.8.4->molecule[docker,lint]) (2.5.0)
Requirement already satisfied: typing-extensions>=3.6.4 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule[docker,lint]) (4.1.1)
Requirement already satisfied: zipp>=0.5 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule[docker,lint]) (3.6.0)
Requirement already satisfied: MarkupSafe>=2.0 in /usr/local/lib64/python3.6/site-packages (from Jinja2>=2.11.3->molecule[docker,lint]) (2.0.1)
Requirement already satisfied: selinux in /usr/local/lib/python3.6/site-packages (from molecule-docker>=1.0.0->molecule[docker,lint]) (0.2.1)
Requirement already satisfied: docker>=4.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule-docker>=1.0.0->molecule[docker,lint]) (5.0.3)
Requirement already satisfied: pynacl>=1.0.1 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule[docker,lint]) (1.5.0)
Requirement already satisfied: cryptography>=2.5 in /usr/local/lib64/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule[docker,lint]) (40.0.2)
Requirement already satisfied: bcrypt>=3.1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule[docker,lint]) (4.0.1)
Requirement already satisfied: importlib-resources<5.3 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[docker,lint]) (5.2.3)
Requirement already satisfied: nodeenv>=0.11.1 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[docker,lint]) (1.6.0)
Requirement already satisfied: virtualenv>=20.0.8 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[docker,lint]) (20.16.2)
Requirement already satisfied: toml in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[docker,lint]) (0.10.2)
Requirement already satisfied: cfgv>=2.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[docker,lint]) (3.3.1)
Requirement already satisfied: identify>=1.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from pre-commit>=2.10.1->molecule[docker,lint]) (2.4.4)
Requirement already satisfied: pygments<3.0.0,>=2.6.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule[docker,lint]) (2.14.0)
Requirement already satisfied: commonmark<0.10.0,>=0.9.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule[docker,lint]) (0.9.1)
Requirement already satisfied: pyparsing!=3.0.5,>=2.0.2 in /usr/local/lib/python3.6/site-packages (from packaging->molecule[docker,lint]) (3.1.2)
Requirement already satisfied: pathspec>=0.5.3 in /home/jenkins/.local/lib/python3.6/site-packages (from yamllint->molecule[docker,lint]) (0.9.0)
Requirement already satisfied: setuptools in /usr/local/lib/python3.6/site-packages (from yamllint->molecule[docker,lint]) (59.6.0)
Requirement already satisfied: chardet>=3.0.2 in /home/jenkins/.local/lib/python3.6/site-packages (from binaryornot>=0.4.4->cookiecutter>=1.7.3->molecule[docker,lint]) (5.0.0)
Requirement already satisfied: cffi>=1.12 in /usr/local/lib64/python3.6/site-packages (from cryptography>=2.5->paramiko<3,>=2.5.0->molecule[docker,lint]) (1.15.1)
Requirement already satisfied: websocket-client>=0.32.0 in /home/jenkins/.local/lib/python3.6/site-packages (from docker>=4.3.1->molecule-docker>=1.0.0->molecule[docker,lint]) (1.3.1)
Requirement already satisfied: arrow in /home/jenkins/.local/lib/python3.6/site-packages (from jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule[docker,lint]) (1.2.3)
Requirement already satisfied: text-unidecode>=1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from python-slugify>=4.0.0->cookiecutter>=1.7.3->molecule[docker,lint]) (1.3)
Requirement already satisfied: charset-normalizer~=2.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule[docker,lint]) (2.0.12)
Requirement already satisfied: idna<4,>=2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule[docker,lint]) (3.6)
Requirement already satisfied: certifi>=2017.4.17 in /home/jenkins/.local/lib/python3.6/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule[docker,lint]) (2024.2.2)
Requirement already satisfied: urllib3<1.27,>=1.21.1 in /home/jenkins/.local/lib/python3.6/site-packages (from requests>=2.23.0->cookiecutter>=1.7.3->molecule[docker,lint]) (1.26.18)
Requirement already satisfied: distlib<1,>=0.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from virtualenv>=20.0.8->pre-commit>=2.10.1->molecule[docker,lint]) (0.3.8)
Requirement already satisfied: filelock<4,>=3.2 in /home/jenkins/.local/lib/python3.6/site-packages (from virtualenv>=20.0.8->pre-commit>=2.10.1->molecule[docker,lint]) (3.4.1)
Requirement already satisfied: platformdirs<3,>=2 in /home/jenkins/.local/lib/python3.6/site-packages (from virtualenv>=20.0.8->pre-commit>=2.10.1->molecule[docker,lint]) (2.4.0)
Requirement already satisfied: distro>=1.3.0 in /usr/local/lib/python3.6/site-packages (from selinux->molecule-docker>=1.0.0->molecule[docker,lint]) (1.9.0)
Requirement already satisfied: pycparser in /usr/local/lib/python3.6/site-packages (from cffi>=1.12->cryptography>=2.5->paramiko<3,>=2.5.0->molecule[docker,lint]) (2.21)
Requirement already satisfied: python-dateutil>=2.7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from arrow->jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule[docker,lint]) (2.9.0.post0)
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Dalee test)
[Pipeline] echo
TEST
[Pipeline] sh
+ molecule test
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
/home/jenkins/.local/lib/python3.6/site-packages/requests/__init__.py:104: RequestsDependencyWarning: urllib3 (1.26.18) or chardet (5.0.0)/charset_normalizer (2.0.12) doesn't match a supported version!
  RequestsDependencyWarning)
CRITICAL 'molecule/default/molecule.yml' glob failed.  Exiting.
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
ERROR: script returned exit code 1
Finished: FAILURE
```

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.

https://github.com/Evgenyi26rus/vector-role/blob/master/Jenkinsfile

4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

![6.4.1.4.1.png](picture%2F6.4.1.4.1.png)

![6.4.1.4.2.png](picture%2F6.4.1.4.2.png)

5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](pipeline).

![6.4.1.6.png](picture%2F6.4.1.6.png)

6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.

Попроавил ссылку, т.к. изначально она не открывалась и падала в ошибку. При запуске плейбука запуск выполняется без флагов --check --diff:


```commandline
Started by user admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on agent in /opt/jenkins_agent/workspace/Scripted Pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Git checkout)
[Pipeline] git
The recommended git tool is: NONE
Warning: CredentialId "5ac0095d-0185-431b-94da-09a0ad9b0e2c" could not be found.
Fetching changes from the remote Git repository
Checking out Revision 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 (refs/remotes/origin/master)
Commit message: "Merge branch 'master' of https://github.com/aragastmatb/example-playbook"
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Scripted Pipeline/.git # timeout=10
 > git config remote.origin.url https://github.com/aragastmatb/example-playbook.git # timeout=10
Fetching upstream changes from https://github.com/aragastmatb/example-playbook.git
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
 > git fetch --tags --progress https://github.com/aragastmatb/example-playbook.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D master # timeout=10
 > git checkout -b master 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
 > git rev-list --no-walk 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Sample define secret_check)
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run playbook)
[Pipeline] sh
+ ansible-playbook site.yml -i inventory/prod.yml

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography will remove support for Python 3.6.
  from cryptography.exceptions import InvalidSignature
ok: [localhost]

TASK [java : Upload .tar.gz file containing binaries from local storage] *******
skipping: [localhost]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] *******
ok: [localhost]

TASK [java : Ensure installation dir exists] ***********************************
fatal: [localhost]: FAILED! => {"changed": false, "module_stderr": "sudo: a password is required\n", "module_stdout": "", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 1}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=1    skipped=1    rescued=0    ignored=0   

[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
ERROR: script returned exit code 2
Finished: FAILURE
```

7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline (https://github.com/Evgenyi26rus/vector-role/blob/master/Jenkinsfile) и Scripted Pipeline ([Jenkinsfile](pipeline%2FJenkinsfile)).
9. Сопроводите процесс настройки скриншотами для каждого пункта задания!!

![6.4.1.9.png](picture%2F6.4.1.9.png)

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.
