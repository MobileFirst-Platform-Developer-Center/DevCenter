---
layout: tutorial
title: Application Center
relevantTo: [ios,android,windows,javascript]
show_children: true
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## Overview
Learn about the {{ site.data.keys.mf_app_center_full }}: what it is for, the different components and features, and how to use the console and the client.

The sale of mobile devices now exceeds that of personal computers. Consequently, mobile applications become critical for businesses.  
The Application Center is a tool to make sharing mobile applications within an organization easier.

You can use the Application Center as an enterprise application store. With the Application Center, you can target some mobile applications to particular groups of users within the company.

A development team can also use the Application Center during the development phase of an application to share applications with testers, designers, or executives in the company. In such a scenario, it makes collaboration easier between all the people who are involved in the development process.

> You can also review [the Application Center tutorial](app-center-tutorial).

#### Jump to
* [Concept of Application Center](#concept-of-application-center)
* [Specific platform requirements](#specific-platform-requirements)
* [General architecture](#general-architecture)
* [Preliminary information](#preliminary-information)
* [Next topics to follow](#next-topics-to-follow)

## Concept of Application Center
Application Center can be used as an Enterprise application store and is a means of sharing information among different team members within a company.

The concept of Application Center is similar to the concept of the Apple public App Store or the Android Market, except that it targets only private usage within a company.

By using Application Center, users from the same company or organization download applications to mobile phones or tablets from a single place that serves as a repository of mobile applications.

Application Center targets mobile applications that are installed on the device itself. Those applications can be native applications that are built by using the device SDK or hybrid applications that mix native and web content. Application Center does not target mobile web applications; such applications are delivered to the mobile device web browser through a URL like a website.

In the current version, Application Center supports applications that are built for the Google Android platform, the Apple iOS platform, the Windows Phone 8 platform, and the Windows 8 platform.

For Windows Phone, only the Windows Phone application package (.xap) file format is currently supported, not the app package (.appx) file format (universal app format). For Windows Store (Desktop applications), the app package (.appx) file format is supported.

Windows Phone 7 and Windows RT, and BlackBerry OS are not supported by the current version of the Application Center.

Application Center manages mobile applications; it supports any kind of Android, iOS, Windows Phone 8, or Windows 8 application, including applications that are built on top of the {{ site.data.keys.product }}.

You can use the Application Center as part of the development process of an application. A typical scenario of Application Center is a team building a mobile application; the development team creates a new version of an Android, iOS, Windows Phone, or Windows 8 application. The development team wants this new version to be reviewed and tested by the extended team. A developer goes to Application Center console and uploads the new version of the application to Application Center. As part of this process, the developer can enter a description of the application version. For example, the description could mention the elements that the development team added or fixed from the previous version. The new version of the application is then available to the other members of the team.

Another person, for example, a beta tester, can launch Application Center installer application, the mobile client, to locate this new version of a mobile application in the list of available applications and install it on his mobile device. After testing the new version, the beta tester can rate the application and submit feedback. The feedback is visible to the developer from the Application Center console.

Application Center is a convenient way to share mobile applications within a company or a group; it is a means of sharing information among team members.

## Specific platform requirements
Different operating systems impose specific requirements for deploying, installing, or using applications on the appropriate mobile devices.

### Android
The mobile device must be configured for installation from unknown sources. The corresponding toggle can be found in the Android Settings. See [User Opt-in for apps from unknown sources for details](http://developer.android.com/distribute/open.html#unknown-sources).  

In Application Center, applications have an internal and a commercial version number. The internal version number is used to distinguish which version is newer while the commercial version is only used as an informative display string. For Android applications, the internal version is the android:[versionCode](http://developer.android.com/guide/topics/manifest/manifest-element.html#vcode) from the application manifest, and it must be an integer.

### iOS
All applications that are managed through Application Center must be packaged for "Ad Hoc Distribution". With an iOS developer account, you can share your application with up to 100 iOS devices. With an iOS enterprise account, you can share your in-house application with an unlimited number of iOS devices. See [iOS Developer Program](https://developer.apple.com/programs/ios/distribute.html) and [iOS Enterprise Program](https://developer.apple.com/programs/ios/enterprise/) for details.
In Application Center, applications have an internal and a commercial version number. The internal version number is used to distinguish which version is newer while the commercial version is used only as an informative display string. For iOS applications, the internal version is the CFBundleVersion from the application manifest **Info.plist**. The version number must have the following format: `a`, or `a.b`, or `a.b.c`, where `a`, `b`, `c` are non-negative integers, and `a` is not `0`.

### Windows Phone 8
Applications are not installed from the Windows Store, but from Application Center, which acts as what Microsoft documentation calls a **Company Hub**. See [Company app distribution for Windows Phone](http://msdn.microsoft.com/en-us/library/windowsphone/develop/jj206943%28v=vs.105%29.aspx) for details.
To use a company hub, Windows Phone requires you to register a company account with Microsoft and to sign all applications, including the Application Center client, with the company certificate. Only signed applications can be managed through Application Center.

You must enroll all mobile devices through an application enrollment token that is associated with your company account.

Application Center helps you to enroll devices through facilities to distribute the application enrollment token. [See Application enrollment tokens in Windows 8 Universal for details](appcenter-console/#application-enrollment-tokens-in-windows-8-universal).

Application Center supports the distribution of applications as Windows Phone application package (.xap) files for Microsoft Windows Phone 8.0 and Microsoft Windows Phone 8.1. With Microsoft Windows Phone 8.1, Microsoft introduced a new universal format as app package (.appx) files for Windows Phone. Currently, Application Center does not support the distribution of app package (.appx) files for Microsoft Windows Phone 8.1, but is limited to Windows Phone application package (.xap) files only.

In Application Center, applications have only one version number. The version number is used to distinguish which version is newer. For Windows Phone 8 applications, the version number is in the **Version** field in the **WMAppManifest.xml** file. This version number must have the following format: `a.b.c.d` where `a`, `b`, `c`, `d` are non-negative integers.

### Windows 8
The Application Center mobile client is provided as a normal desktop executable file (.exe). Use it to install on the device Windows Store applications, which are packaged as .appx files.
Installing a file of type appx on your device without using Windows Store is called sideloading an app. To sideload an app, you must comply with the prerequisites in [Prepare to sideload apps](http://technet.microsoft.com/fr-fr/library/dn613842.aspx). The Windows 8.1 update simplifies the prerequisites for sideloading. For more information, see [Sideloading store apps to Windows 8.1 devices](http://blogs.msdn.com/b/micham/archive/2014/05/30/sideloading-store-apps-to-windows-8-1-devices.aspx).

Files of type .exe cannot be executed on ARM-based tablets, so Application Center does not support Windows RT; only Windows 8 and Windows 8.1 are supported.

The device user needs administrator rights on the device to execute the Application Center client.

Application Center does not provide any predefined way of distributing the mobile client.

In Application Center, applications have only one version number. The version number is used to distinguish which version is newer. For Windows 8 applications, the version number is in the Version field in the AppxManifest.xml file. This version number must have the following format: a.b.c.d, where a, b, c, d are non-negative integers.

## General architecture
The Application Center is composed of these main elements: a server-side component, a repository, an administration console, and a mobile client application.

### Server-side component
The server-side component is a Java™ Enterprise application that must be deployed in a web application server such as IBM  WebSphere  or Apache Tomcat.

The server-side component consists of an administration console and a mobile application. This mobile application installs the mobile applications available to the client-side component.

The web console and the installer application communicate through REST services with the server component.

Several services compose the Application Center server-side component; for example, a service that lists available applications, a service that delivers the application binary files to the mobile device, or a service that registers feedback and ratings.

### Repository
A database that stores information such as which application is installed on which devices, the feedback about applications, and the mobile application binary files. The Application Center application is associated with the database when you configure the Application Center for a particular web application server and a supported database.

### Administration console
A web console through which administrators can manage applications, user access rights to install applications, user feedback about mobile applications, and details about applications installed on devices. See [The Application Center console](appcenter-console).

### Mobile client application
You use the mobile client to install applications on a mobile device and to send feedback about an application to the server. See [The mobile client](mobile-client).

The following figure shows an overview of the architecture.

![Application Center architecture](ac_arch.jpg)

From the Application Center console, you can take the following actions:

* Upload different versions of mobile applications.
* Remove unwanted applications.
* Control access to applications: Each application is associated with the list of people who can install the application.
* View feedback that mobile users have sent about an application.
* Obtain information about applications installed on a device.
* Make an application inactive so that it is not visible in the available applications for download.

From the mobile client, you can take the following actions:

* List available mobile applications.
* Install a new application on a device.
* Send feedback about an application.

The Application Center supports applications for Android, iOS, Windows Phone 8, and Windows 8 devices. Therefore, the mobile client comes in separate versions for Android, iOS, Windows Phone 8, and Windows 8.

The Android, iOS, and Windows Phone 8 mobile clients are built on the {{ site.data.keys.product }}. To learn how to configure the Application Center server-side component on various Java application servers after the product is installed and build {{ site.data.keys.product_adj }} applications for the Application Center client, see [Configuring Application Center after installation](../installation-configuration/production/appcenter).

## Preliminary information
To use the Application Center, you must configure security settings, start the web application server where {{ site.data.keys.product }} is installed, start the Application Center console, and log in.

When you install {{ site.data.keys.product }}, the Application Center is automatically installed in the specified application server.

If you install the Application Center in WebSphere  Application Server Liberty profile, the server is created in **installation-directory/server**.

After the installation is complete, you must configure the security settings for the applications. See [Configuring user authentication for Application Center](../installation-configuration/production/appcenter#configuring-user-authentication-for-application-center) or, if you are using LDAP authentication, [Managing users with LDAP](../installation-configuration/production/appcenter/#managing-users-with-ldap).

### Example: starting the server and the Application Center console on Liberty profile

1. Start the Liberty server by using the **server** command that is in the **installation-directory/server/wlp/bin directory**.

   ```bash
   server start worklightServer
   ```
    
2. When the server is running, start the Application Center console by entering this address in your browser: `http://localhost:9080/appcenterconsole/`
3. Log in. By default, two users are defined for the installation of the Application Center on Apache Tomcat or WebSphere Application Server Liberty profile:
    * **demo** with password **demo**
    * **appcenteradmin** with password **admin**

### For more information
To use the Application Center console, refer to [The Application Center console](appcenter-console).

To install and run the mobile client on the following operating systems, see:

* Android: See [Installing the client on an Android mobile device](mobile-client/#installing-an-application-on-an-android-device).
* iOS operating system: See [Installing the client on an iOS mobile device](mobile-client/#installing-an-application-on-an-ios-device).
* Windows Phone 8: See [Installing the client on Windows 8 Universal](mobile-client/#installing-the-client-on-a-windows-phone-8-universal-mobile-device).
* Windows 8: The mobile client for Windows 8 is not intended to be deployed in Application Center for later distribution. See [Microsoft Windows 8: Building the project](preparations/#microsoft-windows-8-building-the-project).

## Next topics to follow
Follow these topics to use the appcenter mobile client; send notifications to installed applications; learn about the appcenter console, command-line tool, the mobile client; and setting log levels.






