---
title: FCM Support in MFP 7.1 Android
date: 2018-10-09
tags:
- MobileFirst_Foundation
- Announcement
- Android
version:
- 7.1
author:
  name: Anantha Krishnan & Kapil Powar
---

# FCM Support in MFP 7.1 Android


## Follow the below documentation to support FCM in your android app with MFP Android push SDK

Follow below link to get `google-services.json` for your application. Insert json file in to your `app` folder.

https://developers.google.com/cloud-messaging/android/android-migrate-fcm 
### Steps for Native application

#### 1. Open the `AndroidManifest.xml` file and follow below steps
  a. Inside the `<application>` -> `<activity>` tag add the following `intent-filter`
 
  ```Java

   <intent-filter>
	     		<action android:name="<applicationId>.IBMPushNotification" />
	     		<category android:name="android.intent.category.DEFAULT" />
	    </intent-filter>
  ```

  b. Add this acivity after the above step (step 1.a)

   ```Java

    	<activity android:name="com.worklight.wlclient.fcmpush.MFPFCMPushNotificationHandler"
    	                   android:theme="@android:style/Theme.NoDisplay"/>
   ```

  c. Add the following services ,
  
  ```Java

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
   
  d. Update Application Tag as below
  
  ```
     <application android:name="android.support.multidex.MultiDexApplication"
		android:allowBackup="true"
		android:icon="@drawable/ic_launcher"
		android:label="@string/app_name"
		android:theme="@style/AppTheme"
		android:launchMode="singleTask" >
	
  ```
    
  e. Remove below `<permission>`,`<services>` and `<intent-filter>`
   
   
   ```
    <permission android:name="<ApplicationId>.permission.C2D_MESSAGE" android:protectionLevel="signature" />
 	<uses-permission android:name="<ApplicationId>.permission.C2D_MESSAGE" />
 	<uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />

  ```
    
  ```
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
  
#### 2. Open the project gradle file `build.gradle` and add the following dependencies ,

 ```
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
		
		
#### 3. Open the App gradle file `build.gradle` and follow below steps 
	
  a. Add below dependencies
	
  
  ```
   dependencies {
      implementation 'com.google.firebase:firebase-messaging:10.2.6'
      implementation 'com.android.support:multidex:1.0.3'
      compile 'com.android.support:support-v4:28.0.0'
   }
   apply plugin: 'com.google.gms.google-services'
  
 ```
 

 b. Enable multidex in app gradle file`build.gradle` under android tag.
  For more info on multidex follow below link https://developer.android.com/studio/build/multidex.
  
  ```
    multiDexEnabled true
  ```
  
  ```
    dexOptions {
        javaMaxHeapSize "4g"
    }
  ```

#### 4. In main acitivity file `MainActivity.java` do following changes
 
 a. add the following code in `oncreate` method (you can add anywhere , but make sure this is getting called when app opens)

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

#### 1. Open the `AndroidManifest.xml` file and follow below steps

 a. Inside the `<application>` -> `<activity>` tag add the following `intent-filter`
 
  ```Java

	   <intent-filter>
        <action android:name="<applicationId>.IBMPushNotification" />
        <category android:name="android.intent.category.DEFAULT" />
     </intent-filter> 
       
  ```
  
  b. Update the `<application>`  tag as below 

  ```Java
    <application  android:name="android.support.multidex.MultiDexApplication" 
              android:label="@string/app_name" android:icon="@drawable/icon">
  ```

  c. Add below acivity in `<application>`

  ```Java
      <activity android:name="com.worklight.wlclient.fcmpush.MFPFCMPushNotificationHandler" 
          android:theme="@android:style/Theme.NoDisplay"/>
  ```
  
  d. Add the following services ,
  
   ```Java

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
  e. Remove below `<permission>`,`<services>` and `<intent-filter>`
   
   ```
    <permission android:name="com.HybridTagNotifications.permission.C2D_MESSAGE" android:protectionLevel="signature"/>  
    <uses-permission android:name="com.HybridTagNotifications.permission.C2D_MESSAGE"/>  
    <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE"/>  
   ```

   ```
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
       
#### 2. Open the project gradle file and add the following dependencies ,

  ```
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

#### 3. Open the App gradle file `build.gradle`and add the following ,


  ```Java

 		dependencies {

		//compile files('libs/appcompat-v4.jar')   
		    implementation 'com.google.firebase:firebase-messaging:10.2.6'
		    implementation 'com.android.support:multidex:1.0.3'
		    compile 'com.android.support:support-v4:28.0.0'
		}

		apply plugin: 'com.google.gms.google-services'
  ```

#### 4. Enable multidex in app gradle file `build.gradle` under android tag.
  
  ```
    multiDexEnabled true
  ```
    
    
  ```
    dexOptions {
        javaMaxHeapSize "4g"
    }
  ```
For more info on multidex follow below link https://developer.android.com/studio/build/multidex



