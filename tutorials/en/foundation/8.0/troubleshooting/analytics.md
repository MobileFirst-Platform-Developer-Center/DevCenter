---
layout: tutorial
title: Troubleshooting Analytics
breadcrumb_title: Analytics
relevantTo: [ios,android,windows,javascript]
weight: 2
---

## Overview
Find information to help resolve issues that you might encounter when you use the MobileFirst Foundation's Operational Analytics.


### Why is there no data?
Check the following possibilities.

* Verify that your apps are set to point to the MobileFirst Server, which forwards the logs to the MobileFirst Analytics Server. Ensure that the following values are set in the  `mfpclient.plist` (iOS),  `mfpclient.properties` (Android), or  `config.xml` (Cordova) files.

    ```xml
    protocol = http or https
    host = the IP address of your MobileFirst Server
    port = the HTTP port that is set in the server.xml file for reporting analytics
    wlServerContext = by default "/mfp/"
    ```

* Ensure that your MobileFirst Server is pointing to your MobileFirst Analytics Server.

      In the `server.xml` (`mfp-server/usr/servers/mfp/server.xml`) file check the following values:

      For the console:

      `<jndiEntry jndiName="mfp/mfp.analytics.console.url" value='"http://<serverhost>:<serverport>/analytics/console"'/>`

      For the Analytics Server:

      `<jndiEntry jndiName="mfp/mfp.analytics.url" value='"http://<serverhost>:<serverport>/analytics-service/rest"'/>`

      **NB:** The server and the console should have the same host and port values.

      The MobileFirst Foundation Developer Kit installs the servers on the local host with the following default values:

      For the console:

      `<jndiEntry jndiName="mfp/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>`

      For the Analytics Server:

      `<jndiEntry jndiName="mfp/mfp.analytics.url" value='"http://localhost:9080/analytics-service/rest"'/>`



* Check that you are calling the send method.

  * Objective C: `[[WLAnalytics sharedInstance] send];`

  * Swift: `WLAnalytics.sharedInstance().send();`

  * Android: `WLAnalytics.send();`

  * Cordova: `WL.Analytics.send();`

  * Web:**   `ibmmfpfanalytics.send();`

### Why is there crash data in the Crash Overview table, but nothing in the Crash Summary table?
The crash logs must be sent to the server once the app is again running. Verify that your apps are sending logs after a crash. To be safe, send logs on app start-up to ensure that any previously unsent information is reported.

### Why is there no data in the Server Usage Flow graph or the Network Request graph?
Configure your apps to collect analytics on the Network device event.

* For cross-platform apps that use Cordova, follow the iOS or Android guides, as the configurations are the same as for native apps.
* For Web apps, no listeners are required. Analytics can be enabled and disabled through the `ibmmfpfanalytics.logger` class.

  ```javascript  
  ibmmfpfanalytics.logger.config({analyticsCapture: true});                

  ```


* To enable the capture of network analytic data in iOS:

    **Objective C**

    ```objc
    WLAnalytics *analytics = [WLAnalytics sharedInstance];
    [analytics addDeviceEventListener:NETWORK];
    ```

    **Swift**

    ```Swift
    WLAnalytics.sharedInstance().addDeviceEventListener(NETWORK);
    ```

* To enable the capture of network analytic data in Android, add the following code in your Application subclass `onCreate` method.

    ```java
    WLAnalytics.init(this);
    WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
    ```

### Why is there no data for app sessions?
Configure your apps to collect analytics using the Lifecycle device event listener.

* For cross-platform apps that use Cordova, follow the iOS or Android guides, as the configurations are the same as for native apps.
* For Web apps, no listeners are required. Analytics can be enabled and disabled through the `ibmmfpfanalytics.logger` class.

  ```javascript  
  ibmmfpfanalytics.logger.config({analyticsCapture: true});                
  ibmmfpfanalytics.send();
  ```

* To enable the capture of network analytic data in iOS, add the following code in your Application Delegate `application:didFinishLaunchingWithOptions` method.

**Swift**

  ```Swift
  WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
  ```

**Objective C**

  ```objc
  WLAnalytics analytics = [WLAnalytics sharedInstance];
  [analytics addDeviceEventListener:LIFECYCLE];
  ```

* To enable the capture of network analytic data in Android, add the following code in your Application subclass `onCreate` method.

    ```java
    WLAnalytics.init(this);
    WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
    ```
