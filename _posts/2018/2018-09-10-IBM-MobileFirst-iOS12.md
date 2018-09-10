---
title: IBM MobileFirst and iOS12
date: 2018-09-12
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- Announcement
- iOS12
version:
- 7.1
- 8.0
author:
  name: Sandhya Suman


iOS12 is [here](https://developer.apple.com/download/) and IBM MobileFirst is pleased to announce we have embraced the enhancement gracefully like every year.

In our previous [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/), we mentioned about the various new changes seen in iOS12 and what you, as a developer should be doing about it.
We dont see any major impact on existing Mobilefirst apps deployed on user devices after upgrade to iSO12.

With the final release of iOS12, we have validated MobileFirst v8.0 and v7.1 and the all the major features listed below work fine with iOS12.

* Invoking backend procedures through adapters
* Application Authenticity
* Application management
* JSONStore
* Direct Update
* Oauth handshake with Mobile First server
* Push notifications

Swift Apps on iOS12 - [Xcode 10 build](https://developer.apple.com/download) can build targets written in only Swift 4.x or Swift 3. Xcode 10 can be used for migration to Swift 4, This can be easily done using the [migration guide](https://swift.org/migration-guide).Apple introduced  Swift 4.2 to be an intermediate step towards achieving ABI stability in Swift 5, which should enable binary compatibility between applications and libraries compiled with different Swift versions. 

As per Apple, if your app is written in Swift, you can submit your apps to the App Store written in either Swift 3.0 or 2.3. We strongly encourage you to migrate your code to Swift 3. However, if you need to first update your code to Swift 2.3, you can run the Xcode 8 migrator later to move from 2.3 to 3.0.
We have planned to check Swift 4.0 compatibility with MobileFirst Platform Foundation 7.1 and 8.0 in near future and will share the information in a separate post.

### Targeting to build your app with iOS12  

#### MobileFirst v8.0 apps

* If you are planning to build your MobileFirst v8 application for iOS12 you have to get rid of stdc++ library which is removed in iSO12. Refer our previous [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/) for details of the workaround.
If you dont want to go for workaround and looking for a permanent solution upgrade to iFix level

#### Known Issues

MobileFirst Platform provides a framework `IBMMobileFirstPlatformFoundationWatchOS` along with the core `IBMMobileFirstPlatformFoundation` framework to support watchOS 2 onwards, . This framework is currently



### Targeting to build your app with iOS12  
