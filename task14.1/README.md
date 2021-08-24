# Домашнее задание к занятию "14.1 Создание и использование секретов"

## Задача 1: Работа с секретами через утилиту kubectl в установленном minikube

Выполните приведённые ниже команды в консоли, получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать секрет?

```
openssl genrsa -out cert.key 4096
openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
```
## **Ответ**

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ openssl genrsa -out cert.key 4096
Generating RSA private key, 4096 bit long modulus (2 primes)
.....................++++
.................++++
e is 65537 (0x010001)
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj &apos;/C=RU/ST=Moscow/L=Moscow/CN=server.local&apos;
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl create secret tls domain-cert --cert=cert.crt --key=cert.key
secret/domain-cert created
</pre>

### Как просмотреть список секретов?

```
kubectl get secrets
kubectl get secret
```
## **Ответ**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl get secrets
NAME                                            TYPE                                  DATA   AGE
default-token-szmgj                             kubernetes.io/service-account-token   3      16d
domain-cert                                     kubernetes.io/tls                     2      4m3s
nfs-server-nfs-server-provisioner-token-77vrx   kubernetes.io/service-account-token   3      12d
sh.helm.release.v1.nfs-server.v1                helm.sh/release.v1                    1      12d
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl get secret
NAME                                            TYPE                                  DATA   AGE
default-token-szmgj                             kubernetes.io/service-account-token   3      16d
domain-cert                                     kubernetes.io/tls                     2      4m28s
nfs-server-nfs-server-provisioner-token-77vrx   kubernetes.io/service-account-token   3      12d
sh.helm.release.v1.nfs-server.v1                helm.sh/release.v1                    1      12d
</pre>

### Как просмотреть секрет?

```
kubectl get secret domain-cert
kubectl describe secret domain-cert
```
## **Ответ**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl get secret domain-cert
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      5m41s
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl describe secret domain-cert
Name:         domain-cert
Namespace:    default
Labels:       &lt;none&gt;
Annotations:  &lt;none&gt;

Type:  kubernetes.io/tls

Data
====
tls.crt:  1944 bytes
tls.key:  3243 bytes
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ 
</pre>

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get secret domain-cert -o yaml
kubectl get secret domain-cert -o json
```
## **Ответ**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl get secret domain-cert -o yaml
apiVersion: v1
data:
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVWFNqV1BOdlg4WmN1YURXa3NZbTZ1QXFVSmpjd0RRWUpLb1pJaHZjTkFRRUwKQlFBd1JqRUxNQWtHQTFVRUJoTUNVbFV4RHpBTkJnTlZCQWdNQmsxdmMyTnZkekVQTUEwR0ExVUVCd3dHVFc5egpZMjkzTVJVd0V3WURWUVFEREF4elpYSjJaWEl1Ykc5allXd3dIaGNOTWpFd09ESTBNVE15T1RNeFdoY05NekV3Ck9ESXlNVE15T1RNeFdqQkdNUXN3Q1FZRFZRUUdFd0pTVlRFUE1BMEdBMVVFQ0F3R1RXOXpZMjkzTVE4d0RRWUQKVlFRSERBWk5iM05qYjNjeEZUQVRCZ05WQkFNTURITmxjblpsY2k1c2IyTmhiRENDQWlJd0RRWUpLb1pJaHZjTgpBUUVCQlFBRGdnSVBBRENDQWdvQ2dnSUJBTU4wMlVYUlhzM2tIT2sxYnBIaFdOWTNmZ0w5UFBSc0RtUkd3Qk1pCmtzcnI2UHM2MzhjTGhJQ0JldUpzZkJQZktMV2o0bXN4SEhLMm9DWmZOMmtabGtLUXllbzRmUko5UXVFU3prUTUKdTlYWm9WQVJiK3NwOHRmNllRUGRtaWlRU2lhTXpCSjZ6em00ZEhHSmJFclMyVnpIMFhpdlFXWmw3bm5OQ2VaOApSdGNlTHZMZFdIalIxRC8rV1VZUXVhcFl3Z3JqZlV2NnozVmczMFVJbzdMSitKSFhMYUpRb0FScTIzZnFkZ2NrCnhSandodFk3MWVVK1p3azdBV3F4SUZVZDRNN00vL3oxYk03YzhoV2VJbGxDelI5SlZGZXdsY05XRHg2M081cUgKUVBSNm9obEdmNm9qZTc0d3MrR3BLOFlYOGJ2ZVJ0d3VPRGc3b05COVZRbzREU3Z0OVlHenlqVEJnMW84Y0pSYQpSOElMYWVrY2hjTXUyVVVnazdKQXJ1QVI5SktleWxYNk40ZEtkUjE1b1pSNkt2UnQ0cmZLTWVoNXJVb3ZHeHRyCjhxa1dYN0JZNlQ5Zlc4YTBJN2RxNXhraVk5a21Dc0ZDQlFpamVaOFVrRUcwenlLNFVjbWI0dVlNWEg3QWQrTkwKY2N3clVzY0Rzb1BJcHBScDdVRDVUS04rTmFHZzhJdVNTSW80YVVMS25BeFFZUit6VSswcjZYajRhSHFuTE5LRgpEcm9wYWs4VDBzZkFoek5kcE1CMElEQ2YwUjdibDIvT3FzM2xPNGpkZzFkcEpuS01BRy8veWx2Q0VJUVFhYXlZCjBDa21mU1hIN2sxdGZFYlNpRU84VWdGT1NIT2t0TGFmeUtVWnAxTHR2VGk5eit5MFRCR2lGZ0hCWThhZ1JYeXkKcGRHZkFnTUJBQUdqVXpCUk1CMEdBMVVkRGdRV0JCUXVOUVdZM242VElDYmo5QWR2cEcxRUt4TVdBVEFmQmdOVgpIU01FR0RBV2dCUXVOUVdZM242VElDYmo5QWR2cEcxRUt4TVdBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQTBHCkNTcUdTSWIzRFFFQkN3VUFBNElDQVFCSEY1R2VBMlZidFBDV3E2dk9EdURkWnhvcWs1Wkp2VUlvcUk2Slo2Y3UKczQ2bWxSMTJ5dGlOSU9qOGlGWlVlaXgyMEpuNTI5MzJXcENkbUNxalRiRXIvOUNrYUYrb1gvL2t0MzJDcEJwRwpkTE4zdXZPbFBTaUNTS3UrVFJoQUNvTTZWdzhhbGN5cy9MYlFvb2Z5eXl6MzdiKy9HNEMwQktiS2t6L21laEZOCmMzQzdBWXp3cHpOa1Rpcys3bVphbUNLVEdzakd0cjRSanJRRmg1YXJuWnV5L2JvM1pSeHEzTTdMNEhyb3BPdnEKWldPSm5NY09oOWV3NHRXYmVyNXUveThrb2R6alhycEErQzZVSHhmVEtYeUttMWZvNkJFS3lkOHM5Nll4L3FKRwpDWVBOTitKeDB1aWJzWXFsWWMycURyZnZjME5rTzVYUjh1MEthVVJJc0tVdjJZYU5NdFdER3paMVJ0UGV1emxECnpwS0orMENJTG1ITXNBeGFlY2w2YTBPcG1ScUFDd1gvRW1Ea1VDVk9FdmdXQWZ3K0FIbUhPN1hMWVBzNjZMc3IKVjFqU2kxbmsyZFVQL2lKV3VYcUVWakZNUTJjaTVXMU92U0VUTXBxSmRUUWIyWnF0NisyVDdhUDNoUUl0R1Juagp4T044eVNGaUZKZU1JbXBXcDZzaWk3TmZGK2N1T0NLSDJ2bjY3VzFobTVwMFdYUnpTMmRNeXhCbXhqYzNtL0h5CktGazRXTnlwSTkzdi9zcG4xMk5KUkUrQWhpd1ppNmVTbFYvalFNQ1N2MXFZeVZkZCtjSnVsZ3VZWUx1NlJyVTkKY1h3ZmdtL2htUEtUTC90YmZtdEVSVzRERFFtcEVYR25xRXBUOWlLa2pwTkhVRDhidFRoVUJGRFVVbjExYTNGWQpZQT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
  tls.key: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKSndJQkFBS0NBZ0VBdzNUWlJkRmV6ZVFjNlRWdWtlRlkxamQrQXYwODlHd09aRWJBRXlLU3l1dm8renJmCnh3dUVnSUY2NG14OEU5OG90YVBpYXpFY2NyYWdKbDgzYVJtV1FwREo2amg5RW4xQzRSTE9SRG03MWRtaFVCRnYKNnlueTEvcGhBOTJhS0pCS0pvek1FbnJQT2JoMGNZbHNTdExaWE1mUmVLOUJabVh1ZWMwSjVueEcxeDR1OHQxWQplTkhVUC81WlJoQzVxbGpDQ3VOOVMvclBkV0RmUlFpanNzbjRrZGN0b2xDZ0JHcmJkK3AyQnlURkdQQ0cxanZWCjVUNW5DVHNCYXJFZ1ZSM2d6c3ovL1BWc3p0enlGWjRpV1VMTkgwbFVWN0NWdzFZUEhyYzdtb2RBOUhxaUdVWi8KcWlON3ZqQ3o0YWtyeGhmeHU5NUczQzQ0T0R1ZzBIMVZDamdOSyszMWdiUEtOTUdEV2p4d2xGcEh3Z3RwNlJ5Rgp3eTdaUlNDVHNrQ3U0Qkgwa3A3S1ZmbzNoMHAxSFhtaGxIb3E5RzNpdDhveDZIbXRTaThiRzJ2eXFSWmZzRmpwClAxOWJ4clFqdDJybkdTSmoyU1lLd1VJRkNLTjVueFNRUWJUUElyaFJ5WnZpNWd4Y2ZzQjM0MHR4ekN0U3h3T3kKZzhpbWxHbnRRUGxNbzM0MW9hRHdpNUpJaWpocFFzcWNERkJoSDdOVDdTdnBlUGhvZXFjczBvVU91aWxxVHhQUwp4OENITTEya3dIUWdNSi9SSHR1WGI4NnF6ZVU3aU4yRFYya21jb3dBYi8vS1c4SVFoQkJwckpqUUtTWjlKY2Z1ClRXMThSdEtJUTd4U0FVNUljNlMwdHAvSXBSbW5VdTI5T0wzUDdMUk1FYUlXQWNGanhxQkZmTEtsMFo4Q0F3RUEKQVFLQ0FnQU54RVVwYmIzSHNyRjJtNVRXSVpFb1JYQlN0Wk45Zzc3ZndUdjJIUkZKeWFQM1RnWkU5c0syYW1oRgpXbTdDMTR6K2ZqU01hRUVnczB4RVo2QjNmcDNld21QMlkxUXI0VGE4czU1am44MWpHcGtLRXJCWFYvVUswVS9UCi9kL0Z5NlB0WXkxY2Y5bm9ydDFFd2ZFbXRBTXJUY2VyUUd6UzBZc2llUmFoYlU5d0IyZzNJdkFBVW9jb21ybWUKL2I2V0NQcGgyZlFSVGZFZXkxdnVlTlZPMm5ydmlzQmtGbG11OWZmUFVteE54SUU5YUhPVzAxQVZmWGUwWnJ1SwowRDcrdjhQOXpPS2E1bzVyWTVTSmdVSGFGNkpxK2JjL0ZlajJnVEUvY0poNklkeXBXNW5mUGQvd0U5KzdYYUxOCjJpU0RKMXlYWnVpR3lacWNHMWNRV0VPTkhMV1Fxd0lPRjE5YU1aSEtkYjhMUkxIZGpkMGRtNndTTDlGTzhOa3AKaUNNdFk1UU8xRTh0bnFHby9JWjlob0dNT2JNaGg2MkxmQ2RWR2RYaTRmdnB6SjhubjRyc0MxZkVyQ2IwNWJQdwp3dkZGUGp6Uk01OGNjdWtiTTZ6SExyUmhlbVRRVnVnVTR2NHVGRksyUUx5TEU5MUhZV20zcjlNWU0vVkRBZGRoCjhRZVNkdHgxRmsxOGpkMC9MVWRQbDk1Wm5BSGhySmFHd3V4d1dNdHNQNWlDUVRVR2xTVExnWWhvazAwNXdmaXoKSTgwd0hIVWxna01KYit2U3BPNDJaT2hNcHREdGFMTWt2dm5OVnRISlNabzYzODIxb01QWTEwSkhjNUlrbWRPdApnOGxRbEdwMVJVdUNNM0pzZWVqZ3VZSzZhMS9uTXFJMlB6d1JLb3hYNUl6YmdDYmJ3UUtDQVFFQTU5cVpTa3FUCnE5bmJQZis3bDJzbFEvSHFmc2ltUVlvZjFQa0MwSHpPdDlFN3U1QW0xRlFSc2pSYi82cW5DYy81ZUpqWGVrbHYKNmNDNERCZFVkZFdwWld4eTVTQjAwajRWaVdjV0dEODUwdCtoRXNnR0tOalNZS1JyOGVBN3RPdjgvbXdDNkhuQgpwUU9rL012S2ZtN0NjUENCL3htdEVrU3FFbk9HTjlqUjZJMmkxK1VKYWtndzErcDM5eFJRUUxIeHZ5U2RiVkZiCkRWaXI3VVdWY1NoaDA2ZlR3c3dtSDZYY2gvMTdPMHdKN3cya1JiU205V3p0R2JhWCtxZHFvOExvbVE4RUp5aW8KVlYvd2NXL2lnUUdkS040aVpGNHovOUM3YTVKb0lrN1lMa3pHSEZuZ3ZSNnhoSjZBa1IxMzZiMEx2ZG1kZU5NQQpFTTNlOEUyWGg5N05Pd0tDQVFFQTE4L2RyMHdUZ0YzWkZkOUQ3RWhNN3M3REhzRTVqTmFKQUo0YVNxcHd6NkduCkxCbXdZTy9uUnFWYkozNFl2U1dQYnVnWHJWMzVtMHRCWlRCZzR2dDg0U3RqUXNUTUc4Y2VEV2hxMEJwVWQ4Yk4KSUJ3Z2xteW1QdGRDZUpBUm1tRnhZMXVWU0ZDdVAxOWM1cEZEMElxZlVaMnBNK3A1SmxRNENOQUpRMTF3ODFUUApLTHhnUUUyMmFKQzJkbmtDNnh3Q0hXOTFZRnVZaHBVUzRuVWNtQ2VUcXNJQWd2R3BhS2ZURzU0ZENxc2R1Y29HCllDdkpJTk5CQjgrOHphS2F2WWwxNUxiL2VPRG9ML1J6N3FSYkQ4blBFZkxIVWhZcEU0UU1Tb3krV1UwREdFV3QKaTl4cWt2MWQwdG9XLzdSalVZRTJBZWVJN3dNWVpOcjdtbWlWNmxCVzdRS0NBUUFPdjdncW9xM2NLOEtub2dJRAo4dHZ2QTQrZ094RmdiL0h3Y1ZxOWVvTUg3SFo1U3dVOVVvL0JuMVVPNFlNNHU1TXFHY2J6VDRLZ0F4TnlLWFhFCi9TK0dkU3lsNkxlbHZDOVFpMDg3Z2FJakNQak5JZzVLUU9pNUh4eUN5WG5pMjNRL2x3MWtUb0tFQmNSVUZINncKSmttV042WjlYTnZHb3JtUzdPaG4yeElYVWhNKzJxSUxzY1h4cGtlMVh3UnY2U0h3djlxSDNyb0ZFbFAxaHd5bgpveUw5L05vYXRUUGpwWUJ1NGpBWnFJK2xObC94MHprZnVhc25qSmNFYWV2OXVPTmxBVENKY1N1c0txczMvQjhUCmg4L0Fqc2p2UzVMUlBpejkvZFZFQVhIOUdBTXVRSVZzWW14MmZFSy9lSGx0VkFwUUxHeTVCK3NrSm9SOUV1S0YKMFNXTEFvSUJBR05JaDg0TGk3VTBkNWh1WEVzcGYrc2xSL0t3SmcrNjZ0QlQ2L2lKck5oNG4vWFQ0NmJVOTJzeQp5MXJCMGhQQ1lkZytBaGFKOHprVVNBT0xYQ2RRVjBVbnRzU1MwT3Ura1A3T0dNV2dOMWZiSjZjc0NYbnFoaGpHCjR4ZWYvOWtzRndRRXNBclN3emI0WWo3WWVZQkpKYjVnYitVb2E0L01rdkxLOGxnQmR1TWJFeXJFYnV0bVZSS0oKOE1kVUtKbU5DeFFMb000eGxWdmszUWs5bzJnRVhSVGpwMlNXVkwrRzVjSUEzWTk0NVhZQmtTbFJPM2hVZDhobQpNNC9PeksyQnZiRDQxMUwrOVJLS3ZZTCtMYjUzczBHb2xUWVlaOUZJb0hiemhPYUVYWFlmS0JYOTB6SElTZytrCnNZdjFxdk5tSkRpQUVpa1RIWGZZbm9PTXRkdFVGb2tDZ2dFQUxodVdmcTVuOTR6Mlg1bFYrR2MyN1R1S1gwcVEKZXdwSEdFd05YeEFqRGFxYURlWVZrNGRBU05xMkdubngwWk9aWXlUb3JSOTlaYmFBOFg5OXV3U0ZSMXhhSVNOegpSZlJ0VW92azA2ZlBBSUlQWFpuVmJUYkQvd0wycXdnYUV0MEt1VlR5aGNmd0VMNVJsV1BiRmM5OGpoK2J2VmlxClFFOC95T0pPczZtU005QU9qZDRMY21xL2dYaTByT3d6RHQ5ZXpYVEhmZ2lmMFBvbEtGendncXp5UnFES2tmT0cKbFdGUnNiaFpRL2x2RkQ4SzFobFlLemExR0ZLSk80NFp5ZGI4QUdUM3hwMFR3UlhwdmFGRG85R1pzNG9raU9PTwpockt6N0I3ejN4bnRRRWZ6K3BwNk0vcWsvMGJvYWZCTEh1MEZVcXFLS05NUUE3NFlCUFZvTUlranZ3PT0KLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K
kind: Secret
metadata:
  creationTimestamp: &quot;2021-08-24T13:30:34Z&quot;
  name: domain-cert
  namespace: default
  resourceVersion: &quot;287623&quot;
  uid: 0f556cc0-4308-41ad-939b-c6df737b80b1
type: kubernetes.io/tls
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl get secret domain-cert -o json
{
    &quot;apiVersion&quot;: &quot;v1&quot;,
    &quot;data&quot;: {
        &quot;tls.crt&quot;: &quot;LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVWFNqV1BOdlg4WmN1YURXa3NZbTZ1QXFVSmpjd0RRWUpLb1pJaHZjTkFRRUwKQlFBd1JqRUxNQWtHQTFVRUJoTUNVbFV4RHpBTkJnTlZCQWdNQmsxdmMyTnZkekVQTUEwR0ExVUVCd3dHVFc5egpZMjkzTVJVd0V3WURWUVFEREF4elpYSjJaWEl1Ykc5allXd3dIaGNOTWpFd09ESTBNVE15T1RNeFdoY05NekV3Ck9ESXlNVE15T1RNeFdqQkdNUXN3Q1FZRFZRUUdFd0pTVlRFUE1BMEdBMVVFQ0F3R1RXOXpZMjkzTVE4d0RRWUQKVlFRSERBWk5iM05qYjNjeEZUQVRCZ05WQkFNTURITmxjblpsY2k1c2IyTmhiRENDQWlJd0RRWUpLb1pJaHZjTgpBUUVCQlFBRGdnSVBBRENDQWdvQ2dnSUJBTU4wMlVYUlhzM2tIT2sxYnBIaFdOWTNmZ0w5UFBSc0RtUkd3Qk1pCmtzcnI2UHM2MzhjTGhJQ0JldUpzZkJQZktMV2o0bXN4SEhLMm9DWmZOMmtabGtLUXllbzRmUko5UXVFU3prUTUKdTlYWm9WQVJiK3NwOHRmNllRUGRtaWlRU2lhTXpCSjZ6em00ZEhHSmJFclMyVnpIMFhpdlFXWmw3bm5OQ2VaOApSdGNlTHZMZFdIalIxRC8rV1VZUXVhcFl3Z3JqZlV2NnozVmczMFVJbzdMSitKSFhMYUpRb0FScTIzZnFkZ2NrCnhSandodFk3MWVVK1p3azdBV3F4SUZVZDRNN00vL3oxYk03YzhoV2VJbGxDelI5SlZGZXdsY05XRHg2M081cUgKUVBSNm9obEdmNm9qZTc0d3MrR3BLOFlYOGJ2ZVJ0d3VPRGc3b05COVZRbzREU3Z0OVlHenlqVEJnMW84Y0pSYQpSOElMYWVrY2hjTXUyVVVnazdKQXJ1QVI5SktleWxYNk40ZEtkUjE1b1pSNkt2UnQ0cmZLTWVoNXJVb3ZHeHRyCjhxa1dYN0JZNlQ5Zlc4YTBJN2RxNXhraVk5a21Dc0ZDQlFpamVaOFVrRUcwenlLNFVjbWI0dVlNWEg3QWQrTkwKY2N3clVzY0Rzb1BJcHBScDdVRDVUS04rTmFHZzhJdVNTSW80YVVMS25BeFFZUit6VSswcjZYajRhSHFuTE5LRgpEcm9wYWs4VDBzZkFoek5kcE1CMElEQ2YwUjdibDIvT3FzM2xPNGpkZzFkcEpuS01BRy8veWx2Q0VJUVFhYXlZCjBDa21mU1hIN2sxdGZFYlNpRU84VWdGT1NIT2t0TGFmeUtVWnAxTHR2VGk5eit5MFRCR2lGZ0hCWThhZ1JYeXkKcGRHZkFnTUJBQUdqVXpCUk1CMEdBMVVkRGdRV0JCUXVOUVdZM242VElDYmo5QWR2cEcxRUt4TVdBVEFmQmdOVgpIU01FR0RBV2dCUXVOUVdZM242VElDYmo5QWR2cEcxRUt4TVdBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQTBHCkNTcUdTSWIzRFFFQkN3VUFBNElDQVFCSEY1R2VBMlZidFBDV3E2dk9EdURkWnhvcWs1Wkp2VUlvcUk2Slo2Y3UKczQ2bWxSMTJ5dGlOSU9qOGlGWlVlaXgyMEpuNTI5MzJXcENkbUNxalRiRXIvOUNrYUYrb1gvL2t0MzJDcEJwRwpkTE4zdXZPbFBTaUNTS3UrVFJoQUNvTTZWdzhhbGN5cy9MYlFvb2Z5eXl6MzdiKy9HNEMwQktiS2t6L21laEZOCmMzQzdBWXp3cHpOa1Rpcys3bVphbUNLVEdzakd0cjRSanJRRmg1YXJuWnV5L2JvM1pSeHEzTTdMNEhyb3BPdnEKWldPSm5NY09oOWV3NHRXYmVyNXUveThrb2R6alhycEErQzZVSHhmVEtYeUttMWZvNkJFS3lkOHM5Nll4L3FKRwpDWVBOTitKeDB1aWJzWXFsWWMycURyZnZjME5rTzVYUjh1MEthVVJJc0tVdjJZYU5NdFdER3paMVJ0UGV1emxECnpwS0orMENJTG1ITXNBeGFlY2w2YTBPcG1ScUFDd1gvRW1Ea1VDVk9FdmdXQWZ3K0FIbUhPN1hMWVBzNjZMc3IKVjFqU2kxbmsyZFVQL2lKV3VYcUVWakZNUTJjaTVXMU92U0VUTXBxSmRUUWIyWnF0NisyVDdhUDNoUUl0R1Juagp4T044eVNGaUZKZU1JbXBXcDZzaWk3TmZGK2N1T0NLSDJ2bjY3VzFobTVwMFdYUnpTMmRNeXhCbXhqYzNtL0h5CktGazRXTnlwSTkzdi9zcG4xMk5KUkUrQWhpd1ppNmVTbFYvalFNQ1N2MXFZeVZkZCtjSnVsZ3VZWUx1NlJyVTkKY1h3ZmdtL2htUEtUTC90YmZtdEVSVzRERFFtcEVYR25xRXBUOWlLa2pwTkhVRDhidFRoVUJGRFVVbjExYTNGWQpZQT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K&quot;,
        &quot;tls.key&quot;: &quot;LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKSndJQkFBS0NBZ0VBdzNUWlJkRmV6ZVFjNlRWdWtlRlkxamQrQXYwODlHd09aRWJBRXlLU3l1dm8renJmCnh3dUVnSUY2NG14OEU5OG90YVBpYXpFY2NyYWdKbDgzYVJtV1FwREo2amg5RW4xQzRSTE9SRG03MWRtaFVCRnYKNnlueTEvcGhBOTJhS0pCS0pvek1FbnJQT2JoMGNZbHNTdExaWE1mUmVLOUJabVh1ZWMwSjVueEcxeDR1OHQxWQplTkhVUC81WlJoQzVxbGpDQ3VOOVMvclBkV0RmUlFpanNzbjRrZGN0b2xDZ0JHcmJkK3AyQnlURkdQQ0cxanZWCjVUNW5DVHNCYXJFZ1ZSM2d6c3ovL1BWc3p0enlGWjRpV1VMTkgwbFVWN0NWdzFZUEhyYzdtb2RBOUhxaUdVWi8KcWlON3ZqQ3o0YWtyeGhmeHU5NUczQzQ0T0R1ZzBIMVZDamdOSyszMWdiUEtOTUdEV2p4d2xGcEh3Z3RwNlJ5Rgp3eTdaUlNDVHNrQ3U0Qkgwa3A3S1ZmbzNoMHAxSFhtaGxIb3E5RzNpdDhveDZIbXRTaThiRzJ2eXFSWmZzRmpwClAxOWJ4clFqdDJybkdTSmoyU1lLd1VJRkNLTjVueFNRUWJUUElyaFJ5WnZpNWd4Y2ZzQjM0MHR4ekN0U3h3T3kKZzhpbWxHbnRRUGxNbzM0MW9hRHdpNUpJaWpocFFzcWNERkJoSDdOVDdTdnBlUGhvZXFjczBvVU91aWxxVHhQUwp4OENITTEya3dIUWdNSi9SSHR1WGI4NnF6ZVU3aU4yRFYya21jb3dBYi8vS1c4SVFoQkJwckpqUUtTWjlKY2Z1ClRXMThSdEtJUTd4U0FVNUljNlMwdHAvSXBSbW5VdTI5T0wzUDdMUk1FYUlXQWNGanhxQkZmTEtsMFo4Q0F3RUEKQVFLQ0FnQU54RVVwYmIzSHNyRjJtNVRXSVpFb1JYQlN0Wk45Zzc3ZndUdjJIUkZKeWFQM1RnWkU5c0syYW1oRgpXbTdDMTR6K2ZqU01hRUVnczB4RVo2QjNmcDNld21QMlkxUXI0VGE4czU1am44MWpHcGtLRXJCWFYvVUswVS9UCi9kL0Z5NlB0WXkxY2Y5bm9ydDFFd2ZFbXRBTXJUY2VyUUd6UzBZc2llUmFoYlU5d0IyZzNJdkFBVW9jb21ybWUKL2I2V0NQcGgyZlFSVGZFZXkxdnVlTlZPMm5ydmlzQmtGbG11OWZmUFVteE54SUU5YUhPVzAxQVZmWGUwWnJ1SwowRDcrdjhQOXpPS2E1bzVyWTVTSmdVSGFGNkpxK2JjL0ZlajJnVEUvY0poNklkeXBXNW5mUGQvd0U5KzdYYUxOCjJpU0RKMXlYWnVpR3lacWNHMWNRV0VPTkhMV1Fxd0lPRjE5YU1aSEtkYjhMUkxIZGpkMGRtNndTTDlGTzhOa3AKaUNNdFk1UU8xRTh0bnFHby9JWjlob0dNT2JNaGg2MkxmQ2RWR2RYaTRmdnB6SjhubjRyc0MxZkVyQ2IwNWJQdwp3dkZGUGp6Uk01OGNjdWtiTTZ6SExyUmhlbVRRVnVnVTR2NHVGRksyUUx5TEU5MUhZV20zcjlNWU0vVkRBZGRoCjhRZVNkdHgxRmsxOGpkMC9MVWRQbDk1Wm5BSGhySmFHd3V4d1dNdHNQNWlDUVRVR2xTVExnWWhvazAwNXdmaXoKSTgwd0hIVWxna01KYit2U3BPNDJaT2hNcHREdGFMTWt2dm5OVnRISlNabzYzODIxb01QWTEwSkhjNUlrbWRPdApnOGxRbEdwMVJVdUNNM0pzZWVqZ3VZSzZhMS9uTXFJMlB6d1JLb3hYNUl6YmdDYmJ3UUtDQVFFQTU5cVpTa3FUCnE5bmJQZis3bDJzbFEvSHFmc2ltUVlvZjFQa0MwSHpPdDlFN3U1QW0xRlFSc2pSYi82cW5DYy81ZUpqWGVrbHYKNmNDNERCZFVkZFdwWld4eTVTQjAwajRWaVdjV0dEODUwdCtoRXNnR0tOalNZS1JyOGVBN3RPdjgvbXdDNkhuQgpwUU9rL012S2ZtN0NjUENCL3htdEVrU3FFbk9HTjlqUjZJMmkxK1VKYWtndzErcDM5eFJRUUxIeHZ5U2RiVkZiCkRWaXI3VVdWY1NoaDA2ZlR3c3dtSDZYY2gvMTdPMHdKN3cya1JiU205V3p0R2JhWCtxZHFvOExvbVE4RUp5aW8KVlYvd2NXL2lnUUdkS040aVpGNHovOUM3YTVKb0lrN1lMa3pHSEZuZ3ZSNnhoSjZBa1IxMzZiMEx2ZG1kZU5NQQpFTTNlOEUyWGg5N05Pd0tDQVFFQTE4L2RyMHdUZ0YzWkZkOUQ3RWhNN3M3REhzRTVqTmFKQUo0YVNxcHd6NkduCkxCbXdZTy9uUnFWYkozNFl2U1dQYnVnWHJWMzVtMHRCWlRCZzR2dDg0U3RqUXNUTUc4Y2VEV2hxMEJwVWQ4Yk4KSUJ3Z2xteW1QdGRDZUpBUm1tRnhZMXVWU0ZDdVAxOWM1cEZEMElxZlVaMnBNK3A1SmxRNENOQUpRMTF3ODFUUApLTHhnUUUyMmFKQzJkbmtDNnh3Q0hXOTFZRnVZaHBVUzRuVWNtQ2VUcXNJQWd2R3BhS2ZURzU0ZENxc2R1Y29HCllDdkpJTk5CQjgrOHphS2F2WWwxNUxiL2VPRG9ML1J6N3FSYkQ4blBFZkxIVWhZcEU0UU1Tb3krV1UwREdFV3QKaTl4cWt2MWQwdG9XLzdSalVZRTJBZWVJN3dNWVpOcjdtbWlWNmxCVzdRS0NBUUFPdjdncW9xM2NLOEtub2dJRAo4dHZ2QTQrZ094RmdiL0h3Y1ZxOWVvTUg3SFo1U3dVOVVvL0JuMVVPNFlNNHU1TXFHY2J6VDRLZ0F4TnlLWFhFCi9TK0dkU3lsNkxlbHZDOVFpMDg3Z2FJakNQak5JZzVLUU9pNUh4eUN5WG5pMjNRL2x3MWtUb0tFQmNSVUZINncKSmttV042WjlYTnZHb3JtUzdPaG4yeElYVWhNKzJxSUxzY1h4cGtlMVh3UnY2U0h3djlxSDNyb0ZFbFAxaHd5bgpveUw5L05vYXRUUGpwWUJ1NGpBWnFJK2xObC94MHprZnVhc25qSmNFYWV2OXVPTmxBVENKY1N1c0txczMvQjhUCmg4L0Fqc2p2UzVMUlBpejkvZFZFQVhIOUdBTXVRSVZzWW14MmZFSy9lSGx0VkFwUUxHeTVCK3NrSm9SOUV1S0YKMFNXTEFvSUJBR05JaDg0TGk3VTBkNWh1WEVzcGYrc2xSL0t3SmcrNjZ0QlQ2L2lKck5oNG4vWFQ0NmJVOTJzeQp5MXJCMGhQQ1lkZytBaGFKOHprVVNBT0xYQ2RRVjBVbnRzU1MwT3Ura1A3T0dNV2dOMWZiSjZjc0NYbnFoaGpHCjR4ZWYvOWtzRndRRXNBclN3emI0WWo3WWVZQkpKYjVnYitVb2E0L01rdkxLOGxnQmR1TWJFeXJFYnV0bVZSS0oKOE1kVUtKbU5DeFFMb000eGxWdmszUWs5bzJnRVhSVGpwMlNXVkwrRzVjSUEzWTk0NVhZQmtTbFJPM2hVZDhobQpNNC9PeksyQnZiRDQxMUwrOVJLS3ZZTCtMYjUzczBHb2xUWVlaOUZJb0hiemhPYUVYWFlmS0JYOTB6SElTZytrCnNZdjFxdk5tSkRpQUVpa1RIWGZZbm9PTXRkdFVGb2tDZ2dFQUxodVdmcTVuOTR6Mlg1bFYrR2MyN1R1S1gwcVEKZXdwSEdFd05YeEFqRGFxYURlWVZrNGRBU05xMkdubngwWk9aWXlUb3JSOTlaYmFBOFg5OXV3U0ZSMXhhSVNOegpSZlJ0VW92azA2ZlBBSUlQWFpuVmJUYkQvd0wycXdnYUV0MEt1VlR5aGNmd0VMNVJsV1BiRmM5OGpoK2J2VmlxClFFOC95T0pPczZtU005QU9qZDRMY21xL2dYaTByT3d6RHQ5ZXpYVEhmZ2lmMFBvbEtGendncXp5UnFES2tmT0cKbFdGUnNiaFpRL2x2RkQ4SzFobFlLemExR0ZLSk80NFp5ZGI4QUdUM3hwMFR3UlhwdmFGRG85R1pzNG9raU9PTwpockt6N0I3ejN4bnRRRWZ6K3BwNk0vcWsvMGJvYWZCTEh1MEZVcXFLS05NUUE3NFlCUFZvTUlranZ3PT0KLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K&quot;
    },
    &quot;kind&quot;: &quot;Secret&quot;,
    &quot;metadata&quot;: {
        &quot;creationTimestamp&quot;: &quot;2021-08-24T13:30:34Z&quot;,
        &quot;name&quot;: &quot;domain-cert&quot;,
        &quot;namespace&quot;: &quot;default&quot;,
        &quot;resourceVersion&quot;: &quot;287623&quot;,
        &quot;uid&quot;: &quot;0f556cc0-4308-41ad-939b-c6df737b80b1&quot;
    },
    &quot;type&quot;: &quot;kubernetes.io/tls&quot;
}
</pre>


### Как выгрузить секрет и сохранить его в файл?

```
kubectl get secrets -o json > secrets.json
kubectl get secret domain-cert -o yaml > domain-cert.yml
```
## **Ответ**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl get secrets -o json &gt; secrets.json
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl get secret domain-cert -o yaml &gt; domain-cert.yml
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ ls -la
итого 68
drwxrwxr-x  2 serge serge  4096 авг 24 16:41 <font color="#12488B"><b>.</b></font>
drwxr-xr-x 93 serge serge 12288 авг 24 16:20 <font color="#12488B"><b>..</b></font>
-rw-rw-r--  1 serge serge  1944 авг 24 16:29 cert.crt
-rw-------  1 serge serge  3243 авг 24 16:20 cert.key
-rw-rw-r--  1 serge serge  7165 авг 24 16:41 domain-cert.yml
-rw-rw-r--  1 serge serge 36618 авг 24 16:40 secrets.json
<font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ </pre>

### Как удалить секрет?

```
kubectl delete secret domain-cert
```
## **Ответ**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl delete secret domain-cert
secret &quot;domain-cert&quot; deleted</pre>

### Как загрузить секрет из файла?

```
kubectl apply -f domain-cert.yml
```
## **Ответ**
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/cert</b></font>$ kubectl apply -f domain-cert.yml
secret/domain-cert created
</pre>

