# Домашнее задание к занятию "15.1. Организация сети"

Настроить Production like сеть в рамках одной зоны с помощью terraform. Модуль VPC умеет автоматически делать все что есть в этом задании. Но мы воспользуемся более низкоуровневыми абстракциями, чтобы понять, как оно устроено внутри.

1. Создать VPC.

- Используя vpc-модуль terraform, создать пустую VPC с подсетью 172.31.0.0/16.
- Выбрать регион и зону.

2. Публичная сеть.

- Создать в vpc subnet с названием public, сетью 172.31.32.0/19 и Internet gateway.
- Добавить RouteTable, направляющий весь исходящий трафик в Internet gateway.
- Создать в этой приватной сети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task15.1/terraform/certificates</b></font>$ ssh -i my-key.key ubuntu@13.58.36.240 
Warning: Identity file my-key.key not accessible: No such file or directory.
The authenticity of host &apos;13.58.36.240 (13.58.36.240)&apos; can&apos;t be established.
ECDSA key fingerprint is SHA256:yHjq31D70zFjOfUkPZYfIOQK+tiaJop8uigIJMR7Big.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added &apos;13.58.36.240&apos; (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-1017-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed Sep  8 13:34:59 UTC 2021

  System load:  0.0               Processes:             97
  Usage of /:   17.1% of 7.69GB   Users logged in:       0
  Memory usage: 20%               IPv4 address for eth0: 172.31.62.56
  Swap usage:   0%

1 update can be applied immediately.
To see these additional updates run: apt list --upgradable



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user &quot;root&quot;), use &quot;sudo &lt;command&gt;&quot;.
See &quot;man sudo_root&quot; for details.

<font color="#26A269"><b>ubuntu@ip-172-31-62-56</b></font>:<font color="#12488B"><b>~</b></font>$ ping www.ya.ru
PING ya.ru (87.250.250.242) 56(84) bytes of data.
64 bytes from ya.ru (87.250.250.242): icmp_seq=1 ttl=228 time=108 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=2 ttl=228 time=108 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=3 ttl=228 time=109 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=4 ttl=228 time=108 ms
^C
--- ya.ru ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 107.999/108.274/108.884/0.356 ms
<font color="#26A269"><b>ubuntu@ip-172-31-62-56</b></font>:<font color="#12488B"><b>~</b></font>$ 
</pre>



3. Приватная сеть.

- Создать в vpc subnet с названием private, сетью 172.31.96.0/19.
- Добавить NAT gateway в public subnet.
- Добавить Route, направляющий весь исходящий трафик private сети в NAT.

4. VPN.

- Настроить VPN, соединить его с сетью private.
- Создать себе учетную запись и подключиться через нее.
- Создать виртуалку в приватной сети.
- Подключиться к ней по SSH по приватному IP и убедиться, что с виртуалки есть выход в интернет.

Документация по AWS-ресурсам:

- [Getting started with Client VPN](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/cvpn-getting-started.html)

Модули terraform

- [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)











<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task15.1/terraform</b></font>$ ssh -i my_key ubuntu@172.31.65.126
Warning: Identity file my_key not accessible: No such file or directory.
The authenticity of host &apos;172.31.65.126 (172.31.65.126)&apos; can&apos;t be established.
ECDSA key fingerprint is SHA256:UT/V0Y2y1OvbziDMP59NB5cdTxUb8gt9MrVOy06JBC8.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added &apos;172.31.65.126&apos; (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-1017-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed Sep  8 13:31:10 UTC 2021

  System load:  0.0               Processes:             97
  Usage of /:   16.9% of 7.69GB   Users logged in:       0
  Memory usage: 19%               IPv4 address for eth0: 172.31.65.126
  Swap usage:   0%

 * Ubuntu Pro delivers the most comprehensive open source security and
   compliance features.

   https://ubuntu.com/aws/pro

1 update can be applied immediately.
To see these additional updates run: apt list --upgradable



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user &quot;root&quot;), use &quot;sudo &lt;command&gt;&quot;.
See &quot;man sudo_root&quot; for details.

<font color="#26A269"><b>ubuntu@ip-172-31-65-126</b></font>:<font color="#12488B"><b>~</b></font>$ ping www.ya.ru
PING ya.ru (87.250.250.242) 56(84) bytes of data.
64 bytes from ya.ru (87.250.250.242): icmp_seq=1 ttl=227 time=109 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=2 ttl=227 time=109 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=3 ttl=227 time=109 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=4 ttl=227 time=109 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=5 ttl=227 time=109 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=6 ttl=227 time=109 ms
^C
--- ya.ru ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5008ms
rtt min/avg/max/mdev = 108.622/108.743/109.012/0.136 ms
<font color="#26A269"><b>ubuntu@ip-172-31-65-126</b></font>:<font color="#12488B"><b>~</b></font>$ 
</pre>