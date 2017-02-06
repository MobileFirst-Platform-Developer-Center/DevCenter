---
title: IBM Mobile Foundation Support for Swift 3.0
date: 2017-02-05
tags:
- MobileFirst_Foundation
- Announcement
- Swift_3
version:
- 8.0

author:
  name: Sandhya Suman
---
Existing native iOS application(s) that were built using MobileFirst Foundation iOS SDK **will work** with Swift 3.0 as they did with previous versions of Swift 2.x.
The MobileFirst Foundation iOS SDK itself is written in Objective-C and hence remain unaffected due to Swift 3.0 changes.

The blog describes the changes that developers might have to incorporate in their iOS Swift 3.0 applications.

#### **Existing application**
* For applications written in Swift, Swift Migration assistant does most of the job to convert a existing Swift application to Swift 3.0 application. Check Swift 3.0 migration guide [here](https://swift.org/migration-guide/).
* Most of our MobileFirst Foundation iOS SDK API method names are now changed by the Swift Migration assistant in order to comply with latest [Swift 3.0 API guidelines](https://swift.org/documentation/api-design-guidelines/#naming)
* Due to the name conversions few of MobileFirst Foundation iOS SDK API method name now looses its meaning. We have incorporated few fixes regarding the same.
* We recommended to use MobileFirst Foundation [iFix 8.0.0.0-IF20170125-0919]({{site.baseurl}}/blog/2017/02/01/8-0-ifix-release/) for Swift 3.0.

#### **Updating to iFix 8.0.0.0-IF20170125-0919**
* Those not yet migrated to Swift 3.0 , and will migrate only after upgrading MobileFirst Foundation iOS SDK to [iFix 8.0.0.0-IF20170125-0919]({{site.baseurl}}/blog/2017/02/01/8-0-ifix-release/) will not see any issues.

* But those who had already migrated to Swift 3.0 , and when they upgrade their MobileFirst Foundation iOS SDK to [iFix 8.0.0.0-IF20170125-0919]({{site.baseurl}}/blog/2017/02/01/8-0-ifix-release/) following steps are required. Replace MobileFirst Foundation API method name from Swift 3.0 converted name to Original MobileFirst Foundation API method name. For example, Replace `WLClient.sharedInstance().register( )` to `WLClient.sharedInstance().registerChallengeHandler( )`

* Here is the list of API method names changed in Swift 3.0
 1._registerChallengeHandler_ of `WLClient.h`
 2._sendUrlRequest_ of `WLClient.h`
 3._canHandleResponse_ of `GatewayChallengeHandler.h`


#### **Support Testing for Swift 3.0**
Following features of MobileFirst Foundation already tested for IBM Mobile Foundation iOS SDK with Swift 3.0.
* OAuth authorization flow
* Adapters
* push notification
* JSONStore
* watchOS

> **Note:** Please watch this space for upcoming fixes in samples and tutorials related to Swift 3 support .
