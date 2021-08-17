# Домашнее задание к занятию "13.2 разделы и монтирование"
> Приложение запущено и работает, но время от времени появляется необходимость передавать между бекендами данные. А сам бекенд генерирует статику для фронта. Нужно оптимизировать это.
> Для настройки NFS сервера можно воспользоваться следующей инструкцией (производить под пользователем на сервере, у которого есть доступ до kubectl):
> * установить helm: curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
> * добавить репозиторий чартов: helm repo add stable https://charts.helm.sh/stable && helm repo update
> * установить nfs-server через helm: helm install nfs-server stable/nfs-server-provisioner
>
> В конце установки будет выдан пример создания PVC для этого сервера.

## Задание 1: подключить для тестового конфига общую папку
> В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:
> * в поде подключена общая папка между контейнерами (например, /static);
> * после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.

[Решение задания 1](http://https://github.com/Perovss/netology/tree/master/task13.2/1)

<pre><font color="#26A269"><b>serge@Lenovo</b></font>:<font color="#12488B"><b>~/netology/task13.2</b></font>$ kubectl get pods -n stage
NAME                               READY   STATUS    RESTARTS   AGE
frontend-backend-5f8d898dc-zvjq9   2/2     Running   0          49s
</pre>

<pre><font color="#26A269"><b>serge@Lenovo</b></font>:<font color="#12488B"><b>~/netology/task13.2</b></font>$ kubectl exec -it frontend-backend-5f8d898dc-zvjq9 frontend -n stage -- bash
Defaulted container &quot;frontend&quot; out of: frontend, backend
root@frontend-backend-5f8d898dc-zvjq9:/# ls
bin   dev		   docker-entrypoint.sh  home  lib64  mnt  proc  run   srv     sys  usr
boot  docker-entrypoint.d  etc			 lib   media  opt  root  sbin  <font color="red">static</font> tmp  var
root@frontend-backend-5f8d898dc-zvjq9:/# echo &quot;hello world&quot; &gt; static/1.txt </pre>

<pre><font color="#26A269"><b>serge@Lenovo</b></font>:<font color="#12488B"><b>~/netology/task13.2</b></font>$ kubectl exec -it frontend-backend-5f8d898dc-zvjq9 backend -n stage -- bash
Defaulted container &quot;frontend&quot; out of: frontend, backend
root@frontend-backend-5f8d898dc-zvjq9:/# ls
bin   dev		   docker-entrypoint.sh  home  lib64  mnt  proc  run   srv     sys  usr
boot  docker-entrypoint.d  etc			 lib   media  opt  root  sbin <font color="red">static</font>  tmp  var
root@frontend-backend-5f8d898dc-zvjq9:/# cat /s
sbin/   srv/    static/ sys/
root@frontend-backend-5f8d898dc-zvjq9:/# cat /static/1.txt
hello world
</pre>

## Задание 2: подключить общую папку для прода
> Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
> * все бекенды подключаются к одному PV в режиме ReadWriteMany;
> * фронтенды тоже подключаются к этому же PV с таким же режимом;
> * файлы, созданные бекендом, должны быть доступны фронту.

[Решение задания 2](http://https://github.com/Perovss/netology/tree/master/task13.2/2)

<pre><font color="#26A269"><b>serge@Lenovo</b></font>:<font color="#12488B"><b>~/netology/task13.2</b></font>$ kubectl get pods -n production
NAME                        READY   STATUS    RESTARTS   AGE
backend-79c49bf55b-b7mq6    1/1     Running   0          46s
frontend-545b9ffd6b-86kfj   1/1     Running   0          46s
</pre>

<pre><font color="#26A269"><b>serge@Lenovo</b></font>:<font color="#12488B"><b>~/netology/task13.2</b></font>$ kubectl get pvc -n production
NAME     STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
my-pvc   Bound    pvc-909cc4a0-f5c5-4fdd-91cb-f1f82bac04e1   100Mi      RWX            nfs            2m5s
</pre>

<pre><font color="#26A269"><b>serge@Lenovo</b></font>:<font color="#12488B"><b>~/netology/task13.2</b></font>$ kubectl get pv -n production
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM               STORAGECLASS   REASON   AGE
pvc-909cc4a0-f5c5-4fdd-91cb-f1f82bac04e1   100Mi      RWX            Delete           Bound    production/my-pvc   nfs                     2m23s
</pre>

<pre><font color="#26A269"><b>serge@Lenovo</b></font>:<font color="#12488B"><b>~/netology/task13.2</b></font>$ kubectl exec -it frontend-545b9ffd6b-86kfj frontend -n production -- bash
root@frontend-545b9ffd6b-86kfj:/# ls
bin   dev		   docker-entrypoint.sh  home  lib64  mnt  proc  run   srv     sys  usr
boot  docker-entrypoint.d  etc			 lib   media  opt  root  sbin  <font color="red">static</font>  tmp  var
root@frontend-545b9ffd6b-86kfj:/# echo &quot;hello world&quot;&gt; /static/1.txt
</pre>

<pre><font color="#26A269"><b>serge@Lenovo</b></font>:<font color="#12488B"><b>~/netology/task13.2</b></font>$ kubectl -it exec backend-86b46fc569-fldjz backend -n production -- bash
root@backend-86b46fc569-fldjz:/# ls
bin  boot  data  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  <font color="red">static</font>   sys  tmp  usr  var
root@backend-86b46fc569-fldjz:/# cat static/1.txt
hello world

</pre>