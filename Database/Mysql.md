# Mysql 


### 知识点

##### Start MYSQL 

> sudo mysql.server start

##### Change mysql native password 

> 1, mysql -u root

> 2, mysql.user SET authentication_string=PASSWORD('root') WHERE User=‘root’;

> 3, FLUSH PRIVILEGES;


##### ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
https://stackoverflow.com/questions/22436028/cant-connect-to-local-mysql-server-through-socket-tmp-mysql-sock-2/28490565

Following command resolved my issue:

> sudo chown -R _mysql:mysql /usr/local/var/mysql

> sudo mysql.server start


##### ERROR : grant all privileges on *.* to root@"%" identified by ".";
权限问题，授权 给 root  所有sql 权限

> mysql> grant all privileges on *.* to root@"%" identified by ".";

Query OK, 0 rows affected (0.00 sec)

### 参考

MySQL数据库学习笔记（三）----基本的SQL语句
http://www.cnblogs.com/smyhvae/p/4028178.html


Liqui Base 数据迁移：
http://www.liquibase.org/documentation/index.html

关联查询
http://www.cnblogs.com/smyhvae/p/4042303.html
