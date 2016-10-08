---
title: Integrating IBM MobileFirst Foundation 8.0-based Android applications with IBM Bluemix Push Services
date: 2016-10-08
version:
- 8.0
tags:
- Bluemix
- MobileFirst_Foundation
- Bluemix_Push_Service
- Android
author:
  name: Josephine E. Justin 
---
## Overview
Applications using the MobileFirst Foundation SDK can be integrated with Bluemix Push Services for the applications to receive notifications.  
Follow the instructions in this blog post in order to integrate your Android application with the Bluemix Push Notifications service.

> Learn more about [IBM Bluemix Push Notificaitons service](https://new-console.ng.bluemix.net/docs/services/mobilepush/c_overview_push.html) and [IBM Bluemix Mobile Foundation service](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/bluemix/)

### Prerequisites
1. Running a MobileFirst Server either locally or a Mobile Foundation service instance.
2. Instance of [IBM Bluemix Push Notification](https://new-console.ng.bluemix.net/catalog/services/push-notifications/)
3. Push Notification instance created at step 2 should be configured with GCM credentials.
4. Push Notification instance created at step 2 should contain few tags. 

## Setting up the Android application
For the purpose of this blog post, the [RememberMe Android sample application]https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/user-authentication/android/ is used. Download the sample application and follow the instructions in the README.md file to setup and run the app.

## Adding the IBM Bluemix Push Service SDK 
With the application setup and working, we will add the push functionalities into the app using the IBM Bluemix Push Service SDK.

* Open the **build.gradle** of the app (located at **RememberMeAndroid/app**)
* Remove the existing dependency of the **ibmmobilefirstplatformfoundation**
* Add the below dependencies:
```xml
compile ('com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.+@aar'){  
    transitive = false
}
compile ('com.ibm.mobilefirstplatform.clientsdk.android:push:2.+@aar') {
    transitive = true
    exclude module: 'okhttp'
}
compile "com.google.android.gms:play-services-gcm:9.0.2"
```

> **Note:** The **okhttp** module is bundled with both the MFP SDK and the Push SDK.  This will cause runtime issues, and to avoid it exclude the module from the Push SDK dependencies.

## Adding Push Related artifacts into the App
### Initializing the IBM Bluemix Push Service 
Add the following code to the `RememberMeApplication.onCreate()` function. This code initializes the BMS Push Client and this needs to be called only once per application.

```java
String appRoute = "<appRoute of your Push Notification instance>";
String appGuid = "<app GUID of your Pus Notification instance>";

try {
    BMSClient.getInstance().initialize(getApplicationContext(),   
    appRoute , appGuid, BMSClient.REGION_US_SOUTH);
} catch (MalformedURLException e){
    e.printStackTrace();
}

MFPPush.getInstance().initialize(getApplicationContext(),appGuid,   
"<Client Secret of your Push Notification Instance");
```

### Notification Receiving related artifacts
For the application to listen for the notifications, add the below in the **AndroidManifest.xml**.  

* Add the following to the top of the **manifest** tag

```xml
<!-- Permissions -->
<uses-permission android:name="android.permission.WAKE_LOCK" />

<!-- GCM Permissions -->
<uses-permission     
android:name="com.google.android.c2dm.permission.RECEIVE" />

<permission  
android:name="your.application.package.name.permission.C2D_MESSAGE" android:protectionLevel="signature" />
```

* Add the following push intent service and listener service to the application tag

```xml
<!-- GCM Receiver -->
<receiver
    android:name="com.google.android.gms.gcm.GcmReceiver"
    android:exported="true"
    android:permission="com.google.android.c2dm.permission.SEND">
    <intent-filter>
     <action android:name="com.google.android.c2dm.intent.RECEIVE"/>
     <category android:name="your.application.package.name" />
    </intent-filter>
</receiver>

<!-- MFPPush Intent Service -->
<service
  android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.android.c2dm.intent.RECEIVE" />
    </intent-filter>
</service>
```

## Implementing the Push Functionality using SDK

> **Note:** You can choose to create a new button in the `ProtectedActivity` code for push related functionalities. For simplicity the instructions here reuse the “Get Balance” button as the “Push Registration” button. Modify the getBalance button in **activity_protected.xml** accordingly.

On a click of button, registration of the device and tags subscriptions would happen in this app. Call the Push SDK in the ProtectedActivity “on click” event of the button. 

For more details on the SDK refer [here](https://new-console.ng.bluemix.net/docs/services/mobilepush/c_android_enable.html)

## Sending the Notification
To send the notification, one can use the Push Notification dashboard on the IBM Bluemix. [See the send API](https://new-console.ng.bluemix.net/docs/services/mobilepush/c_android_enable.html#send) for more details on sending the notification.

![Demo flow for blog post]({{site.baseurl}}/assets/blog/2016-10-08-integrating-ibm-bluemix-push-services-with-mobilefirst-foundation-android-apps/AndroidMobileFirst.png)