---
title: IBM MobileFirst Foundation 8.0 Support for Swift 3.0
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

> **Note:** The Swift Migration assistant for Swift 3.0 modifies several API method signatures belonging to the iOS SDK. To prevent syntax errors, be sure to first update the iOS SDK and only then migrate to Swift 3.0.

The update to the iOS SDK makes sure that the following APIs will not break during the Swift Migration assistant's migration process:

* `registerChallengeHandler`
* `sendUrlRequest`
* `canHandleResponse`

> **Update:** We now claim support for Swift 3.0 for MobileFirst platform v6.3 to v7.1 without any changes to API naming.All the features of IBM MobileFirst Platform v6.3 to v7.1 work as expected. Existing apps when upgraded to Swift 3.0 work seamlessly.

**Limitation:** Live Update SDK is not yet tested for Swift 3.x. Please watch this space for upcoming fixes in Live Update SDK, samples and tutorials related to Swift 3 support .
