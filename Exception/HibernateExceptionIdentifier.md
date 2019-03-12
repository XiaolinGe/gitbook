# org.hibernate.HibernateException


identifier of an instance of com.spring.mvc.bean.Beneficiary was altered from 1 to 0


### Exception

```aidl
org.hibernate.HibernateException: identifier of an instance of com.spring.mvc.bean.Beneficiary was altered from 1 to 0
	at org.hibernate.event.internal.DefaultFlushEntityEventListener.checkId(DefaultFlushEntityEventListener.java:64) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.event.internal.DefaultFlushEntityEventListener.getValues(DefaultFlushEntityEventListener.java:175) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.event.internal.DefaultFlushEntityEventListener.onFlushEntity(DefaultFlushEntityEventListener.java:135) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.event.internal.AbstractFlushingEventListener.flushEntities(AbstractFlushingEventListener.java:216) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.event.internal.AbstractFlushingEventListener.flushEverythingToExecutions(AbstractFlushingEventListener.java:85) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.event.internal.DefaultFlushEventListener.onFlush(DefaultFlushEventListener.java:38) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.internal.SessionImpl.flush(SessionImpl.java:1282) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.internal.SessionImpl.managedFlush(SessionImpl.java:465) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.internal.SessionImpl.flushBeforeTransactionCompletion(SessionImpl.java:2963) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.internal.SessionImpl.beforeTransactionCompletion(SessionImpl.java:2339) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.engine.jdbc.internal.JdbcCoordinatorImpl.beforeTransactionCompletion(JdbcCoordinatorImpl.java:485) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.resource.transaction.backend.jdbc.internal.JdbcResourceLocalTransactionCoordinatorImpl.beforeCompletionCallback(JdbcResourceLocalTransactionCoordinatorImpl.java:147) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.resource.transaction.backend.jdbc.internal.JdbcResourceLocalTransactionCoordinatorImpl.access$100(JdbcResourceLocalTransactionCoordinatorImpl.java:38) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.resource.transaction.backend.jdbc.internal.JdbcResourceLocalTransactionCoordinatorImpl$TransactionDriverControlImpl.commit(JdbcResourceLocalTransactionCoordinatorImpl.java:231) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.engine.transaction.internal.TransactionImpl.commit(TransactionImpl.java:65) ~[hibernate-core-5.0.12.Final.jar:5.0.12.Final]
	at org.hibernate.jpa.internal.TransactionImpl.commit(TransactionImpl.java:61) ~[hibernate-entitymanager-5.0.12.Final.jar:5.0.12.Final]
	at org.springframework.orm.jpa.JpaTransactionManager.doCommit(JpaTransactionManager.java:517) ~[spring-orm-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.transaction.support.AbstractPlatformTransactionManager.processCommit(AbstractPlatformTransactionManager.java:761) ~[spring-tx-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.transaction.support.AbstractPlatformTransactionManager.commit(AbstractPlatformTransactionManager.java:730) ~[spring-tx-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.transaction.interceptor.TransactionAspectSupport.commitTransactionAfterReturning(TransactionAspectSupport.java:504) ~[spring-tx-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:292) ~[spring-tx-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96) ~[spring-tx-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179) ~[spring-aop-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:136) ~[spring-tx-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179) ~[spring-aop-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.data.jpa.repository.support.CrudMethodMetadataPostProcessor$CrudMethodMetadataPopulatingMethodInterceptor.invoke(CrudMethodMetadataPostProcessor.java:133) ~[spring-data-jpa-1.11.8.RELEASE.jar:na]
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179) ~[spring-aop-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92) ~[spring-aop-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179) ~[spring-aop-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.data.repository.core.support.SurroundingTransactionDetectorMethodInterceptor.invoke(SurroundingTransactionDetectorMethodInterceptor.java:57) ~[spring-data-commons-1.13.8.RELEASE.jar:na]
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179) ~[spring-aop-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:213) ~[spring-aop-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at com.sun.proxy.$Proxy122.save(Unknown Source) ~[na:na]
	at com.spring.mvc.controller.BeneficiaryController.update(BeneficiaryController.kt:46) ~[classes/:na]
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:1.8.0_162]
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:1.8.0_162]
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:1.8.0_162]
	at java.lang.reflect.Method.invoke(Method.java:498) ~[na:1.8.0_162]
	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:116) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:963) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:897) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846) ~[spring-webmvc-4.3.6.RELEASE.jar:4.3.6.RELEASE]
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52) ~[tomcat-embed-websocket-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107) ~[spring-web-4.3.12.RELEASE.jar:4.3.12.RELEASE]
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199) ~[tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1459) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [na:1.8.0_162]
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [na:1.8.0_162]
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61) [tomcat-embed-core-8.5.23.jar:8.5.23]
	at java.lang.Thread.run(Thread.java:748) [na:1.8.0_162]
```


### Reason

```aidl

import org.apache.commons.beanutils.BeanUtils

    @PostMapping("/update")
    fun update(@RequestParam(required = false) id: Int?, @RequestBody beneficiary: Beneficiary): String {
        var old = beneficiaryDao.findOne(id)
        old.bbas = beneficiary.bbas
        BeanUtils.copyProperties(old, beneficiary)
        beneficiaryDao.save(old)
        return "update successful"
    }
```

update 的对象 Beneficiary 主键 id 为 null, 原因是因为 BeanUtils.copyProperties convert id Int as null !!


### Solution



### Reference   
   
https://stackoverflow.com/questions/4179166/hibernate-how-to-fix-identifier-of-an-instance-altered-from-x-to-y

https://stackoverflow.com/questions/8295895/beanutils-copyproperties-convert-integer-null-to-0
