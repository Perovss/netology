# Домашнее задание к занятию "14.2 Синхронизация секретов с внешними сервисами. Vault"

## Задача 1: Работа с модулем Vault

> Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube
> 
> ```
> kubectl apply -f 14.2/vault-pod.yml
> ```

##**Решение**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.2</b></font>$ kubectl apply -f 14.2/vault-pod.yml
pod/14.2-netology-vault created
</pre>

Получить значение внутреннего IP пода

> ```
> kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
> ```
> 
> Примечание: jq - утилита для работы с JSON в командной строке

##**Решение**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.2</b></font>$ kubectl get pod 14.2-netology-vault -o json | jq -c &apos;.status.podIPs&apos;
<b>[{</b><font color="#12488B"><b>&quot;ip&quot;</b></font><b>:</b><font color="#26A269">&quot;172.17.0.14&quot;</font><b>}]</b>
</pre>

> Запустить второй модуль для использования в качестве клиента
> 
> ```
> kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
> ```
> 
> Установить дополнительные пакеты
> 
> ```
> dnf -y install pip
> pip install hvac
> ```

##**Решение**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.2</b></font>$ kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
If you don&apos;t see a command prompt, try pressing enter.
sh-5.1# dnf -y install pip
Fedora 34 - x86_64                                                                      12 MB/s |  74 MB     00:05    
Fedora 34 openh264 (From Cisco) - x86_64                                               1.2 kB/s | 2.5 kB     00:02    
Fedora Modular 34 - x86_64                                                             1.8 MB/s | 4.9 MB     00:02    
Fedora 34 - x86_64 - Updates                                                           8.9 MB/s |  25 MB     00:02    
Fedora Modular 34 - x86_64 - Updates                                                   3.2 MB/s | 4.6 MB     00:01    
Dependencies resolved.
=======================================================================================================================
 Package                            Architecture           Version                       Repository               Size
=======================================================================================================================
Installing:
 <font color="#26A269"><b>python3-pip                       </b></font> noarch                 21.0.1-3.fc34                 updates                 1.8 M
Installing weak dependencies:
 <font color="#26A269"><b>python3-setuptools                </b></font> noarch                 53.0.0-2.fc34                 updates                 840 k

Transaction Summary
=======================================================================================================================
Install  2 Packages

Total download size: 2.6 M
Installed size: 13 M
Downloading Packages:
(1/2): python3-setuptools-53.0.0-2.fc34.noarch.rpm                                     5.0 MB/s | 840 kB     00:00    
(2/2): python3-pip-21.0.1-3.fc34.noarch.rpm                                            7.4 MB/s | 1.8 MB     00:00    
-----------------------------------------------------------------------------------------------------------------------
Total                                                                                  2.3 MB/s | 2.6 MB     00:01     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                               1/1 
  Installing       : python3-setuptools-53.0.0-2.fc34.noarch                                                       1/2 
  Installing       : python3-pip-21.0.1-3.fc34.noarch                                                              2/2 
  Running scriptlet: python3-pip-21.0.1-3.fc34.noarch                                                              2/2 
  Verifying        : python3-pip-21.0.1-3.fc34.noarch                                                              1/2 
  Verifying        : python3-setuptools-53.0.0-2.fc34.noarch                                                       2/2 

Installed:
  python3-pip-21.0.1-3.fc34.noarch                       python3-setuptools-53.0.0-2.fc34.noarch                      

Complete!
sh-5.1# pip install hvac
<font color="#A2734C">WARNING: Running pip install with root privileges is generally not a good idea. Try `pip install --user` instead.</font>
Collecting hvac
  Downloading hvac-0.11.0-py2.py3-none-any.whl (148 kB)
     |████████████████████████████████| 148 kB 1.5 MB/s 
Collecting requests&gt;=2.21.0
  Downloading requests-2.26.0-py2.py3-none-any.whl (62 kB)
     |████████████████████████████████| 62 kB 3.2 MB/s 
Collecting six&gt;=1.5.0
  Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Collecting urllib3&lt;1.27,&gt;=1.21.1
  Downloading urllib3-1.26.6-py2.py3-none-any.whl (138 kB)
     |████████████████████████████████| 138 kB 10.6 MB/s 
Collecting certifi&gt;=2017.4.17
  Downloading certifi-2021.5.30-py2.py3-none-any.whl (145 kB)
     |████████████████████████████████| 145 kB 12.9 MB/s 
Collecting idna&lt;4,&gt;=2.5
  Downloading idna-3.2-py3-none-any.whl (59 kB)
     |████████████████████████████████| 59 kB 12.6 MB/s 
Collecting charset-normalizer~=2.0.0
  Downloading charset_normalizer-2.0.4-py3-none-any.whl (36 kB)
Installing collected packages: urllib3, idna, charset-normalizer, certifi, six, requests, hvac
Successfully installed certifi-2021.5.30 charset-normalizer-2.0.4 hvac-0.11.0 idna-3.2 requests-2.26.0 six-1.16.0 urllib3-1.26.6
sh-5.1# </pre>

> Запустить интепретатор Python и выполнить следующий код, предварительно
> поменяв IP и токен
> 
> ```
> import hvac
> client = hvac.Client(
>     url='http://10.10.133.71:8200',
>     token='aiphohTaa0eeHei'
> )
> client.is_authenticated()
> 
> # Пишем секрет
> client.secrets.kv.v2.create_or_update_secret(
>     path='hvac',
>     secret=dict(netology='Big secret!!!'),
> )
> 
> # Читаем секрет
> client.secrets.kv.v2.read_secret_version(
>     path='hvac',
> )
> ```

##**Решение**

<pre>&gt;&gt;&gt; import hvac
&gt;&gt;&gt; client = hvac.Client(
...     url=&apos;http://172.17.0.14:8200&apos;,
...     token=&apos;aiphohTaa0eeHei&apos;
... )
&gt;&gt;&gt; client.is_authenticated()
True
&gt;&gt;&gt; 
&gt;&gt;&gt; # Пишем секрет
&gt;&gt;&gt; client.secrets.kv.v2.create_or_update_secret(
...     path=&apos;hvac&apos;,
...     secret=dict(netology=&apos;Big secret!!!&apos;),
... )
{&apos;request_id&apos;: &apos;f856475b-c930-b786-577c-9a7763020910&apos;, &apos;lease_id&apos;: &apos;&apos;, &apos;renewable&apos;: False, &apos;lease_duration&apos;: 0, &apos;data&apos;: {&apos;created_time&apos;: &apos;2021-08-24T14:23:43.059809621Z&apos;, &apos;deletion_time&apos;: &apos;&apos;, &apos;destroyed&apos;: False, &apos;version&apos;: 4}, &apos;wrap_info&apos;: None, &apos;warnings&apos;: None, &apos;auth&apos;: None}
&gt;&gt;&gt; 
&gt;&gt;&gt; # Читаем секрет
&gt;&gt;&gt; client.secrets.kv.v2.read_secret_version(
...     path=&apos;hvac&apos;,
... )
{&apos;request_id&apos;: &apos;bd66b893-c57b-5a9c-e97b-2c5a2d2301ac&apos;, &apos;lease_id&apos;: &apos;&apos;, &apos;renewable&apos;: False, &apos;lease_duration&apos;: 0, &apos;data&apos;: {&apos;data&apos;: {&apos;netology&apos;: &apos;Big secret!!!&apos;}, &apos;metadata&apos;: {&apos;created_time&apos;: &apos;2021-08-24T14:23:43.059809621Z&apos;, &apos;deletion_time&apos;: &apos;&apos;, &apos;destroyed&apos;: False, &apos;version&apos;: 4}}, &apos;wrap_info&apos;: None, &apos;warnings&apos;: None, &apos;auth&apos;: None}
&gt;&gt;&gt; </pre>

###Код проверки прошел успешно