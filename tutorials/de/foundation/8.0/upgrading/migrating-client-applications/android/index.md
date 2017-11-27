---
layout: tutorial
title: Vorhandene Android-Anwendungen umstellen
breadcrumb_title: Android
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn Sie ein mit der
IBM MobileFirst Platform Foundation ab Version 6.2.0
erstelltes natives Android-Projekt migrieren möchten, müssen Sie das Projekt so modifizieren, dass es das SDK der aktuellen Version verwendet. Ersetzen Sie
dann die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0 enthalten sind. Das Unterstützungstool für die
Migration kann Ihren Code scannen und Berichte zu den zu ersetzenden APIs generieren. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Vorhandene
native {{ site.data.keys.product_adj }}-Android-Apps in Vorbereitung eines Versionsupgrades scannen](#scanning-existing-mobilefirst-native-android-apps-to-prepare-for-a-version-upgrade)
* [Android-Projekt mit Gradle umstellen](#migrating-an-android-project-with-gradle)
* [Android-Code aktualisieren](#updating-the-android-code)

## Vorhandene native {{ site.data.keys.product_adj }}-Android-Apps in Vorbereitung eines Versionsupgrades scannen
{: #scanning-existing-mobilefirst-native-android-apps-to-prepare-for-a-version-upgrade }
Das Unterstützungstool für die Migration hilft Ihnen, Ihre
mit einer früheren Version
der {{ site.data.keys.product_full }}
erstellten Apps vorzubereiten, indem es die Quellen der nativen Android-App scannt und einen Bericht der in Version
8.0 weggefallenen oder nicht weiter unterstützten APIs generiert. 

Die folgenden Informationen müssen vor Verwendung des Unterstützungstools für die Migration beachtet werden: 

* Sie benötigen eine native, mit der
{{ site.data.keys.product }} erstellte Android-Anwendung. 
* Sie benötigen Internetzugriff. 
* Node.js ab Version 4.0.0 muss installiert sein. 
* Sie müssen die Einschränkungen des Migrationsprozesses kennen und verstehen. Weitere Informationen
finden Sie unter
[Apps früherer Releases umstellen](../).

Mit früheren Versionen der {{ site.data.keys.product }}
erstellte Apps müssen geändert werden, damit sie in Version 8.0 unterstützt werden. Das Unterstützungstool für die Migration vereinfacht diesen Änderungsprozess, indem es die Quellendateien der vorhandenen
App scannt und APIs identifiziert, die in Version 8.0 weggefallen sind oder nicht weiter unterstützt werden bzw. modifiziert wurden. 

Das Unterstützungstool für die Migration modifiziert oder verschiebt keinen Entwicklercode und keine Kommentare Ihrer App. 

1. Wählen Sie eine der folgenden Alternativen, um das Unterstützungstool für die Migration herunterzuladen: 
    * Laden Sie die .tgz-Datei aus dem [Git-Repository](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli) herunter.
    * Laden Sie das {{ site.data.keys.mf_dev_kit }} über die {{ site.data.keys.mf_console }} herunter. Das Kit enthält die Datei mfpmigrate-cli.tgz
mit dem Unterstützungstool für die Migration. 
2. Installieren Sie das Unterstützungstool für die Migration. 
    * Navigieren Sie zu dem Verzeichnis, in das Sie das Tool heruntergeladen haben. 
    * Installieren Sie das Tool mit npm. Geben Sie dazu den folgenden Befehl ein: 

   ```bash
   npm install -g
   ```

3. Scannen Sie die mit der {{ site.data.keys.product }} erstellte App. Geben Sie dazu
den folgenden Befehl ein: 

   ```bash
   mfpmigrate scan --in Quellenverzeichnis --out Zielverzeichnis --type android
   ```

   **Quellenverzeichnis**  
Aktuelle Position des Projekts

   **Zielverzeichnis**  
Verzeichnis, in dem der Bericht erstellt wird

   Wenn der Scanbefehl des Unterstützungstools für die Migration verwendet wird, identifiziert das Tool APIs in der vorhandenen, mit der
{{ site.data.keys.product }} erstellten App, die in Version 8.0 gelöscht oder geändert wurden oder nicht weiter unterstützt werden und speichert sie im angegebenen Zielverzeichnis. 

## Android-Projekt mit Gradle umstellen
{: #migrating-an-android-project-with-gradle }
Sie können Gradle verwenden, um Ihre Android-Anwendung mit dem
{{ site.data.keys.product_adj }}-SDK zu migrieren. 

Stellen Sie sicher, dass Sie Android Studio und das Android-SDK ordnungsgemäß eingerichtet haben. Weitere Informationen
zur Einrichtung Ihres Systems finden Sie unter [Android Studio
Overview](http://developer.android.com/tools/studio/index.html). Ihr Projekt muss mit dem Setup von
Android Studio/Gradle konform gehen und fehlerfrei kompatibel sein, bevor Sie ein Upgrade auf die
{{ site.data.keys.product }} durchführen.

> **Hinweis:** Bei diesem Schritt wird davon ausgegangen, dass das Android-Projekt mit
Android Studio erstellt wurde und das
{{ site.data.keys.product_adj }}-SDK hinzugefügt wurde (siehe
[SDK der {{ site.data.keys.product }}
in Android Studio (7.1) zu einer neuen oder vorhandenen Anwendung hinzufügen](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.dev.doc/dev/t_dev_new_w_gradle.html)).



Wenn Ihr Android-Studio-Projekt für das Hinzufügen einer früheren Version des
{{ site.data.keys.product_adj }}-SDK konfiguriert war, entfernen Sie
**compile group** aus den
Abhängigkeiten ("dependencies") in **build.gradle**. Wenn Sie beispielsweise ein Upgrade für Version 7.1 durchführen, entfernen Sie die folgende Gruppe: 

```xml
compile group: 'com.ibm.mobile.foundation',
            name:'ibmmobilefirstplatformfoundation',
            version:'7.1.0.0',
            ext: 'aar',
            transitive: true
```

Jetzt können Sie mit lokalen oder fernen SDK-Dateien das SDK und die Konfiguration von Version 8.0.0 hinzufügen
(siehe [{{ site.data.keys.product_adj }}-SDK zu Android-Anwendungen hinzufügen](../../../application-development/sdk/android)). 

> Hinweis: Nach dem Import des neuen SDK müssen Sie die Javadoc-Dateien manuell importieren
(siehe
[Javadocs in einem Android-Studio-Gradle-Projekt
registrieren](../../../application-development/sdk/android/additional-information).

Jetzt können Sie mit dem Entwickeln Ihrer nativen
Android-Anwendung mit dem SDK der {{ site.data.keys.product_adj }}
beginnen. Möglicherweise müssen Sie Ihren Code an die Änderungen
der API von Version 8.0.0 anpassen (siehe [Android-Code aktualisieren](#updating-the-android-code)). 

#### Nächste Schritte
{: #what-to-do-next }
Ersetzen Sie die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0 enthalten sind. 

## Android-Code aktualisieren
{: #updating-the-android-code }
In
{{ site.data.keys.product_full }} Version 8.0
gibt es eine Reihe von Änderungen am Android-SDK, durch die Änderungen an Apps erforderlich sein können, die mit früheren Versionen entwickelt wurden.   
In den folgenden Tabellen sind die Änderungen
am {{ site.data.keys.product_adj }}-Android-SDK aufgelistet. 

#### Weggefallene Android-API-Elemente
{: #discontinued-android-api-elements }

| API-Element | Migrationspfad |
|-------------|----------------|
| `WLConfig WLClient.getConfig()` | Kein Ersatz |
| {::nomarkdown}<ul><li><code>WLDevice WLClient.getWLDevice()</code></li><li><code>WLClient.transmitEvent(org.json.JSONObject event) </code></li><li><code>WLClient.setEventTransmissionPolicy(WLEventTransmissionPolicy policy) </code></li><li><code>WLClient.purgeEventTransmissionBuffer() </code></li></ul>{:/} | Verwenden Sie für die Geoortung die Android-API oder Pakete von anderen Anbietern. |
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | Kein Ersatz|
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} | Kein Ersatz|
| `WLClient.checkForNotifications()` | Verwenden Sie [`WLAuthorizationManager.obtainAccessToken("", listener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener), um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden.|
| {::nomarkdown}<ul><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)</code></li><li><code>WLClient.login(java.lang.String realmName, WLRequestListener listener)</code></li></ul>{:/} | Verwenden Sie [`AuthorizationManager.login()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#login(java.lang.String,%20org.json.JSONObject,%20com.worklight.wlclient.api.WLLoginResponseListener).|
| {::nomarkdown}<ul><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener, WLRequestOptions options)</code></li><li><code>WLClient.logout(java.lang.String realmName, WLRequestListener listener)</code></li></ul>{:/} | Verwenden Sie [`AuthorizationManager.logout()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#logout(java.lang.String,%20com.worklight.wlclient.api.WLLogoutResponseListener).|
| `WLClient.obtainAccessToken(java.lang.String scope,WLResponseListener responseListener)` | Verwenden Sie [`WLAuthorizationManager.obtainAccessToken(String, WLAccessTokenListener)`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc#obtainAccessToken(java.lang.String,%20com.worklight.wlclient.api.WLAccessTokenListener), um die Verbindungsmöglichkeiten zum Server zu überprüfen und Anwendungsmanagementregeln anzuwenden.|
| {::nomarkdown}<ul><li><code>WLClient.getLastAccessToken()</code></li><li><code>WLClient.getLastAccessToken(java.lang.String scope)</code></li></ul>{:/} | Verwenden Sie [`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc).|
| `WLClient.getRequiredAccessTokenScope(int status, java.lang.String header)` | Verwenden Sie [`AuthorizationManager`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/WLAuthorizationManager.html?view=kc).|
| `WLClient.logActivity(java.lang.String activityType)` | Verwenden Sie [`com.worklight.common.Logger`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/common/Logger.html?view=kc). |
| `WLAuthorizationPersistencePolicy` | Kein Ersatz. Für die Implementierung der Autorisierungspersistenz müssen Sie das Autorisierungstoken im Anwendungscode speichern und angepasste HTTP-Anforderungen erstellen. Weitere Informationen finden Sie im Implementierungsbeispiel für angepasste Java-Ressourcenanforderungen ([Java™ custom resource-request implementation sample](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.dev.doc/dev/c_custom_request_to_resource_java.html?view=kc#c_custom_request_to_resource_hybrid)).|
| {::nomarkdown}<ul><li><code>WLSimpleSharedData.setSharedToken(myName, myValue)</code></li><li><code>WLSimpleSharedData.getSharedToken(myName)</code></li><li><code>WLSimpleSharedData.clearSharedToken(myName)</code></li></ul>{:/} | Verwenden Sie für die anwendungsübergreifende Nutzung von Token die Android-APIs.|
| `WLUserCertificateManager.deleteCertificate(android.content.Context context)` | Kein Ersatz|
| `BaseChallengeHandler.submitFailure(WLResponse wlResponse)` | Verwenden Sie [`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/BaseChallengeHandler.html?view=kc).|
| `ChallengeHandler` | Verwenden Sie für angepasste Gateway-Abfragen [GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc). Verwenden Sie für Abfragen von {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen [SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc).|
| `WLChallengeHandler` | Verwenden Sie [SecurityCheckChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/SecurityCheckChallengeHandler.html?view=kc). |
| `ChallengeHandler.isCustomResponse()` | Verwenden Sie [`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc).|
| `ChallengeHandler.submitAdapterAuthentication` | Implementieren Sie ähnliche Logik in Ihrem Abfrage-Handler. Verwenden Sie für angepasste Gateway-Abfrage-Handler [GatewayChallengeHandler](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjava-worklight-android-native/html/com/worklight/wlclient/api/challengehandler/GatewayChallengeHandler.html?view=kc). |

#### Von den traditionellen `org.apach.http`-APIs abhängige und nicht mehr unterstützte Android-APIs
{: #android-apis-depending-on-the-legacy-orgapachhttp-apis-are-no-longer-supported }

| API-Element | Migrationspfad |
|-------------|----------------|
| `org.apache.http.Header[]` wird nicht mehr verwendet. Aus diesem Grund wurden die folgenden Methoden entfernt: | |
| `org.apache.http.Header[] WLResourceRequest.getAllHeaders()` | Verwenden Sie stattdessen die neue API `Map<String, List<String>> WLResourceRequest.getAllHeaders()`. |
| `WLResourceRequest.addHeader(org.apache.http.Header header)` | Verwenden Sie stattdessen die neue API `WLResourceRequest.addHeader(String name, String value)`. |
| `org.apache.http.Header[] WLResourceRequest.getHeaders(java.lang.String headerName)` | Verwenden Sie stattdessen die neue API `List<String> WLResourceRequest.getHeaders(String headerName)`. |
| `org.apache.http.Header WLResourceRequest.getFirstHeader(java.lang.String headerName)` | Verwenden Sie stattdessen die neue API `WLResourceRequest.getHeaders(String headerName)`. |
| `WLResourceRequest.setHeaders(org.apache.http.Header[] headers)` | Verwenden Sie stattdessen die neue API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)`. |
| `WLResourceRequest.setHeader(org.apache.http.Header header)` | Verwenden Sie stattdessen die neue API `WLResourceRequest.setHeaders(Map<String, List<String>> headerMap)`. |
| `org.apache.http.client.CookieStore WLClient.getCookieStore()` | Durch `java.net.CookieStore getCookieStore WLClient.getCookieStore()` ersetzt. <br/><br/> `java.net.CookieStore getCookieStore WLClient.getCookieStore()` |
| `WLClient.setAllowHTTPClientCircularRedirect(boolean isSet)` | Kein Ersatz. Der MFP-Client lässt kreisförmige Umleitungen zu. |
| {::nomarkdown}<ul><li><code>WLHttpResponseListener</code></li><li><code>WLResourceRequest</code> und alle Methoden, die <code>WLHttpResponseListener</code> verwenden:<ul><li><code>WLResourceRequest.send(java.util.HashMap formParameters,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(org.json.JSONObject json, WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(byte[] data, WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(java.lang.String requestBody,WLHttpResponseListener listener)</code></li><li><code>WLResourceRequest.send(WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request,WLHttpResponseListener listener)</code></li><li><code>WLClient.sendRequest(org.apache.http.client.methods.HttpUriRequest request, WLResponseListener listener)</code></li></ul></li></ul>{:/} | Wegen nicht weiter unterstützter Apache-HTTP-Clientabhängigkeiten entfernt. Erstellen Sie Ihre eigene Anforderung, um volle Kontrolle über Anforderung und Antwort zu haben.|
