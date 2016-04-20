---
title: Known Limitations & Workarounds for the Cordova Workflow in IBM MobileFirst Platform Foundation 8.0 Beta
date: 2016-03-31
tags:
- MobileFirst_Platform
- Cordova
- Beta
version:
- 8.0
author:
  name: Karen Tran
---
> [UPDATE Apr. 9, 2016] There were several Cordova releases this past week that resolve the issues listed below. Get the latest releases to eliminate the need to use the workarounds.

* [Cordova Tools Release](https://cordova.apache.org/news/2016/04/04/tools-release.html)

    The latest Cordova Tools release includes:

    * cordova-lib@6.1.1
    * cordova@6.1.1
    * plugman@1.2.1

    If you have cordova installed:

            npm install -g cordova@latest

    If you have plugman installed:

            npm install -g plugman@latest


* [Cordova iOS 4.1.1 Release](https://cordova.apache.org/announcements/2016/04/04/ios-4.1.1.html)

    To upgrade:

        npm install -g cordova
        cd my_project
        cordova platform rm ios
        cordova platform add ios@4.1.1

    To add it explicitly:

        cordova platform add ios@4.1.1

* [Cordova Windows 4.3.2 Release](https://cordova.apache.org/announcements/2016/04/05/cordova-windows-4.3.2.html)

    To upgrade:

        npm install -g cordova
        cd my_project
        cordova platform update windows@4.3.2

    To add it explicitly:

        cordova platform add windows@4.3.2


<hr/>

The following lists the known limitations and workarounds of creating Cordova apps with IBM MobileFirst 8.0 Beta.

* Use Cordova CLI v6.0.0, not v6.1.0

    There are known issues with v6.1.0 of Cordova CLI that prevents the iOS platform from being added in some instances as well as trying to add the Android platform from a path. Until v6.1.1 is released, use v6.0.0 of Cordova CLI.

     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`npm install -g cordova@6.0.0`

* A Cordova project created on Linux or Windows workstations that adds the iOS platform will need to remove and then re-add the iOS platform if that Cordova project is moved to an OSX workstation to run.

    After moving to an OSX workstation, in the Cordova project, run:

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cordova platform remove ios`

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cordova platform add ios`

    A fix is planned to be available in the next cordova-ios release.

* A Cordova project created on workstations other than Windows 8 or Windows 10 that adds the Windows Universal platform will need to remove and then re-add the Windows Universal platform if that Cordova project is moved to a Windows 8 or Windows 10 workstation to run.

    After moving to Windows 8 or Windows 10 workstation, in the Cordova project, run:

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cordova platform remove windows`

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`cordova platform add windows`

    A fix is planned to be available in the next cordova-windows release.
