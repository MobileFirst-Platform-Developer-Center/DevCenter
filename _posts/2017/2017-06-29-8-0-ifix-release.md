---
title: MobileFirst Foundation iFix 8.0.0.0-MFPF-IF20170624-0159 released
date: 2017-06-29
version:
- 8.0
tags:
- MobileFirst_Foundation
- Announcement
- iFix_8.0
- iFix
author:
  name: Sreelatha Sankaranarayanan
---
A new iFix has been released for MobileFirst Foundation 8.0, dated **June 24th, 2017**.

## Changes in this iFix
*For a cumulative list of all previous fixes, see the [iFix download page on IBM Fix Central](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc).*

### Support for Cordova v7
Starting from iFix **8.0.0.0-MFPF-IF20170608-0406**, Cordova v7 is supported. For details, refer to [Adding the MobileFirst Foundation SDK to Cordova Applications](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/).

### Multiple certificate pinning support
Starting with this iFix (**8.0.0.0-MFPF-IF20170624-0159**), Mobile Foundation supports pinning of multiple certificates. Prior to this iFix, Mobile Foundation supported pinning of a single certificate. Mobile Foundation has introduced a new API, which allows connection to multiple hosts by allowing the user to pin public keys of multiple X509 certificates to the client application. Read more on **Multiple certificate pinning support** from [What's new](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), under the section *What's new in MobileFirst APIs* .

### APARs Fixed

**PI82841** DEPLOYMENT OF MOBILEFIRST PUREAPPLICATION PATTERN MAY FAIL

**PI78623** SPECIFIED TIMEOUT VALUE IN WLRESOURCEREQUEST API CALLS IGNORED IN NATIVE IOS AND ANDROID SDKS

**PI82800** CLASSNOTFOUNDEXCEPTION ON PASSWORDUTIL WHEN STARTINGMOBILEFIRST SERVER ON TOMCAT

**PI79018** STRENGTHEN MF OAUTH TOKEN EXCHANGE PROCESS to avoid risk oftampering with the URI

**PI80785** USING WL.ANALYTICS.SEND() OR WL.LOGGER.SEND() MIGHT RESULT IN  JAVA.IO.IOEXCEPTIONP

**PI75631** ERROR IN MFPMIGRATE UTILITY WHEN MULTIPLE ENVIRONMENTS HAVE  DIFFERENT VERSIONS.


## How to upgrade
**Server**  
To upgrade, download &amp; install the [Developer Kit for evaluators]({{site.baseurl}}/downloads/), [Developer Kit for customers / iFix package for on-prem production environment](http://www.ibm.com/support/fixcentral/swg/quickorder?parent=ibm%7EOther%2Bsoftware&product=ibm/Other+software/IBM+MobileFirst+Platform+Foundation&release=8.0.0.0&platform=All&function=all&source=fc) (requires login to IBM Fix Central), or refresh your Mobile Foundation service from your service Dashboard.

**Client SDKs**  
To upgrade, [run the upgrade commands for your platform]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/).


## Individual artifact build numbers in this iFix
*The artifacts updated in the iFix are emphasized.*
#### MobileFirst DevKit

_**8.0.0.0-MFPF-DevKit-Linux-IF201706240159.bin**_

_**8.0.0.0-MFPF-DevKit-MacOSX-IF201706240159.zip**_

_**8.0.0.0-MFPF-DevKit-Windows-IF201706240159.exe**_
<hr/>
#### Cordova plugins

_**cordova-plugin-mfp               8.0.2017060910**_

*cordova-plugin-mfp-encrypt-utils   8.0.2017021815*

*cordova-plugin-mfp-fips            8.0.2017021815*

*cordova-plugin-mfp-jsonstore       8.0.2017033009*

*cordova-plugin-mfp-push            8.0.2017062111*

*cordova-template-mfp               8.0.2017060206*

*ibm-mfp-web-sdk                    8.0.2017021409*

*passport-mfp-token-validation      8.0.2017010917*
<hr/>
#### Tools

*mfpdev-cli                         8.0.2017012016*

_**mfpmigrate-cli                   8.0.2017061505**_
<hr/>
#### iOS SDK

_**IBMMobileFirstPlatformFoundation                    8.0.2017053010**_

_**IBMMobileFirstPlatformFoundationOpenSSLUtils        8.0.2017053010**_

_**IBMMobileFirstPlatformFoundationPush                8.0.2017061612**_

_**IBMMobileFirstPlatformFoundationJSONStore           8.0.2017053010**_

<hr/>
#### Andriod SDK

_**ibmmobilefirstplatformfoundation              8.0.2017061318**_

*ibmmobilefirstplatformfoundationpush            8.0.2017011813*

*ibmmobilefirstplatformfoundationjsonstore       8.0.2017011811*

*adapter-maven-plugin              8.0.2017021701*

*adapter-maven-archetype-sql       8.0.2017021701*

*adapter-maven-archetype-java      8.0.2017021701*

*adapter-maven-archetype-http      8.0.2017021701*

*adapter-maven-api                 8.0.2017021701*

*mfp-security-checks-base          8.0.2017020112*

*mfp-java-token-validator          8.0.2017020112*
<hr/>
#### Windows SDK

*IBMMobileFirstPlatform Foundation 8.0.2017012419*

*IBM MobileFirstPlatform Push SDK  8.0.2017012419*
<hr/>
#### Xamarian SDK

*IBMMobileFirstPlatform SDK 8.0.2017051208*
