---
title: Logging in Android Applications
relevantTo: [android]
---
Android MobileFirst Platform SDK cannot persistently capture log data until the ```com.worklight.common.Logger.setContext(Context)``` method is called.

#### Logging example for native Android (Java):
Outputs to LogCat:

```java
import com.worklight.common.Logger;

public class MathUtils{
  private static final Logger logger = Logger.getInstance(MathUtils.class.getName());
  public int sum(final int a, final int b){
  int sum = a + b;
  logger.debug("sum called with args " + a + " and " + b + ".       Returning " + sum);
  return sum;
  }
}
```

### API calls for specific tasks
Log capture is enabled by default. To turn log capture on or off:

```java
Logger.setCapture(false)
```

The default capture level is DEBUG in development and FATAL in production. To control the capture level (verbosity):

```java
Logger.setLevel(Logger.FATAL)
```

Log sending is enabled by default. To turn automatic log sending on or off:

```java
Logger.setAutoSendLogs(false)
```

> For more information about ```Logger API```, see the API reference in the user documentation
