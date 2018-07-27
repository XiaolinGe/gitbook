# X-Frame-Options


### Exception

```aidl
Refused to display 'url' in a frame because it set 'X-Frame-Options' to 'deny'.
```

### Solution
在securityConfig里配置http为：http.headers().frameOptions().sameOrigin();


### Reference

https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options

http://caibaojian.com/x-frame-options.html
