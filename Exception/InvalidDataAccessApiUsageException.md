# InvalidDataAccessApiUsageException


### Exception

```aidl
InvalidDataAccessApiUsageException: Unknown name value [] for enum class [test.enums.PayeeStatusEnum]; nested exception is java.lang.IllegalArgumentException: Unknown name value [] for enum class [test.enums.PayeeStatusEnum]
```


### Reason
数据库里的对应的payee table 里的status 字段值是空，空不能转为Enum,所以需要给已经存在的payee 的status加上Enum对应的值


### Solution

数据库里的对应的payee table 里的status 字段值加上需要的Enum的值
   
