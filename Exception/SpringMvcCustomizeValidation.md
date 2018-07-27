# Spring Mvc Customize Validation

### Exception

```aidl
HV000030: No validator could be found for constraint 'com.spring.mvc.validator.ContactNumberConstraint' validating type 'java.lang.Integer'. Check configuration for 'reader'
```

### Reason

@Constraint 没有配置validatedBy：  @Constraint(validatedBy = [ContactNumberValidator::class])

### Reference

https://blog.csdn.net/hanchao5272/article/details/79090765

https://www.jianshu.com/p/4f0f6df12880


### Solution

```aidl
import javax.validation.Constraint
import javax.validation.ReportAsSingleViolation
import kotlin.reflect.KClass

@MustBeDocumented
@Constraint(validatedBy = [ContactNumberValidator::class])  /* 需要注明 */
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

*** test script