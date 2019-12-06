---
title: FCM Support for Android in MobileFirst Platform v7.1
date: 2018-10-09
tags:
- MobileFirst_Foundation
- Announcement
- Android
version:
- 7.1
author:
  name: Anantha Krishnan
additional_authors:
- Kapil Powar
---

## Follow the steps in this post to use [Firebase Cloud Messaging (FCM)](https://firebase.google.com/docs/cloud-messaging/) in your android app with MobileFirst Platform v7.1 Android Push SDK

Google Cloud Messaging (GCM) has been deprecated and is integrated with Firebase Cloud Messaging (FCM). Google will turn off most GCM services by April 2019.

For now, the existing applications using GCM services will continue to work as-is.

>**Note:** Custom notifications support is available with only FCM. GCM custom notifications are not supported for devices using API 26 or above.

Get `google-services.json` for your application from [here](https://developers.google.com/cloud-messaging/android/android-migrate-fcm). Add the json file to your `app` folder.

### Steps for Native application
<br/>
####  Step 1: Open the `AndroidManifest.xml` file and follow the steps below:
<br/>
 a. Inside the `<application>` -> `<activity>` tag add the following `intent-filter`:

  ```xml
   <intent-filter>
		<action android:name="<applicationId>.IBMPushNotification" />
		<category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
  ```

 b. Add the following `<activity>` after the above step:

   ```xml
	<activity android:name="com.worklight.wlclient.fcmpush.MFPFCMPushNotificationHandler"
			   android:theme="@android:style/Theme.NoDisplay"/>
   ```

 c. Now, add the following services:

  ```xml
      <service android:exported="true" android:name="com.worklight.wlclient.fcmpush.MFPFCMPushIntentService">
            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT"/>
            </intent-filter>
        </service>
        <service android:exported="true" android:name="com.worklight.wlclient.fcmpush.WLFCMPush">
            <intent-filter>
                <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
            </intent-filter>
        </service>
   ```

 d. Update the `application` attributes as below:

  ```xml
     <application android:allowBackup="true"
		android:icon="@drawable/ic_launcher"
		android:label="@string/app_name"
		android:theme="@style/AppTheme"
		android:launchMode="singleTask" >

  ```

 e. Remove the `<permission>`,`<services>` and `<intent-filter>` shown below:

   ```xml
    <permission android:name="<ApplicationId>.permission.C2D_MESSAGE" android:protectionLevel="signature" />
 	<uses-permission android:name="<ApplicationId>.permission.C2D_MESSAGE" />
 	<uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />

  ```

  ```xml
    <service android:name="com.worklight.wlclient.push.GCMIntentService" />		
    <receiver android:name="com.worklight.wlclient.push.WLBroadcastReceiver"
    android:permission="com.google.android.c2dm.permission.SEND">

	<intent-filter>
	<action android:name="com.google.android.c2dm.intent.RECEIVE"/>
	<category android:name="<ApplicationId>" />
	</intent-filter>

	<intent-filter>
	<action android:name="com.google.android.c2dm.intent.REGISTRATION" />
       		<category android:name="<ApplicationId>" />
    </intent-filter>
    </receiver>

    <meta-data
    		android:name="com.google.android.gms.version"
    		android:value="15.0.0" />
   ```
<br/>
####  Step 2: Open the project gradle file `build.gradle` and add the following dependencies:
<br/>
```groovy
    buildscript {

	    repositories {
	        google()
	        jcenter()
	    }

	    dependencies {
	        classpath 'com.android.tools.build:gradle:3.1.3'
	        classpath 'com.google.gms:google-services:3.0.0'
	    }
	}

	allprojects {
	    repositories {
	        google()
	        jcenter()
	    }
	}
```   				
<br/>
####  Step 3: Open the App gradle file `build.gradle` and follow the steps below:
<br/>
a. Add the dependencies below:
```groovy
	dependencies {
	implementation 'com.google.firebase:firebase-messaging:10.2.6'
	implementation 'com.android.support:multidex:1.0.3'
	compile 'com.android.support:support-v4:28.0.0'
	}
	apply plugin: 'com.google.gms.google-services'
```
<br/>
b. Enable multidex in app gradle file `build.gradle` under android tag.
```groovy
    multiDexEnabled true
```

```groovy
    dexOptions {
	javaMaxHeapSize "4g"
    }
```
For more info on multidex follow see [here](https://developer.android.com/studio/build/multidex).
<br/>
####  Step 4:  In the main acitivity file `MainActivity.java` perform the following changes:
<br/>
a. Add the following code in `oncreate` method (you can add it anywhere , but make sure this is getting called when app opens):
  ```java

  final WLClient client = WLClient.createInstance(this);
  push = client.getPush();
  push.setWLNotificationListener(wlNotificationListener);

  ```
<br/>
b. Add the following code for handling the resume and pause scenarios:
  ```java
  	@Override
      protected void onPause() {
  	super.onPause();
         if (push != null) {
  	   push.setForeground(false);
         }
      }
      @Override
      protected void onResume() {
  	super.onResume();
  	if (push != null)
  	    push.setForeground(true);
  	    push.setWLNotificationListener(wlNotificationListener);
      }
  ```
<br/>
### Steps for Hybrid application
<br/>
####  Step 1:  Open the `AndroidManifest.xml` file and follow the steps below:
<br/>
 a. Inside the `<application>` -> `<activity>` tag add the following `intent-filter`:

  ```xml
     <intent-filter>
        <action android:name="<applicationId>.IBMPushNotification" />
        <category android:name="android.intent.category.DEFAULT" />
     </intent-filter>
  ```

  b. Update the `<application>` tag as below:

  ```xml
    <application android:label="@string/app_name" android:icon="@drawable/icon">
  ```

  c. Add below acivity in `<application>`:

  ```xml
      <activity android:name="com.worklight.wlclient.fcmpush.MFPFCMPushNotificationHandler"
          android:theme="@android:style/Theme.NoDisplay"/>
  ```

  d. Add the following services:

   ```xml

      <service android:exported="true" android:name="com.worklight.wlclient.fcmpush.MFPFCMPushIntentService">
      	<intent-filter>
         	<action android:name="com.google.firebase.MESSAGING_EVENT"/>
    	  </intent-filter>
     </service>

     <service android:exported="true" android:name="com.worklight.wlclient.fcmpush.WLFCMPush">
      	<intent-filter>
          	 <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
      	</intent-filter>
     </service>

   ```
  e. Remove the `<permission>`,`<services>` and `<intent-filter>` shown below:

   ```xml
    <permission android:name="com.HybridTagNotifications.permission.C2D_MESSAGE" android:protectionLevel="signature"/>  
    <uses-permission android:name="com.HybridTagNotifications.permission.C2D_MESSAGE"/>  
    <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE"/>  
   ```

   ```xml
    <service android:name=".GCMIntentService"/>
    <service android:name="com.worklight.wlclient.push.MFPPushService" android:permission="android.permission.BIND_JOB_SERVICE" android:exported="true"/>

    <receiver android:name="com.worklight.wlclient.push.WLBroadcastReceiver"
    android:permission="com.google.android.c2dm.permission.SEND">

	<intent-filter>
		<action android:name="com.google.android.c2dm.intent.RECEIVE"/>
		<category android:name="com.sample.tagnotificationsandroid" />
	</intent-filter>

	<intent-filter>
		<action android:name="com.google.android.c2dm.intent.REGISTRATION" />
       	<category android:name="com.sample.tagnotificationsandroid" />
    </intent-filter>
    </receiver>
  ```
<br/>
####  Step 2:  Open the project gradle file and add the following dependencies:
<br/>
  ```groovy
      buildscript {

		    repositories {
		        google()
		        jcenter()
		    }

		    dependencies {
		        classpath 'com.android.tools.build:gradle:3.1.3'
		        classpath 'com.google.gms:google-services:3.0.0'
		    }
		}

		allprojects {
		    repositories {
		        google()
		        jcenter()
		    }
		}
  ```
<br/>
####  Step 3:  Open the App gradle file `build.gradle`and add the following:
<br/>
   ```groovy
	dependencies {

	//compile files('libs/appcompat-v4.jar')   
	    implementation 'com.google.firebase:firebase-messaging:10.2.6'
	    implementation 'com.android.support:multidex:1.0.3'
	    compile 'com.android.support:support-v4:28.0.0'
	}

	apply plugin: 'com.google.gms.google-services'
   ```
<br/>
####  Step 4:  Enable multidex in app gradle file `build.gradle` under android tag:
<br/>
  ```groovy
    multiDexEnabled true
  ```
   ```groovy
    dexOptions {
	javaMaxHeapSize "4g"
    }
   ```
For more info on multidex see [here](https://developer.android.com/studio/build/multidex).
