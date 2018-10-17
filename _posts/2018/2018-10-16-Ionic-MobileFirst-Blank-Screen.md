---
title: Compatibility issues with MobileFirst Plugin for Cordova and Ionic Webview 2.x
date: 2018-10-16
tags:
- MobileFirst_Foundation
- iOS
- Ionic
version:
- 8.0
author:
  name: Vittal Pai
additional_authors:
- Srihari Kulkarni
---

Ionic Developers - take note! If you now create a new Ionic project and add the [MobileFirst Plugin](https://www.npmjs.com/package/cordova-plugin-mfp) to your Ionic app, you will see that the app launches and after getting past the splash screen displays a blank white screen as seen in the screenshot below. If you're affected by this, read on to know why this happens and how to resolve the issue. 


### The Cause 
The default WebView that is added to this project on iOS (as of today) is `cordova-plugin-ionic-weview@2.2.0`. `cordova-plugin-ionic-webview` versions 2.x has an [issue](https://github.com/ionic-team/cordova-plugin-ionic-webview/issues/195) wherein a page with an absolute URI is not rendered. Ionic apps make use of relative URIs by default and hence are not affected by this issue. However, this issue surfaces in apps that have the MobileFirst plugin. This is because MobileFirst makes use of absolute URLs for the HTML files. This is by design of the MobileFirst SDK. 

![Blank Screen on an Ionic App]({{site.baseurl}}/assets/blog/2018-10-16-Ionic-MobileFirst-Blank-Screen/ionic-blank-screen.png)	
![Correct rendering of the UI after replacing the webview]({{site.baseurl}}/assets/blog/2018-10-16-Ionic-MobileFirst-Blank-Screen/ionic-old-webview.png)

### The Solution
The current solution is to simply replace the `cordova-plugin-ionic-webview` plugin to the compatible version (1.2.1). To do so, navigate to the folder of your Ionic project. 
Then, remove the existing `cordova-plugin-ionic-webview` plugin

```bash
ionic cordova plugin remove cordova-plugin-ionic-webview
```

And add the older version of the plugin

```bash
ionic cordova plugin add cordova-plugin-ionic-webview@1.2.1
``` 

Then, do a cordova prepare 

```bash
ionic cordova prepare
```

If you are affected by this issue, feel free to vote on the Git issue [here](https://github.com/ionic-team/cordova-plugin-ionic-webview/issues/195).
