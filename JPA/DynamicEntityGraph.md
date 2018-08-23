# Dynamic Entity Graph 

JPA效率优化

demo: spring-mvc-practice

### 定义


### 应用

PayeeController.kt
```aidl
@GetMapping("test")
    fun test(@RequestParam(required = false) id: Int?, items: String?, model: ModelMap): String {

        if (items != null && items.contains(".")) {
            val strList = items.split(".")
            val graph = this.entityManager.createEntityGraph(Payee::class.java)
            val subGraph = graph.addSubgraph<PayeeBankAccount>(strList[1])
            if (strList.size == 3) {
                subGraph.addAttributeNodes(strList[2])
            }
            val hints = HashMap<String, Any>()
            hints["javax.persistence.fetchgraph"] = graph
            this.entityManager.find(Payee::class.java, id, hints)
        }

        val payee = payeeDao.findOne(id)
        val bankOwner = payee.pba[1].bankOwners
        val bankOwner2 = payee.pba[0].bankOwners
        return "test successful"
    }    
```

http://localhost:8080/payee/test?id=1&items=payee.pba.bankOwners

http://localhost:8080/payee/test?id=1&items=payee.pba

http://localhost:8080/payee/test?id=1&items=payee

http://localhost:8080/payee/test?id=1


> select payee0_.id as id1_4_0_, payee0_.create_by as create_b2_4_0_, payee0_.create_time as create_t3_4_0_, payee0_.last_modified_by as last_mod4_4_0_, payee0_.last_modified_time as last_mod5_4_0_, payee0_.version as version6_4_0_, payee0_.name as name7_4_0_, pba1_.payee_id as payee_id9_5_1_, pba1_.id as id1_5_1_, pba1_.id as id1_5_2_, pba1_.create_by as create_b2_5_2_, pba1_.create_time as create_t3_5_2_, pba1_.last_modified_by as last_mod4_5_2_, pba1_.last_modified_time as last_mod5_5_2_, pba1_.version as version6_5_2_, pba1_.account_name as account_7_5_2_, pba1_.account_number as account_8_5_2_, pba1_.payee_id as payee_id9_5_2_, bankowners2_.payee_bank_account_id as payee_ba8_0_3_, bankowners2_.id as id1_0_3_, bankowners2_.id as id1_0_4_, bankowners2_.create_by as create_b2_0_4_, bankowners2_.create_time as create_t3_0_4_, bankowners2_.last_modified_by as last_mod4_0_4_, bankowners2_.last_modified_time as last_mod5_0_4_, bankowners2_.version as version6_0_4_, bankowners2_.name as name7_0_4_, bankowners2_.payee_bank_account_id as payee_ba8_0_4_ from payee payee0_ left outer join payee_bank_account pba1_ on payee0_.id=pba1_.payee_id left outer join bank_owner bankowners2_ on pba1_.id=bankowners2_.payee_bank_account_id where payee0_.id=1;



### 参考

JPA 2.1 Entity Graph : Part 2- Define lazy/eager loading at runtime

https://www.thoughts-on-java.org/jpa-21-entity-graph-part-2-define/

JPA 处理 N+1 问题的办法

https://www.mingzhe.org/blog/2017/06/20/solve-n-plus-1-problems-using-hibernate/