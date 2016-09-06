---
title: Compatibility tests for iOS 10 with supported MobileFirst Platform Foundation releases
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
Apple announced iOS 10 mid-June during their annual WWDC conference. This release of iOS includes many new user and developer oriented features. You can read more about all the new features in iOS 10 [in this news bulletin](http://www.apple.com/newsroom/2016/06/apple-previews-ios-10-biggest-ios-release-ever.html).

We encourage you to start testing your application(s) with iOS 10.  
Please see [our support plan for iOS 10]({{site.baseurl}}/blog/2016/06/05/support-plan-for-ios-10/).

### iOS 10 beta 1

Compatibility tests with [iOS 10 beta 1](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 9.3.3 to iOS 10 beta 1.

For the tests, [XCode 8 beta 1](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Analytics

All the above features were validated to work on iOS 10 beta 1.  


### iOS 10 beta 2

Compatibility tests with [iOS 10 beta 2](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10 beta 1 to iOS 10 beta 2.

For the tests, [XCode 8 beta 2](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Analytics

All the above features were validated to work on iOS 10 beta 2.  

### iOS 10 beta 3

Compatibility tests with [iOS 10 beta 3](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10 beta 2 to iOS 10 beta 3.

For the tests, [XCode 8 beta 3](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Analytics

All the above features were validated to work on iOS 10 beta 3.

### iOS 10 beta 4

Compatibility tests with [iOS 10 beta 4](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10 beta 3 to iOS 10 beta 4.

For the tests, [XCode 8 beta 4](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management

All the above features were validated to work on iOS 10 beta 4. 

### iOS 10 beta 7

Compatibility tests with [iOS 10 beta 7](https://developer.apple.com/download) have been performed for MobileFirst Platform Foundation 6.3 to 7.1 as well as MobileFirst Foundation 8.0 using an iPhone 6 that was upgraded from iOS 10 beta 4 to iOS 10 beta 7.

For the tests, [XCode 8 beta 6](https://developer.apple.com/download) was used to compile native, hybrid and Cordova apps.  
Highlighted features that were tested are: 

* OAuth authorization flow
* Adapters
* JSONStore
* Direct Update
* Application Management
* Mobilefirst Application Center

All the above features were validated to work on iOS 10 beta 7. 

However, there are few issues that were stumbled upon during our testing:

* `Push notification` and `Simple Data Sharing` feature is not working as expected in iOS 10. We are looking into these issues.
**Update** : `Simple Data Sharing` feature is working properly in iOS 10 beta 7 onwards.
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="PushNotificationIssue">
            <h4 class="panel-title">
                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#pushissue" aria-expanded="false" aria-controls="collapseTwo">More detail on Push notification feature issue on iOS 10</a>
            </h4>
        </div>
        <div id="pushissue" class="panel-collapse collapse" role="tabpanel" aria-labelledby="PushNotificationIssue">
            <div class="panel-body">
                <p><h4>Push Notification Issue Faced</h4>
                <p>Token retrieval for the device registration fails in iOS 10 since Apple has a new API for device registration. The old API doesn’t work anymore in iOS 10.  Existing Registered users will not face any issues when moving to iOS 10 as the device token would already have been retrieved and stored in the server. The APIs to send the notifications have not been changed, hence, sending of push notification functionality is not affected.
                New app installation followed by the device registration will fail in iOS10.</p>  
               </p>
               <h4>Push Notification Fix</h4>
               <p><b>Note:</b> Push SDK would be updated when the iOS 10 release is made.  This fix is applicable only after the SDK update.</p>
               <p>Following are the steps to be followed in the app to work with iOS10 :</p>
                        <ul>
                            <li>Upgrade your Xcode version to 8</li>
                            <li>Open the application in the Xcode 8</li>
                            <li><p>Enable Push Notifications capability in the app</p>
                             <img alt="Push Notification Capability" src="{{site.baseurl}}/assets/blog/2016-07-01-compatibility-tests-for-ios-10/capability.png"/></li>
                            <li><p>Add the required frameworks to the app. – Click on the <b>+</b> symbol in the Build Phases/Link Binary With Libraries</p>
                            <img alt="Add notification frameworks" src="{{site.baseurl}}/assets/blog/2016-07-01-compatibility-tests-for-ios-10/linkframeworks.png"/>
                            <img alt="Notification Frameworks" src="{{site.baseurl}}/assets/blog/2016-07-01-compatibility-tests-for-ios-10/notificationframework.png"/>
                            <p>Both the <code>UserNotifications.framework</code> and <code>UserNotificationsUI.framework</code> is required for the notifications to work in iOS10</p></li>
                            <li>Build the application</li>
                            <li>Push the updated application to the appcenter or App Store</li>
                            <li>When the mobile app receives the update, device registration and other functionalities starts working</li>
                        </ul>
                <br/>
            </div>
        </div>
    </div>
* `NSLog` does not print messages to the XCode console. Messages however are printed to the device/simulator log file. This is a [known bug](http://adcdownload.apple.com/WWDC_2016/Xcode_8_beta/Release_Notes_for_Xcode_8_beta.pdf) in XCode 8 beta 1.
* iOS applications written in Swift need to be migrated to Swift 3.0 or Swift 2.3. We migrated our samples to Swift 3.0 and we were able to perform the migration easliy using the migration guide [provided by Apple](https://swift.org/migration-guide).
* `NSContactsUsageDescription` or `NSMicrophoneUsageDescription` keys are now mandatory in the plist file while accessing contacts or microphone in cordova/hybrid iOS application. This affects users who use `cordova-plugin-contact` or `cordova-plugin-media` API's. The fix is simply to include those keys in application plist file.
* `Push notification` is not working in `Mobilefirst Application Center` due to iOS 10 Push API changes. We are working on this issue.
* If your application crashes because of 'KeyChain' - It happens because Apple changed the way of working with keychain in iOS 10. To fix this issue you simply should go to Targets->Capabilities and enable keychain sharing. 

We will continue our validation on iOS 10 as Apple releases more beta builds, and update this blog post with our findings.