---
layout: tutorial
title: Adding Push Notifications
weight: 11
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Adding Push Notifications to an app
{: #dab-engagement-push }

You can add Push notifications to your app and increase user engagement.

To add Push notifications to your app:

1. Select **Engagement**. This will display the list of available services.

    ![Engagement Push](dab-push-notification.png)

2. Select **Push Notifications** and click **Enable**. This display the Push Notifications configuration page.

3. Configure push notification for Android by providing **API Secret Key** and **Sender ID** and click **Save configuration**.

    ![Engagement Push Notification Android configuration](dab-push-android-config.png)

4. Navigate to the iOS tab and provide push configuration details: select the **Environment**, provide the .p12 file with path, and enter the **Password** and click **Save configuration**.

    ![Engagement Push Notification iOS configuration](dab-push-ios-config.png)

5. Perform the following additional step for iOS:
    * Open the xcode project `<path_to_app>/ionic/platforms/ios/<app>.xcodeproj` and enable push notification capability. For more details, refer to [https://help.apple.com/xcode/mac/current/#/devdfd3d04a1](https://help.apple.com/xcode/mac/current/#/devdfd3d04a1).

6. On the server side,
 
    * Follow [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications) to enable push notifications on the server side.

    * Follow [http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#sending-notifications) to send notifications from the server

**Note**:
Push notifications from MFP server is used to enable the notification service. So if IBM Cloud push notification service was used before, follow the link to set up notifications in MFP server
[http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/notifications/sending-notifications/#setting-up-notifications).

