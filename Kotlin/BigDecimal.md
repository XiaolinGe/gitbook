#BigDecimal 常见用法 

## Double 保留小数点四位，四舍五入

```
(55555!!.toDouble() / 100).doubleFormat2()
    
private fun Double.doubleFormat2(): String = DecimalFormat("#.00").format(this)

private fun Double.doubleFormat4(): String = DecimalFormat("#.0000").format(this)
```

## Double round up keep 2 digit 精确计算

```
wallet.availableAmount = BigDecimal(wallet.availableAmount).plus(BigDecimal(walletDetail.amount)).setScale(2, BigDecimal.ROUND_HALF_UP).toDouble()
```

## Double 科学计数法 转为 数字显示， Double to BigDecimal to String

```
BigDecimal(doubleAmount.toString()).toString()
// Kotlin 中的Double是用科学计数法显示，即 1.2345E, 上面为将其用数字方式显示
```