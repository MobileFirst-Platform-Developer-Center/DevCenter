---
layout: tutorial
title: Sample Application for IBM MobileFirst Platform Foundation on IBM Containers
breadcrumb_title: Sample application
relevantTo: [ios,android,cordova]
---
## Overview
To complete your evaluation experience of IBM MobileFirst Platform Foundation on IBM Containers, download the Wishlist sample application.

**Note:** No additional setup is required in your development computer for this evaluation. However, to run *applications on devices*, you might have to go through some prerequisite setup, such as device provisioning in Xcode. Such prerequisite steps are outside of the scope of this tutorial and of IBM MobileFirst Platform.</p>

#### Jumpt to:

* [Wishlist sample application](#wishlist-sample-application)
* [Downloading the sample application](#downloading-the-sample-application)
* [Configuring the sample application](#configuring-the-sample-application)
* [What's next](#whats-next)

## Wishlist sample application
<img alt="Image of the Wishlist application" src="{{ site.baseurl }}/assets/backup/wishlist-app-156x300.png" style="float:right" />

The Wishlist application is meant for iOS, Android, or hybrid environments (iPhone, Android).  
The application implements the following functionality:

* Fetches catalog data (a hard-coded list of items) from a web service by using the catalog adapter.
* Contains a secured wishlist area which allows users to save catalog items or custom items (by manually entering the item details) into a store. By default, the store uses a Cloudant database, but if it is configured otherwise, it can store data by using the local file store.

The wishlist section within the application is accessible via authentication. For demonstration purposes, use "user" and "password" as the user/password.


## Downloading the sample application
#### Native iOS app
[Click to download the native iOS application from GitHub](https://github.com/MobileFirst-Platform-Developer-Center/WishlistiOS/)

#### Native Android app
[Click to download the native Android application from GitHub](https://github.com/MobileFirst-Platform-Developer-Center/WishlistAndroid/)

#### Hybrid app
[Click to download the hybrid application from GitHub](https://github.com/MobileFirst-Platform-Developer-Center/Wishlist/)

## Configuring the sample application
To have the sample application connect to the MobileFirst Server instance that is running in your container, follow the next steps for a hybrid or native app.

<a class="btn" role="button" data-toggle="collapse" href="#collapseHybrid" aria-expanded="false" aria-controls="collapseHybrid">Hybrid sample</a>

<div class="collapse" id="collapseHybrid">
    <div class="well">
        <h4>Open the application in your favorite IDE</h4>
        <ul>
            <li><strong>iOS:</strong> Navigate to the MobileFirstStarter/apps/WishList/iphone/native and double-click the <em>.xcodeproj</em> file.</li>
            <li><strong>Android:</strong> Open the MobileFirstStarter/apps/WishList/android/native folder in Android Studio.</li>
        </ul>

        <h4 id="runNativeApp">Run the application</h4>
        <ul>
            <li>In the container Overview page, find the Server IP address.</li>
            <li>Build and run it in the IDE of the selected environment.</li>
            <li>Run the app from Xcode/Android Studio into your device and supply the IP address in the application UI.</li>
        </ul>
    </div>
</div>

<a class="btn" role="button" data-toggle="collapse" href="#collapseNative" aria-expanded="false" aria-controls="collapseNative">Native sample</a>

<div class="collapse" id="collapseNative">
    <div class="well">
        <h4>Open the application in your favorite IDE</h4>
        <ul>
            <li><strong>iOS:</strong> Navigate to the WishListiOS folder and double-click the <em>.xcworkspace</em> file.</li>
            <li><strong>Android:</strong> Open the WishListAndroid project in Android Studio.</li>
        </ul>

        <h4>Run the application</h4>
        <ul>
            <li>In the container Overview page, find the Server IP address.</li>
            <li>Build and run it in the IDE of the selected environment.</li>
            <li>Run the app from Xcode/Android Studio into your device and supply the IP address in the application UI.</li>
        </ul>
    </div>
</div>

## What's next
You can now edit the application code.

If you are new to developing applications in IBM MobileFirst Platform, you are encouraged [to learn more about it]({{site.baseurl}}/get-introduced/). You can develop applications either in MobileFirst Studio - an Eclipse plug-in that provides an IDE-like experience - or on the Command Line Interface, which you can use with your favorite IDE.

After you've downloaded the tool of your choice, learn about the possibilities [in the Getting Started section]({{site.baseurl/tutorials/en/foundation}}).
