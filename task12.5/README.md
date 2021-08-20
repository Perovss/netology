# Домашнее задание к занятию "12.5 Сетевые решения CNI"
> После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.

## Задание 1: установить в кластер CNI плагин Calico

> Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
> * установка производится через ansible/kubespray;
* после применения следует настроить политику доступа к hello world извне.

Добавим в инветарь inventory.ini модуль callico-rr
```
master ansible_host=192.168.0.228  ip=192.168.0.228
node01 ansible_host=192.168.0.142  ip=192.168.0.142 

[kube-master]
master

[etcd]
master

[kube_node]
node01

[calico-rr]

[k8s_cluster:children]
kube-master
kube_node
calico-rr
```

Далее добавим плагин балансировщик Ingress в invetory/group_vars/k8_cluster/addons.yml
ingress_nginx_enabled: true
плагин сети Calico invetory/group_vars/k8_cluster/k8_cluster.yml
kube_network_plugin: calico
## Задание 2: изучить, что запущено по умолчанию

> Самый простой способ — проверить командой calicoctl get <type>. Для проверки стоит получить список нод, ipPool и profile.
> Требования: 
> * установить утилиту calicoctl;
> * получить 3 вышеописанных типа в консоли.


<pre>root@master:/home/user# calicoctl version
Client Version:    v3.18.4
Git commit:        dabbf416
Cluster Version:   v3.18.4
Cluster Type:      kubespray,bgp,kubeadm,kdd,k8s
</pre>

<pre>root@master:/home/user# calicoctl get nodes
NAME     
master   
node01   
node02   
node03   
node04   
node05   
</pre>

<pre>root@master:/home/user# calicoctl get ipPool
NAME           CIDR             SELECTOR   
default-pool   10.233.64.0/18   all()  </pre>

<pre>root@master:/home/user# calicoctl get profile
NAME                                                 
projectcalico-default-allow                          
kns.default                                          
kns.ingress-nginx                                    
kns.kube-node-lease                                  
kns.kube-public                                      
kns.kube-system                                      
ksa.default.default                                  
ksa.ingress-nginx.default                            
ksa.ingress-nginx.ingress-nginx                      
ksa.kube-node-lease.default                          
ksa.kube-public.default                              
ksa.kube-system.attachdetach-controller              
ksa.kube-system.bootstrap-signer                     
ksa.kube-system.calico-kube-controllers              
ksa.kube-system.calico-node                          
ksa.kube-system.certificate-controller               
ksa.kube-system.clusterrole-aggregation-controller   
ksa.kube-system.coredns                              
ksa.kube-system.cronjob-controller                   
ksa.kube-system.daemon-set-controller                
ksa.kube-system.default                              
ksa.kube-system.deployment-controller                
ksa.kube-system.disruption-controller                
ksa.kube-system.dns-autoscaler                       
ksa.kube-system.endpoint-controller                  
ksa.kube-system.endpointslice-controller             
ksa.kube-system.endpointslicemirroring-controller    
ksa.kube-system.ephemeral-volume-controller          
ksa.kube-system.expand-controller                    
ksa.kube-system.generic-garbage-collector            
ksa.kube-system.horizontal-pod-autoscaler            
ksa.kube-system.job-controller                       
ksa.kube-system.kube-proxy                           
ksa.kube-system.local-volume-provisioner             
ksa.kube-system.namespace-controller                 
ksa.kube-system.node-controller                      
ksa.kube-system.nodelocaldns                         
ksa.kube-system.persistent-volume-binder             
ksa.kube-system.pod-garbage-collector                
ksa.kube-system.pv-protection-controller             
ksa.kube-system.pvc-protection-controller            
ksa.kube-system.replicaset-controller                
ksa.kube-system.replication-controller               
ksa.kube-system.resourcequota-controller             
ksa.kube-system.root-ca-cert-publisher               
ksa.kube-system.service-account-controller           
ksa.kube-system.service-controller                   
ksa.kube-system.statefulset-controller               
ksa.kube-system.token-cleaner                        
ksa.kube-system.ttl-after-finished-controller        
ksa.kube-system.ttl-controller </pre>