---
title: Known Limitations & Workarounds for the Cordova Workflow in IBM MobileFirst Platform Foundation 8.0 Beta
date: 2016-03-31
tags:
- MobileFirst_Platform
- Cordova
- Beta
author:
  name: Karen Tran
---
The following lists the known limitations and workarounds of creating Cordova apps with IBM MobileFirst 8.0 Beta.

* Use Cordova CLI v6.0.0, not v6.1.0

    There are known issues with v6.1.0 of Cordova CLI that prevents the iOS platform from being added in some instances as well as trying to add the Android platform from a path. Until v6.1.1 is released, use v6.0.0 of Cordova CLI.

     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`npm install -g cordova@6.0.0`

* A Cordova project created on Linux or Windows workstations that adds the iOS platform will need to remove and then re-add the iOS platform if that Cordova project is moved to an OSX workstation to run.

    After moving to an OSX workstation, in the Cordova project, run:

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cordova platform remove ios`

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cordova platform add ios`

    A fix will be available in the next cordova-ios release.

* A Cordova project created on workstations other than Windows 8 or Windows 10 that adds the Windows Universal platform will need to remove and then re-add the Windows Universal platform if that Cordova project is moved to a Windows 8 or Windows 10 workstation to run.

    After moving to Windows 8 or Windows 10 workstation, in the Cordova project, run:

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cordova platform remove windows`

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cordova platform add windows`

    A fix will be available in the next cordova-windows release.

* Secure Direct Update may not work for all platforms. For Cordova apps using the Windows Universal platform, the server may also fail to detect mismatch between cordova plugin versions used when building the app and when building the web resources.

    No workaround is available for Beta. A fix will be available post-Beta.
