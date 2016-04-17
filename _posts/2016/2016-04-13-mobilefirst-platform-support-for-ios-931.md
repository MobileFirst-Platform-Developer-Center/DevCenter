---
title: IBM MobileFirst Platform Foundation support for iOS 9.3.1
date: 2016-04-13
tags:
- MobileFirst_Platform
- iOS
version:
- 7.1
- 7.0
- 6.3
author:
  name: S.A.Norton Stanley
---
![iOS 9.3](https://dl.dropboxusercontent.com/s/las86rdppknh4n1/ios9.3resize.jpg?dl=0)
Apple's iOS 9.3.1 released earlier this March packs in new features to its mobile operating system for iPhone and iPad. The features include a new Night Shift mode, Touch ID security for Notes, greater personalization for News, app discovery in Health, Apple Music and Nearby for CarPlay, and a new education experience for [iOS](http://www.apple.com/ios/updates/).

MobileFirst Platform Foundation v6.3, v7.0, v7.1 has embraced iOS 9.3.1 very well, we tested a bunch of feature like connection to the server, OAuth flow, form based authentication, invoking of JavaScript adapters. All these feature works well, however we did notice few issues which we have documented here.

Known Issues

- With MobileFirst Platform v7.0 and v7.1 we noticed UI issues while the Active notifying dialog is displayed. 
- With MobileFirst Platform v7.0 and Xcode v7.3 we notice issues with WLHttpMethodGet not being recognized as a constant in a Swift app. A workaround could be to use a String "GET" in place of the constant.

We are investigating on these issues and will keep the blog updated as we make progress!

The version of Cordova shipped with MobileFirst Platform has been verified with iOS 9.3.1 and it works well!

Stay tuned for more updates.