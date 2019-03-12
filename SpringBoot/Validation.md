# Spring MVC Custom Validation

demo: spring-mvc-practice


pring提供了非常好用的JavaMailSender接口实现邮件发送。在Spring Boot的Starter模块中也为此提供了自动化配置。下面通过实例看看如何在Spring Boot中使用JavaMailSender发送邮件。

### 应用

##### 创建一个 MyConstraintValidator.kt 这个类，它就是我们的校验逻辑类，并且让它继承 ConstraintValidator<MyConstraint, Any>

MyConstraintValidator.kt
```aidl
import javax.validation.ConstraintValidator
import javax.validation.ConstraintValidatorContext

class MyConstraintValidator : ConstraintValidator<ContactNumberConstraint, Any> {

    override fun initialize(contactNumber: ContactNumberConstraint?) {
        super.initialize(contactNumber)
        println("my validator init 初始化方法")
    }

    override fun isValid(contactField: Any, cxt: ConstraintValidatorContext): Boolean {
        return when (contactField) {
            is String -> contactField.length in 3..13
            else -> false
        }
    }
}
```


##### 定义一个 annotation

ContactNumberConstraint.kt
```aidl
import javax.validation.Constraint
import javax.validation.ReportAsSingleViolation
import kotlin.reflect.KClass

@MustBeDocumented
@Constraint(validatedBy = [MyConstraintValidator::class])
@Target(
        AnnotationTarget.FUNCTION, AnnotationTarget.FIELD, AnnotationTarget.ANNOTATION_CLASS,
        AnnotationTarget.PROPERTY_GETTER
)
@Retention(AnnotationRetention.RUNTIME)
@ReportAsSingleViolation
annotation class ContactNumberConstraint(
        val message: String = "foo",
        val groups: Array<KClass<out Any>> = [],
        val payload: Array<KClass<out Any>> = []
)
```


##### 在定义的 bean 中使用定义好的annotation

Blog.kt
```
import javax.validation.constraints.Min
import javax.validation.constraints.NotNull
import javax.validation.constraints.Size
import com.spring.mvc.validator.ContactNumberConstraint
import org.springframework.data.annotation.CreatedBy
import org.springframework.data.annotation.CreatedDate
import org.springframework.data.annotation.LastModifiedBy
import org.springframework.data.annotation.LastModifiedDate
import java.io.Serializable
import java.util.*
import javax.persistence.*


@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
class Blog: BaseEntity(),  Serializable  {

    @NotNull
    @Size(min=1, max=30)
    @ContactNumberConstraint(message = "自定义验证校验name不符合要求")
    var name: String? = null

    companion object {
       const val serialVersionUID = 1L
    }
}
```

##### 在 BlogController 中标注 @Valid

BlogController.kt

```aidl
    @PostMapping("save")
    fun save(@Valid blog: Blog, request: HttpServletRequest): String {

        if (blog.id != null) {
            val oldBlog = blogDao.findOne(blog.id)
            BeanUtils.copyProperties(oldBlog, blog)
            blogDao.save(oldBlog)
        } else {
            blogDao.save(blog)
        }

        delete("blog-list")
        return "redirect:/blog/list "
    }

```


##### 选用 thymeleaf 做模版引擎，显示validation验证信息

form.html
```aidl
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <title>Create Blog Form</title>

</head>
<body>
<h2>Create Blog Form</h2>
<br/>
<form action="/blog/save" method="post">
    <input type="hidden" name="id" th:if="${blog}!=null" th:value="${blog.id}" />
    <input type="hidden" name="version" th:if="${blog}!=null" th:value="${blog.version}" />

    <lable>Name</lable>
    <br/>
    <input type="text" name="name"  th:if="${blog}!=null" th:value="${blog.name}" />
    <p th:if="${errorsMap!=null and errorsMap.containsKey('name')}" th:text=" ${errorsMap['name']} ">Name Error</p>

    <br/>
    <lable>Reader</lable>
    <br/>
    <input type="text" name="reader" th:if="${blog}!=null" th:value="${blog.reader}" />
    <p th:if="${errorsMap!=null and errorsMap.containsKey('reader')}" th:text=" ${errorsMap['reader']} ">Name Error</p>


    <br/>
    <br/>
    <input type="submit"/>
</form>
</body>
</html>
```

#### 参考

Validating Form Input
https://spring.io/guides/gs/validating-form-input/

Spring MVC Custom Validation
http://www.baeldung.com/spring-mvc-custom-validator

kotlin validation 自定义校验注解 
https://www.jianshu.com/p/4f0f6df12880