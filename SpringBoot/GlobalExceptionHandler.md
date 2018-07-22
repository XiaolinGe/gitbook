# Global Exception Handler (统一异常处理)

demo: spring-mvc-practice

Spring Boot提供了一个默认的映射：/error，当处理中抛出异常之后，会转到该请求中处理，并且该请求有一个全局的错误页面用来展示异常内容。


### 应用

GlobalExceptionHandler.kt

```aidl

import com.spring.mvc.bean.ProductInformation
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.mail.SimpleMailMessage
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.orm.ObjectOptimisticLockingFailureException
import org.springframework.validation.BindException
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.servlet.ModelAndView
import javax.servlet.http.HttpServletRequest


@ControllerAdvice
internal class GlobalExceptionHandler {

    @Autowired
    private val mailSender: JavaMailSender? = null

    @Autowired
    private val productInformation: ProductInformation? = null

    @ExceptionHandler(value = Exception::class)
    fun defaultErrorHandler(req: HttpServletRequest, e: Exception): ModelAndView {

        val piName = productInformation!!.name
        val piVersion = productInformation.version
        println("piName : $piName")
        println("piV : $piVersion")

        e.printStackTrace()
        val mav = ModelAndView()
        mav.addObject("exception", e)
        mav.addObject("url", req.requestURL)
        mav.addObject("name", piName)
        mav.addObject("version", piVersion)
        mav.viewName = DEFAULT_ERROR_VIEW
   
        return mav
    }

    @ExceptionHandler(value = BindException::class)
    fun bindErrorHandler(req: HttpServletRequest, e: Exception): ModelAndView {
        val bindingException = e as BindException
        val bindingResult = bindingException.bindingResult
        val errors = bindingResult.fieldErrors


        val referer = req.getHeader("referer")
        val beanName = referer.substringBeforeLast("/").substringAfterLast("/")
        println("referer: $referer")
        println("beanName: $beanName")

        val errorsMap = mutableMapOf<String, String>()

        errors.forEach {
            // println(it.)
            println(it.field)
            println(it.defaultMessage)
            // println(+" "+ it.defaultMessage)
            errorsMap[it.field] = it.defaultMessage
        }

        println(errorsMap.contains("name"))
        println(errorsMap)
        val mav = ModelAndView()
        mav.addObject("errorsMap", errorsMap)
        mav.viewName = "$beanName/form"
        return mav
    }

    @ExceptionHandler(value = ObjectOptimisticLockingFailureException::class)
    fun optimisticLockingFailureException(req: HttpServletRequest, e: Exception): ModelAndView {
        e.printStackTrace()
        val mav = ModelAndView()
        mav.addObject("exception", e)
        mav.addObject("name", "there is an another user save at same time !")
        mav.addObject("url", req.requestURL)

        mav.viewName = DEFAULT_ERROR_VIEW
        return mav
    }

    companion object {

        const val DEFAULT_ERROR_VIEW = "error"
    }
}
```

error.html
/src/main/resources/templates/error.html
```aidl
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org" xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <title>Error</title>
</head>
<body>
<h1>Error Handler</h1>
<div th:text="${url}"></div>
<div th:text="${name}"></div>
<div th:text="${version}"></div>
<!--
<div th:text="${exception.message}"></div>
-->

</body>
</html>

```