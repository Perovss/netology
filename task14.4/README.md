# Домашнее задание к занятию "14.4 Сервис-аккаунты"

## Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать сервис-аккаунт?

> ```
> kubectl create serviceaccount netology
> ```


## **Решение**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$ kubectl create serviceaccount netology
serviceaccount/netology created
</pre>

### Как просмотреть список сервис-акаунтов?

> ```
> kubectl get serviceaccounts
> kubectl get serviceaccount
> ```

## **Решение**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$ kubectl get serviceaccounts
NAME       SECRETS   AGE
default    1         51m
netology   1         30s
</pre>

### Как получить информацию в формате YAML и/или JSON?

> ```
> kubectl get serviceaccount netology -o yaml
> kubectl get serviceaccount default -o json
> ```

## **Решение**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$ kubectl get serviceaccount netology -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: &quot;2021-08-25T13:40:30Z&quot;
  name: netology
  namespace: default
  resourceVersion: &quot;2589&quot;
  uid: c4cab2ea-74bb-47a6-bda1-71d33633f98a
secrets:
- name: netology-token-8hvtf
</pre>

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$  kubectl get serviceaccount default -o json
{
    &quot;apiVersion&quot;: &quot;v1&quot;,
    &quot;kind&quot;: &quot;ServiceAccount&quot;,
    &quot;metadata&quot;: {
        &quot;creationTimestamp&quot;: &quot;2021-08-25T12:49:55Z&quot;,
        &quot;name&quot;: &quot;default&quot;,
        &quot;namespace&quot;: &quot;default&quot;,
        &quot;resourceVersion&quot;: &quot;419&quot;,
        &quot;uid&quot;: &quot;6fa27315-9384-43b0-b830-4c623577bbac&quot;
    },
    &quot;secrets&quot;: [
        {
            &quot;name&quot;: &quot;default-token-vs4m2&quot;
        }
    ]
}</pre>

### Как выгрузить сервис-акаунты и сохранить его в файл?

> ```
> kubectl get serviceaccounts -o json > serviceaccounts.json
> kubectl get serviceaccount netology -o yaml > netology.yml
> ```

## **Решение**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$ kubectl get serviceaccounts -o json &gt; serviceaccounts.json
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$ kubectl get serviceaccount netology -o yaml &gt; netology.yml
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$ ls -la
итого 20
drwxrwxr-x  2 serge serge 4096 авг 25 16:43 <font color="#12488B"><b>.</b></font>
drwxrwxr-x 24 serge serge 4096 авг 24 15:23 <font color="#12488B"><b>..</b></font>
-rw-rw-r--  1 serge serge  236 авг 25 16:43 netology.yml
-rw-rw-r--  1 serge serge 1144 авг 25 16:43 serviceaccounts.json
</pre>

### Как удалить сервис-акаунт?

> ```
> kubectl delete serviceaccount netology
> ```

## **Решение**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$ kubectl delete serviceaccount netology
serviceaccount &quot;netology&quot; deleted
</pre>

### Как загрузить сервис-акаунт из файла?

> ```
> kubectl apply -f netology.yml
> ```

## **Решение**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.4</b></font>$ kubectl apply -f netology.yml
serviceaccount/netology created
</pre>