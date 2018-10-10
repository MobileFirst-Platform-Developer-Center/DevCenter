---
title: FCM Support for Android in MobileFirst Platform 7.1 
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

## Follow the steps in this post to use FCM in your android app with MobileFirst Platform Android Push SDK

Get `google-services.json` for your application from [here](https://developers.google.com/cloud-messaging/android/android-migrate-fcm). Add the json file to your `app` folder.
 
### Steps for Native application

1. Open the `AndroidManifest.xml` file and follow the steps below:
 a. Inside the `<application>` -> `<activity>` tag add the following `intent-filter`
 
  ```xml
   <intent-filter>
		<action android:name="<applicationId>.IBMPushNotification" />
		<category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
  ```

 b. Add the following `<acivity>` after the above step:

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
     <application android:name="android.support.multidex.MultiDexApplication"
		android:allowBackup="true"
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
  
2. Open the project gradle file `build.gradle` and add the following dependencies:

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

3. Open the App gradle file `build.gradle` and follow the steps below:
	
  a. Add below dependencies
	```groovy
		dependencies {
		implementation 'com.google.firebase:firebase-messaging:10.2.6'
		implementation 'com.android.support:multidex:1.0.3'
		compile 'com.android.support:support-v4:28.0.0'
		}
		apply plugin: 'com.google.gms.google-services'

	```
  b. Enable multidex in app gradle file`build.gradle` under android tag.
     For more info on multidex follow see [here](https://developer.android.com/studio/build/multidex).
  ```
    multiDexEnabled true
  ```

  ```
    dexOptions {
	javaMaxHeapSize "4g"
    }
  ```

4. In the main acitivity file `MainActivity.java` perform the following changes:
 
   a. Add the following code in `oncreate` method (you can add it anywhere , but make sure this is getting called when app opens)

	  ```Java

		final WLClient client = WLClient.createInstance(this);
		push = client.getPush();
		push.setWLNotificationListener(wlNotificationListener);

	  ```
   b. Add the following code for handling the resume and pause scenarios 
 
	  ```Java
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
  
### Steps for Hybrid application 

1. Open the `AndroidManifest.xml` file and follow the steps below:

 a. Inside the `<application>` -> `<activity>` tag add the following `intent-filter`
 
  ```xml
     <intent-filter>
        <action android:name="<applicationId>.IBMPushNotification" />
        <category android:name="android.intent.category.DEFAULT" />
     </intent-filter> 
  ```
  
  b. Update the `<application>` tag as below:

  ```xml
    <application  android:name="android.support.multidex.MultiDexApplication" 
              android:label="@string/app_name" android:icon="@drawable/icon">
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
       
2. Open the project gradle file and add the following dependencies:

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

3. Open the App gradle file `build.gradle`and add the following:

   ```groovy
	dependencies {

	//compile files('libs/appcompat-v4.jar')   
	    implementation 'com.google.firebase:firebase-messaging:10.2.6'
	    implementation 'com.android.support:multidex:1.0.3'
	    compile 'com.android.support:support-v4:28.0.0'
	}

	apply plugin: 'com.google.gms.google-services'
   ```

4. Enable multidex in app gradle file `build.gradle` under android tag:
  
  ```
    multiDexEnabled true
  ```
   ```
    dexOptions {
	javaMaxHeapSize "4g"
    }
   ```
For more info on multidex see [here](https://developer.android.com/studio/build/multidex).



