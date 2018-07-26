# Lock 
### Optimistic Lock & Pessimistic Lock

### 定义

*** 乐观锁(Optimistic Lock)，使用对数据进行版本校验和比较，来对保证本次的更新时最新的，否则就失败。 
```
select uid,name,version from user where uid=1;
update user set name='abc', version=version+1 where uid=1 and version=1
```

*** 悲观锁(Pessimistic Lock)，简单的理解就是把需要的数据全部加锁，在事务提交之前，这些数据全部不可读取和修改。 
```
select * from user where uid=1 for update;
update user  set name='bac'  where uid=1;
```

### 应用

#### 乐观锁(Optimistic Lock) 
在JPA中, 使用@Version在某个字段上进行乐观锁控制。
   
BaseEntity.kt 

(BaseEntity 中有基本字段，其中version是乐观锁的应用)
```$xslt
import org.springframework.data.annotation.CreatedBy
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.LastModifiedBy
import org.springframework.data.annotation.LastModifiedDate
import org.springframework.data.jpa.domain.support.AuditingEntityListener
import java.util.*
import java.io.Serializable
import javax.persistence.*

@MappedSuperclass
@EntityListeners(AuditingEntityListener::class)
abstract class BaseEntity(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,

        @Version
        var version: Long? = null,

        @Column(name = "create_time", columnDefinition = "DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3)")
        @CreatedDate
        val createTime: Date? = null,

        @Column(name = "create_by")
        @CreatedBy
        val createBy: Long? = null,

        @Column(name = "last_modified_time", columnDefinition = "DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3)")
        @LastModifiedDate
        val lastModifiedTime: Date? = null,

        @Column(name = "last_modified_by")
        @LastModifiedBy
        val lastModifiedBy: String? = null

) : Serializable {
    companion object {
        protected const val serialVersionUID: Long = 1
    }
}

```


Product.kt

(Product 继承 BaseEntity)

```$xslt
import java.io.Serializable
import javax.persistence.*

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
class Product: BaseEntity(), Serializable {
    var name: String? = null
    var price: Double? = null
    var count: Long? = null
    companion object {
        const val serialVersionUID = 1L
    }
}
```

form.html

(对应表单提交的情况, 在前端页面加入version, 例如模版引擎是 thymeleaf 的时候)
```$xslt
<input type="hidden" name="version" th:if="${blog}!=null" th:value="${blog.version}" />
```

#### 悲观锁(Pessimistic Lock)

以购物为例，用户选购商品，在高并发多线程的情况下，如何用悲观锁来解决产品超售问题。


我们用@Transactional来进行事务控制，但事务控制要加在service层，不能加在controller层，原因如下：

用户A 与 用户B 同时购买商品X， 产生了两个线程，假设用户A是线程1，用户B是线程2。当事务控制是在controller层面的时候，以下 0-7 步会导出超售问题

| 用户A | 线程1 | 商品X | 库存1 |

| 用户B | 线程2 | 商品X | 库存1 |

ProductController.kt （错误示范及解释）
```$xslt
@Transactional
@GetMapping("buy")
fun buy(id: Int?, model: ModelMap): String {

    try {  // 1, 用户B 线程2 等待线程1解锁，等等等一直等
        productLock.lock()   // 0. 用户A 线程1 上锁
        log.debug("{} get lock", Thread.currentThread().name)
        println("${Thread.currentThread().name} get lock ")
        val product = productDao.findOne(id) // 2. 用户A 线程1 取得产品X的库存是1  // 6. 由于线程1事务没有提交，库存减1还没有生效，所以用户B 线程2 判断出的库存仍是1，此时就会产生超售问题

        val isSellout = product.count == 0.toLong()
        log.debug("isSellout: $isSellout")
        println("isSellout: $isSellout")
        if (isSellout) {
            log.debug("already sell out")
            println("already sell out")
        } else {  // 3. 用户A 线程1 产品X 库存1 所以可以进行购买
            val user = userDao.findOne(1)
            val product = productDao.findOne(id)
            val trx = Transaction()

            product.count = product.count!!.dec() // 4. 用户A 线程1 产品X 库存1 进行购买后 产品X 库存此时仍未1， 当事务全部提交后才减1变为0
            trx.product = product
            trx.user = user

            productDao.save(product) 
            transactionDao.save(trx)
        }
    } finally { 
        log.debug("{} release lock", Thread.currentThread().name)
        println("${Thread.currentThread().name} release lock") 
        productLock.unlock() // 5. 用户A 线程1 解锁， 此时用户B 线程2进入执行阶段，但此时线程1的事务没有提交，产品X库存仍为1， 那么用户B 线程2 判断出的库存仍是1
    }

    return "redirect:/productLock/list "  // 7. 线程1执行到此后事务生效，产品X的库存减1为0
    }
```

所以需要将事务加在service层面：（正确示范）

ProductController.kt
```$xslt
import com.spring.mvc.dao.ProductDao
import com.spring.mvc.dao.TransactionDao
import com.spring.mvc.dao.UserDao
import com.spring.mvc.service.ProductService
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.ModelMap
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import java.util.concurrent.locks.ReentrantLock

@Controller
@RequestMapping(value = ["/productLock"])
class ProductController(
        @Autowired
        val transactionDao: TransactionDao,
        @Autowired
        val productDao: ProductDao,
        @Autowired
        val productService: ProductService,
        @Autowired
        val userDao: UserDao
) {
    val productLock = ReentrantLock()
    val log = LoggerFactory.getLogger(ProductController::class.java)!!

    @GetMapping("list")
    fun list(model: ModelMap): String {
        val list = productDao.findAll()
        model.addAttribute("list", list)
        return "productLock/list"
    }

    @GetMapping("buy")
    fun buy(id: Int?, model: ModelMap): String {
        // 悲观锁的应用
        try {
            productLock.lock()
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
            productLock.unlock()
        }
        return "redirect:/productLock/list "
    }
}
```

ProductService.kt
```
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
    @Transactional // 事务应用
    fun buy(id: Int?) {
        val user = userDao.findOne(1)
        val product = productDao.findOne(id)
        val trx = Transaction()

        product.count = product.count!!.dec()
        trx.product = product
        trx.user = user

        productDao.save(product) 
        transactionDao.save(trx)
    }
}
```


### 参考

发锁事务重试机制（JPA高并发下的乐观锁异常）总结，以及中间遇到各种问题和解决方案
https://blog.csdn.net/zhanghongzheng3213/article/details/50819539