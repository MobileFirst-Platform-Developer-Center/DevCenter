---
layout: tutorial
title: What's new in Interim Fixes
breadcrumb_title: Interim iFixes
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Interim fixes provide patches and updates to correct problems and keep {{ site.data.keys.product_full }} current for new releases of mobile operating systems.

Interim fixes are cumulative. When you download the latest v8.0 interim fix, you get all of the fixes from earlier interim fixes.

Download and install the latest interim fix to obtain all of the fixes that are described in the following sections. If you install earlier fixes, you might not get all of the fixes described here.

> For a list of iFix releases of {{ site.data.keys.product }} 8.0, [see here]({{site.baseurl}}/blog/tag/iFix_8.0/).

Where an APAR number is listed, you can confirm that an interim fix has that feature by searching the interim fix README file for that APAR number.

### Features introduced with CD update 3 (8.0.0.0-MFPF-IF201811050432-CDUpdate-03)

##### <span style="color:NAVY">**Support for refresh tokens on iOS**</span>

Mobile Foundation introduces the refresh token feature on iOS starting with this CD Update. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Download admin CLI (*mfpadm*) from Mobile Foundation console**</span>

Mobile Foundation admin CLI (*mfpadm*) can now be downloaded from within the *Download Center* of the Mobile Foundation console.

##### <span style="color:NAVY">**Support for Node v8.x for MobileFirst CLI**</span>

Starting from this iFix (*8.0.0.0-MFPF-IF201810040631*), Mobile Foundation adds support for Node v8.x for MobileFirst CLI.

##### <span style="color:NAVY">**Remove dependency on *libstdc++* for Cordova projects**</span>

Starting with this iFix (*8.0.0.0-MFPF-IF201809041150*), a change to remove *libstdc++* as a dependency to Cordova projects is introduced. This is required for new apps running on iOS 12. For further details, such as a workaround, refer to [this blog post](https://mobilefirstplatform.ibmcloud.com/blog/2018/07/23/mfp-support-for-ios12/).

### Features introduced with CD update 2 (8.0.0.0-MFPF-IF201807180449-CDUpdate-02)

##### <span style="color:NAVY">**Support for React Native development**</span>

Starting with the CD Update (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*), Mobile Foundation [announces]({{site.baseurl}}/blog/2018/07/24/React-Native-SDK-Mobile-Foundation/) the support for React Native development with the availability of IBM Mobile Foundation SDK for React Native apps. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/reactnative-tutorials/).

##### <span style="color:NAVY">**Automated synchronization of JSONStore collections with CouchDB databases for iOS and Cordova SDK**</span>

Starting with the CD Update (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*), using MobileFirst iOS SDK and Cordova SDK, you can automate the synchronization of data between a JSONStore Collection on a device with any flavour of CouchDB database, including [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). For more information on this feature, read this [blog post]({{site.baseurl}}/blog/2018/07/24/jsonstoresync-couchdb-databases-ios-and-cordova/).

##### <span style="color:NAVY">**Introducing Refresh tokens**</span>

Starting with the CD Update (*8.0.0.0-MFPF-IF201807180449-CDUpdate-02*), Mobile Foundation now introduces special kind of tokens called Refresh tokens that can be used to request a new access token.  [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/authentication-and-security/#refresh-tokens).

##### <span style="color:NAVY">**Support for Cordova v8 and Cordova Android v7**</span>

Starting from this iFix (*8.0.0.0-MFPF-IF201804051553*), MobileFirst Cordova plugins for Cordova v8 and Cordova Android v7 is supported. To work with the mentioned version of Cordova, you need to get the latest MobileFirst plugins and upgrade to the latest CLI (mfpdev-cli) version. For details on supported versions for individual platforms, refer to  [Adding the MobileFirst Foundation SDK to Cordova Applications]({{site.baseurl}}/tutorials/en/foundation/8.0/application-development/sdk/cordova/#support-levels).

##### <span style="color:NAVY">**Automated synchronization of JSONStore collections with CouchDB databases**</span>

Starting with this iFix (*8.0.0.0-MFPF-IF201802201451*), using MobileFirst Android SDK, you can automate the synchronization of data between a JSONStore Collection on a device with any flavour of CouchDB database, including [Cloudant](https://www.ibm.com/in-en/marketplace/database-management). For more information on this feature, read this [blog post]({{site.baseurl}}/blog/2018/02/23/jsonstoresync-couchdb-databases/).

### Features introduced with CD update 1 (8.0.0.0-MFPF-IF201711230641-CDUpdate-01)

##### <span style="color:NAVY">**Support for Eclipse UI editor**</span>

Starting with CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, WYSIWYG editor is now provided in MobileFirst Studio’s Eclipse. Developers can design and implement UI for their Cordova applications using this UI editor. [Learn more](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/cordova-apps/developing-ui/).

##### <span style="color:NAVY">**New adapters for building cognitive apps**</span>

Starting with CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, Mobile Foundation has introduced two new pre-built cognitive services adapters for the [*Watson Tone Analyzer*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonToneAnalyzer) and [*Language Translator*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonLanguageTranslator) services. These adapters are available to be downloaded and deployed from the *Download Center* in the Mobile Foundation Console.

##### <span style="color:NAVY">**Dynamic App Authenticity**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170220-1900*, A new implementation of *application authenticity* is provided. This implementation does not require the offline *mfp-app-authenticity* tool for generating the *.authenticity_data* file. Instead, you can enable or disable *application authenticity* from the MobileFirst console. For more information see [Configuring Application Authenticity](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/authentication-and-security/application-authenticity).

##### <span style="color:NAVY">**Appcenter (client & server) support for Windows 10**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170327-1055*, Windows 10 UWP apps are supported in IBM Application Center. The user can now upload Windows 10 UWP apps and install the same on their device. The Windows 10 UWP client project for installing the UWP app is now shipped with the Application Center. You can open the project in Visual Studio and create a binary (for example, *.appx*) for distribution. Application Center does not provide a predefined method of distributing the mobile client. For more information, see [Microsoft Windows 10 Universal (Native) IBM AppCenter client](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/appcenter/preparations/#microsoft-windows-10-universal-native-ibm-appcenter-client).

##### <span style="color:NAVY">**MobileFirst Eclipse plugin support for Eclipse Neon**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170426-1210*, MobileFirst Eclipse plugin is updated to support Eclipse Neon.

##### <span style="color:NAVY">**Android SDK modified to use a newer version of OkHttp (version 3.4.1)**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170605-2216*, Android SDK has been modified to use a newer version of *OkHttp (version 3.4.1)* instead of the old version that was previously bundled with the MobileFirst SDK for Android. OkHttp is added as a dependency rather than being bundled with the SDK. This allows freedom of choice in using the OkHttp library for developers and also prevents conflicts with multiple versions of OkHttp.

##### <span style="color:NAVY">**Support for Cordova v7**</span>

Starting with iFix *8.0.0.0-MFPF-IF20170608-0406*, Cordova v7 is supported. For details on supported versions of individual platforms, refer to [Adding the MobileFirst Foundation SDK to Cordova Applications](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/application-development/sdk/cordova/).

##### <span style="color:NAVY">**Multiple certificate pinning support**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170624-0159*), Mobile Foundation supports pinning of multiple certificates. Earlier to this iFix, Mobile Foundation supported pinning of a single certificate. Mobile Foundation introduced a new API, which allows connection to multiple hosts by allowing the user to pin public keys of multiple X509 certificates to the client application. This feature is supported only for native Android and iOS apps. Learn more about *Multiple certificate pinning support* from [What's new](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), under the section *What's new in MobileFirst APIs*.

##### <span style="color:NAVY">**Adapters for building a cognitive app**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170710-1834*), Mobile Foundation has introduced pre-built adapters for Watson cognitive services such as [*WatsonConversation*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonConversationAdapter), [*WatsonDiscovery*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonDiscoveryAdapter), and [*WatsonNLU (Natural Language Understanding)*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/WatsonNLUAdapter). These adapters are available to be downloaded and deployed from the *Download Center* in the Mobile Foundation Console.

##### <span style="color:NAVY">**Cloud Functions adapter for building a serverless app**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170710-1834*), Mobile Foundation introduced a pre-built adapter called [*Cloud Functions adapter*](https://github.com/mfpdev/mfp-extension-adapters/tree/master/OpenWhiskAdapter) for the [Cloud Functions Platform](https://console.bluemix.net/openwhisk/). The adapter is available to be downloaded and deployed from the *Download Center* in the Mobile Foundation Console.

##### <span style="color:NAVY">**Support for pinning multiple certificates in the Cordova SDK**</span>

Starting with this iFix (*8.0.0.0-MFPF-IF20170803-1112*) pinning of multiple certificates is supported in the Cordova SDK. Read more on *Multiple certificate pinning support* from [What's new](http://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/product-overview/release-notes/whats-new/), under the section *What's new in MobileFirst APIs* .

##### <span style="color:NAVY">**Support for Cordova browser platform**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170823-1236*), {{ site.data.keys.product }} supports the Cordova browser platform along with the earlier supported platforms of Cordova Windows, Cordova Android, and Cordova iOS. [Learn more](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/29/cordova-browser-compatibility-with-MFP/).

##### <span style="color:NAVY">**Generate an adapter from its OpenAPI specification**</span>

Starting with iFix (*8.0.0.0-MFPF-IF20170901-1903*), {{ site.data.keys.product }} introduced the capability to auto-generate an adapter from its OpenAPI specification. {{ site.data.keys.product }} users can now focus on the application logic instead of creating the {{ site.data.keys.product }} adapter, which connects the application to the desired back-end service. [Learn more]({{site.baseurl}}/tutorials/en/foundation/8.0/adapters/microservice-adapter/).

##### <span style="color:NAVY">**Support for iOS 11 and iPhone X**</span>

Starting with CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, Mobile Foundation announced the support for iOS 11 and iPhone X on Mobile Foundation v8.0. For further details, read the blog post [IBM MobileFirst Platform Foundation Support for iOS 11 and iPhone X](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/18/mfp-support-for-ios11/).

##### **<span style="color:NAVY">Support for Android Oreo</span>**

Starting with CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, Mobile Foundation announced the support for Android Oreo with this [blog post](https://mobilefirstplatform.ibmcloud.com/blog/2017/08/22/mobilefirst-android-Oreo/). Both native Android apps and hybrid/Cordova apps, built on older versions of Android, work as expected on Android Oreo when the device is upgraded through an OTA.

##### <span style="color:NAVY">**Mobile Foundation can now be deployed on Kubernetes clusters**</span>

Starting with CD Update *8.0.0.0-MFPF-IF201711230641-CDUpdate-01*, Mobile Foundation user can now deploy Mobile Foundation, which includes the Mobile Foundation Server, Mobile Analytics Server, and the Application Center, on Kubernetes clusters. The deployment package has been updated to support Kubernetes deployment. Read the [announcement](https://mobilefirstplatform.ibmcloud.com/blog/2017/09/09/mobilefoundation-on-kube/).

<!--
### Licensing
{: #licensing }
#### PVU licensing
{: #pvu-licensing }
A new offering, {{ site.data.keys.product }} Extension V8.0.0, is available through PVU (processor value unit) licensing. For more information on PVU licensing for {{ site.data.keys.product }} Extension, see [Licensing {{ site.data.keys.product_adj }}](../../licensing).


### Web applications
{: #web-applications }
#### Registering web applications from the {{ site.data.keys.mf_cli }} (APAR PI65327)
{: #registering-web-applications-from-the-mobilefirst-cli-apar-pi65327 }
You can now register client web applications to {{ site.data.keys.mf_server }} by using the {{ site.data.keys.mf_cli }} (mfpdev) as an alternative to registration from the {{ site.data.keys.mf_console }}. For more information, see Registering web applications from the {{ site.data.keys.mf_cli }}.

### Cordova applications
{: #cordova-applications }
#### Opening the native IDE for a Cordova project from Eclipse with the Studio plug-in
{: #opening-the-native-ide-for-a-cordova-project-from-eclipse-with-the-studio-plug-in }
With the Studio plug-in installed in your Eclipse IDE, you can open an existing Cordova project in Android Studio or Xcode from the Eclipse interface to build and run the project.

#### Added *projectName* directory as an option when you use the Migration Assistance tool
{: #added-projectname-directory-as-an-option-when-you-use-the-migration-assistance-tool }
You can specify a name for your Cordova project directory when you migrate projects with the migration assistance tool. If you do not provide a name, the default name is *app_name-app_id-version*.

#### Usability improvements to the Migration Assistance tool
{: #usability-improvements-to-the-migration-assistance-tool }
Made the following changes to improve the usability of the Migration Assistance tool:

* The Migration Assistance tool scans HTML files and JavaScript files.
* The scan report opens in your default browser automatically after the scan is finished.
* The *--out* flag is optional. The working directory is used if it is not specified.
* When the *--out* flag is specified and the directory does not exist, the directory is created.

### Adapters
{: #adapters }
#### Added `mfpdev push` and `pull` commands for Java and JavaScript adapter configurations
{: #added-mfpdev-push-and-pull-commands-for-java-and-javascript-adapter-configurations }
You can use {{ site.data.keys.mf_cli }} to push Java and JavaScript adapter configurations to the {{ site.data.keys.mf_server }} and pull adapter configurations from the {{ site.data.keys.mf_server }}.

### Application Center
{: #application-center}

Cordova based application center client is now available for iOS and Android.
-->