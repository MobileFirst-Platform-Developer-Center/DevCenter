---
title: Logging in iOS Applications
relevantTo: [iOS]
---
### Logging example for native iOS (Objective-C)
Outputs to Xcode console
```objective-c
#import "OCLogger.h"
+ (int) sum:(int) a with:(int) b{
    int sum = a + b;
    OCLogger* mathLogger = [OCLogger getInstanceWithPackage:@"MathUtils"];
    NSString* logMessage = [NSString stringWithFormat:@"sum called with args %d and %d. Returning %d", a, b, sum];
    [mathLogger debug:logMessage];
    return sum;
}
```
### API calls for specific tasks
Log capture is enabled by default. To turn log capture on or off:

```objective-c
OCLogger.setCapture(NO)
```

The default capture level is DEBUG in development and FATAL in production. To control the capture level (verbosity):

```objective-c
OCLogger.setLevel(OCLogger_DEBUG)
```

Log sending is enabled by default. To turn automatic log sending on or off:

```objective-c
OCLogger.setAutoSendLogs(NO)
```
> For more information about ```objective-cOCLogger API```, see the API reference in the user documentation
