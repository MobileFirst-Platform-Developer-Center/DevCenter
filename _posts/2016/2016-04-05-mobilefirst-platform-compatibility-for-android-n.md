---
title: MobileFirst Platform Foundation compatibility for Android N
date: 2016-04-05
tags:
- MobileFirst_Platform
- Announcement
- Android
version:
- 6.3
- 7.0
- 7.1
- 8.0

author:
  name: S.A.Norton Stanley
---
![Android N]({{site.baseurl}}/assets/blog/2016-04-05-mobilefirst-platform-compatibility-for-android-n/mfpcompatibilityandroidn.png)
Google has rolled out the final version of [Android 7.0 Nougat](http://android-developers.blogspot.in/2016/08/taking-final-wrapper-off-of-nougat.html). 

Android 7.0 has a whole bunch of new [features](https://www.android.com/versions/nougat-7-0/) like Multi-window support, Notification enhancements, Doze on the go, Data Saver.

MobileFirst Platform Foundation v6.3 to v8.0 has embraced Android 7.0 very well. A bunch of powerful features like adapter based authentication, custom authentication, form based authentication, invoking adapter procedures, application management, direct update, push notification that are offered by the MobileFirst Platform Foundation has been verified to work without any issues on the final version of Android 7.0. A sanity check has been performed to ensure that all the existing native Android and hybrid apps built on Android Marshmallow work on Android Nougat platform.

We encourage you to start testing your application(s) with Android N. Please see [IBM MobileFirst Platform Foundation's support plan for Android 7.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/07/14/support-plan-for-android-n/).

## Known Issues

#### JSONStore API
   The MobileFirst Platform Foundation's JSONStore API does not work as expected on Android N, with the [behavior changes](https://developer.android.com/preview/behavior-changes.html#ndk) introduced in Android N for NDK applications. The change in Android N is to remove support for linking against non-public APIs. This requires an update to the [SQLCipher library](https://www.zetetic.net/blog/2016/6/23/sqlcipher-android-release-n-support/) used in the MobileFirst Platform Foundation's JSONStore library. More details on the changes to the SQLCipher library can be found [here](https://discuss.zetetic.net/t/sqlcipher-for-android-upcoming-changes-for-android-n-and-coordinated-beta-test-request/1315). 
   
>#### Update 
The JSONStore issues on Android N are addressed in the following iFixes

>| MFP Version  | iFix Number |
| ------------- | ------------- |
| 6.3  | [6.3.0.0-MFPF-IF201609272209](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm~Other%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=6.3.0.0&platform=All&function=all&source=fc)  |
| 7.0  | [7.0.0.0-MFPF-IF201609291531](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm~Other%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=7.0.0.0&platform=All&function=all&source=fc)  |
| 7.1  | [7.1.0.0-MFPF-IF201610060540](https://www-945.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm~Other%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=7.1.0.0&platform=All&function=all&source=fc)  |
   
   
#### Cordova with Android N   

* Android 7.0 does not allow the ``file://`` protocol to be used externally from the scope of the app. The error occurs when sharing file URIs across Intent.Even though other plugins use the file URIs, such as File plugin, out of the core Cordova plugins, only the camera plugin uses the Cross-Process communication of sharing file URIs. Hence the  **FILE_URI** and **NATIVE_URI** destination type of the Cordova camera plugin throws an ``android.os.FileUriExposedException``.
For updates on these issue please follow this [thread](https://issues.apache.org/jira/browse/CB-11625).

* Multi-Window Support is the big new feature of Android N and one that presents some minor problems for existing Cordova apps. When apps that are compiled with the pre-N SDK are put into multi-window mode, the user gets a message saying "App may not work in multi-window mode". Cordova apps definitely fall into the non-working category because they tend to either crash or randomly restart when placed into multi-window mode. More information [here](https://github.com/cordova/cordova-discuss/blob/master/proposals/android-n-support.md).

### Handling Secure Connections
---
Android Nougat has changed how Android handles trusted certificate authorities (CAs) to provide safer defaults for secure app traffic.Custom CAs are typically used in test environments and B2B apps. Apps that target API Level 24 and above no longer trust user or admin-added CAs for secure connections by default, more details [here](https://developer.android.com/preview/features/security-config.html). In order to allow your MobileFirst Platform Foundation app to trust user-added CAs for all secure connections the following needs to be done

  - Create ```network_security_config.xml``` under ```res/xml/``` with the following content
  	
  	 ```xml
  	 <?xml version="1.0" encoding="utf-8"?>
	   <network-security-config>
	        <base-config>
		        <trust-anchors>
			        <certificates src="@raw/name of the .crt file"/>
			        <certificates src="user"/>
		        </trust-anchors>
	        </base-config>
       </network-security-config>```
    

  - Include ``` android:networkSecurityConfig="@xml/network_security_config" ``` under the ``` application ``` tag of the ``` AndroidManifest.xml ```.  The resulting ``` AndroidManifest.xml ``` should look as below
      
  	 ```xml 
  	 <manifest xmlns:android="http://schemas.android.com/apk/res/android" package="sample.com.pincodeandroid">
	   
	    <uses-permission android:name="android.permission.INTERNET"/>
    	<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>

	    <application
	        android:networkSecurityConfig="@xml/network_security_config"
	        android:allowBackup="true"
	        android:icon="@mipmap/ic_launcher"
	        android:label="@string/app_name"
	        android:supportsRtl="true"
	        android:theme="@style/AppTheme"
	        android:name=".PinCodeApplication">
	        <activity android:name="com.worklight.wlclient.ui.UIActivity" />
	        <activity android:name=".MainActivity">
	            <intent-filter>
	                <action android:name="android.intent.action.MAIN" />

	                <category android:name="android.intent.category.LAUNCHER" />
	            </intent-filter>
	        </activity>
	    </application>
     </manifest>```
     

  - Finally copy the custom certificate (.crt) file into ```/res/raw``` folder
    ![copy-custom-ca-raw-folder]({{site.baseurl}}/assets/blog/2016-04-05-mobilefirst-platform-compatibility-for-android-n/copy-custom-ca-raw-folder.png)


Stay tuned for more updates.