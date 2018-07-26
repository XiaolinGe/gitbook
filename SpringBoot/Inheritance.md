# Inheritance 

demo: spring-mvc-practice

### 定义


### 知识点

* 标注为@MappedSuperclass的类将不是一个完整的实体类，他将不会映射到数据库表，但是他的属性都将映射到其子类的数据库字段中。

* serialVersionUID  不能从父类继承

### 应用



### 参考

Hibernate JPA实体继承的映射(一) 概述
http://www.cnblogs.com/yingsong/p/5179975.html

Hibernate JPA实体继承的映射(二) @MappedSuperclass
https://www.cnblogs.com/yingsong/p/5179961.html

JPA @MappedSuperclass 注解说明
https://blog.csdn.net/heardy/article/details/7924192

java中序列化之子类继承父类序列化
https://www.cnblogs.com/youxin/archive/2013/06/04/3116304.html
