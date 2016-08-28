---
layout: tutorial
title: Deprecated and discontinued features and API elements
weight: 3
---
<br/>
Consider carefully how removed features and API elements affect your IBM MobileFirst Foundation environment.

#### Jump to

* [Discontinued features and features that are not included in v8.0](#discontinued-features-and-features-that-are-not-included-in-v8-0)
* [Server-side API Changes](#server-side-api-changes)

### Discontinued features and features that are not included in v8.0
IBM MobileFirst Platform Foundation v8.0 is radically simplified compared to the previous version. As a result of this simplification, some features that were available in V7.1 are discontinued in v8.0. In most cases, an alternative way to implement the features is suggested. These features are marked discontinued. Some other features that exist in V7.1. are not in v8.0, but not as a consequence of the new design of v8.0. To distinguish these excluded features from the features that are discontinued from v8.0, they are marked not in v8.0.

<table class="table table-striped">
    <tr>
        <td>Feature</td>
        <td>Status and replacement path</td>
    </tr>
    <tr>
        <td>MobileFirst Studio is replaced by MobileFirst Studio plug-in for Eclipse.</td>
        <td><p>Replaced by MobileFirst Studio plug-in for Eclipse empowered by standard and community-base Eclipse plug-ins.
You can develop hybrid applications directly with the Apache Cordova CLI or with a Cordova enabled IDE such as Visual Studio Code, Eclipse, IntelliJ, and others.For more information about using eclipse as a Cordova enabled IDE, see <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/using-the-mfpf-sdk/using-mobilefirst-cli-in-eclipse/">IBM MobileFirst Studio plug-in for managing Cordova projects in Eclipse</a>.</p>

            <p>You can develop adapters with Apache Maven or a maven-enabled IDE such as Eclipse, IntelliJ, and others. For more information about developing adapters, see the <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters">Adapters category</a>. For more information about using Eclipse as a Maven enabled IDE, read the <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters/">Developing Adapters in Eclipse tutorial</a>.</p>

            <p>Install IBM MobileFirst Platform Foundation Developer Kit to test adapters and applications with MobileFirst Development Server. You can also access MobileFirst development tools and SDKs if you do not want to download them from Internet-based repositories such as NPM, Maven, Cocoapod, or NuGet. For more information about IBM MobileFirst Platform Foundation Developer Kit, see <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/setting-up-your-development-environment/mobilefirst-development-environment/">The IBM MobileFirst Platform Foundation Developer Kit</a>.
            </p></td>
    </tr>
    <tr>
        <td>
        Skins, Shells, the Setting page, minification, and JavaScript UI elements are discontinued for hybrid applications.
        </td>
        <td><p>Discontinued. Hybrid applications are developed directly with the Apache Cordova. For more information about replacing skins, shells, the Setting page, and minification, see Removed components and Comparison of Cordova apps developed with v8.0 versus v7.1 and before.</p></td>
    </tr>
    <tr>
        <td>
        Sencha Touch can no longer be imported into MobileFirst projects for hybrid applications.</td>
        <td><p>Discontinued. MobileFirst hybrid applications are developed directly with the Apache Cordova, and the MobileFirst features are provided as Cordova plug-ins. Refer to the Sencha Touch documentation to integrate Sencha Touch and Cordova.</p></td>
    </tr>
    <tr>
        <td>The encrypted cache is discontinued.</td>
        <td>
            <p>Discontinued. To store encrypted data locally, use JSONStore. For more information about JSONStore, see the <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/using-the-mfpf-sdk/jsonstore">JSONStore tutorial</a>.</p></td>
    </tr>
    <tr>        
        <td>
            Triggering Direct Update on demand is not in v8.0. The client application checks for Direct Update when it obtains the OAuth token for a session. You cannot program a client application to check for direct updates at a different point in time in v8.0.</td>
        <td>Not in v8.0.</td>
    </tr>
    <tr>
        <td>
        Adapters with session-dependency configuration. In V7.1.0, you can configure MobileFirst Server to work in session-independent mode (default) or in session-dependent mode. Beginning with v8.0, session-dependent mode is no longer supported. The server is inherently independent of the HTTP session, and no related configuration is required.</td>
        <td>Discontinued.</td>
    </tr><td>
        Attribute store over IBM® WebSphere® eXtreme Scale is not supported in v8.0.</td>
        <td>Not in v8.0.</td>
    </tr>
    <tr>
        <td>
        Service discovery and adapter generation for IBM® Business Process Manager (IBM BPM) process applications, Microsoft Azure Marketplace DataMarket, OData RESTful APIs, RESTful resources, Services that are exposed by an SAP Netweaver Gateway, and Web Services is not in v8.0.</td>
        <td>
        Not in v8.0.</td>
    </tr>
    <tr>
        <td>
        The JMS JavaScript adapter is not in v8.0.</td>
        <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        The SAP Gateway JavaScript adapter is not in v8.0.	</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        The SAP JCo JavaScript adapter is not in v8.0.	</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        The Cast Iron® JavaScript adapter in not in v8.0.	</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        The OData and Microsoft Azure OData JavaScript adapters are not in v8.0.	</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
    Push notification support for USSD is not supported in v8.0.	</td>
    <td>
        Discontinued.</td>
    </tr>
    <tr><td>
        Event-based push notifications is not supported in v8.0.	</td>
    <td>
        Discontinued. Use the push notification service. For more information on migrating to push notification service, see topic Migrating to push notifications from event source-based notifications.</td>
    </tr>
    <tr><td>
        Security: User-certificate authentication. v8.0 does not include any predefined security check to authenticate users with X.509 client-side certificates.	</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        Security: Simple data sharing. The WLSimpleDataSharing API is not included in v8.0. Therefore, using simple data sharing to configure device single sign-on with a reverse proxy (for example to exchange LTPA tokens between applications) is also not supported in v8.0.	</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        Security: Integration with IBM Trusteer®. v8.0 does not include any predefined security check or challenge to test IBM Trusteer risk factors.	</td>
    <td>
        Not in v8.0. Use IBM Trusteer Mobile SDK.</td>
    </tr>
    <tr><td>
        Security: Device provisioning and device auto-provisioning.	</td>
    <td>
        <p>Discontinued.</p>
        <p>Note: Device provisioning is handled in the normal authorization flow. Device data is automatically collected during the registration process of the security flow. For more information about the security flow, see End-to-end authorization flow.</p></td>
    </tr>
    <tr><td>
        Security: Configuration file for obfuscating Android code with ProGuard. v8.0 does not include the predefined proguard-project.txt configuration file for Android ProGuard obfuscation with a MobileFirst Android application.	</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        Security: Adapter based authentication is replaced. Authentication uses the OAuth protocol and is implemented with security checks.</td>
    <td>
        Replaced by a security check based implementation.</td>
    </tr>
    <tr><td>
        <p>Security: LDAP login. v8.0 does not include any predefined security check to authenticate users with an LDAP server.</p>
        <p>Instead, for WebSphere Application Server or WebSphere Application Server Liberty use the application server or a gateway to map an Identity Provider such as LDAP to LTPA, and generate an OAuth token for the user by using an LTPA security check.</p></td>
    <td>
        Not in v8.0. Replaced by an LTPA security check for WebSphere Application Server or WebSphere Application Server Liberty.</td>
    </tr>
    <tr><td>
        Authentication configuration of the HTTP adapter. The predefined HTTP adapter does not support the connection as a user to a remote server.</td>
    <td>
        <p>Not in v8.0.</p>
        <p>Edit the source code of the HTTP adapter and add the authentication code. Use <code>MFP.Server.invokeHttp</code> to add identification tokens to the HTTP request's header.</p></td>
    </tr>
    <tr><td>
        Security Analytics, the ability to monitor MobileFirst security framework's events with MobileFirst Analytics Console is not in v8.0.	</td>
    <td>
        Not in v.8.0.</td>
    </tr>
    <tr><td>
        The event source-based model for push notifications is discontinued and replaced by the tag-based push service model.	</td>
    <td>
        Discontinued and replaced by the tag-based push service model.</td>
    </tr>
    <tr><td>
        Unstructured Supplementary Service Data (USSD) support is not in v8.0.</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        Cloudant® used as a database for MobileFirst Server in not supported in v8.0.	</td>
    <td>
        Not in v8.0.</td>
    </tr>
    <tr><td>
        Geolocation: The geolocation support is discontinued in IBM MobileFirst Platform Foundation v8.0. The REST API for beacons and for mediators is discontinued. The client-side and server-side API WL.Geo and WL.Device are discontinued.	</td>
    <td>
        Discontinued. Use the native device API or third-party Cordova plug-ins for geolocation.</td>
    </tr>
    <tr><td>
        The MobileFirst Data Proxy feature is discontinued. The Cloudant IMFData and CloudantToolkit APIs are also discontinued.	</td>
    <td>
        Discontinued. For more information about replacing the IMFData and CloudantToolkit APIs in your apps, see Migrating apps storing mobile data in Cloudant with IMFData or Cloudant SDK.</td>
    <tr/>
    <tr><td>
        The IBM Tealeaf® SDK is no longer bundled with IBM MobileFirst Platform Foundation.	</td>
    <td>
        Discontinued. Use IBM Tealeaf SDK. For more information, see <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/AndroidGuide1010/CFs/TLAnddLggFrwkInstandImpl/TealeafAndroidLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-1-0&lang=en">Tealeaf installation and implementation in an Android application</a> and <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/iOSGuide1010/CFs/TLiOSLggFrwkInstandImpl/TealeafIOSLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-3-1&lang=en">Tealeaf iOS Logging Framework Installation and Implementation</a> in the IBM Tealeaf Customer Experience documentation.</td>
    </tr>
    <tr><td>
        IBM MobileFirst Platform Test Workbench is not bundled with IBM MobileFirst Platform Foundation	</td>
    <td>
        Discontinued.</td>
    </tr>
    <tr><td>
        BlackBerry, Adobe AIR, Windows Silverlight are not supported by IBM MobileFirst Platform Foundation v8.0. No SDK is provided for these platforms.	</td>
    <td>
        Discontinued.</td>
    </tr>
</table>

## Server-side API Changes
To migrate the server side of your MobileFirst application, take into account the changes to the APIs.  
The following tables list the discontinued server-side API elements in v8.0, deprecated server-side API elements in v8.0, and suggested migration paths. For more information about migrating the server side of your application, 

### JavaScript API elements discontinued in v8.0

#### Security
|API Element                         | Replacement Path                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.getActiveUer`             | Use `MFP.Server.getAuthenticatedUser` instead. |
| `WL.Server.getCurrentUserIdentity`   |                                                |
| `WL.Server.getCurrentDeviceIdentity` |                                                |	
| `WL.Server.setActiveUser`	         |                                                |
| `WL.Server.getClientId	`             |                                                |
| `WL.Server.getClientDeviceContext`	 |                                                |
| `WL.Server.setApplicationContext`	 |                                                |
 
#### Event Source
|API Element                         | Replacement Path                               |
|------------------------------------|------------------------------------------------|
| `WL.Server.createEventSource`	     | Use `MFP.Server.getAuthenticatedUser` instead. |
| `WL.Server.setEventHandlers`         | To migrate from Event source-based notifications to tag-based notifications, see Migrating to push notifications from event source-based notifications.                                                     |
| `WL.Server.createEventHandler`       |                                                |	
| `WL.Server.createSMSEventHandler`	 | To send SMS messages, use the push service REST API. For more information, see [Sending Notifications](../../../notifications/sending-notifications).                         |
| `WL.Server.createUSSDEventHandler`	 | Integrate USSD by using third-party services.  |

#### Push
|API Element                                | Replacement Path                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.getUserNotificationSubscription`	| To migrate from Event source-based notifications to tag-based notifications, see Migrating to push notifications from event source-based notifications.                                                       |
| `WL.Server.notifyAllDevices`                |                                                |
| `WL.Server.sendMessage`                     |                                                |
| `WL.Server.notifyDevice`                    |                                                |
| `WL.Server.notifyDeviceSubscription`        |                                                |
| `WL.Server.notifyAll`                       |                                                |
| `WL.Server.createDefaultNotification`       |                                                |
| `WL.Server.submitNotification`              |                                                |
| `WL.Server.subscribeSMS`	                | Use the REST API Push Device Registration (POST) to register the device. To send and receive SMS notifications, provide the phoneNumber in the payload while invoking the API.                               |
| `WL.Server.unsubscribeSMS`	                | Use the REST API Push Device Registration (DELETE) to unregister the device. |
| `WL.Server.getSMSSubscription`	            | Use the REST API Push Device Registration GET) to get the device registrations. |

#### Location Services
|API Element                                | Replacement Path                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Geo.*`	                                | Integrate Location services by using third-party services. |

#### WS-Security
|API Element                                | Replacement Path                               |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.signSoapMessage`	                | Use the WS-Security capabilities of WebSphere® Application Server. |

### Java API elements discontinued in v8.0
#### Security
|API Element                                | Replacement Path                               |
|-------------------------------------------|------------------------------------------------|
| `SecurityAPI.getSecurityContext`	        | Use AdapterSecurityContext instead.            |

#### Push
|API Element                                | Replacement Path                               |
|-------------------------------------------|------------------------------------------------|
| `PushAPI.sendMessage(INotification notification, String applicationId)`	| To migrate from Event source-based notifications to tag-based notifications, see Migrating to push notifications from event source-based notifications. |
| `INotification PushAPI.buildNotification();` | To migrate from Event source-based notifications to tag-based notifications, see Migrating to push notifications from event source-based notifications. |
| `UserSubscription PushAPI.getUserSubscription(String eventSource, String userId)` | To migrate from Event source-based notifications to tag-based notifications, see Migrating to push notifications from event source-based notifications. |

#### Adapters
|API Element                                | Replacement Path                               |
|-------------------------------------------|------------------------------------------------|
| `AdaptersAPI` interface in the `com.worklight.adapters.rest.api package` | Use the `AdaptersAPI` interface in the `com.ibm.mfp.adapter.api` package instead. |
| `AnalyticsAPI` interface in the `com.worklight.adapters.rest.api` package | Use the `AnalyticsAPI` interface in the `com.ibm.mfp.adapter.api` package instead. |
| `ConfigurationAPI` interface in the `com.worklight.adapters.rest.api` package | Use the `ConfigurationAPI` interface in the `com.ibm.mfp.adapter.api` package instead. |
| `OAuthSecurity` annotation in the `com.worklight.core.auth` package | Use the `OAuthSecurity` annotation in the `com.ibm.mfp.adapter.api` package instead. | 
| `MFPJAXRSApplication` class in the `com.worklight.wink.extensions` package | Use the `MFPJAXRSApplication` class in the `com.ibm.mfp.adapter.api` package instead. |
| `WLServerAPI` interface in the `com.worklight.adapters.rest.api` package | Use the JAX-RS `Context` annotation to access the MobileFirst API interfaces directly. |
| `WLServerAPIProvider` class in the `com.worklight.adapters.rest.api` package | Use the JAX-RS `Context` annotation to access the MobileFirst API interfaces directly. | 

## Client-side API Changes