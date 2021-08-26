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
