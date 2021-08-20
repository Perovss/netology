# Домашнее задание к занятию "13.3 работа с kubectl"
## Задание 1: проверить работоспособность каждого компонента
> Для проверки работы можно использовать 2 способа: port-forward и exec. Используя оба способа, проверьте каждый компонент:
> * сделайте запросы к бекенду;
> * сделайте запросы к фронту;
> * подключитесь к базе данных.


В данной задании используем манифесты с Занятия 13.1 Задание №2

**Frontend EXEC**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~</b></font>$ kubectl exec frontend-5cf457b7d8-7vzsw -- curl localhost:80
&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;ru&quot;&gt;
&lt;head&gt;
    &lt;title&gt;Список&lt;/title&gt;
    &lt;meta charset=&quot;UTF-8&quot;&gt;
    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;
    &lt;link href=&quot;/build/main.css&quot; rel=&quot;stylesheet&quot;&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;main class=&quot;b-page&quot;&gt;
        &lt;h1 class=&quot;b-page__title&quot;&gt;Список&lt;/h1&gt;
        &lt;div class=&quot;b-page__content b-items js-list&quot;&gt;&lt;/div&gt;
    &lt;/main&gt;
    &lt;script src=&quot;/build/main.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
</pre>

**Frontend PORT-FORWARD**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~</b></font>$ kubectl port-forward frontend-5cf457b7d8-7vzsw  8081:80 &amp;
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~</b></font>$ Forwarding from 127.0.0.1:8081 -&gt; 80
Forwarding from [::1]:8081 -&gt; 80
curl localhost:8081
Handling connection for 8081
&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;ru&quot;&gt;
&lt;head&gt;
    &lt;title&gt;Список&lt;/title&gt;
    &lt;meta charset=&quot;UTF-8&quot;&gt;
    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;
    &lt;link href=&quot;/build/main.css&quot; rel=&quot;stylesheet&quot;&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;main class=&quot;b-page&quot;&gt;
        &lt;h1 class=&quot;b-page__title&quot;&gt;Список&lt;/h1&gt;
        &lt;div class=&quot;b-page__content b-items js-list&quot;&gt;&lt;/div&gt;
    &lt;/main&gt;
    &lt;script src=&quot;/build/main.js&quot;&gt;&lt;/script&gt;
&lt;/body&gt;
</pre>

**Backend EXEC**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~</b></font>$ kubectl exec backend-68f7d9dc55-6lkqp  -- curl localhost:9000
Defaulted container &quot;backend&quot; out of: backend, init-postgres (init)
{&quot;detail&quot;:&quot;Not Found&quot;}
</pre>

**Backend PORT-FORWARD**

<pre>
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl port-forward backend-68f7d9dc55-5k76s 9001:9000 &amp;
[2] 45292
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ Forwarding from 127.0.0.1:9001 -&gt; 9000
Forwarding from [::1]:9001 -&gt; 9000
curl localhost:9001
Handling connection for 9001
{&quot;detail&quot;:&quot;Not Found&quot;}</pre>

**Postgres EXEC**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl exec -it db-0 -- psql -U postgres
psql (13.3)
Type &quot;help&quot; for help.

postgres=# 
</pre>

**Postgres PORT-FORWARD**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl port-forward db-0 35432:5432 &amp;
[7] 77604
psql -U postgres -h localhost -p 35432
Handling connection for 35432
psql (13.4 (Ubuntu 13.4-0ubuntu0.21.04.1), server 13.3)
Type &quot;help&quot; for help.
</pre>

## Задание 2: ручное масштабирование

> При работе с приложением иногда может потребоваться вручную добавить пару копий. Используя команду kubectl scale, попробуйте увеличить количество бекенда и фронта до 3. После уменьшите количество копий до 1. Проверьте, на каких нодах оказались копии после каждого действия (kubectl describe).

Масштабируем до 3 реплик

kubectl scale --replicas=3 deployment/backend
kubectl scale --replicas=3 deployment/frontend

Происходит инициализация новых реплик

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl scale --replicas=3 deployment/backend
deployment.apps/backend scaled
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl scale --replicas=3 deployment/frontend
deployment.apps/frontend scaled
font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl get pods
NAME                        READY   STATUS     RESTARTS   AGE
backend-68f7d9dc55-c4lxb    0/1     Init:0/1   0          5s
backend-68f7d9dc55-hpkkv    1/1     Running    0          18m
backend-68f7d9dc55-sgzt8    0/1     Init:0/1   0          5s
db-0                        1/1     Running    0          18m
frontend-5cf457b7d8-5w4qf   0/1     Init:0/1   0          2s
frontend-5cf457b7d8-mr59k   0/1     Init:0/1   0          2s
frontend-5cf457b7d8-tfvgm   1/1     Running    0          18m
</pre>

через некоторое время запущены три реплики

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
backend-68f7d9dc55-cnxgc    1/1     Running   0          31s
backend-68f7d9dc55-hpkkv    1/1     Running   0          14m
backend-68f7d9dc55-jrgfx    1/1     Running   0          31s
db-0                        1/1     Running   0          14m
frontend-5cf457b7d8-9t2gh   1/1     Running   0          13s
frontend-5cf457b7d8-qmwr5   1/1     Running   0          13s
frontend-5cf457b7d8-tfvgm   1/1     Running   0          14m
</pre>

Масштабируем до 1 реплик

kubectl scale --replicas=1 deployment/backend
kubectl scale --replicas=1 deployment/frontend

Происходит терминация подов
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl scale --replicas=1 deployment/backend
deployment.apps/backend scaled
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl scale --replicas=1 deployment/frontend
deployment.apps/frontend scaled
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl get pods
NAME                        READY   STATUS        RESTARTS   AGE
backend-68f7d9dc55-cnxgc    1/1     Terminating   0          2m29s
backend-68f7d9dc55-hpkkv    1/1     Running       0          16m
backend-68f7d9dc55-jrgfx    1/1     Terminating   0          2m29s
db-0                        1/1     Running       0          16m
frontend-5cf457b7d8-tfvgm   1/1     Running       0          16m
</pre>

через некоторое время остается одна реплика

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.3</b></font>$ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
backend-68f7d9dc55-hpkkv    1/1     Running   0          18m
db-0                        1/1     Running   0          18m
frontend-5cf457b7d8-tfvgm   1/1     Running   0          18m
</pre>