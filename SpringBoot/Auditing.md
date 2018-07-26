# Auditing 

demo: spring-mvc-practice

### 定义
在spring jpa中，支持在字段或者方法上进行注解 @CreatedDate、@CreatedBy、@LastModifiedDate、@LastModifiedBy

* @CreatedDate
表示该字段为创建时间时间字段，在这个实体被insert的时候，会设置值

* @CreatedBy
表示该字段为创建人，在这个实体被insert的时候，会设置值

* @LastModifiedDate、@LastModifiedBy同理。

### 应用

1. 在 Application 启动类中加上注解 @EnableJpaAuditing。

2. 在实体类上加上注解@EntityListeners(AuditingEntityListener.class)。

3. 在需要的字段上加上 @CreatedDate、@CreatedBy、@LastModifiedDate、@LastModifiedBy 等注解。


Application.kt
```aidl
import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.builder.SpringApplicationBuilder
import org.springframework.boot.web.support.SpringBootServletInitializer
import org.springframework.data.jpa.repository.config.EnableJpaAuditing
import org.springframework.data.redis.serializer.GenericToStringSerializer
import org.springframework.data.redis.serializer.StringRedisSerializer
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.context.annotation.Bean
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory

@SpringBootApplication(scanBasePackages = ["com.spring.mvc"])
@EnableJpaAuditing
open class Application : SpringBootServletInitializer() {
    override fun configure(builder: SpringApplicationBuilder?): SpringApplicationBuilder {
        return builder!!.sources(Application::class.java)
    }
}

fun main(args: Array<String>) {
    SpringApplication.run(Application::class.java, *args)
}

```

BaseEntity.kt
```aidl
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



### 参考

Spring JPA 使用@CreatedDate、@CreatedBy、@LastModifiedDate、@LastModifiedBy 自动生成时间和修改者
https://www.jianshu.com/p/14cb69646195
