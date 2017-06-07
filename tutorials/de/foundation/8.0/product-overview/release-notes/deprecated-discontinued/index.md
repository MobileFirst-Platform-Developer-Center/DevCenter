---
layout: tutorial
title: Veraltete und weggefallene Features und APIs
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Überprüfen Sie gründlich, wie sich Features und API-Elemente, die entfernt wurden,
auf Ihre
{{ site.data.keys.product_full }}-Umgebung auswirken. #### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [In Version 8.0 weggefallene und nicht mehr enthaltene Features](#dicontinued-features-and-features-that-are-not-included-in-v-80)
* [Änderungen an der serverseitigen API](#server-side-api-changes)
* [Änderungen an der clientseitigen API](#client-side-api-changes)

## In Version 8.0 weggefallene und nicht mehr enthaltene Features
{: #dicontinued-features-and-features-that-are-not-included-in-v-80 }
{{ site.data.keys.product }} Version
8.0
ist im Vergleich zur Vorgängerversion stark vereinfacht. Ein Ergebnis dieser Vereinfachung ist, dass einige Features aus Version 7.1 in
Version 8.0 weggefallen sind. In den meisten Fällen wird eine Alternative für die Implementierung der Features vorgeschlagen. Betroffene Features sind mit dem Vermerk
"weggefallen" versehen. Es gibt auch Features aus Version 7.1, die aus anderen Gründen nicht mehr in Version
8.0 enthalten sind. Damit Sie diese nicht mehr enthaltenen Features von den weggefallenen Features in Version 8.0 unterscheiden können, haben die nicht mehr enthaltenen Features den Vermerk "nicht in Version 8.0 enthalten".

<table class="table table-striped">
    <tr>
        <td>Feature</td>
        <td>Status und Ersetzungspfad</td>
    </tr>
    <tr>
        <td><p>MobileFirst Studio wird durch das MobileFirst-Studio-Plug-in für Eclipse ersetzt.</p></td>
        <td><p>Ersetzt durch das MobileFirst-Studio-Plug-in für Eclipse, das mit Eclipse-Standard- und -Community-Plug-ins abgestimmt ist. Sie können Hybridanwendungen direkt über die Apache-Cordova-CLI oder in einer Cordova-fähigen IDE wie Visual Studio Code, Eclipse, IntelliJ und anderen entwickeln. Weitere Informationen zur Verwendung von Eclipse als Cordova-fähige IDE finden Sie unter <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/using-mobilefirst-cli-in-eclipse/">IBM MobileFirst-Studio-Plug-in für die Verwaltung von Cordova-Projekten in Eclipse</a>.</p>

        <p>Adapter können Sie mit Apache Maven oder einer Maven-fähigen IDE wie Eclipse, IntelliJ und anderen entwickeln. Weitere Informationen zur Entwicklung von Adaptern finden Sie unter <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters">Adapter entwickeln</a>. Weitere Informationen zur Verwendung von Eclipse als Maven-fähige IDE enthält das Lernprogramm <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/adapters/developing-adapters/">Adapter in Eclipse entwickeln</a>.</p>

        <p>Installieren Sie das {{ site.data.keys.mf_dev_kit_full }}, um Adapter und Anwendungen mit {{ site.data.keys.mf_server }} zu testen. Sie können auch auf die {{ site.data.keys.product_adj }}-Entwicklungstools und -SDKs zugreifen, wenn Sie sie nicht aus Internet-Repositorys wie NPM, Maven, Cocoapod oder NuGet herunterladen möchten. Weitere Informationen zum {{ site.data.keys.mf_dev_kit }} finden Sie unter <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/installation-configuration/development/mobilefirst/">{{ site.data.keys.mf_dev_kit }}</a>.</p>
        </td>
    </tr>
    <tr>
        <td><p>Oberflächen, Shells, die Seite mit den Einstellungen, die Verkleinerung auf Symbolgröße und JavaScript-UI-Elemente für Hybridanwendungen sind weggefallen.</p></td>
        <td><p>Weggefallen. Hybridanwendungen werden direkt mit Apache Cordova entwickelt. Weitere Informationen zum Ersetzen von Oberflächen und Shells sowie zur Ersetzung der Seite mit den Einstellungen und zur Verkleinerung auf Symbolgröße finden Sie unter "Gelöschte Komponenten" und "In Version 8.0 und Version 7.1 entwickelte Cordova-Apps im Vergleich".</p>
        </td>
    </tr>
    <tr>
        <td><p>Sencha Touch kann für Hybridanwendungen nicht mehr in {{ site.data.keys.product_adj }}-Projekte importiert werden.</p></td>
        <td><p>Weggefallen. {{ site.data.keys.product_adj }}-Hybridanwendungen werden direkt mit Apache Cordova entwickelt und die {{ site.data.keys.product_adj }}-Features werden als Cordova-Plug-ins bereitgestellt. Wie Sencha Touch und Cordova kombiniert verwendet werden können, erfahren Sie in der Sencha-Touch-Dokumentation.</p>
        </td>
    </tr>
    <tr>
        <td><p>Der verschlüsselte Cache ist weggefallen.</p></td>
        <td><p>Weggefallen. Verwenden Sie JSONStore, um verschlüsselte Daten lokal zu speichern. Weitere Informationen zu JSONStore enthält das Lernprogramm <a href="{{site.baseurl}}/tutorials/en/foundation/8.0/application-development/jsonstore">JSONStore</a>.</p>
        </td>
    </tr>
    <tr>        
        <td><p>Die Auslösung der direkten Aktualisierung bei Bedarf ist in Version 8.0 nicht möglich. Die Clientanwendung überprüft, ob eine direkte Aktualisierung verfügbar ist, wenn sie das OAuth-Token für eine Sitzung abruft. Sie können eine Clientanwendung in Version 8.0 nicht so programmieren, dass sie zu einem anderen Zeitpunkt überprüft, ob eine direkte Aktualisierung verfügbar ist.</p></td>
        <td><p>Nicht in Version 8.0 enthalten</p></td>
    </tr>
    <tr>
        <td><p>Adapter mit konfigurierter Sitzungsabhängigkeit: In Version 7.1.0 konnten Sie {{ site.data.keys.mf_server }} für den sitzungsunabhängigen Modus (Standardeinstellung) oder den sitzungsabhängigen Modus konfigurieren. Ab Version 8.0 wird der sitzungsabhängige Modus nicht mehr unterstützt. Der Server ist grundsätzlich unabhängig von HTTP-Sitzungen. Eine spezielle Konfiguration dafür ist nicht erforderlich.</p></td>
        <td><p>Weggefallen.</p></td>
    </tr>
    <tr>
        <td><p>Der Attribut-Store in IBM WebSphere eXtreme Scale wird in Version 8.0 nicht unterstützt.</p></td>
        <td><p>Nicht in Version 8.0 enthalten</p></td>
    </tr>
    <tr>
        <td><p>Die Serviceerkennung und Adaptergenerierung für IBM BPM-Prozessanwendungen (IBM Business Process Manager), Microsoft Azure Marketplace DataMarket, REST-konforme OData-APIs, REST-konforme Ressourcen, über SAP NetWeaver Gateway zugänglich gemachte Services und Web-Services ist in Version 8.0 nicht verfügbar.</p></td>
        <td><p>Nicht in Version 8.0 enthalten</p></td>
    </tr>
    <tr>
        <td>Der JMS-JavaScript-Adapter ist nicht in Version 8.0 enthalten.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Der SAP-Gateway-JavaScript-Adapter ist in Version 8.0 nicht verfügbar.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Der SAP-JCo-JavaScript-Adapter ist in Version 8.0 nicht verfügbar.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Der Cast-Iron-JavaScript-Adapter ist in Version 8.0 nicht verfügbar.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Der OData-Adapter und der Microsoft-Azure-OData-JavaScript-Adapter sind nicht in Version 8.0 enthalten.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Push-Benachrichtigungsunterstüzung für USSD ist in Version 8.0 nicht verfügbar.</td>
        <td>Weggefallen.</td>
    </tr>
    <tr>
        <td>Ereignisbasierte Push-Benachrichtigungen werden in Version 8.0 nicht unterstützt.</td>
        <td>Weggefallen. Verwenden Sie den Push-Benachrichtigungsservice. Weitere Informationen zur Umstellung auf den Push-Benachrichtigungsservice finden Sie unter "Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen".</td>
    </tr>
    <tr>
      <td>
        Sicherheit: Das Anti-XSRF-Realm <code>wl_antiXSRFRealm</code> ist in Version 8.0 nicht erforderlich.
      </td>
      <td>
        In Version 7.1.0 wurde der Authentifizierungskontext in der HTTP-Sitzung gespeichert und über ein vom Browser in standortübergreifenden Anforderungen gesendetes Sitzungscookie identifiziert. In dieser Version wird das Anti-XSRF-Realm verwendet, um die Cookieübertragung gegen XSRF-Attacken durch das Senden eines zusätzlichen Headers vom Client an den Server zu schützen.
        <br />
        Der Sicherheitskontext wird in Version 8.0.0 nicht mehr mit einer HTTP-Sitzung verknüpft und nicht über ein Sitzungscookie identifiziert.
        Die Autorisierung erfolgt stattdessen mithilfe eines OAuth-2.0-Zugriffstokens, das an den Authorization-Header übergeben wird.
        Da der Authorization-Header in standortübergreifenden Anforderungen nicht vom Browser gesendet wird, muss er nicht vor XSRF-Attacken geschützt werden.
      </td>
    </tr>
    <tr>
        <td>Sicherheit - Authentifizierung mit Benutzerzertifikat: In Version 8.0 gibt es keine vordefinierte Sicherheitsüberprüfung zur Authentifizierung von Benutzern mit clientseitigen X.509-Zertifikaten.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Sicherheit - Integration von IBM Trusteer: In Version 8.0 gibt es keine vordefinierte Sicherheitsüberprüfung oder Abfrage, um die Risikofaktoren von IBM Trusteer zu testen.</td>
        <td>Nicht in Version 8.0 enthalten. Verwenden Sie das IBM Trusteer Mobile SDK.</td>
    </tr>
    <tr>
        <td>Sicherheit - Bereitstellung und automatische Bereitstellung für Geräte</td>
        <td><p>Weggefallen.</p><p>Hinweis: Die Bereitstellung für Geräte erfolgt im Rahmen des normalen Autorisierungsablaufs. Während des Registrierungsprozesses, der Teil des Sicherheitsablaufs ist, werden automatisch Gerätedaten erfasst. Weitere Informationen zum Sicherheitsablauf finden Sie unter "End-to-End-Autorisierungsablauf".</p>
        </td>
    </tr>
    <tr>
        <td>Sicherheit - Konfigurationsdatei für die Verschleierung von Android-Code mit ProGuard: In Version 8.0 gibt es keine vordefinierte Konfigurationsdatei proguard-project.txt für die ProGuard-Verschleierung einer MobileFirst-Android-Anwendung.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Sicherheit: Die adapterbasierte Authentifizierung wurde ersetzt. Die Authentifizierung erfolgt mit dem OAuth-Protokoll und wird mit Sicherheitsüberprüfungen implementiert.</td>
        <td>Durch eine auf Sicherheitsüberprüfungen basierende Implementierung ersetzt.</td>
    </tr>
    <tr>
        <td><p>Sicherheit - LDAP-Anmeldung: In Version 8.0 gibt es keine vordefinierte Sicherheitsüberprüfung für die Authentifizierung von Benutzern gegenüber einem LDAP-Server.</p>
        <p>Verwenden Sie für WebSphere Application Server oder WebSphere Application Server Liberty stattdessen den Anwendungsserver oder ein Gateway, um für LTPA einen Identitätsprovider wie LDAP zuzuordnen, und generieren Sie für den Benutzer ein OAuth-Token mit einer LTPA-Sicherheitsüberprüfung.</p></td>
        <td>Nicht in Version 8.0 enthalten. Durch eine LTPA-Sicherheitsüberprüfung für WebSphere Application Server oder  WebSphere Application Server Liberty ersetzt.</td>
    </tr>
    <tr>
        <td>
        Dieses Unterelement gibt die Authentifizierungskonfiguration des HTTP-Adapters an. Der vordefinierte HTTP-Adapter bietet keine Unterstützung das Herstellen einer Verbindung zu einem fernen Server als Benutzer.</td>
        <td><p>Nicht in Version 8.0 enthalten</p><p>Bearbeiten Sie den Quellcode des HTTP-Adapters. Fügen Sie den Authentifizierungscode hinzu. Verwenden Sie <code>MFP.Server.invokeHttp</code>, um Identifizierungstoken zum Header der HTTP-Anforderung hinzuzufügen.</p></td>
    </tr>
    <tr>
        <td>
        In Version 8.0 gibt es keine Sicherheitsanalyse und keine Überwachung der Ereignisse des MobileFirst-Sicherheitsframeworks in der MobileFirst Analytics Console.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Das auf Ereignisquellen basierende Modell für Push-Benachrichtigungen ist weggefallen und wird durch das Push-Servicemodell auf Tagbasis ersetzt.</td>
        <td>Weggefallen und durch tagbasiertes Push-Servicemodell ersetzt.</td>
    </tr>
    <tr>
        <td>In Version 8.0 gibt es keine USSD-Unterstützung (Unstructured Supplementary Service Data).</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Die Verwendung von Cloudant als Datenbank für {{ site.data.keys.mf_server }} wird in Version 8.0 nicht unterstützt.</td>
        <td>Nicht in Version 8.0 enthalten</td>
    </tr>
    <tr>
        <td>Geoortung: In Version 8.0 der {{ site.data.keys.product }} gibt es keine Geoortungsunterstützung. Die REST-API für Beacons und Mediatoren ist weggefallen. Die clientseitige API und die serverseitige API (WL.Geo und WL.Device) sind weggefallen.</td>
        <td>Weggefallen. Verwenden Sie für die Geoortung die native Geräte-API oder Cordova-Plug-ins anderer Anbieter.</td>
    </tr>
    <tr>
        <td>Der {{ site.data.keys.product_adj }} Data Proxy ist weggefallen. Die Cloudant-APIs IMFData und CloudantToolkit sind ebenfalls weggefallen.</td>
        <td>Weggefallen. Weitere Informationen zur Ersetzung der APIs IMFData und CloudantToolkit in Ihren Apps finden Sie unter "Apps umstellen, die mobile Daten mit IMFData oder dem Cloudant-SDK in Cloudant speichern".</td>
    </tr>
    <tr>
        <td>Das IBM Tealeaf SDK ist nicht mehr im Produktpaket der {{ site.data.keys.product }} enthalten.</td>
        <td>Weggefallen. Verwenden Sie das IBM Tealeaf SDK. Weitere Informationen finden Sie in der Dokumentation zu IBM Teleaf Customer Experience unter <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/AndroidGuide1010/CFs/TLAnddLggFrwkInstandImpl/TealeafAndroidLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-1-0&lang=en">Tealeaf installation and implementation in an Android application</a> and <a href="https://www.ibm.com/support/knowledgecenter/TLSDK/iOSGuide1010/CFs/TLiOSLggFrwkInstandImpl/TealeafIOSLoggingFrameworkInstallationAndImplementation.dita?cp=SS2MBL_9.0.2%2F5-0-3-1&lang=en">Tealeaf iOS Logging Framework Installation and Implementation</a>.</td>
    </tr>
    <tr>
        <td>Die {{ site.data.keys.mf_test_workbench_full }} ist nicht im Produktpaket der {{ site.data.keys.product }} enthalten.</td>
        <td>Weggefallen</td>
    </tr>
    <tr>
        <td>BlackBerry, AIR und Windows Silverlight werden von Version 8.0 nicht unterstützt. Für die genannten Plattformen wird kein SDK bereitgestellt.</td>
        <td>Weggefallen</td>
    </tr>
</table>

## Änderungen an der serverseitigen API
{: #server-side-api-changes }
Wenn Sie die Serverseite Ihrer {{ site.data.keys.product_adj }}-Anwendung umstellen, müssen Sie die Änderungen an den APIs beachten.  
In den folgenden Tabellen sind die in
Version 8.0 weggefallenen und nicht weiter unterstützten
serverseitigen API-Elemente
mit Vorschlägen für den Migrationspfad aufgelistet. Weitere Informationen zur Migration der Serverseite Ihrer Anwendung finden Sie unter .

### In Version 8.0 weggefallene JavaScript-API-Elemente
{: #javascript-api-elements-discontinued-v-v-80 }
#### Sicherheit
{: #security }

| API-Element                         | Ersetzungspfad                                 |
|------------------------------------|------------------------------------------------|
| `WL.Server.getActiveUser`, `WL.Server.getCurrentUserIdentity`,  `WL.Server.getCurrentDeviceIdentity`, `WL.Server.setActiveUser`, `WL.Server.getClientId`, `WL.Server.getClientDeviceContext`, `WL.Server.setApplicationContext` | Verwenden Sie stattdessen `MFP.Server.getAuthenticatedUser`.  |

#### Ereignisquelle
{: #event-source }

| API-Element                         | Ersetzungspfad                                 |
|------------------------------------|------------------------------------------------|
| `WL.Server.createEventSource`	     | Verwenden Sie stattdessen `MFP.Server.getAuthenticatedUser`.  |
| `WL.Server.setEventHandlers`         | Informationen zur Migration Ihrer Push-Benachrichtigungen finden Sie unter "Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen".                                                      |
| `WL.Server.createEventHandler`       |                                                |
| `WL.Server.createSMSEventHandler`	 | Verwenden Sie die Push-Service-REST-API zum Senden von SMS-Nachrichten. Weitere Informationen finden Sie unter [Benachrichtigungen senden](../../../notifications/sending-notifications).                         |
| `WL.Server.createUSSDEventHandler`	 | Integrieren Sie USSD über Services anderer Anbieter.   |

#### Push
{: #push }

| API-Element                                | Ersetzungspfad                                 |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.getUserNotificationSubscription`, `WL.Server.notifyAllDevices`, `WL.Server.sendMessage`, `WL.Server.notifyDevice`, `WL.Server.notifyDeviceSubscription`, `WL.Server.notifyAll`, `WL.Server.createDefaultNotification`, `WL.Server.submitNotification` 	| Informationen zur Migration Ihrer Push-Benachrichtigungen finden Sie unter "Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen".  |
| `WL.Server.subscribeSMS`	                | Verwenden Sie die REST-API Push Device Registration (POST), um das Gerät zu registrieren. Wenn Sie SMS-Benachrichtigungen senden und empfangen möchten, geben Sie beim Aufrufen der API in den Nutzdaten die Rufnummer (phoneNumber) an.                                |
| `WL.Server.unsubscribeSMS`	                | Verwenden Sie die REST-API Push Device Registration (DELETE), um die Geräteregistrierung aufzuheben.  |
| `WL.Server.getSMSSubscription`	            | Verwenden Sie die REST-API Push Device Registration GET), um die Geräteregistrierungen abzurufen.  |

#### Ortungsdienste
{: #location-services }

| API-Element                                | Ersetzungspfad                                 |
|-------------------------------------------|------------------------------------------------|
| `WL.Geo.*`	                                | Integrieren Sie Ortungsdienste über Services anderer Anbieter.  |

#### WS-Security
{: #ws-security }

| API-Element                                | Ersetzungspfad                                 |
|-------------------------------------------|------------------------------------------------|
| `WL.Server.signSoapMessage`	                | Verwenden Sie die WS-Security-Funktionen von WebSphere Application Server. |

### In Version 8.0 weggefallene Java-API-Elemente
{: #java-api-elements-discontinued-in-v-80 }
#### Sicherheit
{: #security-java }

| API-Element                                | Ersetzungspfad                                 |
|-------------------------------------------|------------------------------------------------|
| `SecurityAPI.getSecurityContext`	        | Verwenden Sie stattdessen AdapterSecurityContext.             |

#### Push
{: #push-java }

| API-Element                                | Ersetzungspfad                                 |
|-------------------------------------------|------------------------------------------------|
| `PushAPI.sendMessage(INotification notification, String applicationId)`	| Informationen zur Migration Ihrer Push-Benachrichtigungen finden Sie unter "Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen".  |
| `INotification PushAPI.buildNotification();` | Informationen zur Migration Ihrer Push-Benachrichtigungen finden Sie unter "Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen".  |
| `UserSubscription PushAPI.getUserSubscription(String eventSource, String userId)` | Informationen zur Migration Ihrer Push-Benachrichtigungen finden Sie unter "Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen".  |

#### Adapter
{: #adapters-java }

| API-Element                                | Ersetzungspfad                                 |
|-------------------------------------------|------------------------------------------------|
| Schnittstelle `AdaptersAPI` aus dem Paket `com.worklight.adapters.rest.api` | Verwenden Sie stattdessen die Schnittstelle `AdaptersAPI` aus dem Paket `com.ibm.mfp.adapter.api`.  |
| Schnittstelle `AnalyticsAPI` aus dem Paket `com.worklight.adapters.rest.api` | Verwenden Sie stattdessen die Schnittstelle `AnalyticsAPI` aus dem Paket `com.ibm.mfp.adapter.api`.  |
| Schnittstelle `ConfigurationAPI` aus dem Paket `com.worklight.adapters.rest.api` | Verwenden Sie stattdessen die Schnittstelle `ConfigurationAPI` aus dem Paket `com.ibm.mfp.adapter.api`.  |
| Annotation `OAuthSecurity` aus dem Paket `com.worklight.core.auth` | Verwenden Sie stattdessen die Annotation `OAuthSecurity` aus dem Paket `com.ibm.mfp.adapter.api`.  |
| Klasse `MFPJAXRSApplication` aus dem Paket `com.worklight.wink.extensions` | Verwenden Sie stattdessen die Klasse `MFPJAXRSApplication` aus dem Paket `com.ibm.mfp.adapter.api`.  |
| Schnittstelle `WLServerAPI` aus dem Paket `com.worklight.adapters.rest.api` | Verwenden Sie für einen direkten Zugriff auf die {{ site.data.keys.product_adj }}-APIs die JAX-RS-Annotation `Context`.  |
| Klasse `WLServerAPIProvider` aus dem Paket `com.worklight.adapters.rest.api` | Verwenden Sie für einen direkten Zugriff auf die {{ site.data.keys.product_adj }}-APIs die JAX-RS-Annotation `Context`.  |

## Änderungen an der clientseitigen API
{: #client-side-api-changes }
Für die Migration Ihrer
{{ site.data.keys.product_adj }}-Clientanwendung sind die folgenden
API-Änderungen relevant.   
In den folgenden Tabellen sind die in
Version 8.0 weggefallenen und nicht weiter unterstützten
clientseitigen API-Elemente
mit Vorschlägen für den Migrationspfad aufgelistet. 

### JavaScript-APIs
{: #javascript-apis }
Die folgenden JavaScript-APIs mit Einfluss auf die Benutzerschnittstelle werden in Version 8.0 nicht mehr unterstützt. Sie können durch verfügbare Cordova-Plug-ins anderer
Anbieter ersetzt werden. Sie können aber auch angepasste Cordova-Plug-ins erstellen. 

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `WL.BusyIndicator`, `WL.OptionsMenu`, `WL.TabBar`, `WL.TabBarItem` | Verwenden Sie Cordova-Plug-ins oder HTML-5-Elemente.  |
| `WL.App.close` | Handhaben Sie dieses Ereignis außerhalb von {{ site.data.keys.product_adj }}. |
| `WL.App.copyToClipboard()` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen.  |
| `WL.App.openUrl(url, target, options)` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. **Hinweis:** Dieses Feature wird vom Cordova-Plug-in **InAppBrowser** bereitgestellt.  |
| `WL.App.overrideBackButton(callback)`, `WL.App.resetBackButton()` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. **Hinweis:** Dieses Feature wird vom Cordova-Plug-in **backbutton** bereitgestellt.  |
| `WL.App.getDeviceLanguage()` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. **Hinweis:** Dieses Feature wird vom Cordova-Plug-in **cordova-plugin-globalization** bereitgestellt.  |
| `WL.App.getDeviceLocale()` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. **Hinweis:** Dieses Feature wird vom Cordova-Plug-in **cordova-plugin-globalization** bereitgestellt.  |
| `WL.App.BackgroundHandler` | Verwenden Sie zum Ausführen einer angepassten Handlerfunktion den Cordova-Standardereignislistener "pause". Verwenden Sie ein Cordova-Plug-in, mit dem die Privatsphäre gewahrt werden kann und das iOS- und Android-Systeme oder -Benutzer daran hindert, Screenshots zu erstellen. Weitere Informationen enthält die Beschreibung zu **[PrivacyScreenPlugin](https://github.com/devgeeks/PrivacyScreenPlugin)**. |
| `WL.Client.close`, `WL.Client.restore`, `WL.Client.minimize` | Die Funktionen wurden zur Unterstützung der AIR-Plattform bereitgestellt, die von {{ site.data.keys.product }} Version 8.0 nicht unterstützt wird.  |
| `WL.Toast.show(string)` | Verwenden Sie Cordova-Plug-ins für Toast.  |

Die folgenden APIs werden in Version 8.0 nicht weiter unterstützt.

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `WL.Client.checkForDirectUpdate(options)` | Kein Ersatz. **Hinweis:** Sie können `WLAuthorizationManager.obtainAccessToken` aufrufen, um eine verfügbare direkte Aktualisierung auszulösen. Der Zugriff auf ein Sicherheitstoken löst die direkte Aktualisierung aus, sofern auf dem Server eine direkte Aktualisierung verfügbar ist. Eine bedarfsabhängige Auslösung der direkten Aktualisierung ist nicht möglich.  |
| `WL.Client.setSharedToken({key: myName, value: myValue})`, `WL.Client.getSharedToken({key: myName})`, `WL.Client.clearSharedToken({key: myName})` | Kein Ersatz.  |
| `WL.Client.isConnected()`, `connectOnStartup` init option | Verwenden Sie `WLAuthorizationManager.obtainAccessToken`, um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden.  |
| `WL.Client.setUserPref(key,value, options)`, `WL.Client.setUserPrefs(userPrefsHash, options)`, `WL.Client.deleteUserPrefs(key, options)` | Kein Ersatz. Sie können einen Adapter und die API `MFP.Server.getAuthenticatedUser` verwenden, um Benutzervorgaben zu verwalten.  |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Kein Ersatz.  |
| `WL.Client.logActivity(activityType)` | Verwenden Sie `WL.Logger`.  |
| `WL.Client.login(realm, options)` | Verwenden Sie `WLAuthorizationManager.login`. Eine Einführung in die Bereiche Authentifizierung und Sicherheit bieten die Lernprogramme "Authentifizierung" und "Sicherheit".  |
| `WL.Client.logout(realm, options)` | Verwenden Sie `WLAuthorizationManager.logout`.  |
| `WL.Client.obtainAccessToken(scope, onSuccess, onFailure)` | Verwenden Sie `WLAuthorizationManager.obtainAccessToken`.  |
| `WL.Client.transmitEvent(event, immediate)`, `WL.Client.purgeEventTransmissionBuffer()`, `WL.Client.setEventTransmissionPolicy(policy)` | Erstellen Sie einen angepassten Adapter für den Empfang von Benachrichtigungen über diese Ereignisse.  |
| `WL.Device.getContext()`, `WL.Device.startAcquisition(policy, triggers, onFailure)`, `WL.Device.stopAcquisition()`, `WL.Device.Wifi`, `WL.Device.Geo.Profiles`, `WL.Geo` | Verwenden Sie für die Geoortung die native API oder Cordova-Plug-ins von anderen Anbietern.  |
| `WL.Client.makeRequest (url, options)` | Erstellen Sie einen angepassten Adapter, der diese Funktionalität bereitstellt.  |
| `WLDevice.getID(options)` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. **Hinweis:** Dieses Feature wird vom Plug-in **cordova-plugin-device** mit `device.uuid` bereitgestellt.  |
| `WL.Device.getFriendlyName()` | Verwenden Sie `WL.Client.getDeviceDisplayName`.  |
| `WL.Device.setFriendlyName()` | Verwenden Sie `WL.Client.setDeviceDisplayName`.  |
| `WL.Device.getNetworkInfo(callback)` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. **Hinweis:** Dieses Feature wird vom Plug-in **cordova-plugin-network-information** bereitgestellt.  |
| `WLUtils.wlCheckReachability()` | Erstellen Sie einen angepassten Adapter für die Überprüfung der Serververfügbarkeit.  |
| `WL.EncryptedCache` | Verwenden Sie JSONStore zum lokalen Speichern verschlüsselter Daten. JSONStore ist im Plug-in **cordova-plugin-mfp-jsonstore** enthalten. Weitere Informationen finden Sie unter [JSONStore](../../../application-development/jsonstore). |
| `WL.SecurityUtils.remoteRandomString(bytes)` | Erstellen Sie einen angepassten Adapter, der diese Funktionalität bereitstellt.  |
| `WL.Client.getAppProperty(property)` | Sie können die Eigenschaft für die App-Version mit dem Plug-in **cordova-plugin-appversion** abrufen. Die zurückgegebene Version ist die Version der nativen App (nur Android und iOS). |
| `WL.Client.Push.*` | Verwenden Sie die clientseitige JavaScript-Push-API aus dem Plug-in **cordova-plugin-mfp-push**.  |
| `WL.Client.Push.subscribeSMS(alias, adapterName, eventSource, phoneNumber, options)` | Verwenden Sie `MFPPush.registerDevice(org.json.JSONObject options, MFPPushResponseListener listener)`, um das Gerät für Push und SMS zu registrieren.  |
| `WLAuthorizationManager.obtainAuthorizationHeader(scope)` | Verwenden Sie `WLAuthorizationManager.obtainAccessToken`, um ein Token für den erforderlichen Bereich anzufordern.  |
| `WLClient.getLastAccessToken(scope)` | Verwenden Sie `WLAuthorizationManager.obtainAccessToken`.  |
| `WLClient.getLoginName()`, `WL.Client.getUserName(realm)` | Kein Ersatz |
| `WL.Client.getRequiredAccessTokenScope(status, header)` | Verwenden Sie `WLAuthorizationManager.isAuthorizationRequired` und `WLAuthorizationManager.getResourceScope`. |
| `WL.Client.isUserAuthenticated(realm)` | Kein Ersatz |
| `WLUserAuth.deleteCertificate(provisioningEntity)` | Kein Ersatz |
| `WL.Trusteer.getRiskAssessment(onSuccess, onFailure)` | Kein Ersatz |
| `WL.Client.createChallengeHandler(realmName)` | Verwenden Sie `WL.Client.createGatewayChallengeHandler(gatewayName)`, um einen Abfrage-Handler für angepasste Gateway-Abfragen zu erstellen. Verwenden Sie `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`, um einen Abfrage-Handler für die Behandlung von Abfragen zu {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen zu erstellen. |
| `WL.Client.createWLChallengeHandler(realmName)` | Verwenden Sie `WL.Client.createSecurityCheckChallengeHandler(securityCheckName)`. |
| `challengeHandler.isCustomResponse()` - hier steht challengeHandler für ein Abfrage-Handler-Objekt, das von `WL.Client.createChallengeHandler()` zurückgegeben wird.  | Verwenden Sie `gatewayChallengeHandler.canHandleResponse()`, wobei `gatewayChallengeHandler` für ein Abfrage-Handler-Objekt steht, das von `WL.Client.createGatewayChallengeHandler()` zurückgegeben wird. |
| `wlChallengeHandler.processSucccess()` - hier steht `wlChallengeHandler` für ein Abfrage-Handler-Objekt, das von `WL.Client.createWLChallengeHandler()` zurückgegeben wird | Verwenden Sie `securityCheckChallengeHandler.handleSuccess()`, wobei `securityCheckChallengeHandler` für ein Abfrage-Handler-Objekt steht, das von `WL.Client.createSecurityCheckChallengeHandler()` zurückgegeben wird. |
| `WL.Client.AbstractChallengeHandler.submitAdapterAuthentication()` | Implementieren Sie ähnliche Logik in Ihrem Abfrage-Handler. Verwenden Sie für angepasste Gateway-Abfrage-Handler ein Abfrage-Handler-Objekt, das von `WL.Client.createGatewayChallengeHandler()` zurückgegeben wird. Verwenden Sie für Abfrage-Handler für {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen ein Abfrage-Handler-Objekt, das von `WL.Client.createSecurityCheckChallengeHandler()` zurückgegeben wird. |
| `WL.Client.createProvisioningChallengeHandler()` | Kein Ersatz. Die Bereitstellung für Geräte erfolgt jetzt automatisch über das Sicherheitsframework.  |

#### Nicht mehr verwendete JavaScript-APIs
{: #deprecated-javascript-apis }

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData,WLResponseListener responseListener)`, `WL.Client.invokeProcedure(invocationData, options)`, `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener, WLRequestOptions requestOptions)`, `WLProcedureInvocationResult` | Verwenden Sie stattdessen `WLResourceRequest`. **Hinweis:** Die `invokeProcedure`-Implementierung verwendet `WLResourceRequest`. |
| `WLClient.getEnvironment` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. **Hinweis:** Dieses Feature wird vom Plug-in **device.platform** bereitgestellt.  |
| `WLClient.getLanguage` | Verwenden Sie Cordova-Plug-ins, die diese Funktionalität bereitstellen. **Hinweis:** Dieses Feature wird vom Plug-in **cordova-plugin-globalization** bereitgestellt.  |
| `WL.Client.connect(options)` | Verwenden Sie `WLAuthorizationManager.obtainAccessToken`, um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden.  |

### Android-APIs
{: #android-apis}
####  Weggefallene Android-API-Elemente
{: #discontinued-android-api-elements }

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `WLConfig WLClient.getConfig()` | Kein Ersatz |
| `WLDevice WLClient.getWLDevice()`, `WLClient.transmitEvent(org.json.JSONObject event)`, `WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy)`, `WLClient.purgeEventTransmissionBuffer()` | Verwenden Sie für die Geoortung die Android-API oder Pakete von anderen Anbietern.  |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Kein Ersatz |
| `WL.Client.getUserInfo(realm, key`, `WL.Client.updateUserInfo(options)` | Kein Ersatz |
| `WLClient.checkForNotifications()` | Verwenden Sie `WLAuthorizationManager.obtainAccessToken("", listener)`, um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden.  |
| `WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.login(java.lang.String realmName, WLRequestListener listener)` | Verwenden Sie `AuthorizationManager.login()`. |
| `WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)`, `WLClient.logout(java.lang.String realmName, WLRequestListener listener)` | Verwenden Sie `AuthorizationManager.logout()`. |
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` | Verwenden Sie `WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)`, um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden.  |
| `WLClient.getLastAccessToken()`, `WLClient.getLastAccessToken(java.lang.String scope)` | Verwenden Sie `AuthorizationManager`.  |
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` | Verwenden Sie `AuthorizationManager`.  |
| `WLClient.logActivity(java.lang.String activityType)` | Verwenden Sie `com.worklight.common.Logger`. Weitere Informationen finden Sie unter "Logger-SDK".  |
| `WLAuthorizationPersistencePolicy` | Kein Ersatz. Für die Implementierung der Autorisierungspersistenz müssen Sie das Autorisierungstoken im Anwendungscode speichern und angepasste HTTP-Anforderungen erstellen.  |
| `WLSimpleSharedData.setSharedToken(myName, myValue)`, `WLSimpleSharedData.getSharedToken(myName)`, `WLSimpleSharedData.clearSharedToken(myName)` | Verwenden Sie für die anwendungsübergreifende Nutzung von Token die Android-APIs.  |
| `WLUserCertificateManager.deleteCertificate(android.content.Context context)` | Kein Ersatz |
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | Verwenden Sie `BaseChallengeHandler.cancel()`. |
| `ChallengeHandler` | Verwenden Sie für angepasste Gateway-Abfragen `GatewayChallengeHandler`. Verwenden Sie für Abfragen von {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler`.
 |
| `WLChallengeHandler` | Verwenden Sie `SecurityCheckChallengeHandler`.  |
| `ChallengeHandler.isCustomResponse()` | Verwenden Sie `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication ` | Implementieren Sie ähnliche Logik in Ihrem Abfrage-Handler. Verwenden Sie für angepasste Gateway-Abfrage-Handler `GatewayChallengeHandler`.
 |

#### Nicht mehr verwendete Android-APIs
{: #deprecated-android-apis }

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `WLClient.invokeProcedure(WLProcedureInvocationData invocationData, WLResponseListener responseListener)` | Nicht mehr verwendet. Verwenden Sie `WLResourceRequest`. **Hinweis:** Die `invokeProcedure`-Implementierung verwendet `WLResourceRequest`. |
| `WLClient.connect(WLResponseListener responseListener)`, `WLClient.connect(WLResponseListener responseListener,WLRequestOptions options)` | Verwenden Sie `WLAuthorizationManager.obtainAccessToken("", listener)`, um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden.  |

#### Von den traditionellen org.apach.http-APIs abhängige und nicht mehr unterstützte Android-APIs
{: #android-apis-depending-on-the-legacy-orgapachehttp-apis-are-no-longer-supported }

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `org.apache.http.Header[]` wird nicht mehr verwendet. Aus diesem Grund wurden die folgenden Methoden entfernt: ||
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | Verwenden Sie stattdessen die neue API `Map<String, List<String>> WLResourceRequest.getAllHeaders()` API. |
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | Verwenden Sie stattdessen die neue API `WLResourceRequest.addHeader(String name, String value)`.  |
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` | Verwenden Sie stattdessen die neue API `List<String> WLResourceRequest.getHeaders(String headerName)`.  |
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` | Verwenden Sie stattdessen die neue API `WLResourceRequest.getHeaders(String headerName)`.  |
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | Verwenden Sie stattdessen die neue API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)`.  |
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | Verwenden Sie stattdessen die neue API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)`.  |
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | Durch `java.net.CookieStore getCookieStore WLClient.getCookieStore()` ersetzt.  |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | Kein Ersatz. Der MFP-Client lässt kreisförmige Umleitungen zu.  |
| `WLHttpResponseListener`, `WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)`, `WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)`, `WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)`, `WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)`, `WLResourceRequest.send(WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)`, `WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)` | Wegen nicht weiter unterstützter Apache-HTTP-Clientabhängigkeiten entfernt. Erstellen Sie Ihre eigene Anforderung, um volle Kontrolle über Anforderung und Antwort zu haben.  |

#### Das Paket `com.worklight.androidgap.api` stellt die Android-Plattformfunktionen für Cordova-Apps bereit. In {{ site.data.keys.product }} wurden einige Änderungen vorgenommen, um die Cordova-Integration zu ermöglichen. 
{: #comworklightandroidgapapi }

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| Die Android-Aktivität wurde durch den Android-Kontext ersetzt.  | |
| `static WL.createInstance(android.app.Activity activity)` | `static WL.createInstance(android.content.Context context)` erstellt eine gemeinsame Instanz.  |
| `static WL.getInstance()` |  `static WL.getInstance()` ruft eine Instanz der WL-Klasse ab. Diese Methode kann nicht vor `WL.createInstance(Context)` aufgerufen werden. |

### Objective-C-APIs
{: #objective-c-apis }
#### Weggefallene iOS-Objective-C-APIs
{: #discontinued-ios-objective-c-apis }

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `[WLClient getWLDevice][WLClient transmitEvent:]`, `[WLClient setEventTransmissionPolicy]`, `[WLClient purgeEventTransmissionBuffer]` | Die Geoortung wurde entfernt. Verwenden Sie für die Geoortung native iOS-Optionen oder Pakete von anderen Anbietern.  |
| `WL.Client.getUserInfo(realm, key)`, `WL.Client.updateUserInfo(options)` | Kein Ersatz |
| `WL.Client.deleteUserPref(key, options)` | Kein Ersatz. Sie können einen Adapter und die API `MFP.Server.getAuthenticatedUser` verwenden, um Benutzervorgaben zu verwalten.  |
| `[WLClient getRequiredAccessTokenScopeFromStatus]` | Verwenden Sie `WLAuthorizationManager obtainAccessTokenForScope`.  |
| `[WLClient login:withDelegate:]` | Verwenden Sie `WLAuthorizationManager login`.  |
| `[WLClient logout:withDelegate:]` | Verwenden Sie `WLAuthorizationManager logout`.  |
| `[WLClient lastAccessToken]`, `[WLClient lastAccessTokenForScope:]` | Verwenden Sie `WLAuthorizationManager obtainAccessTokenForScope`.  |
| `[WLClient obtainAccessTokenForScope:withDelegate:]`, `[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]` | Verwenden Sie `WLAuthorizationManager obtainAccessTokenForScope`.  |
| `[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` | Verwenden Sie die clientseitige Objective-C-Push-API für iOS-Apps aus dem Framework IBMMobileFirstPlatformFoundationPush.  |
| `[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` | Verwenden Sie die clientseitige Objective-C-Push-API für iOS-Apps aus dem Framework IBMMobileFirstPlatformFoundationPush.  |
| `[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` | Nicht mehr verwendet. Verwenden Sie stattdessen `WLResourceRequest`.  |
| `WLClient sendUrlRequest:delegate:]` | Verwenden Sie stattdessen `[WLResourceRequest sendWithDelegate:delegate]`.  |
| `[WLClient (void) logActivity:(NSString *) activityType]` | Gelöscht. Verwenden Sie einen Objective-C-Logger. |
| `[WLSimpleDataSharing setSharedToken: myName value: myValue]`, `[WLSimpleDataSharing getSharedToken: myName]]`, `[WLSimpleDataSharing clearSharedToken: myName]` | Verwenden Sie für die anwendungsübergreifende Nutzung von Token die Betriebssystem-APIs.  |
| `BaseChallengeHandler.submitFailure(WLResponse *)challenge` | Verwenden Sie `BaseChallengeHandler.cancel()`. |
| `BaseProvisioningChallengeHandler` | Kein Ersatz. Die Bereitstellung für Geräte erfolgt jetzt automatisch über das Sicherheitsframework.  |
| `ChallengeHandler` | Verwenden Sie für angepasste Gateway-Abfragen `GatewayChallengeHandler`. Verwenden Sie für Abfragen von {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler`.  |
| `WLChallengeHandler` | Verwenden Sie `SecurityCheckChallengeHandler`.  |
| `ChallengeHandler.isCustomResponse()` | Verwenden Sie `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication ` | Implementieren Sie ähnliche Logik in Ihrem Abfrage-Handler. Verwenden Sie für angepasste Gateway-Abfrage-Handler `GatewayChallengeHandler`. Verwenden Sie für Abfrage-Handler für {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler`.  |

### Windows-C#-APIs
{: #windows-c-apis }
#### Nicht weiter verwendete Windows-C#-API-Elemente - Klassen
{: #deprecated-windows-c-api-elements-classes }

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `ChallengeHandler` | Verwenden Sie für angepasste Gateway-Abfragen `GatewayChallengeHandler`. Verwenden Sie für Abfragen von {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler`.  |
| `ChallengeHandler. isCustomResponse()` | Verwenden Sie `GatewayChallengeHandler.canHandleResponse()`. |
| `ChallengeHandler.submitAdapterAuthentication ` | Implementieren Sie ähnliche Logik in Ihrem Abfrage-Handler. Verwenden Sie für angepasste Gateway-Abfrage-Handler `GatewayChallengeHandler`. Verwenden Sie für Abfrage-Handler für {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler`.  |
| `ChallengeHandler.submitFailure(WLResponse wlResponse)` | Verwenden Sie für angepasste Gateway-Abfrage-Handler `GatewayChallengeHandler.Shouldcancel()`. Verwenden Sie für Abfrage-Handler für {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen `SecurityCheckChallengeHandler.ShouldCancel()`.  |
| `WLAuthorizationManager` | Verwenden Sie stattdessen `WorklightClient.WorklightAuthorizationManager`.  |
| `WLChallengeHandler` | Verwenden Sie `SecurityCheckChallengeHandler`.  |
| `WLChallengeHandler.submitFailure(WLResponse wlResponse)` | Verwenden Sie `SecurityCheckChallengeHandler.ShouldCancel()`. |
| `WLClient` | Verwenden Sie stattdessen `WorklightClient`.  |
| `WLErrorCode` | Nicht unterstützt |
| `WLFailResponse ` | Verwenden Sie stattdessen `WorklightResponse`.  |
| `WLResponse` | Verwenden Sie stattdessen `WorklightResponse`.  |
| `WLProcedureInvocationData` | Verwenden Sie stattdessen `WorklightProcedureInvocationData`.  |
| `WLProcedureInvocationFailResponse` | Nicht unterstützt |
| `WLProcedureInvocationResult` | Nicht unterstützt |
| `WLRequestOptions` | Nicht unterstützt |
| `WLResourceRequest` | Nicht unterstützt |

#### Nicht weiter verwendete Windows-C#-API-Elemente - Schnittstellen
{: #deprecated-windows-c-api-elements-interfaces }

| API-Element           | Migrationspfad                           |
|-----------------------|------------------------------------------|
| `WLHttpResponseListener` | Nicht unterstützt |
| `WLResponseListener` | Die Antwort ist als ein `WorklightResponse`-Objekt verfügbar.  |
| `WLAuthorizationPersistencePolicy` | Nicht unterstützt |
