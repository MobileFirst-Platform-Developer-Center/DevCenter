---
title: MobileFirst Platform Foundation compatibility for Android N
date: 2016-04-05
tags:
- MobileFirst_Platform
- Android
version:
- 6.3
- 7.0
- 7.1
- 8.0

author:
  name: S.A.Norton Stanley
---
![Android N]({{site.baseurl}}/assets/blog/2016-07-28-mobilefirst-platform-support-for-android-n/mfpcompatibilityandroidn.png)
Google rolled out the final SDK version of [Android 7.0 Nougat](https://developer.android.com/preview/index.html), earlier this month. To run and test your app on the new platform you need to set up an [Android N runtime environment](http://developer.android.com/preview/download.html).

The final developer preview version provides a flavour of the new [features](http://developer.android.com/preview/api-overview.html) like Multi-window support, Notification enhancements, Doze on the go, Data Saver.

We encourage you to start testing your application(s) with Android N. Please see [IBM MobileFirst Platform Foundation's support plan for Android 7.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/07/14/support-plan-for-android-n/).

MobileFirst Platform Foundation v6.3 to v8.0 has embraced Android Nougat very well. A bunch of powerful features like adapter based authentication, custom authentication, form based authentication, invoking adapter procedures, application management, direct update that are offered by the MobileFirst Platform Foundation has been verified to work without any issues on Android 7.0. A sanity check has been performed to ensure that all the existing apps built on Android Marshmallow work on Android Nougat platform.

### Known Issues
---
   The MobileFirst Platform Foundation's JSONStore api does not work as expected on Android N, with the [behavior changes](https://developer.android.com/preview/behavior-changes.html#ndk) introduced in for NDK applications. The change in Android N is to remove support for linking against non-public APIs. This requires an update to the [SQLCipher library](https://www.zetetic.net/blog/2016/6/23/sqlcipher-android-release-n-support/) used in the MobileFirst Platform Foundation's JSONStore library. More details on the changes to the SQLCipher library can be found [here](https://discuss.zetetic.net/t/sqlcipher-for-android-upcoming-changes-for-android-n-and-coordinated-beta-test-request/1315). The fix for MobileFirst Platform Foundation's JSONStore library is in progress and should be available soon. Watch this space for the link to download the ifix.

### Handling Secure Connections
---
Android Nougat has changed how Android handles trusted certificate authorities (CAs) to provide safer defaults for secure app traffic. Apps that target API Level 24 and above no longer trust user or admin-added CAs for secure connections, by default more details [here](https://developer.android.com/preview/features/security-config.html). In order to allow your MobileFirst Platform Foundation app to trust user-added CAs for all secure connections the following needs to be done

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
    ![copy-custom-ca-raw-folder]({{site.baseurl}}/assets/blog/2016-07-28-mobilefirst-platform-support-for-android-n/copy-custom-ca-raw-folder.png)

All for now on the compatibility of MobileFirst Platform Foundation on Android 7.0.

Stay tuned for more updates.