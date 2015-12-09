---
layout: tutorial
title: Adding the MobileFirst Platform Foundation SDK to iOS Applications
breadcrumb_title: iOS SDK
relevantTo: [ios]
weight: 2
---
### Overview
The MobileFirst Platform Foundation SDK provides a set of API methods enabling a developer to implement various MobileFirst features, such as: authentication and security mechanisms, notifications, resource requests, collecting analytics data and more.

> For a complete list of MobileFirst SDK abilities visit the user documentation

In this tutorial you will learn how to add the MobileFirst Native SDK using CocoaPods to either a new or existing iOS application. You will also learn how to configure the MobileFirst Server to recognize to application, as well as find information about the files added to your project by the SDK. 

> Note: a "skeleton" Xcode project pre-bundled with the MobileFirst Native SDK can be downloaded from the MobileFirst Operations Console. Review the console tutorials to learn how. <span style="color:red">missing link</span>

**Pre-requisites:** Xcode and MobileFirst CLI installed in the developer workstation.

**Jump to:**

- [Adding the MobileFirst Native SDK](#adding-the-mobilefirst-native-sdk-manually)
- [Configuring the MobileFirst Server to recognize the application](#configuring-the-mobilefirst-server-to-recognize-the-application)
- [Generated MobileFirst Native SDK artifacts](#generated-mobilefirst-native-sdk-artifacts)
- [Tutorials to follow next](#tutorials-to-follow-next)

### Adding the MobileFirst Native SDK manually
The MobileFirst Native SDK is provided via CocoaPods. Follow the below instructions to add it manually:

1. Create an Xcode project or use an existing Xcode project.
2. If [CocoaPods](http://guides.cocoapods.org) is not installed in your development environment, install it as follows:
 - Open **Terminal**
 - Run the command: <code>sudo gem install cocoapods</code>
 - Run the command: <code>pod setup</code>  
   **Note:** This command may take several minutes to complete.
3. Change directory to the location of the Xcode project.
4. Run the command: <code>pod init</code>. This creates a <code>Podfile</code>.
5. Using your favorite editor, open the <code>Podfile</code> file.
6. Comment out or remove the contents of the file.
7. Add the following lines and save the changes:

        ```xml
        source 'https://github.com/CocoaPods/Specs.git'
        pod 'IBMMobileFirstPlatformFoundation'
        ```

8. Run the command: <code>pod install</code>. This command adds the MobileFirst Native SDK, generates the Pod project, and integrates it with the Xcode project.   **Note:** This command may take several minutes to complete.

    > <b>Important</b>: From here on, use the <code>[ProjectName].<b>xcworkspace</b></code> file in order to open the project in Xcode. Do <b>not</b> use the <code>[ProjectName].<b>xcodeproj</b></code> file. A CocoaPods-based project is managed as a workspace containing the application (the executable) and the library (all project dependencies that are pulled by the CocoaPods manager).

9. Open the Xcode project by double-clicking the <b>.xcworkspace</b> file.
10. Right-click the project and select <b>Add Files To [ProjectName]</b>, select the <code>mfpclient.plist</code>, located in the root folder of the Xcode project.
11. Whenever you want to use the MobileFirst Native SDK, make sure that you import the framework:

        ```objc
        #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h> 
        ```

<br>
#### Note about Swift:
> Because Swift is designed to be compatible with Objective-C you can use the MobileFirst SDK from within an iOS Swift project, too. Create a Swift project and follow the same steps, as described at the beginning of the tutorial, to integrate the MobileFirst Native SDK. Use <code>import IBMMobileFirstPlatformFoundation</code> in any class that needs to use the SDK.

<br>
#### Note about iOS 9:
> If you are developing for iOS9, [consider disabling ATS](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error) in the application's <code>info.plist</code> to be able to test locally without security restrictions.

Now that the MobileFirst Native SDK was added to the Xcode project, the final step to perform is to ensure that the MobileFirst Server will recognize any future requests arriving to it from the application.

### Configuring the MobileFirst Server to recognize the application
Configuring the MobileFirst Server recognize the application can be achieved in two ways:

- By registering the application in the MobileFirst Operations Console.
- By registering the application using the MobileFirst CLI.

<br>
#### Registering the application using the MobileFirst CLI

1. Open **Terminal** and navigate to the root of the Xcode project.
2. Run the command: <code>mfpdev app register</code>

 The <code>mfpdev app register</code> CLI command generates several required files as well as registers the application in the MobileFirst Server.  
 These files are further explained in the [Generated MobileFirst Native SDK artifacts](#generated-mobilefirst-native-sdk-artifacts) section below.

<br>
#### Registering the application in the MobileFirst Operations Console

1. Open your browser of choice and navigate to the MobileFirst Operations Console using the address  <code>http://localhost:10080/mfpconsole/</code>. You can also open the console from **Terminal** using the CLI command <code>mfpdev server console</code>.
2. <span style="color:red">TODO</span>

### Generated MobileFirst Native SDK artifacts
Now that the Xcode project is integrated with the MobileFirst Native SDK, three artifacts were added: the <code>mfpclient.plist</code> file, the application-descriptor.xml file and the <code>mobilefirst</code> folder.

<span style="color:red">TODO</span>

#### mfpclient.plist 
The <code>mfpclient.plist</code> file, located at the root of the project, holds server configuration properties and is user-editable:

- <code>protocol</code> – The communication protocol to MobileFirst Server, which is either <code>http</code> or <code>https</code>.
- <code>host</code> – The hostname of the MobileFirst Server instance.
- <code>port</code> – The port of the MobileFirst Server instance.
- <code>wlServerContext</code> – The context root path of the application on the MobileFirst Server instance.
- <code>application id</code> – The application ID as defined in the <code>application-descriptor.xml</code> file.
- <code>application version</code> – The application version.
- <code>environment</code> – The target environment of the native application (“iOSnative”).
- <code>wlUid</code> – This property is used by Mobile Test Workbench (deprecated feature) to identify it as a MobileFirst application.
- <code>wlPlatformVersion</code> – The MobileFirst Studio version.

#### application-descriptor.xml
The <code>application-descriptor.xml</code> file, located at the root of the project, is a metadata file that you use to define various aspects of the application, such as user identity realms and push notifications support, security settings that MobileFirst Server enforces, and more.

#### The mobilefirst folder
The <code>mobilefirst</code> folder, located at the root of the project contains <code>.wlapp</code> files. These files are the server-side entities that are deployed to the MobileFirst Server.

### Tutorials to follow next
Now that the application is integrated with the MobileFirst Native SDK you can follow the tutorials in the [Native iOS development](../../native/ios/) category to learn more about authentication and security, server-side development, notifications, and more.