# Send Email 

demo: spring-mvc-practice

### Spring Boot中使用JavaMailSender发送邮件

pring提供了非常好用的JavaMailSender接口实现邮件发送。在Spring Boot的Starter模块中也为此提供了自动化配置。下面通过实例看看如何在Spring Boot中使用JavaMailSender发送邮件。

### 应用

gradle.build

```aidl
compile "org.springframework.boot:spring-boot-starter-mail:1.5.8.RELEASE"

```

application.yml
```aidl
spring:
    mail:
        host: smtp.office365.com
        password: xxx
        port: 587
        properties:
            mail:
                smtp:
                    auth: true
                    connectiontimeout: 5000
                    socketFactory: 
                        fallback: false
                    starttls:
                        enable: true
                        required: true
                    timeout: 5000
                    writetimeout: 5000
        username: webservice@test.co.nz
```


controller

```aidl
    fun sendEmail() {
        val message = SimpleMailMessage()
        message.from = "webservice@test.co.nz"
        message.setTo("test@gmail.com")
        message.subject = "主题：测试异常"
        message.text = "测试邮件内容"

        mailSender!!.send(message)
    }

```