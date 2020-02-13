---
title: Discontinuation of UIWebView and its implication on MobileFirst apps
date: 2020-01-27
tags:
- MobileFirst_Platform
- MobileFirst_Foundation
- iOS
version:
- 8.0
author:
  name: Sandhya Suman
---
<style>
.audio-background {
  background-image: linear-gradient(to right, rgba(255,255,255,0), #285675);
;
}
</style>
<script>
$('#audioMFWebView').on('ended', function() {
        manageImageObjectsLevel();
}).get(0).play();
</script>

<div class="container audio-background">
  <h3>Listen to the post excerpt</h3>
  <audio id="audioMFWebView" controls>
  <source src="{{site.baseurl}}/assets/blog/2020-01-31-Removal-of-UIWebview/discontinuation-of-uiwebview.mp3" type="audio/mpeg">
  Your browser does not support the audio tag.
  </audio>

</div>
<br/>
[UIWebView](https://developer.apple.com/documentation/uikit/uiwebview) has been deprecated by Apple since June 2018. However, this recent [announcement](https://developer.apple.com/news/?id=12232019b) by Apple brings an end to the use of UIWebView in all iOS apps.

>If your app still embeds web content using the deprecated UIWebView API, we strongly encourage you to update to WKWebView, as soon as possible, for improved security and reliability. WKWebView ensures that compromised web content doesn’t affect the rest of an app by limiting web processing to the app’s web view. It is supported in iOS and macOS, and by Mac Catalyst.
>The App Store will no longer accept new apps using UIWebView as of April 2020 and app updates using UIWebView as of December 2020.

Since iOS 12, Apple began warning developers about migrating to [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview/), UIWebView’s successor. Since last year, the warning `ITMS-90809: UIWebView API Deprecation` was seen during app submission, if the app used UIWebview.

The message you see while you upload app using UIWebview is as below.

>We identified one or more issues with a recent delivery for your app, [App Name & version number]. Your delivery was successful, but you may wish to correct the following issues in your next delivery:

>ITMS-90809: Deprecated API Usage – Apple will stop accepting submissions of apps that use UIWebView APIs. See https://developer.apple.com/documentation/uikit/uiwebview for more information.

>After you’ve corrected the issues, you can use Xcode or Application Loader to upload a new binary to App Store Connect.

Upon app submission, Apple searches the app’s code for the “UIWebView” string then generates a submission warning if found. Therefore, a future release of MobileFirst based apps will be required to ensure that all references to UIWebView APIs are  removed.


## What should you do

We recommend all developers to update their apps. Apple will only accept submissions of iOS apps that contain references to UIWebView until April 2020 (for new apps) and December 2020 (for existing apps). To meet the new requirement, please upgrade your MobileFirst SDK to *iFix 8.0.0.0-IF202001211306*.

If you wish to update from cocopod, please add `pod 'IBMMobileFirstPlatformFoundation' '~>8.0.2020011414'` to your Podfile.

If you’re using Cordova, see below.

### Enabling WkWebview for Cordova/Ionic apps

The Cordova community has released [Cordova iOS 5.1.0](https://cordova.apache.org/announcements/2019/11/25/cordova-ios-release-5.1.0.html), which disables UIWebview at compile time. In order to disable UIWebview with MFP cordova app, use following steps.

1. Upgrade `cordova-plugin-mfp` to  version `8.0.2020012010`.
Ensure you have a WKWebView plugin installed, either the [official Apache](https://github.com/apache/cordova-plugin-wkwebview-engine) one or [Ionic’s](https://github.com/ionic-team/cordova-plugin-ionic-webview).

2. Add following lines to to your config.xml file.

```xml
  <preference name="WKWebViewOnly" value="true" />
```
3. Run `cordova prepare ios` to apply the changes.

4. Link `webkit.framework` to your app in **Build Phases** of your project in Xcode as below.

![Xcode screenshot]({{site.baseurl}}/assets/blog/2020-01-31-IBM-MobileFoundation-UIWebview/webview_mfp_screenshots.png)


>**Note** Ensure that other Cordova plugins that might be using UIWebView are also updated to remove references to UIWebView.
For example, `InAppBrowser plugin`, The Cordova team released an update in January 2020. Be sure to [update](https://cordova.apache.org/announcements/2020/01/08/inappbrowser-release-3.2.0.html) this plugin to version 3.2.0 and above.

>If you are using MobileFirst v7.1, then please read the [blog](https://mobilefirstplatform.ibmcloud.com/blog/2020/01/12/support-new-requirements-mobilefirst-71/) to learn about MobileFirst v7.1 support for the above App Store restriction.
