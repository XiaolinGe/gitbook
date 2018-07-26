# Gatling

性能测试工具，可模拟高并发，并生成报表

### 应用

pom.xml

```aidl
    <build>
        <plugins>
            <plugin>
                <groupId>io.gatling</groupId>
                <artifactId>gatling-maven-plugin</artifactId>
                <version>${gatling-plugin.version}</version>
                <configuration>
                    <!-- 测试脚本 -->
                      <simulationClass>com.anoyi.test.BuyProductTest</simulationClass>
                    <!-- 结果输出地址 -->
                    <resultsFolder>/Users/xiaolinge/Desktop/gatling</resultsFolder>
                </configuration>
            </plugin>
        </plugins>
    </build>
```

BuyProductTest.kt
```aidl
import java.util.concurrent.TimeUnit

import io.gatling.core.Predef._
import io.gatling.core.scenario.Simulation
import io.gatling.core.structure.ScenarioBuilder
import io.gatling.http.Predef._

import scala.concurrent.duration.{Duration, FiniteDuration}

class BuyProductTest extends Simulation {

  val scn: ScenarioBuilder = scenario("Rate")
    .repeat(5, "n") {
    exec(
      http("Rare-API")
        .get("http://localhost:8080/product/buy2?id=1")
        .header("Content-Type", "application/json")
        .check(status.is(200))
    ).pause(Duration.apply(1000, TimeUnit.MILLISECONDS))
  }

  setUp(scn.inject(atOnceUsers(2)))
    .maxDuration(FiniteDuration.apply(5, "minutes"))

}
```


### 参考

性能测试之Gatling
http://blog.didispace.com/%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95%E4%B9%8BGatling/