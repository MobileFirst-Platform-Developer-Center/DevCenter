---
layout: tutorial
title: Debugging applications
relevantTo: [cordova]
weight: 12
---
## Overview
This tutorial explores various approaches to debugging the web resources of a MobileFirst application, either before running the application on a device or while running it on a device.

The following debugging options are covered:

* [What is debugging?](#what-is-debugging)
* [Debugging on a desktop browser](#debugging-on-a-desktop-browser)
* [Debugging with iOS Remote Web Inspector](#debugging-with-ios-remote-web-inspector)
* [Debugging with Chrome Remote Web Inspector](#debugging-with-chrome-remote-web-inspector)
* [Debugging with Weinre](#debugging-with-weinre)
* [Debugging with IBM MobileFirst Logger](#debugging-with-ibm-mobilefirst-logger)
* [Debugging with WireShark](#debugging-with-wireshark)

## What is debugging?
Debugging is a process that consists of finding the cause of defects in the application code and UI.

* MobileFirst applications consist of web-based resources and optional native code (such as Java, Objective-C and C#).
* You can debug native code by using standard tools that are provided by the platform SDK, such as XCode, Android LogCat/ADB, or Microsoft Visual Studio.

## Debugging on a desktop browser
Modern browsers, such as Chrome, Firefox, Safari, or Opera, provide an easy and convenient way to debug web apps.
Many web tools for debugging are available on various desktop browsers, for example:

* FireBug
* Chrome Developer Tools
* Internet Explorer Developer Tools
* Dragonfly for Opera
* Safari Web Inspector

![Developer Tools](developer-tools.png)

In early application development stages, these tools can be used to debug the application just like a regular website. It is not required to install them in a mobile device.
You can also preview changes to HTML and CSS in real time by modifying the values in the inspector.
![modifying values in the Developer Tools](developer-tools-2.png)

## Debugging with iOS Remote Web Inspector
Starting in iOS 6, Apple introduced a remote web inspector for debugging web applications on iOS devices. To debug, make sure that the device (or simulator) has the **Private Browsing** option turned off.
To enable Web Inspector on the device, click **Settings > Safari > Advanced > Web Inspector**.
![iOS Web Inspector](ios-web-inspector.png)

1. To start debugging, connect the iOS device to a Mac, or start the simulator. Safari 6.0 or higher is required.
In Safari, go to **Preferences > Advanced**, and select the **Show Develop menu in menu bar** checkbox.
![Safari Developer Menu](safari-developer-menu.png)
2. Now in Safari, select **Develop > [*your device ID*] > [*your application HTML file*]**.
The DOM can now be inspected. It is also possible to alter the CSS and run JavaScript commands, just as in the desktop inspector.
![Safari Debugging](safari-debugging.png)

## Debugging with Chrome Remote Web Inspector
With Google Chrome, it is possible to remotely inspect web applications on Android devices.
This action requires Android 4.4 or later, Chrome 32 or later, and IBM Worklight Foundation V6.2.0 or IBM MobileFirst Platform Foundation 6.3 or later.
Additionally, in the `AndroidManifest.xml` file, `targetSdkVersion` = 19 or above is required.
In the `project.properties` file, `target` = 19 or above is required.
<ol>
<li>Start the application in the Android Emulator or a connected device.</li>
<li>In Chrome, enter the following URL: `about:inspect`.</li>
<li>Press **Inspect** for the relevant application.
You can now use all the features of the Chrome Inspector to inspect the Android application.</li>
<a href="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/07/03_04_debug_with_chrome.png"><img class="aligncenter size-large wp-image-1724" src="{{ site.baseurl }}/assets/backup/03_04_debug_with_chrome-1024x731.png" alt="03_04_debug_with_chrome" width="980" height="699" /></a>
</ol>

## Debugging with Weinre
<a href="http://people.apache.org/~pmuellr/weinre/">Weinre</a> stands for **Web Inspector Remote**.
Weinre is a debugger for web pages, like Firebug or other Web Inspectors, except that Weinre is designed to work remotely.
Weinre can be used to inspect and debug web resources such as HTML, JavaScript, CSS, and network traffic on mobile handsets.
The Weinre architecture includes the following components:
<a href="http://developer.ibm.com/worklight/wp-content/uploads/sites/32/2014/07/03_04_weinre.png"><img class="aligncenter size-full wp-image-734" src="{{ site.baseurl }}/assets/backup/03_04_weinre.png" alt="03_04_weinre" width="860" height="251" /></a>
The Weinre debug server requires a `node.js` runtime.
You can find instructions to install Weinre on the <a href="http://people.apache.org/~pmuellr/weinre/docs/latest/Installing.html">Weinre installation page</a>.
<h3>Debug server</h3>
When the Weinre server is installed, enter the following command to run it:
`weinre --httpPort 8888 --boundHost -all-`
This command starts a Weinre server. The default port is `8888` but you can change it.
<h3>Target</h3>
The Weinre server must be accessible from the device that will be used for debugging. To make it accessible, add the following code line to the web application:
[code lang="js"]&lt;script src=&quot;http://a.b.c:8888/target/target-script-min.js&quot;<&lt;/script<[/code]
Where a.b.c is the hostname or IP of the Weinre server.
<h3>Client</h3>
Before you can start debugging, make sure that the application is open and loaded on the browser with this URL:
<a href="http://developer.ibm.com/worklight/wp-content/uploads/sites/32/2014/07/03_04_weinre_debugging.png"><img class="aligncenter size-full wp-image-735" src="{{ site.baseurl }}/assets/backup/03_04_weinre_debugging.png" alt="03_04_weinre_debugging" width="798" height="684" /></a>

## Debugging with IBM MobileFirst Logger
IBM MobileFirst Platform Foundation provides a `WL.Logger` object which can be used to print log messages to the log for the environment used.
Two of its methods are `WL.Logger.debug()` and `WL.Logger.error()`.
These APIs are multiplatform. The output destination changes according to the platform on which that application runs:
<ul>
<li>**Developer console** when it is running on a desktop browser</li>
<li>**LogCat** when it is running on Android device</li>
<li>**Visual Studio Output** when it is running on a Windows Phone 8 device and Windows 8 App</li>
<li>**XCode Console** when it is running on an iOS device</li>
</ul>
`WL.Logger` contains more methods.
<blockquote>For more information, see the documentation for `WL.Logger` in the API reference part of the user documentation.</blockquote>

## Testing adapter procedures
You can test adapter procedures by using MobileFirst Studio.
To test a procedure:
<ol>
<li>Right-click an adapter folder and select **Run As < Invoke MobileFirst Procedure**.
<a href="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/07/03_04_deploy_mobilefirst_adapter.png"><img class="aligncenter wp-image-1509 size-full" src="{{ site.baseurl }}/assets/backup/03_04_deploy_mobilefirst_adapter.png" alt="03_04_deploy_mobilefirst_adapter" width="738" height="124" /></a>
The adapter and procedure are selected. </li>
<li>Optionally, enter comma-separated parameters.
<a href="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/07/03_04_select_adapter_and_procedure.png"><img class="aligncenter size-full wp-image-1722" src="{{ site.baseurl }}/assets/backup/03_04_select_adapter_and_procedure.png" alt="03_04_select_adapter_and_procedure" width="602" height="422" /></a>
</li>
Adapter invocation result:
<a href="http://developer.ibm.com/mobilefirstplatform/wp-content/uploads/sites/32/2014/07/03_04_adapter_proceudre_invocation_result1.png"><img alt="missing_alt" class="aligncenter wp-image-1731 size-full" src="{{ site.baseurl }}/assets/backup/03_04_adapter_proceudre_invocation_result1.png" alt="" width="871" height="544" /></a>
</ol>

## Debugging with WireShark
Wireshark is a network protocol analyzer that can be used to see what happens in the network.
You can use filters to follow only what is required.
For more information, see the <a href="http://www.wireshark.org">WireShark</a> website.
<a href="http://developer.ibm.com/worklight/wp-content/uploads/sites/32/2014/07/03_04_wireshark.png"><img class="aligncenter size-full wp-image-739" src="{{ site.baseurl }}/assets/backup/03_04_wireshark.png" alt="03_04_wireshark" width="970" height="562" /></a>
