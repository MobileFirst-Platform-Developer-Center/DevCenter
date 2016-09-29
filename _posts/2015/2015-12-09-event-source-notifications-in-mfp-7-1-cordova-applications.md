---
title: Event Source Notifications in MFP 7.1 Cordova Applications
date: 2015-12-09
tags:
- MobileFirst_Platform
- Push_Notifications
version:
- 7.1
author:
  name: Theodora Cheng
---
### Overview

**Prerequisite:** Make sure to read the [Push Notifications in Hybrid Applications]({{site.baseurl}}/tutorials/en/foundation/7.1/notifications/push-notifications-overview/push-notifications-in-hybrid-applications/) tutorial first.

This blogpost is here to show you how to write Cordova applications with event source notification functionality.

Event source notifications are notification messages that are targeted to devices with a user subscription.
While the user subscription exists, MobileFirst Server can produce push notifications for the subscribed user. These notifications can be delivered by the adapter code to all or some of the devices from which the user subscribed.

To learn more about the architecture and terminology of event-source push notifications refer to the [Push notification overview]({{site.baseurl}}/tutorials/en/foundation/7.1/notifications/push-notifications-overview/) tutorial.

Implementation of the push notification API consists of the following main steps:

#### On the server side:

- Creating an event source
- Sending notification

#### On the client side:


- Sending the token and initializing the <code>WLPush</code> class
- Registering the event source
- Subscribing to/unsubscribing from the event source
Displaying a received notification

### Agenda

- [Notification API - server-side](#notification-api-server-side)
- [Notification API - client-side](#notification-api-client-side)
- [Sample application](#sample-application)

### Notification API - Server-side

#### Creating an event source
To create an event source, you declare a notification event source in the adapter JavaScript code at a global level (outside any JavaScript function):

{% highlight javascript %}
WL.Server.createEventSource({
    name: 'PushEventSource',
    onDeviceSubscribe: 'deviceSubscribeFunc',
    onDeviceUnsubscribe: 'deviceUnsubscribeFunc',
    securityTest:'PushApplication-strong-mobile-securityTest'
});{% endhighlight %}

- **<code>name</code>** – a name by which the event source is referenced.
- **<code>onDeviceSubscribe</code>** – an adapter function that is invoked when the user subscription request is received.
- **<code>onDeviceUnsubscribe</code>** – an adapter function that is invoked when the user unsubscription request is received.
- **<code>securityTest</code>** – a security test from the <code>authenticationConfig.xml</code> file, which is used to protect the event source.

An additional event source option:
{% highlight javascript %}
poll: {
    interval: 3,
    onPoll: 'getNotificationsFromBackend'
}
{% endhighlight %}


- **<code>poll</code>** – a method that is used for notification retrieval.
The following parameters are required:

- **<code>interval</code>** – the polling interval in seconds.
- **<code>onPoll</code>** – the polling implementation. An adapter function to be invoked at specified intervals.

#### Sending a notification

As described previously, notifications can be either polled from the back-end system or pushed by one. In this example, a <code>submitNotifications()</code> adapter function is invoked by a back-end system as an external API to send notifications.

{% highlight javascript %}
function submitNotification(userId, notificationText) {
    var userSubscription = WL.Server.getUserNotificationSubscription('PushAdapter.PushEventSource', userId);

    if (userSubscription === null) {
        return { result: "No subscription found for user :: " + userId };
    }

    var badgeDigit = 1;
    var notification = WL.Server.createDefaultNotification(notificationText, badgeDigit, {custom:"data"});

        WL.Server.notifyAllDevices(userSubscription, notification);

    return {
        result: "Notification sent to user :: " + userId
    };
}
{% endhighlight %}

The <code>submitNotification</code> function receives the <code>userId</code> to send notification to and the <code>notificationText</code>.

{% highlight javascript %}
function submitNotification(userId, notificationText) {
{% endhighlight %}

A user subscription object contains the information about all of the user’s subscriptions. Each user subscription can have several device subscriptions. The object structure is as follows:

{% highlight javascript %}
{
    userId: 'bjones',
    state: {
        customField: 3
    },
    getDeviceSubscriptions: function()[}
};
{% endhighlight %}

Next line:
{% highlight javascript %}
var userSubscription = WL.Server.getUserNotificationSubscription('PushAdapter.PushEventSource', userId);
{% endhighlight %}

If the user has no subscriptions for the specified event source, a **null** object is returned.
{% highlight javascript %}
if (userSubscription === null) {
        return { result: "No subscription found for user :: " + userId };
}
{% endhighlight %}

The <code>WL.Server.createDefaultNotification</code> API method creates and returns a default notification JSON block for the supplied values.
{% highlight javascript %}var badgeDigit = 1;
var notification = WL.Server.createDefaultNotification(notificationText, badgeDigit, {custom:"data"});
{% endhighlight %}


- **<code>notificationText</code>** - The text to be pushed to the device.
- **<code>Badge</code>** (number) - A number that is displayed on the application icon or tile (available only in iOS and Windows Phone).
- **<code>custom</code>** - Custom, or Payload, is a JSON object that is transferred to the application and that can contain custom properties.


The <code>WL.Server.notifyAllDevices</code> API method sends notification to all the devices that are subscribed to the user.

{% highlight javascript %}
WL.Server.notifyAllDevices(userSubscription, notification);
{% endhighlight %}

#### Several APIs exist for sending notifications:


- <code>WL.Server.notifyAllDevices(userSubscription, options)</code> - to send notification to all user’s devices.
- <code>WL.Server.notifyDevice(userSubscription, device, options)</code> - to send notification to a specific device that belongs to a specific user subscription. 
- <code>WL.Server.notifyDeviceSubscription(deviceSubscription, options)</code> - to send the notification to a specific device.


### Notification API - Client-side

- <code>WL.Client.Push.isPushSupported()</code> – returns <code>true</code> if push notifications are supported by the platform, or <code>false</code> otherwise.
- <code>WL.Client.Push.isSubscribed(alias)</code> – returns whether the currently logged-in user is subscribed to a specified event source alias.

Set up push notifications, with the callback function defined in <code>WL.Client.Push.onReadyToSubscribe</code> to notify that a device is ready to subscribe to push notifications:

{% highlight javascript %}
if (WL.Client.Push) {	
    WL.Client.Push.onReadyToSubscribe = function() {

        WL.SimpleDialog.show("Push Notifications", "onReadyToSubscribe", 
        [{
            text : 'Close',
            handler : function() {}
        }]);

        $('#SubscribeButton').removeAttr('disabled');
        $('#UnsubscribeButton').removeAttr('disabled');

        WL.Client.Push.registerEventSourceCallback(
            "myPush", 
            "PushAdapter", 
            "PushEventSource", 
            pushNotificationReceived
        );
   };
}
{% endhighlight %}

When a push notification is received by a device, the callback function defined in <code>WL.Client.Push.registerEventSourceCallback</code> is invoked:

{% highlight javascript %}
WL.SimpleDialog.show("Push Notifications", "Provider notification data: " + JSON.stringify(props), [{
    text: 'Close',
    handler: function() {
        WL.SimpleDialog.show("Push Notifications", "Application notification data: " + JSON.stringify(payload), [{
            text: 'Close',
            handler: function() {}
        }]);
    }
}]);
{% endhighlight %}

If the application was in background mode (or inactive) when the push notification arrived, this callback function is invoked when the application returns to the foreground.

### Sample application

[Click to download](https://github.com/tchengus/EventSourceNotificationsCordova) the sample project.

![push app sample]({{site.baseurl}}/assets/blog/2015-12-09-event-source-notifications-in-mfp-7-1-cordova-applications/08_01_push_sample.png)

#### Sending a notification

To get the app running:
1. Create a MFP Cordova Application and select the platforms you would like to be supported by your app

{% highlight bash %}
$ mfp cordova create 
[?] Enter name of app: PushNotifications
[?] Enter the package ID: com.ibm.PushNotifications
[?] Enter the app version: 1.0.0
[?] Select platforms to be supported by your app: android, ios
[?] Select additional plugins you would like to add: 
  ⬡ cordova-plugin-mfp-jsonstore 8.0.0 "IBM MobileFirst Platform Foundation - JSONStore"
 ❯⬢ cordova-plugin-mfp-push 8.0.0
[?] Enter a path to an app template to be added: cordova-hello-world-mfp
$ cd PushNotifications
{% endhighlight %}

2. Copy contents in sample app to your Cordova app (PushNotifications/www/, application-descriptor.xml) 

3. Follow instructions in [Push Notifications Overview]({{site.baseurl}}/tutorials/en/foundation/7.1/notifications/push-notifications-overview/push-notifications-in-hybrid-applications/) to set up corresponding platform

4. Create Local MFP Server, or Use Remote MFP Server

{% highlight bash %}
$ cd ..
$ mfp create backendServer
$ cd backendServer
$ mfp start
{% endhighlight %}

5. Create http adapter

{% highlight bash %}
$ mfp add adapter PushAdapter -t http
{% endhighlight %}

6. Copy contents in sample app to your Cordova app (backendServer/PushAdapter/, backendServer/server/conf/authenticationConfig.xml)

7. Push Adapter to server

{% highlight bash %}
$ mfp push
{% endhighlight %}

8. Run app on corresponding device

{% highlight bash %}
$ cd ..
$ cd PushNotifications
$ mfp cordova run
{% endhighlight %}

9. To test the sample, go into <code>/backendServer</code> to call the adapter in the CLI. Use the username you entered to login to the app:

{% highlight bash %}
$ mfp adapter call
[?] Which endpoint do you want to use? PushAdapter/submitNotification
[?] Enter the comma-separated parameters: "the-user-name", "hello!"
[?] How should the procedure be called? GET
{% endhighlight %}

Note that for push notifications to work on an emulator, it must be using one of the “Google APIs…” targets, as opposed to the regular “Android x.x.x” targets. You can check what target an emulator is using by opening the AVD manager and looking at the value in the “Target Name” column.