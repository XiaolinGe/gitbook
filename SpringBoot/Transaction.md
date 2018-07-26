# Transaction (事务) 

demo: spring-mvc-practice

### 定义


#### 隔离级别

隔离级别是指若干个并发的事务之间的隔离程度，主要相关开发场景包括：脏读取、重复读、幻读。

org.springframework.transaction.annotation.Isolation 枚举类中定义了五个隔离级别的值：

```aidl
public enum Isolation {
    DEFAULT(-1),
    READ_UNCOMMITTED(1),
    READ_COMMITTED(2),
    REPEATABLE_READ(4),
    SERIALIZABLE(8);
}
```

* DEFAULT：
这是默认值，表示使用底层数据库的默认隔离级别。对大部分数据库而言，通常这值就是：READ_COMMITTED。

* READ_UNCOMMITTED：
该隔离级别表示一个事务可以读取另一个事务修改但还没有提交的数据。该级别不能防止脏读和不可重复读，因此很少使用该隔离级别。

* READ_COMMITTED：
该隔离级别表示一个事务只能读取另一个事务已经提交的数据。该级别可以防止脏读，这也是大多数情况下的推荐值。

* REPEATABLE_READ：
该隔离级别表示一个事务在整个过程中可以多次重复执行某个查询，并且每次返回的记录都相同。即使在多次查询之间有新增的数据满足该查询，这些新增的记录也会被忽略。该级别可以防止脏读和不可重复读。

* SERIALIZABLE：
所有的事务依次逐个执行，这样事务之间就完全不可能产生干扰，也就是说，该级别可以防止脏读、不可重复读以及幻读。但是这将严重影响程序的性能。通常情况下也不会用到该级别。


#### 传播行为

传播行为是指，如果在开始当前事务之前，一个事务上下文已经存在，此时有若干选项可以指定一个事务性方法的执行行为。

org.springframework.transaction.annotation.Propagation 枚举类中定义了6个传播行为的枚举值：

```
public enum Propagation {
    REQUIRED(0),
    SUPPORTS(1),
    MANDATORY(2),
    REQUIRES_NEW(3),
    NOT_SUPPORTED(4),
    NEVER(5),
    NESTED(6);
}
```
* REQUIRED：如果当前存在事务，则加入该事务；如果当前没有事务，则创建一个新的事务。

* SUPPORTS：如果当前存在事务，则加入该事务；如果当前没有事务，则以非事务的方式继续运行。

* MANDATORY：如果当前存在事务，则加入该事务；如果当前没有事务，则抛出异常。

* REQUIRES_NEW：创建一个新的事务，如果当前存在事务，则把当前事务挂起。

* NOT_SUPPORTED：以非事务方式运行，如果当前存在事务，则把当前事务挂起。

* NEVER：以非事务方式运行，如果当前存在事务，则抛出异常。

* NESTED：如果当前存在事务，则创建一个事务作为当前事务的嵌套事务来运行；如果当前没有事务，则该取值等价于REQUIRED。



### 应用
 
#### 在 Spring data jap 中运用事务

gradle.build

```aidl
compile "org.springframework.boot:spring-boot-starter-data-jpa:1.5.8.RELEASE"
```

ProductDao.kt
```aidl
import com.spring.mvc.bean.Product
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ProductDao : JpaRepository<Product, Int> {}
```

事务 @Transactional 加在 Service 层，而不是加在 Controller 层的原因参看 Spring Boot > Lock > Pessimistic Lock

ProductService.kt
```aidl
import com.spring.mvc.bean.Transaction
import com.spring.mvc.dao.ProductDao
import com.spring.mvc.dao.TransactionDao
import com.spring.mvc.dao.UserDao
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class ProductService(
        @Autowired
        val transactionDao: TransactionDao,

        @Autowired
        val productDao: ProductDao,

        @Autowired
        val userDao: UserDao
) {
    @Transactional /* 运用事务 */
    fun buy(id: Int?) {
        val product = productDao.findOne(id)
        val isSellout = product.count == 0.toLong()
        println("isSellout: $isSellout")

        val user = userDao.findOne(1)
        val trx = Transaction()

        println("${Thread.currentThread().name} buy before count is ${product.count}" )

        product.count = product.count!!.dec()
        trx.product = product
        trx.user = user

        productDao.save(product) 
        transactionDao.save(trx)

        println("${Thread.currentThread().name} buy after count is ${product.count}" )
    }
}
```

ProductController.kt
```aidl
    @GetMapping("buy")
    fun buy(@RequestParam(required = false) id: Int?, model: ModelMap): String {

        try {
            finishLock.lock()
            log.debug("{} get lock", Thread.currentThread().name)
            println("${Thread.currentThread().name} get lock ")
            val product = productDao.findOne(id)

            val isSellout = product.count == 0.toLong()
            log.debug("isSellout: $isSellout")
            println("isSellout: $isSellout")
            if (isSellout) {
                log.debug("already sell out")
                println("already sell out")
            } else {
                productService.buy(id)
            }
        } finally {
            log.debug("{} release lock", Thread.currentThread().name)
            println("${Thread.currentThread().name} release lock")
            finishLock.unlock()
        }

        return "redirect:/product/list "
    }
```


#### AOP 运用事务

TransactionalAspect.kt
```aidl
import org.aspectj.lang.ProceedingJoinPoint
import org.aspectj.lang.annotation.Around
import org.aspectj.lang.annotation.Aspect
import org.aspectj.lang.annotation.Pointcut
import org.springframework.stereotype.Component
import org.springframework.transaction.PlatformTransactionManager
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.transaction.support.DefaultTransactionDefinition


@Aspect
@Component
class TransactionalAspect {
    @Autowired
    var transactionManager: PlatformTransactionManager? = null

    @Pointcut("execution(* com.spring.mvc.service..*(..))")
    fun TransactionalPointcut() {
    }

    @Around("TransactionalPointcut()")
    fun interceptor(pjp: ProceedingJoinPoint) {
        val transactionDefinition = DefaultTransactionDefinition()
        val transactionStatus = transactionManager!!.getTransaction(transactionDefinition)
        try {
            pjp.proceed()
            transactionManager!!.commit(transactionStatus)
        } catch (ex: Exception) {
            println("there is a exception for transactional !")
            ex.printStackTrace()
            transactionManager!!.rollback(transactionStatus)
        }
    }
}
```

ProductController.kt
```aidl
    @GetMapping("buy2")
    fun buy2(@RequestParam(required = false) id: Int?, model: ModelMap): String {

        productService.buy(id)
        
        return "redirect:/product/list "
    }
```


### 参考

Spring Boot中的事务管理
http://blog.didispace.com/springboottransactional/


Programmatic Transaction Management Example in Spring
https://www.jeejava.com/programmatic-transaction-management-example-in-spring/