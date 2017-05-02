---
title: Extended application authenticity feature does not work in MobileFirst Platform on iOS v7.x and v8.0
date: 2017-04-17
tags:
- MobileFirst_Foundation
- Extended_Application_Authenticity
- Dynamic_Application_Authenticity
- iOS
version:
- 8.0
- 7.1
- 7.0
author:
    name: Raghunathan Krishnamurthy
---
> This blog is an update to the issue described in the blog [Note About Application Authenticity Failures in Applications Downloaded from the Apple App Store](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/19/application-authenticity-failure-ios-app-store/)

Application authenticity feature in MobileFirst Platform Foundation (MFPF) protects the customer's back-end systems and APIs from being exposed to fake apps. This is achieved by testing whether an app that tries to access the MobileFirst Foundation server has the unique characteristics of a genuine app accessing the server. Two levels of application authentication can be configured, *Basic* and *Extended*.
The difference between *Basic* and *Extended* application authenticity is in the type and the number of characteristics that are taken into account when verifying the app's identity.

>The application characteristics used in *Extended* application authenticity relies on the structure of the binary app that gets downloaded to the mobile device.
Apple changed this structure recently, breaking the extended application authenticity functionality in MobileFirst Platform Foundation on iOS.

[Apple's changes to the app binary formats](https://developer.apple.com/library/content/documentation/IDEs/Conceptual/AppDistributionGuide/AppThinning/AppThinning.html) were introduced after IBM released MFPF v7.x and v8.0, hence the extended app authenticity functionality does not work for all these releases. This is not a product defect, however, this problem was created by a change introduced by the third-party vendor, without any prior notice to app developers or mobile platform vendors. The application authenticity feature works fine if the application binary is distributed using IBM Application Center, other enterprise stores, MDM solutions or Apple TestFlight. The feature fails to work only when uploaded and distributed through Apple AppStore

After a thorough technical analysis of the Apple's new app binary formats enhancement, MFPF product team has come to the conclusion that the application authenticity feature cannot be supported instead this feature has to be redesigned to avoid any dependency on Apple's app binary formats.
The resolution is complex as it needs to accomplish the following:

* determine the authenticity of the application

+ maximize the chance that the algorithm will not break when Apple changes anything in their binary structure in the future

+ minimize the burden this feature puts on developers and administrators.

>Keeping this in mind, MFPF team completely re-architected the app authenticity feature and released the same for MFPF v8.0 as [Dynamic App Authenticity](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity/).

To use *Dynamic App Authenticity*, customers need to use SDK version released in February 2017 or later. This also requires corresponding changes to be available on the MFPF server side. If either the client or the server is not at the desired level, then an exception will be thrown and the user will need to upgrade them to the required levels.

Due to the complexity of the design changes to be implemented for the *Dynamic App Authenticity* feature, the underlying differences in the existing design for product versions MFPF v7.x and v8.0 and considering the fact that all the major changes would need to be rolled out even for those customers who do not want extended app authenticity, this feature is made available only on MFPF v8.0 and above.
>The *Dynamic App Authenticity* feature will not be backported to MFPF v7.x.

All the existing customers running MFPF v7.x can continue to use Basic App authentication on iOS, or can upgrade to v8.0 to use *Dynamic App Authentication*.
