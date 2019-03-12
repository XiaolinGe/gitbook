# FetchType 

demo: spring-mvc-practice

### 定义

在jpa中jpa默认的加载方式是lazy方式也就是在实际使用到数据的时候才加载相关数据，使用lazy时可以不用显示注明fetch=FetchType.LAZY


1、FetchType.LAZY：懒加载，加载一个实体时，定义懒加载的属性不会马上从数据库中加载。


2、FetchType.EAGER：急加载，加载一个实体时，定义急加载的属性会立即从数据库中加载。

### 应用

#### FetchType.LAZY

```aidl
@OneToMany(mappedBy = "payee", fetch = FetchType.LAZY)
var pba: MutableList<PayeeBankAccount> = mutableListOf()

```
则发多条 sql

> select payee0_.id as id1_4_0_, payee0_.create_by as create_b2_4_0_, payee0_.create_time as create_t3_4_0_, payee0_.last_modified_by as last_mod4_4_0_, payee0_.last_modified_time as last_mod5_4_0_, payee0_.version as version6_4_0_, payee0_.name as name7_4_0_ from payee payee0_ where payee0_.id=1;

==============================================

>  select pba0_.payee_id as payee_id9_5_0_, pba0_.id as id1_5_0_, pba0_.id as id1_5_1_, pba0_.create_by as create_b2_5_1_, pba0_.create_time as create_t3_5_1_, pba0_.last_modified_by as last_mod4_5_1_, pba0_.last_modified_time as last_mod5_5_1_, pba0_.version as version6_5_1_, pba0_.account_name as account_7_5_1_, pba0_.account_number as account_8_5_1_, pba0_.payee_id as payee_id9_5_1_ from payee_bank_account pba0_ where pba0_.payee_id=1;

==============================================
 
> select bankowners0_.payee_bank_account_id as payee_ba8_0_0_, bankowners0_.id as id1_0_0_, bankowners0_.id as id1_0_1_, bankowners0_.create_by as create_b2_0_1_, bankowners0_.create_time as create_t3_0_1_, bankowners0_.last_modified_by as last_mod4_0_1_, bankowners0_.last_modified_time as last_mod5_0_1_, bankowners0_.version as version6_0_1_, bankowners0_.name as name7_0_1_, bankowners0_.payee_bank_account_id as payee_ba8_0_1_ from bank_owner bankowners0_ where bankowners0_.payee_bank_account_id=2;



#### FetchType.EAGER

```aidl
@OneToMany(mappedBy = "payee", fetch = FetchType.LAZY)
var pba: MutableList<PayeeBankAccount> = mutableListOf()

```

则发一条 sql

> select payee0_.id as id1_4_0_, payee0_.create_by as create_b2_4_0_, payee0_.create_time as create_t3_4_0_, payee0_.last_modified_by as last_mod4_4_0_, payee0_.last_modified_time as last_mod5_4_0_, payee0_.version as version6_4_0_, payee0_.name as name7_4_0_, pba1_.payee_id as payee_id9_5_1_, pba1_.id as id1_5_1_, pba1_.id as id1_5_2_, pba1_.create_by as create_b2_5_2_, pba1_.create_time as create_t3_5_2_, pba1_.last_modified_by as last_mod4_5_2_, pba1_.last_modified_time as last_mod5_5_2_, pba1_.version as version6_5_2_, pba1_.account_name as account_7_5_2_, pba1_.account_number as account_8_5_2_, pba1_.payee_id as payee_id9_5_2_, bankowners2_.payee_bank_account_id as payee_ba8_0_3_, bankowners2_.id as id1_0_3_, bankowners2_.id as id1_0_4_, bankowners2_.create_by as create_b2_0_4_, bankowners2_.create_time as create_t3_0_4_, bankowners2_.last_modified_by as last_mod4_0_4_, bankowners2_.last_modified_time as last_mod5_0_4_, bankowners2_.version as version6_0_4_, bankowners2_.name as name7_0_4_, bankowners2_.payee_bank_account_id as payee_ba8_0_4_ from payee payee0_ left outer join payee_bank_account pba1_ on payee0_.id=pba1_.payee_id left outer join bank_owner bankowners2_ on pba1_.id=bankowners2_.payee_bank_account_id where payee0_.id=1;




### 参考

jpa抓取策略详解fetch(lazy ,eager)

http://sefcertyu.iteye.com/blog/477775


FetchType.LAZY和FetchType.EAGER什么区别？（懒加载和急加载的理解）

https://blog.csdn.net/u010082453/article/details/43339031


JPA效率优化（EntityGraph）

https://blog.csdn.net/dalangzhonghangxing/article/details/56680629

