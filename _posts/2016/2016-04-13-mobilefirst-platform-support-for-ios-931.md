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
- 6.2
author:
  name: S.A.Norton Stanley
---
![iOS 9.3](https://dl.dropboxusercontent.com/s/las86rdppknh4n1/ios9.3resize.jpg?dl=0)
Apple's iOS 9.3.1 released earlier this March packs in new features to its mobile operating system for iPhone and iPad. The features include a new Night Shift mode, Touch ID security for Notes, greater personalization for News, app discovery in Health, Apple Music and Nearby for CarPlay, and a new education experience for [iOS](http://www.apple.com/ios/updates/).

MobileFirst Platform Foundation v6.2, v6.3, v7.0, v7.1 has embraced iOS 9.3.1 very well, we tested a bunch of feature like connection to the server, OAuth flow, form based authentication, invoking of JavaScript adapters, push notifications. All these features work well, however we did notice few issues which we have documented here.

Known Issues

 - With MobileFirst Platform Foundation v7.0 and v7.1 we noticed the following issues with Remote disable and Active notifying 
 
 	 - UI issues when the dialog is displayed for  Remote disable and Active notifying. (Update: These issues were seen with some older versions of MobileFirst Platform Foundation v7.0/v7.1. Updating to the latest iFix of IBM MobileFirst Platform Foundation v7.0/v7.1 will resolve the above mentioned issues.)

 	 - The Locale for Remote disable and Active notifying dialog does not change according to the device locale.
 	 

 - With MobileFirst Platform Foundation v7.0 and Xcode v7.3 we notice issues with WLHttpMethodGet not being recognized as a constant in a Swift v2.2 app. A workaround could be to use a String "GET" in place of the constant. **Update:** This issue can be resolved by updating XCode to version 7.3.1. 

 - Devices running iOS 9.3 or 9.3.1 cannot install, or upgrade existing applications from the MobileFirst Application Center. There is an APAR in place to address this issue.


The version of Cordova shipped with MobileFirst Platform has been verified with iOS 9.3.1 and it works well!

Stay tuned for more updates.