---
title: IBM MobileFirst Platform Foundation support for iOS 10
date: 2016-07-01
tags:
- MobileFirst_Platform
- iOS
version:
- 8.0
- 7.1
- 7.0
- 6.3
author:
  name: Vittal R Pai
---
Apple announced iOS 10 earlier this June during their annual developer conference WWDC. This release of iOS includes many new user and developer oriented features. You can read more about all the new features in iOS 10 [here](http://www.apple.com/newsroom/2016/06/apple-previews-ios-10-biggest-ios-release-ever.html).

We at IBM Labs, tested IBM MobileFirst Platform Foundation with [iOS 10 Beta](https://developer.apple.com/download) release by upgrading an iPhone 6 running iOS 9.3.3. 

![iOS 10]({{site.baseurl}}/assets/blog/2016-07-01-mobilefirst-platform-support-for-ios-10/iOS10.png)

We have tested  our latest release MobileFirst Platform Foundation v8.0 and v7.0 and both these releases of IBM MobileFirst have embraced iOS 10 very well. Using [XCode 8 Beta](https://developer.apple.com/download) to compile MobileFirst apps, we carried out various tests on native iOS applications such as OAuth flow, invoking backend adapters, JSONStore and Application Management. 

We also validated Hybrid/Cordova applications on iOS 10 with the above features. In addition, features like Direct Update also have been validated to work on iOS 10. In summary, all these features work well and we didn't notice any major issues. 

![XCode 8 Beta]({{site.baseurl}}/assets/blog/2016-07-01-mobilefirst-platform-support-for-ios-10/xcode.png)

However, there were a few minor issues we stumbled upon during our testing on iOS 10 Beta release with XCode 8 Beta. 

* `NSLog` does not print messages to the XCode console. Messages however are printed to the device/simulator log file. This is a [known bug](http://adcdownload.apple.com/WWDC_2016/Xcode_8_beta/Release_Notes_for_Xcode_8_beta.pdf) in XCode 8 Beta.
* iOS applications written in Swift need to be migrated to Swift 3.0 or Swift 2.3. We migrated our samples to Swift 3.0 and we were able to perform the migration easliy using the migration guide found [here](https://swift.org/migration-guide).
![Swift 3.0]({{site.baseurl}}/assets/blog/2016-07-01-mobilefirst-platform-support-for-ios-10/swift.png)

We will contiune our validation on iOS 10 for more releases of IBM MobileFirst Platform and features. Keep an eye on this blog post for the latest news.