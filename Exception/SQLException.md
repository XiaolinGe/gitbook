# 


### Exception

```aidl
java.sql.SQLException: Incorrect integer value: 'NEW' for column 'status' at row 1
```

### Reason
数据库中Payee的status 是int 类型，但是Entity 里的是String， 当payee.setStatus(PayeeStatusEnum.NEW);的时候，无法对数据库进行操作


### Solution
删除数据库中的status字段，从新run程序，根据Entity从新update 数据库，那么，数据库中的payee table里的status字段的属性就变成varchar了，

