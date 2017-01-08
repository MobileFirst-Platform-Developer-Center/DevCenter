---
title: 'cordova-plugin-mfp v8.0.2016122615 released'
date: 2017-01-06
version:
- 8.0
tags:
- MobileFirst_Foundation
- Cordova
- Plugin
- Announcement
author:
  name: Idan Adar 
---
A new Cordova SDK build has been released for MobileFirst Foundation 8.0.  
This build introduces support for cordova-android@6.0, support for JSONStore in Android N devices, as well as several bug fixes.

## Changelog

* *Fixed* PI72919 JSONSTORE SECURED COLLECTION INITIALIZATION AND OAUTH IS NOT WORKING IN IOS 10 SIMULATORS WITH CORDOVA IOS VERSION 4.3.0
* *Fixed* PI71695 CORDOVA BUILD ERROR OCCURS WHEN ADDING MFP CORDOVA PLUGIN INTO AN EXISTING VISUAL STUDIO CORDOVA PROJECT
* *Fixed* PI70140 WHEN MAKING A RESOURCE REQUEST FROM AN ADAPTER IN PREVIEW MODE NOTHING HAPPENS
* *Fixed* PI64860 MFP CORDOVA TEMPLATE ADDS PACKAGE.JSON AND OTHER NOT RELATED FILES TO NEW APP CREATED
* *Fixed* PI66353 AN APP BUILT WITH RELEASE CONFIGURATION CRASHES ON IOS
* *Fixed* PI68455 WLNETWORKMANAGER NO LONGER EXISTS IN MFP8 AND CAUSES ERROR WITH CORDOVA-PLUGIN-NETWORK-INFORMATION
* *Fixed* PI71330 MFPDEV APP PREVIEW COMMAND DOES NOT ALLOW USE OF THE "PROMPT()" FUNCTION ON THE ANDROID PLATFORM
* *Fixed* PI71613 CORDOVA IOS APP BUILD FAILS WITH CORDOVA-PLUGIN-MFP-JSONSTORE WITH LD: FRAMEWORK NOT FOUND SQLCIPHER
* *Fixed* Wrong and inaccurate "warning" message for cordova-plugin-mfp-jsonstore on android

## Installation
To install, remove and re-add the cordova-plug-mfp plug-in.

```bash
cordova plugin remove cordova-plugin-mfp
cordova plugin add cordova-plugin-mfp
```
