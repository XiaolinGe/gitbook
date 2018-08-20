# EntityGraph 

JPA效率优化

demo: spring-mvc-practice

### 定义


##### NameEntityGraph

这是JPA2.1的新特性，其主要作用是来设置懒加载需要加载的关联对象，并且支持多层关联，比如 payee.pba[1].bankOwners ,来获取一个 payee 的某个 payee bank account 的 bank owners 所能访问的页面。


在 Dao 配置 @EntityGraph 

> @EntityGraph(value="payee.all",type= EntityGraph.EntityGraphType.FETCH)


则只发一条 sql


> select payee0_.id as id1_4_0_, payee0_.create_by as create_b2_4_0_, payee0_.create_time as create_t3_4_0_, payee0_.last_modified_by as last_mod4_4_0_, payee0_.last_modified_time as last_mod5_4_0_, payee0_.version as version6_4_0_, payee0_.name as name7_4_0_, pba1_.payee_id as payee_id9_5_1_, pba1_.id as id1_5_1_, pba1_.id as id1_5_2_, pba1_.create_by as create_b2_5_2_, pba1_.create_time as create_t3_5_2_, pba1_.last_modified_by as last_mod4_5_2_, pba1_.last_modified_time as last_mod5_5_2_, pba1_.version as version6_5_2_, pba1_.account_name as account_7_5_2_, pba1_.account_number as account_8_5_2_, pba1_.payee_id as payee_id9_5_2_, bankowners2_.payee_bank_account_id as payee_ba8_0_3_, bankowners2_.id as id1_0_3_, bankowners2_.id as id1_0_4_, bankowners2_.create_by as create_b2_0_4_, bankowners2_.create_time as create_t3_0_4_, bankowners2_.last_modified_by as last_mod4_0_4_, bankowners2_.last_modified_time as last_mod5_0_4_, bankowners2_.version as version6_0_4_, bankowners2_.name as name7_0_4_, bankowners2_.payee_bank_account_id as payee_ba8_0_4_ from payee payee0_ left outer join payee_bank_account pba1_ on payee0_.id=pba1_.payee_id left outer join bank_owner bankowners2_ on pba1_.id=bankowners2_.payee_bank_account_id where payee0_.id=1;


不配置@EntityGraph 时候，则发查询次数条 sql

> select payee0_.id as id1_4_0_, payee0_.create_by as create_b2_4_0_, payee0_.create_time as create_t3_4_0_, payee0_.last_modified_by as last_mod4_4_0_, payee0_.last_modified_time as last_mod5_4_0_, payee0_.version as version6_4_0_, payee0_.name as name7_4_0_ from payee payee0_ where payee0_.id=1;

==============================================

>  select pba0_.payee_id as payee_id9_5_0_, pba0_.id as id1_5_0_, pba0_.id as id1_5_1_, pba0_.create_by as create_b2_5_1_, pba0_.create_time as create_t3_5_1_, pba0_.last_modified_by as last_mod4_5_1_, pba0_.last_modified_time as last_mod5_5_1_, pba0_.version as version6_5_1_, pba0_.account_name as account_7_5_1_, pba0_.account_number as account_8_5_1_, pba0_.payee_id as payee_id9_5_1_ from payee_bank_account pba0_ where pba0_.payee_id=1;

==============================================
 
> select bankowners0_.payee_bank_account_id as payee_ba8_0_0_, bankowners0_.id as id1_0_0_, bankowners0_.id as id1_0_1_, bankowners0_.create_by as create_b2_0_1_, bankowners0_.create_time as create_t3_0_1_, bankowners0_.last_modified_by as last_mod4_0_1_, bankowners0_.last_modified_time as last_mod5_0_1_, bankowners0_.version as version6_0_1_, bankowners0_.name as name7_0_1_, bankowners0_.payee_bank_account_id as payee_ba8_0_1_ from bank_owner bankowners0_ where bankowners0_.payee_bank_account_id=2;



### 应用


Payee.kt
```aidl
package com.spring.mvc.bean

import java.io.Serializable
import javax.persistence.*

@Entity
@NamedEntityGraph(
        name = "payee.all",
        attributeNodes = [(NamedAttributeNode(value = "pba",
                subgraph = "bankOwners"))],
        subgraphs = [
            NamedSubgraph(name = "bankOwners",//一层延伸
                    attributeNodes = [NamedAttributeNode("bankOwners")])
        ]
)
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
class Payee : BaseEntity(), Serializable {
    companion object {
        const val serialVersionUID = 1L
    }
    var name: String? = null
    @OneToMany(mappedBy = "payee")
    var pba: MutableList<PayeeBankAccount> = mutableListOf()
}
```


PayeeDao.kt  (@EntityGraph)
```aidl
package com.spring.mvc.dao

import com.spring.mvc.bean.Payee
import org.springframework.data.jpa.repository.EntityGraph
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface PayeeDao : JpaRepository<Payee, Int> {
    @EntityGraph(value="payee.all",type= EntityGraph.EntityGraphType.FETCH) // EntityGraph 
    override fun findOne(id: Int?): Payee
}
```


PayeeBankAccount.kt
```aidl
package com.spring.mvc.bean

import java.io.Serializable
import javax.persistence.*

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
class PayeeBankAccount: BaseEntity(), Serializable {
    companion object {
        const val serialVersionUID = 1L
    }
    var accountName: String? = null
    var accountNumber: String? = null
    @ManyToOne
    @JoinColumn(name = "payee_id")
    var payee: Payee? = null
    @OneToMany(mappedBy = "payeeBankAccount")
    val bankOwners: MutableList<BankOwner> = mutableListOf()
}
```

BankOwner.kt
```aidl
package com.spring.mvc.bean

import java.io.Serializable
import javax.persistence.*

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
class BankOwner: BaseEntity(), Serializable {

    companion object {
        const val serialVersionUID = 1L
    }

    var name: String? = null

    @ManyToOne
    @JoinColumn(name = "payee_bank_account_id")
    var payeeBankAccount: PayeeBankAccount ? = null
}
```

PayeeController.kt
```aidl
    @GetMapping
    fun get(@RequestParam(required = false) id: Int?, model: ModelMap): String {
        payeeDao.findOne(id)
        return "get successful"
    }
```


http://localhost:8080/payee?id=1


> select payee0_.id as id1_4_0_, payee0_.create_by as create_b2_4_0_, payee0_.create_time as create_t3_4_0_, payee0_.last_modified_by as last_mod4_4_0_, payee0_.last_modified_time as last_mod5_4_0_, payee0_.version as version6_4_0_, payee0_.name as name7_4_0_, pba1_.payee_id as payee_id9_5_1_, pba1_.id as id1_5_1_, pba1_.id as id1_5_2_, pba1_.create_by as create_b2_5_2_, pba1_.create_time as create_t3_5_2_, pba1_.last_modified_by as last_mod4_5_2_, pba1_.last_modified_time as last_mod5_5_2_, pba1_.version as version6_5_2_, pba1_.account_name as account_7_5_2_, pba1_.account_number as account_8_5_2_, pba1_.payee_id as payee_id9_5_2_, bankowners2_.payee_bank_account_id as payee_ba8_0_3_, bankowners2_.id as id1_0_3_, bankowners2_.id as id1_0_4_, bankowners2_.create_by as create_b2_0_4_, bankowners2_.create_time as create_t3_0_4_, bankowners2_.last_modified_by as last_mod4_0_4_, bankowners2_.last_modified_time as last_mod5_0_4_, bankowners2_.version as version6_0_4_, bankowners2_.name as name7_0_4_, bankowners2_.payee_bank_account_id as payee_ba8_0_4_ from payee payee0_ left outer join payee_bank_account pba1_ on payee0_.id=pba1_.payee_id left outer join bank_owner bankowners2_ on pba1_.id=bankowners2_.payee_bank_account_id where payee0_.id=1;




### 参考

JPA效率优化（EntityGraph）

https://blog.csdn.net/dalangzhonghangxing/article/details/56680629

jpa抓取策略详解fetch(lazy ,eager)

http://sefcertyu.iteye.com/blog/477775