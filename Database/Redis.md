# Redis 

### 应用

```aidl
    fun <T> get(key: String, supplier: () -> T): T? {

        val redisHasKey = redisTemplate!!.hasKey(key)

        val list = when (redisHasKey) {
            false -> {
                val list = supplier()
                redisTemplate.opsForValue().set(key, list)
                list
            }
            else -> {
                try {
                    redisTemplate.opsForValue().get(key)

                } catch (e: SerializationException) {
                    e.printStackTrace()
                    val list = supplier()
                    redisTemplate.opsForValue().set(key, list)
                    list
                }

            }
        }
        return list as T
    }
```

### 参考