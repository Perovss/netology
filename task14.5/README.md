# Домашнее задание к занятию "14.5 SecurityContext, NetworkPolicies"

## Задача 1: Рассмотрите пример 14.5/example-security-context.yml

> 
> Создайте модуль
> 
> ```
> kubectl apply -f 14.5/example-security-context.yml
> ```
> 
> Проверьте установленные настройки внутри контейнера
> 
> ```
> kubectl logs security-context-demo
> uid=1000 gid=3000 groups=3000
> ```

## **Решение**
<pre>
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.5/14.5</b></font>$ kubectl apply -f example-security-context.yml
pod/security-context-demo created
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.5/14.5</b></font>$ kubectl logs 
security-context-demo  
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.5/14.5</b></font>$ kubectl logs security-context-demo 
uid=1000 gid=3000 groups=3000
</pre>

## Задача 2 (*): Рассмотрите пример 14.5/example-network-policy.yml
> ```
> Создайте два модуля. Для первого модуля разрешите доступ к внешнему миру и ко второму контейнеру. Для второго модуля > разрешите связь только с первым контейнером. Проверьте корректность настроек.
> ```

## **Решение**
Ссылка на [манифесты](https://github.com/Perovss/netology/tree/master/task14.5/task2)

Поднимаем поды и сетевые политики

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.5/task2</b></font>$ kubectl apply -f .
networkpolicy.networking.k8s.io/one created
networkpolicy.networking.k8s.io/two created
pod/one created
pod/two created
</pre>

Получаем IP адреса подов

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.5/task2</b></font>$ kubectl describe pods | grep -E &quot;(^Name:|^IP:)&quot;
<font color="#C01C28"><b>Name:</b></font>         one
<font color="#C01C28"><b>IP:</b></font>           10.10.67.83
<font color="#C01C28"><b>Name:</b></font>         two
<font color="#C01C28"><b>IP:</b></font>           10.10.213.49
</pre>

Проверим наши правила на первом поде
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.5/task2</b></font>$ kubectl exec -it one -- sh

<font color="red"><b>Пингуем внешнюю сеть</b></font>
/ # ping www.ya.ru -c2
PING www.ya.ru (87.250.250.242): 56 data bytes
64 bytes from 87.250.250.242: seq=0 ttl=55 time=13.151 ms
64 bytes from 87.250.250.242: seq=1 ttl=55 time=13.232 ms
--- www.ya.ru ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 13.151/13.191/13.232 ms
<font color="blue"><b>ОК</b></font>

<font color="red"><b>Пингуем под №2(two)</b></font>
/ # ping 10.10.213.49 -c2
PING 10.10.213.49 (10.10.213.49): 56 data bytes
64 bytes from 10.10.213.49: seq=0 ttl=62 time=0.446 ms
64 bytes from 10.10.213.49: seq=1 ttl=62 time=0.504 ms

--- 10.10.213.49 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.446/0.475/0.504 ms
<font color="blue"><b>ОК</b></font>
</pre>

Проверим наши правила на втором поде

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.5/task2</b></font>$ kubectl exec -it two -- sh

<font color="red"><b>Пингуем внешнюю сеть</b></font>
/ # ping www.ya.ru -c2
ping: bad address &apos;www.ya.ru&apos;
<font color="gree"><b>Блокировка сработала</b></font>

<font color="red"><b>Пингуем под №1(one)</b></font>
/ # ping 10.10.67.83 -c2
PING 10.10.67.83 (10.10.67.83): 56 data bytes
64 bytes from 10.10.67.83: seq=0 ttl=62 time=0.411 ms
64 bytes from 10.10.67.83: seq=1 ttl=62 time=0.489 ms
--- 10.10.67.83 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.411/0.450/0.489 ms
<font color="blue"><b>ОК</b></font>
</pre>
