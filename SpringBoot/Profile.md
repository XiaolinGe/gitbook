# Config Profile 

application.profile 


### 知识点

### 应用

application.yml
```aidl
com:
    spring:
        mvc:
            bean:
                blog:
                    name: blog name
product:
    information:
        name: application product information name
        version: 1.0.0

spring:
    aop:
       proxy-target-class: true
    messages:
        fallbackToSystemLocale: true
        basename: i18n/messages
    datasource:
        driver-class-name: com.mysql.jdbc.Driver
        password: root
        url: jdbc:mysql://localhost:3306/blog
        username: root
    jpa:
        hibernate:
            ddl-auto: update 
    thymeleaf:
        cache: false
    redis:
      port: 6379

logging:
  level:
    org:
      hibernate:
        SQL: DEBUG
        type:
          descriptor:
            sql:
              BasicBinder: TRACE
```


### 参考

Guide to @ConfigurationProperties in Spring Boot
http://www.baeldung.com/configuration-properties-in-spring-boot

Spring 自定义properties升级篇【从零开始学Spring Boot】
http://412887952-qq-com.iteye.com/blog/2311017

Spring Boot属性配置文件详解
http://blog.didispace.com/springbootproperties/