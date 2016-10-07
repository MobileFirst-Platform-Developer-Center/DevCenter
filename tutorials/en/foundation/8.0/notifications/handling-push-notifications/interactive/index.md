---
layout: tutorial
title: Interactive notifications
relevantTo: [ios,cordova]
show_in_nav: false
weight: 2
---
## Overview
With interactive notification, when a notification arrives, users can take actions without opening the application. When an interactive notification arrives, the device shows action buttons along with the notification message. Currently, interactive notifications are supported on devices with iOS version 8 onwards. If an interactive notification is sent to an iOS device with version earlier than 8, the notification actions are not displayed.

## Sending interactive push notification
Prepare the notification and send notification. For more information, see [Sending push notifications](../../sending-notifications).

You can set a string to indicate the category of notification with the notification object. Based on the category value, the notification action buttons are displayed.

To set the category in event source notifications, you have two options:

* Create a notification JSON object and set the category in that object:

    ```javascript
    var notification = { badge:1, category: 'poll', ....};
    ```
        
* Create a notification object by using the `WL.Server.createDefaultNotification` API and set the category on the notification object:

    ```javascript
    notification.APNS.category= 'poll';
    ```
    
For more information, see the `WL.Server.createDefaultNotification` and `WL.Server.notifyAllDevices` APIs in `WL.Server` class.  

In broadcast, tag-based and Uni-cast notifications, set the type while you create the notification object:

```javascript
notification.settings.apns.category = 'poll';
```

For more information, see the `WL.Server.sendMessage` API in `WL.Server` class.

## Handling interactive push notifications in Cordova application
To receive interactive notifications, follow these steps:

1. In the main JavaScript, define the following method to return the registered categories for the interactive notifications.

    ```javascript
    WL.Client.Push.getInteractivePushCategories = function(){
      var categories = [{
        //Category identifier, this is used while sending the notification.
        id : "poll", 
        //Optional array of actions to show the action buttons along with the message.	
        actions: [
          {
            //Action identifier
            id : "poll_ok", 
          
            //Action title to be displayed as part of the notification button.
            title : "OK", 
    				
            //Optional mode to run the action in foreground or background. 1-foreground. 0-background. Default is foreground.
            mode: 1,  
          
            //Optional property to mark the action button in red color. Default is false.
            destructive: false,
          
            //Optional property to set if authentication is required or not before running the action.(Screen lock).
            //For foreground, this property is always true.
            authenticationRequired: true
          },
          {
            id : "poll_nok",
            title : "NOK",
            mode: 1,
            destructive: false,
            authenticationRequired: true
          }
        ],
        //Optional list of actions that is needed to show in the case alert. 
        //If it is not specified, then the first four actions will be shown.
        defaultContextActions: ['poll_ok','poll_nok'],
        
        //Optional list of actions that is needed to show in the notification center, lock screen. 
        //If it is not specified, then the first two actions will be shown.
        minimalContextActions: ['poll_ok','poll_nok'] 
      }];
      return categories;
    };
    ```

    > For more information, see `WL.Client.Push.getInteractivePushCategories` API in `WL.Client.Push` class.

2. The notification callback method contains two extra properties. You can use them to take actions.
    * **category**: The name of the category that you set while sending the notification.
    * **action-id**: If the user clicks the action button, this represents the ID of the action.

## Handling interactive push notifications in native iOS application
You must follow these steps to receive interactive notifications:

1. Enable the application capability to perform background tasks on receiving the remote notifications. This step is required if some of the actions are background-enabled.
2. In the **AppDelegate** (application: `didRegisterForRemoteNotificationsWithDeviceTokenapplication:`), set the categories before you set the `deviceToken` on `WLPush` Object.

    ```objc
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)]){
      UIUserNotificationType userNotificationTypes = UIUserNotificationTypeNone | UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge;
           
      UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
      acceptAction.identifier = @"OK";
      acceptAction.title = @"OK";
           
      UIMutableUserNotificationAction *rejetAction = [[UIMutableUserNotificationAction alloc] init];
      rejetAction.identifier = @"NOK";
      rejetAction.title = @"NOK";
           
      UIMutableUserNotificationCategory *cateogory = [[UIMutableUserNotificationCategory alloc] init];
      cateogory.identifier = @"poll";
      [cateogory setActions:@[acceptAction,rejetAction] forContext:UIUserNotificationActionContextDefault];
      [cateogory setActions:@[acceptAction,rejetAction] forContext:UIUserNotificationActionContextMinimal];
           
      NSSet *catgories = [NSSet setWithObject:cateogory];
      [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:catgories]];
    }
    ```
    
3. Implement new callback method on `AppDelegate`:

    ```objc
    -(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (ˆ)())completionHandler
    ```
    
    This new callback method is invoked when the user clicks the action button.

4. Implement this method mustso that it perform the action that is associated with the specified identifier and executes the block in the `completionHandler` parameter.
 