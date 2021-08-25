# Домашнее задание к занятию "14.3 Карты конфигураций"

## Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

 ### Как создать карту конфигураций?
> 
> ```
> kubectl create configmap nginx-config --from-file=nginx.conf
> kubectl create configmap domain --from-literal=name=netology.ru
> ```

## **Решение**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl create configmap nginx-config --from-file=nginx.conf
configmap/nginx-config created
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl create configmap domain --from-literal=name=netology.ru
configmap/domain created</pre>
### Как просмотреть список карт конфигураций?

> ```
> kubectl get configmaps
> kubectl get configmap
> ```

## **Решение**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl get configmaps
NAME               DATA   AGE
domain             1      35s
nginx-config       1      50s
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl get configmap
NAME               DATA   AGE
domain             1      74s
nginx-config       1      89s
</pre>

### Как просмотреть карту конфигурации?
> 
> ```
> kubectl get configmap nginx-config
> kubectl describe configmap domain
> ```

## **Решение**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl get configmap nginx-config
NAME           DATA   AGE
nginx-config   1      2m52s
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl describe configmap domain
Name:         domain
Namespace:    default
Labels:       &lt;none&gt;
Annotations:  &lt;none&gt;

Data
====
name:
----
netology.ru

BinaryData
====

Events:  &lt;none&gt;
</pre>

### Как получить информацию в формате YAML и/или JSON?
> 
> ```
> kubectl get configmap nginx-config -o yaml
> kubectl get configmap domain -o json
> ```

## **Решение**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl get configmap nginx-config -o yaml
apiVersion: v1
data:
  nginx.conf: |
    server {
        listen 80;
        server_name  netology.ru www.netology.ru;
        access_log  /var/log/nginx/domains/netology.ru-access.log  main;
        error_log   /var/log/nginx/domains/netology.ru-error.log info;
        location / {
            include proxy_params;
            proxy_pass http://10.10.10.10:8080/;
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: &quot;2021-08-24T21:43:14Z&quot;
  name: nginx-config
  namespace: default
  resourceVersion: &quot;297253&quot;
  uid: fc250d08-e014-47f5-9732-5565412b8884
</pre>
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl get configmap domain -o json
{
    &quot;apiVersion&quot;: &quot;v1&quot;,
    &quot;data&quot;: {
        &quot;name&quot;: &quot;netology.ru&quot;
    },
    &quot;kind&quot;: &quot;ConfigMap&quot;,
    &quot;metadata&quot;: {
        &quot;creationTimestamp&quot;: &quot;2021-08-24T21:43:29Z&quot;,
        &quot;name&quot;: &quot;domain&quot;,
        &quot;namespace&quot;: &quot;default&quot;,
        &quot;resourceVersion&quot;: &quot;297284&quot;,
        &quot;uid&quot;: &quot;a6028576-1268-4996-b460-7d48e0be10ae&quot;
    }
}
</pre>

### Как выгрузить карту конфигурации и сохранить его в файл?

> ```
> kubectl get configmaps -o json > configmaps.json
> kubectl get configmap nginx-config -o yaml > nginx-config.yml
> ```

## **Решение**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl get configmaps -o json &gt; configmaps.json
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl get configmap nginx-config -o yaml &gt; nginx-config.yml
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ ls
configmaps.json  nginx-config.yml
</pre>

### Как удалить карту конфигурации?

> ```
> kubectl delete configmap nginx-config
> ```

## **Решение**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl delete configmap nginx-config
configmap &quot;nginx-config&quot; deleted</pre>

### Как загрузить карту конфигурации из файла?

> ```
> kubectl apply -f nginx-config.yml
> ```

## **Решение**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task14.3/14.3</b></font>$ kubectl apply -f nginx-config.yml
configmap/nginx-config created
</pre>
