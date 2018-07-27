# Caused by: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: 


### Exception

```aidl
Caused by: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: 
Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'mrpdbs.n.short_name' which is not functionally dependent on columns in GROUP BY clause; 
this is incompatible with sql_mode=only_full_group_by
```


### Reference

https://stackoverflow.com/questions/10757169/mysql-my-cnf-location-on-os-x

By default, the OS X installation does not use a my.cnf, and MySQL just uses the default values. To set up your own my.cnf, you could just create a file straight in /etc.
OS X provides example configuration files at /usr/local/mysql/support-files/.



### Solution

disable permanently error sql_mode=only_full_group_by do those steps:

改mysql的配置文件里的sql_mode 为:

sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION



#### for mac:

1.  命令行： mysql_config
  
2.  找到mysql 在mac上的位置： [/etc/mysql]
  
3.  mac menu: Go -> Go to Folder -> 输入：/etc/mysql
  
4.  找到support-files并且在此folder里复制my-default.cnf 并命名为my.cnf
  
5.  用vim打开my.cnf文件(vim /etc/mysql/my.cnf )
  
6.  在 my.cnf 这个文件里最后一行输入: sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
  
7.  重启MySQL： brew services restart mysql
  
8.  check sql_mode是否改过来：mysql> SELECT @@sql_mode;

