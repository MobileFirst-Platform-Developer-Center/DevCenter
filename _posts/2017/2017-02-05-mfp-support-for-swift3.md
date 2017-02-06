---
title: IBM MobileFirst Platform Foundation Support for Swift 3.0
date: 2017-02-05
tags:
- MobileFirst_Platform
- Announcement
- Swift 3.0
version:
- 8.0

author:
  name: Sandhya Suman
---
Existing native iOS application(s) that were built using MobileFirst Platform v8.0 iOS SDK **will work** with Swift 3.0 as they did with previous versions of Swift 2.x.
The MobileFirst Platform Foundation itself is written in Objective C and hence remain unaffected due to Swift 3.0 changes.

The blog inscribes the steps that developers might have to incorporate in their iOS Swift 3.0 applications.

#### **Existing application**
* For applications written in Swift, Swift Migration assistant does most of the job to convert a existing Swift application to Swift 3.0 application. Check Swift 3.0 migration guide [here](https://swift.org/migration-guide/).
* For MobileFirst Foundation framework written in Objective C , XCode creates an extra layer between Swift to Objective C that is used as an adapter between these 2 languages.The default naming convention of this layer doesn't match many of our MobileFirst Platform iOS API methods names.This happens because Swift 3.0 has changed  their Objective-C translator. Check [here](https://github.com/apple/swift-evolution/blob/master/proposals/0005-objective-c-name-translation.md)
* Most of our MobileFirst Platform iOS API method names are now changed by the Objective-C translator in order to comply with latest [Swift 3.0 API guidelines](https://swift.org/documentation/api-design-guidelines/#naming)
* Due to the name conversions many of MobileFirst Platform API method name now looses its meaning. For example Swift 3 renamed our `WLClient.sharedInstance().registerChallengeHandler( ) `to `WLClient.sharedInstance().register( )`

#### **Updating to iFix**
We fixed name conversion of few such API and forcing Swift 3.0 to retain the original API method name.
For example _registerChallengeHandler_ , _sendUrlRequest_ of `WLClient.h`

* Those not yet migrated to Swift 3.0 , and will migrate only after upgrading MobileFirst Platform iOS SDK to [iFix 8.0.0.0-IF20170125-0919]({{site.baseurl}}/blog/2017/02/01/8-0-ifix-release/) will not see any issues.

* But those who had already migrated to Swift 3.0 , and when they upgrade their MobileFirst Platform 8.0 iOS SDK to [iFix 8.0.0.0-IF20170125-0919]({{site.baseurl}}/blog/2017/02/01/8-0-ifix-release/) following steps are required. Replace Mobilefirst Platform API method name from Swift 3.0 converted name to Original API method name. e.g. `WLClient.sharedInstance().register( )` to `WLClient.sharedInstance().registerChallengeHandler( )`


#### **Support Testing for Swift 3.0**
Following feature of MobileFirst Platform Foundation already tested for MobileFirst Platform iOS sdk version 8.0 [iFix 8.0.0.0-IF20170125-0919]({{site.baseurl}}/blog/2017/02/01/8-0-ifix-release/) with Swift 3.0.
* OAuth authorization flow
* Adapters
* push notification
* json store
* watchOS

> **Note:** Please watch this space for upcoming fixes in samples and tutorials related to Swift 3 support .
