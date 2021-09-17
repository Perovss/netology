# [Все файлы задания](https://github.com/Perovss/netology/tree/master/task15.2)

# Домашнее задание к занятию 15.2 "Вычислительные мощности. Балансировщики нагрузки".

> Используя конфигурации, выполненные в рамках ДЗ на предыдущем занятии добавить к Production like сети Autoscaling > group из 2 EC2-инстансов с  автоматической установкой web-сервера в private домен. Создать приватный домен в Route53, чтобы был доступ из VPN.

## Задание 1. Создать bucket S3 и разместить там файл с картинкой.

> - Создать бакет в S3 с произвольным именем (например, имя_студента_дата).
> - Положить в бакет файл с картинкой.
> - Сделать доступным из VPN используя ACL.

# Решение

Создаем бакет в S3

[Манифест](https://github.com/Perovss/netology/blob/master/task15.2/terraform/s3_bucket.tf)
[Картинка](https://github.com/Perovss/netology/blob/master/task15.2/terraform/files/netology.jpg)
---

## Задание 2. Создать запись в Route53 домен с возможностью определения из VPN.

> - Сделать запись в Route53 на приватный домен, указав адрес LB.

# Решение

Создаем запись в Route53

[Манифест](https://github.com/Perovss/netology/blob/master/task15.2/terraform/route53.tf)

---

## Задание 3. Загрузить несколько ЕС2-инстансов с веб-страницей, на которой будет картинка из S3.

> - Сделать Launch configurations с использованием bootstrap скрипта с созданием веб-странички на которой будет ссылка на картинку в S3.
> - Загрузить 3 ЕС2-инстанса и настроить LB с помощью Autoscaling Group.


# Решение
Создаем группуAutoscaling и правила для файрвола, шаблон инстансов и classic LB
[Манифест](https://github.com/Perovss/netology/blob/master/task15.2/terraform/autoscaling_lb.tf)
[Скрипт](https://github.com/Perovss/netology/blob/master/task15.2/terraform/files/bootstrap.tmpl)

На выходе получаем изображение

![1](https://github.com/Perovss/netology/blob/master/task15.2/pic1.png)
![2](https://github.com/Perovss/netology/blob/master/task15.2/pic2.png)
![3](https://github.com/Perovss/netology/blob/master/task15.2/pic3.png)



[Все файлы задания](https://github.com/Perovss/netology/tree/master/task15.2)