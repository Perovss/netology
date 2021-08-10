2. Задача №2
Ссылка на манифест
Pods
```
serge@Lenovo:~/netology/netology/task13.1$ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
backend-57bfb6bc48-rjtb8    1/1     Running   0          113s
frontend-84bd998c99-vnqds   1/1     Running   0          25m
postgres-0                  1/1     Running   0          25m
```
Service
```
serge@Lenovo:~/netology/netology/task13.1$ kubectl get service
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
backend      ClusterIP   10.103.121.123   <none>        9000/TCP   26m
db           ClusterIP   10.107.77.238    <none>        5432/TCP   26m
frontend     ClusterIP   10.106.201.74    <none>        8000/TCP   26m
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP    2d4h
```
Ingress
```
serge@Lenovo:~/netology/netology/task13.1$ kubectl get ingress
NAME               CLASS    HOSTS              ADDRESS        PORTS   AGE
frontend-ingress   <none>   netology.example   192.168.58.2   80      27m
```