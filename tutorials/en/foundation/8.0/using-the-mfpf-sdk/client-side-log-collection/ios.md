---
layout: tutorial
title: Logging in iOS Applications
relevantTo: [ios]
weight: 2
---
## Overview
This tutorial provides the required code snippets in order to add logging capabilities in iOS applications.

**Prerequisite:** Make sure to read the [overview of client-side log collection](../).

## Logging example
Outputs to Xcode console

```objc
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

```objc
[OCLogger setCapture:NO]
```

The default capture level is FATAL in development and in production. To control the capture level (verbosity):

```objc
[OCLogger setLevel:DEBUG];
```

Log sending is enabled by default. To turn automatic log sending on or off:

```objc
[OCLogger setAutoSendLogs:NO]
```

> For more information about the `Logger` API, see the API reference in the user documentation.
