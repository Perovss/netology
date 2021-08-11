1. Задача №1
Ссылка на [манифест](https://github.com/Perovss/netology/blob/master/task13.1/task1.yaml)

Pods
```
serge@Lenovo:~/netology/task13.1$ kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
netology   3/3     Running   0          20s
```
Service
```
serge@Lenovo:~/netology/task13.1$ kubectl get service
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
db           ClusterIP   10.110.252.186   <none>        5432/TCP   3m44s
frontend     ClusterIP   10.99.75.139     <none>        8000/TCP   3m44s
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP    3d9h

```
Ingress
```
serge@Lenovo:~/netology/task13.1$ kubectl get ingress
NAME               CLASS    HOSTS          ADDRESS        PORTS   AGE
frontend-ingress   <none>   help.example   192.168.58.2   80      6m18s
```


2. Задача №2
Ссылка на [манифест](https://github.com/Perovss/netology/blob/master/task13.1/task2.yaml)

Pods
```
serge@Lenovo:~/netology/task13.1$ kubectl get pods
NAME                                  READY   STATUS    RESTARTS   AGE
backend-57bfb6bc48-pkscq              1/1     Running   1          31m
backend-57bfb6bc48-t2clw              1/1     Running   1          31m
backend-57bfb6bc48-w7q4t              1/1     Running   1          31m
frontend-84bd998c99-b87j2             1/1     Running   1          31m
frontend-84bd998c99-k8wtp             1/1     Running   1          31m
frontend-84bd998c99-zc9gp             1/1     Running   1          31m
postgres-0                            1/1     Running   1          31m

```
Service
```
serge@Lenovo:~/netology/netology/task13.1$ kubectl get service
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
backend      ClusterIP   10.103.121.123   <none>        9000/TCP   26m
db           ClusterIP   10.107.77.238    <none>        5432/TCP   26m
frontend     ClusterIP   10.106.201.74    <none>        8000/TCP   26m
```
Ingress
```
serge@Lenovo:~/netology/netology/task13.1$ kubectl get ingress
NAME               CLASS    HOSTS              ADDRESS        PORTS   AGE
frontend-ingress   <none>   netology.example   192.168.58.2   80      27m
```
Deployment
```
serge@Lenovo:~/netology/netology/task13.1$ kubectl get deployments
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
backend    1/1     1            1           49m
frontend   1/1     1            1           49m
```
Statefulset
```
serge@Lenovo:~/netology/netology/task13.1$ kubectl get statefulsets
NAME       READY   AGE
postgres   1/1     50m
```
