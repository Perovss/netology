# Домашнее задание к занятию "13.4 инструменты для упрощения написания конфигурационных файлов. Helm и Jsonnet"
> В работе часто приходится применять системы автоматической генерации конфигураций. Для изучения нюансов использования разных инструментов нужно попробовать упаковать приложение каждым из них.

## Задание 1: подготовить helm чарт для приложения
> Необходимо упаковать приложение в чарт для деплоя в разные окружения. Требования:
> * каждый компонент приложения деплоится отдельным deployment’ом/statefulset’ом;
> * в переменных чарта измените образ приложения для изменения версии.

Переделаем исходники с задания 13.1 задача 2

Ссылка на [Chart](https://github.com/Perovss/netology/tree/master/task13.4/chart)

Сделаем проверку на ошибки 
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.4</b></font>$ helm lint chart/
==&gt; Linting chart/
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
</pre>

Производим тестовую компиляцию
<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.4</b></font>$ helm template netology chart/ &gt;netology.yaml
</pre>

Скомпилированный манифест


## Задание 2: запустить 2 версии в разных неймспейсах
Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:
* одну версию в namespace=app1;
* вторую версию в том же неймспейсе;
* третью версию в namespace=app2.

Подготовим  и запустим чарты

<pre>helm upgrade v1 ./chart/ --install --namespace app1 --values ./chart/values-1.yaml
helm upgrade v2 ./chart/ --install --namespace app1 --values ./chart/values-2.yaml
helm upgrade v3 ./chart/ --install --namespace app2 --values ./chart/values-3.yaml</pre>

Проверим работу чартов:

<pre><font color="#26A269"><b>serge@serge</b></font>:<font color="#12488B"><b>~/netology/task13.4</b></font>$ helm list --all-namespaces -d 
NAME      	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART                       	APP VERSION
nfs-server	default  	1       	2021-08-11 21:54:53.871511624 +0300 MSK	deployed	nfs-server-provisioner-1.1.3	2.3.0      
v1        	app1     	1       	2021-08-23 15:33:17.449096068 +0300 MSK	deployed	chart-0.1.0                 	1.16.0     
v2        	app1     	1       	2021-08-23 15:33:36.321262396 +0300 MSK	deployed	chart-0.1.0                 	1.16.0     
v3        	app2     	2       	2021-08-23 15:33:48.455460928 +0300 MSK	deployed	chart-0.1.0                 	1.16.0     </pre>