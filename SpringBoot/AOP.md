# AOP 

demo: spring-mvc-practice

### 定义


### 应用

gradle.build

```aidl
compile "org.springframework.boot:spring-boot-starter-aop:1.5.8.RELEASE"
```

ServiceAspect.kt
```aidl
import com.mysql.jdbc.exceptions.jdbc4.MySQLTransactionRollbackException
import org.aspectj.lang.ProceedingJoinPoint
import org.aspectj.lang.annotation.Around
import org.aspectj.lang.annotation.Aspect
import org.aspectj.lang.annotation.Pointcut
import org.aspectj.lang.reflect.MethodSignature
import org.hibernate.StaleStateException
import org.springframework.dao.CannotAcquireLockException
import org.springframework.orm.ObjectOptimisticLockingFailureException
import org.springframework.stereotype.Component
import java.sql.SQLException

@Aspect
@Component
class ServiceAspect {

   // @Pointcut("execution(* com.spring.mvc.service..*(..)) and @annotation(org.springframework.transaction.annotation.Transactional)")
   @Pointcut("execution(* com.spring.mvc.service..*(..))")
    fun serviceMethodPointcut() {
    }

    @Around("serviceMethodPointcut()")
    fun interceptor(pjp: ProceedingJoinPoint): Any?   {
        val beginTime = System.currentTimeMillis()
        val signature = pjp.signature as MethodSignature
        val method = signature.method
        val methodName = method.name

        println("请求开始，方法：$methodName")

        val result: Any? = null

        var count = 3

        while (count > 0) {
            try {
                pjp.proceed()

                break

            } catch (e0: Exception) {
                println("retry e0 ${4 - count}")
                e0.printStackTrace()

            }  catch (e: CannotAcquireLockException) {
                println("retry e ${4 - count}")
                e.printStackTrace()

            } catch (e2: ObjectOptimisticLockingFailureException) {
                println("retry e2 ${4 - count}")

                e2.printStackTrace()

            } catch (e3: MySQLTransactionRollbackException) {
                println("retry e3 ${4 - count}")

                e3.printStackTrace()

            } catch (e4: StaleStateException) {
                println("retry e4 ${4 - count}")

                e4.printStackTrace()
            } catch (e5: SQLException) {
                println("retry e5 ${4 - count}")

                e5.printStackTrace()
            }
            count--
        }

        val costMs = System.currentTimeMillis() - beginTime
        println("$methodName 请求结束，耗时：$costMs ms")

        return result
    }
}

```


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


### 参考

Spring Boot中使用AOP统一处理Web请求日志
http://blog.didispace.com/springbootaoplog/

spring boot 使用spring AOP实现拦截器
https://blog.csdn.net/ClementAD/article/details/52035199

Spring ORM example with AOP Transaction Management
https://www.journaldev.com/7772/spring-orm-example-aop-transactions
