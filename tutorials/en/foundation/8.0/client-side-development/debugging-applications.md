---
layout: tutorial
title: Debugging applications
relevantTo: [cordova]
weight: 12
---
### Overview
This tutorial explores various approaches to debugging the web resources of Cordova application,  
Either before running the application on a device or while running it on a device.

#### Jump to:

* [What is debugging?](#what-is-debugging)
* [Debugging on a desktop browser](#debugging-on-a-desktop-browser)
* [Debugging with the Mobile Browser Simulator](#debugging-with-the-mobile-browser-simulator)
* [Debugging with Ripple](#debugging-with-ripple)
* [Debugging with iOS Remote Web Inspector](#debugging-with-ios-remote-web-inspector)
* [Debugging with Chrome Remote Web Inspector](#debugging-with-chrome-remote-web-inspector)
* [Debugging with Weinre](#debugging-with-weinre)
* [Debugging with IBM MobileFirst Logger](#debugging-with-ibm-mobilefirst-logger)
* [Debugging with WireShark](#debugging-with-wireshark)

### What is debugging?
Debugging is a process that consists of finding the cause of defects in applicative code and UI.

* Cordova applications consist of web-based resources such as HTML, JavaScript &amp; CSS, and optional native code (written in Java, Objective-C, Swift, C#, ...).
* Native code can be debugged by using standard tools that are provided by the platform SDK, such as XCode, Android LogCat, or Microsoft Visual Studio.

### Debugging on a desktop browser
Modern browsers, such as Chrome, Firefox, Safari, Internet Explorer 10 (and above) and Opera, provide an easy and convenient way to debug web apps.
Many web tools for debugging are available. For example:

* FireBug
* Chrome Developer Tools
* Internet Explorer Developer Tools
* Dragonfly for Opera
* Safari Web Inspector

![Developer Tools](developer-tools.png)

In early application development stages, these tools can be used to debug the application just like a regular website. It is not required to install them in a mobile device.  
You can also preview changes to HTML and CSS in real time by modifying the values in the inspector.

![modifying values in the Developer Tools](developer-tools-2.png)

### Debugging with the Mobile Browser Simulator
You can use the Mobile Browser Simulator to preview and debug MobileFirst applications.  
To use the Mobile Browser Simulator, open **Terminal** and run the command:

```bash
mfpdev app preview
```

If your application consists of more that one platform - specify the platform to preview:

```bash
mfpdev app preview -p <platform>
```

> Learn more about the MobileFirst CLI in the [Using CLI to manage MobileFirst artifacts](../using-cli-to-manage-mobilefirst-artifacts) tutorial.

### Debugging with Ripple
Apache Ripple™ is a web based mobile environment simulator designed to enable rapid development of mobile web applications for various web application frameworks, such as Apache Cordova™ and BlackBerry® WebWorks™. It lets you run a Cordova application in your browser and fake various Cordova features. For example, it lets you simulate the accelerometer to test shake events. It can fake the camera API by letting you select a picture from your hard drive.  
More information about how to install and use Apache Ripple™ can be found on the [Apache Ripple page](http://ripple.incubator.apache.org/).

![Ripple emulator](ripple2.png)

### Debugging with iOS Remote Web Inspector
Starting in iOS 6 Apple introduced a remote [Web Inspector](https://developer.apple.com/safari/tools/) for debugging web applications on iOS devices. To debug, make sure that the device (or simulator) has the **Private Browsing** option turned off.  
To enable Web Inspector on the device, Tap **Settings > Safari > Advanced > Web Inspector**.

![iOS Web Inspector](ios-web-inspector.png)

1. To start debugging, connect the iOS device to a Mac, or start the simulator.
2. In Safari, go to **Preferences > Advanced**, and select the **Show Develop menu in menu bar** checkbox.

    ![Safari Developer Menu](safari-developer-menu.png)
3. Now in Safari, select **Develop > [*your device ID*] > [*your application HTML file*]**.  
The DOM can now be inspected. It is also possible to alter the CSS and run JavaScript commands, just as in the desktop inspector.

    ![Safari Debugging](safari-debugging.png)

### Debugging with Chrome Remote Web Inspector
Using Google Chrome it is possible to remotely inspect web applications on Android devices or the Android Emulator.  
This action requires Android 4.4 or later, Chrome 32 or later, and IBM Worklight Foundation V6.2.0 or IBM MobileFirst Platform Foundation 6.3 or later. Additionally, in the `AndroidManifest.xml` file, `targetSdkVersion = 19` or above is required. In the `project.properties` file, `target = 19` or above is required.

1. Start the application in the Android Emulator or a connected device.
2. In Chrome, enter the following URL in the address bar: `about:inspect`.
3. Press **Inspect** for the relevant application.

You can now use all the features of the Chrome Inspector to inspect the Android application.

![Chrome Remote Web Inspector](Chrome-Remote-Web-Inspector.png)

### Debugging with Weinre
Weinre is a debugger for web pages, like Firebug or other Web Inspectors, except that **Weinre is designed to work remotely**.
Weinre can be used to inspect and debug web resources such as HTML, JavaScript, CSS, and network traffic on mobile handsets.
The Weinre architecture includes the following components:
![Weinre](Weinre.jpg)

The Weinre debug server requires a `node.js` runtime.
You can find instructions to install Weinre on the [Weinre installation page](http://people.apache.org/~pmuellr/weinre/docs/latest/Installing.html).

<h3>Debug server</h3>
When the Weinre server is installed, enter the following command to run it:  
`weinre --httpPort 8080 --boundHost -all-`  
This command starts a Weinre server.  
The default port is `8080` but you can change it.

<h3>Target</h3>
The Weinre server must be accessible from the device that will be used for debugging.  
To make it accessible, add the following code line to the web application:

```
<script src="http://a.b.c:8080/target/target-script-min.js"></script>
```

Where a.b.c is the hostname or IP of the Weinre server.

<h3>Client</h3>
Before you can start debugging, make sure that the application is open and loaded on the browser with this URL:
![Weinre Debugging](Weinre-Debugging.png)

### Debugging with IBM MobileFirst Logger
IBM MobileFirst Platform Foundation provides a `WL.Logger` object which can be used to print log messages to the log for the environment used.  
Two of its methods are `WL.Logger.debug()` and `WL.Logger.error()`.  
These APIs are multiplatform. The output destination changes according to the platform on which that application runs:

* **Developer console** when it is running on a desktop browser
* **LogCat** when it is running on Android device
* **Visual Studio Output** when it is running on a Windows Phone 8 device and Windows 8 App
* **XCode Console** when it is running on an iOS device

`WL.Logger` contains more methods.
> For more information, see the documentation for `WL.Logger` in the API reference part of the user documentation.

### Debugging with WireShark
**Wireshark is a network protocol analyzer** that can be used to see what happens in the network.  
You can use filters to follow only what is required.  
For more information, see the [WireShark](http://www.wireshark.org) website.
![WirShark](WireShark.png)
