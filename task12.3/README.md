##Задание 12.3
***
1.Для того, чтобы кластер продолжал работать после выхода из строя одного ноды (в нашем случае мастера kubernetes), нужно минимум 2 ноды.(ОЗУ:2гб,2 ядро, диск 50Гб)  
2.Аналогично ноды с служебными ресурсами Etcd+HAproxy 2 ноды.  (ОЗУ:2гб,2 ядро, диск 50Гб)  
3.БД лучше хранить снаружи.  На БД и Кеш 4 ноды(ОЗУ:8гб,1 ядро, диск 200Гб)  
4.бекэнд+фронт 5 нод. 
(ОЗУ:2гб,2 ядро, диск 200Гб)  

[Ссылка на расчеты](https://docs.google.com/spreadsheets/d/1WyGJ8teaMunAQI7fCqNTejbPbA9SgbeZTzJ1LfFs3yc/edit?usp=sharing)

Для создания кластера необходимо 13 нод, общяя сумма ресурсов (ОЗУ:50гб,26 ядер, диск 2Тб)