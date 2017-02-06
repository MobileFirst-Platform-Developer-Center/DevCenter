---
title: IBM MobileFirst Foundation Support for Swift 3.0
date: 2017-02-06
tags:
- MobileFirst_Foundation
- Announcement
- Swift_3
version:
- 8.0

author:
  name: Sandhya Suman
---
Starting with [iFix 8.0.0.0-IF20170125-0919]({{site.baseurl}}/blog/2017/02/01/8-0-ifix-release/) for MobileFirst Foundation 8.0, we now support Swift 3.0 for iOS application development.

To update the SDK:

1. From Terminal, navigate to the Xcode project's root folder.
2. Run the command: `pod update`
3. Open the Xcode project and re-build it.

> **Note:** The Swift Migration assistant for Swift 3.0 modifies several method signatures of APIs belonging to the iOS SDK. To prevent syntax errors, be sure to first update the iOS SDK and only then migrate to Swift 3.0.

The update to the SDK makes sure that the following APIs will not break during the Swift Migration assistant's migration process:

* `registerChallengeHandler`
* `sendUrlRequest`
* `canHandleResponse`