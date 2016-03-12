---
title: Logging in iOS Applications
relevantTo: [iOS]
---
## Overview
This tutorial provides the required code snippets in order to add logging capabilities in iOS applications.

## Logging example
Outputs to Xcode console

```objective-c
#import "OCLogger.h"
+ (int) sum:(int) a with:(int) b{
    int sum = a + b;
    [OCLogger setLevel:DEBUG];
    OCLogger* mathLogger = [OCLogger getInstanceWithPackage:@"MathUtils"];
    NSString* logMessage = [NSString stringWithFormat:@"sum called with args %d and %d. Returning %d", a, b, sum];
    [mathLogger debug:logMessage];
    return sum;
}
```

### Additional API Methods For Specific Tasks
Log capture is enabled by default. To turn log capture on or off:

```objective-c
[OCLogger setCapture:NO]
```

The default capture level is FATAL in development and in production. To control the capture level (verbosity):

```objective-c
[OCLogger setLevel:DEBUG];
```

Log sending is enabled by default. To turn automatic log sending on or off:

```objective-c
[OCLogger setAutoSendLogs:NO]
```

> For more information about the `Logger` API, see the API reference in the user documentation.
