---
layout: tutorial
title: Migrating push notifications from event source-based notifications
breadcrumb_title: Migrating push notifications 
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
From {{ site.data.keys.product_full }} v8.0, the event source-based model is not supported, and push notifications capability is enabled entirely by the push service model. For existing event source-based applications on earlier versions of {{ site.data.keys.product_adj }} to be moved to v8.0, they must be migrated to the new push service model.

During migration, keep in mind that it is not about using one API instead of another, but more about using one model/approach versus another.

For example, in the event source-based model, if you were to segment your mobile application users to send notifications to specific segments, you would model every segment as a distinct event source. In the push service model, you would achieve the same by defining tags that represents segments and have users subscribe to the respective tags. Tag-based notifications is a replacement to event source-based notifications.

#### Jump to
* [Migration scenarios](#migration-scenarios)
* [Migration tool](#migration-tool)

<br/>

The table below provides you with a comparison between the two models.

| User requirement | Event source model | Push service model | 
|------------------|--------------------|--------------------|
| To enable your application with push notifications | {::nomarkdown}<ul><li>Create an Event Source Adapter and within it create an EventSource.</li><li>Configure or setup your application with push  credentials.</li></ul>{:/} | Configure or setup your application with push credentials. | 
| To enable your mobile client application with push notifications | {::nomarkdown}<ul><li>Create WLClient</li><li>Connect to the {{ site.data.keys.mf_server }}</li><li>Get an instance of push client</li><li>Subscribe to the Event source</li></ul>{:/} | {::nomarkdown}<ul><li>Instantiate push client</li><li>Initialize push client</li><li>Register the mobile device</li></ul>{:/} |
| To enable your mobile client application for notifications based on specific tags | Not supported. | Subscribe to the tag (that uses tag name) that is of interest. | 
| To receive and handle notifications in your mobile client applications | Register a listener implementation. | Register a listener implementation. |
| To send push notifications to mobile client applications | {::nomarkdown}<ul><li>Implement adapter procedures that internally call the WL.Server APIs to send push notifications.</li><li>WL Server APIs provide means to send notifications:<ul><li>By user</li><li>By device</li><li><li>Broadcasts (all devices)</li></ul></li><li>Backend server applications can then invoke the adapter procedures to trigger push notification as part of their application logic.</li></ul>{:/} | {::nomarkdown}<ul><li>Backend server applications can directly call the messages REST API. However, these applications must register as confidential client with the {{ site.data.keys.mf_server }} and obtain a valid OAuth access token that must be passed in the Authorization header of the REST API.</li><li>The REST API provides options to send notifications:<ul><li>By user</li><li>By device</li><li>By platform</li><li>By tags</li><li>Broadcasts (all devices)</li></ul></li></ul>{:/} |
| To trigger push notifications as regular time periods (polling intervals) |  Implement the function to send push notifications within the event-source adapter and this as part of the createEventSource function call. | Not supported. |
| To register a hook with the name, URL, and the even types. | Implement hooks on the path of a device subscribing or unsubscribing to push notifications. | Not supported. | 

## Migration Scenarios
Starting from {{ site.data.keys.product }} v8.0, the event source-based model will not be supported and push notifications capability will be enabled on {{ site.data.keys.product }} entirely by the push service model, which is a more simple and agile alternative to event source model.

Existing event source-based applications on earlier versions of IBM MobileFirst Platform Foundation need to be migrated to v8.0, to the new push service model.

#### Jump to

* [Hybrid applications](#hybrid-applications)
* [Native Android applications](#native-android-applications)
* [Native iOS applications](#native-ios-applications)
* [Native Windows Universal applications](#native-windows-universal-applications)

### Hybrid applications
Examples of migration scenarios cover applications that use a single event sources or multiple sources, broadcast or Unicast notification, or tag notification.

#### Scenario 1: Existing applications using single event source in their application
Applications have used single event source over the earlier versions of {{ site.data.keys.product_adj }} as it supported push only through event source-based model.

##### Client
To migrate this in V8.0.0, convert this model to Unicast notification.

1. Initialize the {{ site.data.keys.product_adj }} push client instance in your application and in the success callback register the callback method that should receive the notification.

   ```javascript
   MFPPush.initialize(function(successResponse){
   MFPPush.registerNotificationsCallback(notificationReceived); }, 
   function(failureResponse){alert("Failed to initialize");    
                              }  
   );
   ```
    
2. Implement the notification callback method.

   ```javascript
   var notificationReceived = function(message) {
        alert(JSON.stringify(message)); 
   };
   ```
    
3. Register the mobile device with the push notification service.

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```
    
4. (Optional) Un-register the mobile device from the push notification service.
 
   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```
    
5. Remove WL.Client.Push.isPushSupported() (if used) and use.

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	   },
	   function(failureResponse) {
	       alert("Failed to get the push suport status");
	   }
   );
   ```
    
6. Remove the following `WL.Client.Push` APIs, since there will be no event source to subscribe to and register notification callbacks.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

##### Server
1. Remove the following WL.Server APIs (if used), in your adapter:
    * `notifyAllDevices()`
    * `notifyDevice()`
    * `notifyDeviceSubscription()`
    * `createEventSource()`
2. Complete the following steps for every application that was using the same event source:
    1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

        You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
    2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
    3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
    4. You can use either of the following methods to send notifications:
        * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
        * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.

#### Scenario 2: Existing applications using multiple event sources in their application
Applications using multiple event sources requires segmentation of users based on subscriptions.

##### Client
This maps to tags which segments the users/devices based on topic of interest. To migrate this, this model can be converted to tag-based notification.

1. Initialize the MFPPush client instance in your application and in the success callback register the callback method that should receive the notification.

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					}, 
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```
    
2. Implement the notification callback method.

   ```javascript
   var notificationReceived = function(message) {
		alert(JSON.stringify(message));
   };
   ```

3. Register the mobile device with the push notification service.

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```
    
4. (Optional) Unregister the mobile device from the push notification service.

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```
    
5. Remove `WL.Client.Push.isPushSupported()` (if used) and use.

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	    },
	  function(failureResponse) {
		alert("Failed to get the push suport status");
	    }
   );
   ```
    
6. Remove the following `WL.Client.Push` APIs since there will be no event source to subscribe to and register notification callbacks.
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

7. Subscribe to tags.

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
    	alert("Successfully subscribed");
        },
      function(failureResponse) {
    	alert("Failed to subscribe");
        }
   );
   ```

8. (Optional) Unsubscribe from tags.

   ```javascript
   MFPPush.unsubscribe(tags, function(successResponse) {
		alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```
    
##### Server
Remove the following `WL.Server` APIs (if used) in your adapter:

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.

#### Scenario 3: Existing applications using broadcast/Unicast notification in their application
##### Client
1. Initialize the MFPPush client instance in your application and in the success callback register the callback method that should receive the notification.

   ```javascript
   MFPPush.initialize(function(successResponse){
        MFPPush.registerNotificationsCallback(notificationReceived);              					}, 
        function(failureResponse){
            alert("Failed to initialize");
        }
   );
   ```
    
2. Implement the notification callback method.

   ```javascript
   var notificationReceived = function(message) {
        alert(JSON.stringify(message));
   };
   ```
    
3. Register the mobile device with the push notification service.

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
        alert("Successfully registered");
        },
      function(failureResponse) {
        alert("Failed to register");
        }
   );
   ```
    
4. (Optional) Unregister the mobile device from the push notification service.

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
        alert("Successfully unregistered");
        },
      function(failureResponse) {
        alert("Failed to unregister");
        }
   );
   ```

5. Remove WL.Client.Push.isPushSupported() (if used) and use.

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
        alert(successResponse);
        },
      function(failureResponse) {
        alert("Failed to get the push suport status");
        }
   );
   ```

6. Remove the following `WL.Client.Push` APIs:
    * `onReadyToSubscribe()`
    * `onMessage()`

##### Server
Remove `WL.Server.sendMessage()` (if used) in your adapter.  
Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.

#### Scenario 4: Existing applications using tag notifications in their application
##### Client
1. Initialize the MFPPush client instance in your application and in the success callback register the callback method that should receive the notification.

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					}, 
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. Implement the notification callback method.

   ```javascript
   var notificationReceived = function(message) {
		alert(JSON.stringify(message));
   };
   ```

3. Register the mobile device with the push notification service.

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. (Optional) Un-register the mobile device from push notification service.

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```
    
5. Remove `WL.Client.Push.isPushSupported()` (if used) and use:

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	    },
	  function(failureResponse) {
		alert("Failed to get the push suport status");
	    }
   );
   ```

6. Remove the following `WL.Client.Push` APIs:
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `onReadyToSubscribe()`
    * `onMessage()`

7. Subscribe to tags:

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
		alert("Successfully subscribed");
	    },
	  function(failureResponse) {
		alert("Failed to subscribe");
	    }
   );
   ```

8. (Optional) Unsubscribe from tags:

   ```javascript
   MFPPush.unsubscribe(tags, function(successResponse) {
		alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```

##### Server
Remove `WL.Server.sendMessage()` (if used) in your adapter.  
Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`. 

### Native Android applications
Examples of migration scenarios cover applications that use a single event sources or multiple sources, broadcast or Unicast notification, or tag notification.

#### Scenario 1: Existing applications using single event source in their application
Applications have used single event source over the earlier versions of MobileFirst as it supported push only through event source-based model.

##### Client
To migrate this in v8.0, convert this model to Unicast notification.

1. Initialize the MFPPush client instance in your application.

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. Implement the interface MFPPushNotificationListener and define onReceive().

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```
    
3. Register the mobile device with the push notification service.

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
           Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```
    
4. (Optional) Un-register the mobile device from the push notification service.

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
             Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```
    
5. Remove `WLClient.Push.isPushSupported()` (if used) and use `push.isPushSupported();`.
6. Remove the following `WLClient.Push` APIs since there will be no event source to subscribe to and register notification callbacks:
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` and `WLNotificationListener` implementation

##### Server
Remove the following `WL.Server` APIs (if used) in your adapter:

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`. 

#### Scenario 2: Existing applications using multiple event sources in their application
Applications using multiple event sources requires the segmentation of users based on the subscriptions.

##### Client
This maps to tags which segments the users/devices based on topic of interest. To migrate this in {{ site.data.keys.product }} V8.0.0, convert this model to tag based notification.

1. Initialize the `MFPPush` client instance in your application:

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```
    
2. Implement the interface MFPPushNotificationListener and define onReceive().

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. Register the mobile device with the push notification service.

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){   
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");
        }
   });
   ```
    
4. (Optional) Un-register the mobile device from the push notification service:
  
   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){   
       @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```
    
5. Remove `WLClient.Push.isPushSupported()` (if used) and use `push.isPushSupported();`.
6. Remove the following `WLClient.Push` APIs since there will be no event source to subscribe to and register notification callbacks:
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`

7. `WLOnReadyToSubscribeListener` and `WLNotificationListener` Implementation
8. Subscribe to tags:

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```
    
9. (Optional) Unsubscribe from tags:
 
   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```
   
##### Server
Remove the following `WL.Server` APIs (if used) in your adapter:

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.     

#### Scenario 3: Existing applications using broadcast/Unicast notification in their application
##### Client

1. Initialize the `MFPPush` client instance in your application:

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```
    
2. Implement the interface `MFPPushNotificationListener` and define `onReceive()`.

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```
    
3. Register the mobile device with push notification service.

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```
    
4. (Optional) Un-register the mobile device from push notification service.

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
       @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. Remove `WLClient.Push.isPushSupported()` (if used) and use `push.isPushSupported();`.
6. Remove the following WLClient.Push APIs:
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` and `WLNotificationListener` Implementation

##### Server
Remove WL.Server.sendMessage()` APIs (if used) in your adapter:

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.    

#### Scenario 4: Existing applications using tag notifications in their application
##### Client

1. Initialize the `MFPPush` client instance in your application:

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```

2. Implement the interface MFPPushNotificationListener and define onReceive().
 
   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```
    
3. Register the mobile device with the push notification service.
    
   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");
        }
   });
   ```
    
4. (Optional) Un-register the mobile device from the push notification service.
 
   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```
    
5. Remove `WLClient.Push.isPushSupported()` (if used) and use `push.isPushSupported()`;
6. Remove the following `WLClient.Push` API's:
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` and `WLNotificationListener` Implementation

7. Subscribe to tags:

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```

8. (Optional) Unsubscribe from tags:

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```

##### Server
Remove `WL.Server.sendMessage()` (if used) in your adapter.

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.

### Native iOS applications
Examples of migration scenarios cover applications that use a single event sources or multiple sources, broadcast or Unicast notification, or tag notification.

#### Scenario 1: Existing applications using single event source in their application
Applications have used single event source over the earlier versions of {{ site.data.keys.product_adj }} as it supported push only through event source-based model.

##### Client
To migrate this in v8.0, convert this model to Unicast notification.

1. Initialize the `MFPPush` client instance in your application.

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```
    
2. Implement the notification processing in the `didReceiveRemoteNotification()`.
3. Register the mobile device with the push notification service.

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
    	   NSLog(@"Failed to register");
        } else {
            NSLog(@"Successfullyregistered");
        }
   }];
   ```
    
4. (Optional) Un-register the mobile device from the push notification service.

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        } else {
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
5. Remove `WLClient.Push.isPushSupported()` (if used) and use:

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. Remove the following `WLClient.Push` API's since there will be no event source to subscribe to and register notification callbacks:
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` implementation

7. Call `sendDeviceToken()` in `didRegisterForRemoteNotificationsWithDeviceToken`.

   ```objc
   [[MFPPush sharedInstance] sendDeviceToken:deviceToken];
   ```
    
##### Server
Remove the following WL.Server API's (if used) in your adapter:

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.

#### Scenario 2: Existing applications using multiple event sources in their application
Applications using multiple event sources requires segmentation of users based on subscriptions.

##### Client
This maps to tags which segments the users/devices based on topic of interest. To migrate this to {{ site.data.keys.product_adj }} V8.0.0, convert this model to tag based notification.

1. Initialize the `MFPPush` client instance in your application.

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. Implement the notification processing in the `didReceiveRemoteNotification()`.
3. Register the mobile device with the push notification service:

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```
    
4. (Optional) Un-register the mobile device from the push notification service:

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
5. Remove `WLClient.Push.isPushSupported()` (if used) and use:

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```
    
6. Remove the following `WLClient.Push` API's since there will be no event source to subscribe to and register notification callbacks:
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` Implementation

7. Call `sendDeviceToken()` in `didRegisterForRemoteNotificationsWithDeviceToken`.
8. Subscribe to tags:

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
9. (Optional) Unsubscribe from tags:

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
##### Server
Remove `WL.Server` (if used) in your adapter.

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.    

#### Scenario 3: Existing applications using broadcast/Unicast notification in their application
##### Client
1. Initialize the MFPPush client instance in your application:

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```
    
2. Implement the notification processing in the `didReceiveRemoteNotification()`.
3. Register the mobile device with the push notification service:

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```
    
4. (Optional) Un-register the mobile device from the push notification service.

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
5. Remove `WLClient.Push.isPushSupported()` (if used) and use:

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. Remove the following `WLClient.Push` API's:
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` Implementation

##### Server
Remove `WL.Server.sendMessage` (if used) in your adapter.

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.  

#### Scenario 4: Existing applications using tag notifications in their application
##### Client

1. Initialize the MFPPush client instance in your application:

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. Implement the notification processing in the `didReceiveRemoteNotification()`.
3. Register the mobile device with the push notification service:

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```
    
4. (Optional) Un-register the mobile device from the push notification service:
 
   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
5. Remove `WLClient.Push.isPushSupported()` (if used) and use `[[MFPPush sharedInstance] isPushSupported]`.
6. Remove the following `WLClient.Push` API's since there will be no Event source to subscribe to and register notification callbacks:
    * `registerEventSourceCallback()`
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` Implementation

7. Call `sendDeviceToken()` in `didRegisterForRemoteNotificationsWithDeviceToken`.
8. Subscribe to tags:
 
   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{    
	       NSLog(@"Successfully unregistered");
       }
   }];
   ```
    
9. (Optional) Unsubscribe from tags:

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

##### Server
Remove the `WL.Server.sendMessage` (if used), in your adapter.

Complete the following steps for every application that was using the same event source:

1. Set up the credentials by using the {{ site.data.keys.mf_console }}. See [Configuring push notification settings](../../notifications/sending-notifications).

    You can also set up the credentials by using [Update GCM settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) REST API, for Android applications or [Update APNs settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) REST API, for iOS applications.
2. Add the scope `push.mobileclient` in **Scope Elements Mapping**.
3. Create tags to enable push notifications to be sent to subscribers. See [Defining tags](../../notifications/sending-notifications/#defining-tags) for push notification.
4. You can use either of the following methods to send notifications:
    * The {{ site.data.keys.mf_console }}. See [Sending push notifications to subscribers](../../notifications/sending-notifications/#sending-notifications).
    * The [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`.  

### Native Windows Universal applications
Examples of migration scenarios cover applications that use a single event sources or multiple sources, broadcast or Unicast notification, or tag notification.

#### Scenario 1: Existing applications using single event source in their application
To migrate this in v8.0, convert this model to Unicast notification.

1. Initialize the `MFPPush` client instance in your application.

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        { 
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```
    
2. Register the mobile device with the push notification service.

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (Optional) Un-register the mobile device from the push notification service.

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. Remove `WLClient.Push.IsPushSupported()` (if used) and use `push.IsPushSupported();`.
5. Remove the following `WLClient.Push` APIs since there will be no event source to subscribe to and register notification callbacks:
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` and `WLNotificationListener` implementation

##### Server
Remove the following `WL.Server` APIs (if used) in your adapter:

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Complete the following steps for every application that was using the same event source:

1. Set up the WNS credentials in the **Push Settings** page of {{ site.data.keys.mf_console }} or use WNS Settings REST API.
2. Add the scope `push.mobileclient` in **Map Scope Elements to security checks** section in the Security tab of {{ site.data.keys.mf_console }}.
3. You can also use the [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`, to send message.

#### Scenario 2: Existing applications using multiple event sources in their application
Applications using multiple event sources requires segmentation of users based on subscriptions.

##### Client
This maps to tags which segments the users/devices based on topic of interest. To migrate this in {{ site.data.keys.product_adj }} V8.0.0, convert this model to tag based notification.

1. Initialize the `MFPPush` client instance in your application:

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        { 
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```
    
2. Register the mobile device with the IMFPUSH service.

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (Optional) Un-register the mobile device from the IMFPUSH service:

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. Remove `WLClient.Push.IsPushSupported()` (if used) and use `push.IsPushSupported();`.
5. Remove the following `WLClient.Push` APIs since there will be no Event Source to subscribe to and register notification callbacks:
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `WLOnReadyToSubscribeListener` and `WLNotificationListener` implementation

6. Subscribe to tags:

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```
    
7. (Optional) Unsubscribe from tags:

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```
    
##### Server
Remove the following `WL.Server` APIs (if used) in your adapter:

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Complete the following steps for every application that was using the same event source:

1. Set up the WNS credentials in the **Push Settings** page of {{ site.data.keys.mf_console }} or use WNS Settings REST API.
2. Add the scope `push.mobileclient` in **Map Scope Elements to security checks** section in the **Security** tab of {{ site.data.keys.mf_console }}.
3. Create Push tags in the **Tags** page of {{ site.data.keys.mf_console }}.
4. You can also use the [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`/`tagNames` as target, to send notifications.

#### Scenario 3: Existing applications using broadcast/Unicast notification in their application
##### Client

1. Initialize the `MFPPush` client instance in your application:

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        { 
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. Register the mobile device with the push notification service.

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. (Optional) Un-register the mobile device from the push notification service.

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```
    
4. Remove `WLClient.Push.isPushSupported()` (if used) and use `push.IsPushSupported();`.
5. Remove the following `WLClient.Push` APIs:
    * `registerEventSourceCallback()`
    * `WLOnReadyToSubscribeListener` and `WLNotificationListener` implementation

##### Server
Remove `WL.Server.sendMessage()` (if used) in your adapter.

Complete the following steps for every application that was using the same event source:

1. Set up the WNS credentials in the **Push Settings** page of {{ site.data.keys.mf_console }} or use WNS Settings REST API.
2. Add the scope `push.mobileclient` in **Map Scope Elements to security checks** section in the **Security** tab of {{ site.data.keys.mf_console }}.
3. Create Push tags in the **Tags** page of {{ site.data.keys.mf_console }}.
4. You can also use the [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`/`tagNames` as target, to send notifications.

#### Scenario 4: Existing applications using tag notifications in their application
##### Client

1. Initialize the `MFPPush` client instance in your application:

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   ```
    
2. Implement the interface MFPPushNotificationListener and define onReceive().

   ```csharp
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        { 
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

3. Register the mobile device with the push notification service.

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

4. (Optional) Un-register the mobile device from push notification service.

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

5. Remove `WLClient.Push.IsPushSupported()` (if used) and use `push.IsPushSupported()`;
6. Remove the following `WLClient.Push` API's:
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `WLOnReadyToSubscribeListener` and `WLNotificationListener` implementation

7. Subscribe to tags:

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```
    
8. (Optional) Unsubscribe from tags:

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```
    
##### Server
Remove `WL.Server.sendMessage()` (if used) in your adapter.

Complete the following steps for every application that was using the same event source:

1. Set up the WNS credentials in the **Push Settings** page of {{ site.data.keys.mf_console }} or use WNS Settings REST API.
2. Add the scope `push.mobileclient` in **Map Scope Elements to security checks** section in the **Security** tab of {{ site.data.keys.mf_console }}.
3. Create Push tags in the **Tags** page of {{ site.data.keys.mf_console }}.
4. You can also use the [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) REST API with `userId`/`deviceId`/`tagNames` as target, to send notifications.

## Migration tool
The migration tool helps in migrating MobileFirst Platform Foundation 7.1 push data (devices, user subscriptions, credentials & tags) to {{ site.data.keys.product }} 8.0.  
The migration tool simplifies the process with the following functions:

1. Reads the devices, credentials, tags and user subscriptions for each application from the MobileFirst Platform Foundation 7.1 database.
2. Copies the data to respective tables in {{ site.data.keys.product }} 8.0 database for respective application.
3. Migrates all the Push data of all v7.1 environments, irrespective of environments in the v8.0 application.

The migration tool doesn't modify any data related to user subscriptions, application environments or devices.  

The following information is important to know before you use the migration tool:

1. You must have Java version 1.6 or above.
2. Make sure you have both MobileFirst Server 7.1 and {{ site.data.keys.mf_server }} 8.0 setup and ready.
3. Make a backup of both MobileFirst Server 7.1 and {{ site.data.keys.mf_server }} 8.0.
4. Register latest version of the application(s) in {{ site.data.keys.mf_server }} 8.0.
	* Display name of application should match the respective application in MobileFirst Platform Foundation 7.1.
	* Remember the PacakgeName/BundleID and provide the same values for the applications.
	* If the application is not registered on {{ site.data.keys.mf_server }} 8.0 then the migration will succeed.
5. Provide Scope-Elements Mapping for each environment of application. [Learn more about scope mapping](../../notifications/sending-notifications/#scope-mapping).

#### Procedure
1. Download the migration tool from [its following GitHub repository](http://github.com).
2. After downloading the tool, provide the following details in the **migration.properties** file:
	
    | Value                | Description  | Sample Values |
    |----------------------|--------------|---------------|
    | w.db.type		       | Type of the database under consideration	           | pw.db.type = db2 possible values DB2,Oracle,MySql,Derby | 
    | pw.db.url			   | MobileFirst Platform Foundation 7.1 worklight DB url  | jdbc:mysql://localhost:3306/WRKLGHT |
    | pw.db.adminurl	   | MobileFirst Platform Foundation 7.1 Admin DB url      | jdbc:mysql://localhost:3306/ADMIN |
    | pw.db.username	   | MobileFirst Platform Foundation 7.1 Worklight DB username | pw.db.username=root |
    | pw.db.password	   | MobileFirst Platform Foundation 7.1 Worklight DB password | pw.db.password=root |
    | pw.db.adminusername  | MobileFirst Platform Foundation 7.1 Admin DB username     | pw.db.adminusername=root |
    | pw.db.adminpassword  | MobileFirst Platform Foundation 7.1 Admin DB password     | pw.db.adminpassword=root |
    | pw.db.urlTarget	   | MFP 8.0 DB url						        | jdbc:mysql://localhost:3306/MFPDATA |
    | pw.db.usernameTarget | MFP 8.0 DB username						| pw.db.usernameTarget=root |
    | pw.db.passwordTarget | MFP 8.0 DB password						| pw.db.passwordTarget=root |
    | pw.db.schema         | MobileFirst Platform Foundation 7.1 Worklight DB schema | WRKLGT |
    | pw.db.adminschema    | MobileFirst Platform Foundation 7.1 Admin DB schema     | WLADMIN |
    | pw.db.targetschema   | {{ site.data.keys.product }} 8.0 worklight DB schema    | MFPDATA |
    | runtime			   | MobileFirst Platform Foundation 7.1 Runtime name		 | runtime=worklight |
    | applicationId	       | Provide list of applications registered on MobileFirst Platform Foundation 7.1 separated by comma(,) | HybridTestApp,NativeiOSTestApp |
    | targetApplicationId  | Provide list of applications registered on {{ site.data.keys.product }} 8.0 separated by comma(,).   | com.HybridTestApp,com.NativeiOSTestApp |

    * Make sure that you have provided values for both **applicationID** and **targetApplicationId** in proper sequence. The mapping is done in 1-1 (or n-n) fashion, i.e. data of the first application in **applicationId** list will be migrated to the first application in the **targetApplicationId** list.
	* In the **targetApplicationId** list, provide a packageName/BundleId for the application. i.e. for TestApp1 in MobileFirst Platform Foundation 7.1, **targetApplicationId** will be packageName/BundleId of TestApp1 which is com.TestApp1. This is because in MobileFirst Platform Foundation 7.1 **applicationId** is the application name and in {{ site.data.keys.mf_server }} 8.0 it is packageName/BundleId/packageIdentityName based on application environment.

2. Run the tool by using the following command:

   ```bash
   java -jar pushDataMigration.jar path-to-migration.properties
   ```
   
   * Replace **path-to-migration.properties** with the path to **migration.properties** in case the tool .jar file and the properties file are located at different locations. Otherwise, remove the path from the command.

