---
layout: tutorial
title: Vorhandene iOS-Anwendungen umstellen
breadcrumb_title: iOS
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn Sie ein mit der
IBM MobileFirst Platform Foundation ab Version 6.2.0
erstelltes natives iOS-Projekt migrieren möchten, müssen Sie das Projekt so modifizieren, dass es das SDK der aktuellen Version verwendet. Ersetzen Sie
dann die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0 enthalten sind. Das Unterstützungstool für die
Migration kann Ihren Code scannen und Berichte zu den zu ersetzenden APIs generieren. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Vorhandene
native {{ site.data.keys.product_adj }}-iOS-Apps in Vorbereitung eines Versionsupgrades scannen](#scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-a-version-upgrade)
* [Vorhandenes iOS-Projekt manuell
umstellen](#migrating-an-existing-ios-project-manually)
* [Vorhandenes natives iOS-Projekt mit CocoaPods umstellen](#migrating-an-existing-native-ios-project-with-cocoapods)
* [Verschlüsselung in iOS umstellen](#migrating-encryption-in-ios)
* [iOS-Code aktualisieren](#updating-the-ios-code)

## Vorhandene native {{ site.data.keys.product_adj }}-iOS-Apps in Vorbereitung eines Versionsupgrades scannen
{: #scanning-existing-mobilefirst-native-ios-apps-to-prepare-for-a-version-upgrade }
Das Unterstützungstool für die Migration hilft Ihnen, Ihre
mit früheren Versionen der
IBM MobileFirst™ Platform Foundation
erstellten Apps vorzubereiten, indem es die Quellen der nativen iOS-Apps scannt und einen Bericht der in Version
8.0 weggefallenen oder nicht weiter unterstützten APIs generiert. 

Die folgenden Informationen müssen vor Verwendung des Unterstützungstools für die Migration beachtet werden: 

* Sie benötigen eine mit der
IBM MobileFirst Platform Foundation erstellte, native iOS-Anwendung. 
* Sie benötigen Internetzugriff. 
* Node.js ab Version 4.0.0 muss installiert sein. 
* Sie müssen die Einschränkungen des Migrationsprozesses kennen und verstehen. Weitere Informationen
finden Sie unter
[Apps früherer Releases umstellen](../).

Mit früheren Versionen der IBM MobileFirst Platform Foundation
erstellte Apps müssen geändert werden, damit sie in {{ site.data.keys.product }} 8.0 unterstützt werden. Das Unterstützungstool für die Migration vereinfacht diesen Änderungsprozess, indem es die Quellendateien der
App der vorhandenen Version scannt und APIs identifiziert, die in Version 8.0 weggefallen sind oder nicht weiter unterstützt werden bzw. modifiziert wurden. 

Das Unterstützungstool für die Migration modifiziert oder verschiebt keinen Entwicklercode und keine Kommentare Ihrer App. 

1. Wählen Sie eine der folgenden Alternativen, um das Unterstützungstool für die Migration herunterzuladen: 
    * Laden Sie die .tgz-Datei aus dem [Git-Repository](https://git.ng.bluemix.net/ibmmfpf/mfpmigrate-cli) herunter.
    * Laden Sie das {{ site.data.keys.mf_dev_kit }} über die {{ site.data.keys.mf_console }} herunter. Das Kit enthält die Datei **mfpmigrate-cli.tgz** mit dem Unterstützungstool für die Migration. 
2. Installieren Sie das Unterstützungstool für die Migration. 
    * Navigieren Sie zu dem Verzeichnis, in das Sie das Tool heruntergeladen haben. 
    * Installieren Sie das Tool mit npm. Geben Sie dazu den folgenden Befehl ein: 

   ```bash
   npm install -g
   ```

3. Scannen Sie die mit der IBM MobileFirst Platform Foundation erstellte App. Geben Sie dazu
den folgenden Befehl ein: 

   ```bash
   mfpmigrate scan --in Quellenverzeichnis --out Zielverzeichnis --type ios
   ```

    **Quellenverzeichnis**  
Aktuelle Position der Projektversion

    **Zielverzeichnis**  
Verzeichnis, in dem der Bericht erstellt wird  
    <br/>
Wenn der Scanbefehl des Unterstützungstools für die Migration verwendet wird, identifiziert das Tool APIs in der vorhandenen, mit der
IBM MobileFirst Platform Foundation erstellten App,
die in Version 8.0 gelöscht oder geändert wurden oder nicht weiter unterstützt werden und speichert sie im angegebenen Zielverzeichnis. 

## Vorhandenes iOS-Projekt manuell
umstellen
{: #migrating-an-existing-ios-project-manually }
Stellen Sie Ihr vorhandenes natives iOS-Projekt innerhalb Ihres Xcode-Projekts um und setzen Sie die Entwicklung in
{{ site.data.keys.product }} Version 8.0 fort. 

Voraussetzungen: 

* Sie müssen in Xcode 7.0 (iOS 9) oder einer aktuelleren Version arbeiten. 
* Sie benötigen ein mit
IBM MobileFirst Platform Foundation Version 6.2.0 oder einer aktuelleren Version
erstelltes natives iOS-Projekt. 
* Sie müssen auf eine Kopie der {{ site.data.keys.product_adj }}-iOS-SDK-Dateien von Version 8.0.0 zugreifen können. 

1. Löschen Sie im Abschnitt
**Link Binary With
Libraries** der Registerkarte **Build Phases** alle vorhandenen Verweise auf die statische Bibliothek **libWorklightStaticLibProjectNative.a**. 
2. Löschen Sie den Ordner Headers aus dem Ordner **WorklightAPI**. 
3. Auf der Registerkarte **Build Phases** müssen Sie im Abschnitt
**Link Binary
With Libraries** die erforderliche Hauptframeworkdatei **IBMMobileFirstPlatformFoundation.framework** verbinden. 

    Dieses Framework stellt
zentrale MobileFirst-Funktionen bereit. Analog dazu können Sie [weitere, für optionale Funktionen benötigte Frameworks](../../../application-development/sdk/ios/#manually-adding-the-mobilefirst-native-sdk) hinzufügen.
Frameworks für iOS).

4. Ähnlich wie im vorherigen Schritt müssen Sie im Abschnitt **Link Binary With Libraries** der Registerkarte **Build Phases** die folgenden Ressourcen mit Ihrem Projekt verbunden werden.
    * SystemConfiguration.framework
    * MobileCoreServices.framework
    * Security.framework
    * Hinweis: Möglicherweise sind einige Frameworks bereits verlinkt. 
        * libstdc++.6.tbd
        * libz.tbd
        * libc++.tbd
5. Entfernen Sie **$(SRCROOT)/WorklightAPI/include** aus dem Headersuchpfad.
6. Ersetzen Sie alle vorhandenen {{ site.data.keys.product_adj }}-Importe in Headern durch nur einen Eintrag im folgenden neuen Umbrella-Header:
    * Objective-C:

      ```objc
      #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
      ```
    * Swift:

      ```swift
      import IBMMobileFirstPlatformFoundation
      ```

Ihre Anwendung ist jetzt aktualisiert und kann mit dem iOS-SDK von {{ site.data.keys.product }} Version 8.0 verwendet werden. 

#### Nächste Schritte
{: #what-to-do-next }
Ersetzen Sie die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0 enthalten sind. 

## Vorhandenes natives iOS-Projekt mit CocoaPods umstellen
{: #migrating-an-existing-native-ios-project-with-cocoapods }
Sie können für Ihr vorhandenes natives iOS-Projekt
mit dem iOS-SDK der {{ site.data.keys.product }} auf
Version 8.0 umstellen.
Verwenden Sie
CocoaPods, um
die erforderlichen Änderungen an der Projektkonfiguration vorzunehmen. 

> **Hinweis:** Die {{ site.data.keys.product_adj }}-Entwicklung
wird in Xcode ab Version 7.1 für iOS ab Version 8.0 unterstützt. 

Folgende Voraussetzungen müssen erfüllt sein: 

* In Ihrer Entwicklungsumgebung muss CocoaPods installiert sein. 
* Xcode 7.1 mit iOS ab Version 8.0 muss für Ihre Entwicklungsumgebung verfügbar sein. 
* Sie benötigen eine in MobileFirst ab Version
6.2 integrierte
App. 

Das SDK enthält erforderliche und optionale SDKs. Für jedes erforderliche oder optionale SDK gibt es einen eigenen Pod.   
Der erforderliche Pod
IBMMobileFirstPlatformFoundation ist der Kern des Systems. Er implementiert Client-Server-Verbindungen und ist für Sicherheit, Analysen und das Anwendungsmanagement zuständig. 

Die folgenden
optionalen Pods stellen zusätzliche Features bereit. 

|Pod|Feature|
|-----|---------|
|IBMMobileFirstPlatformFoundationPush|Fügt das Framework IBMMobileFirstPlatformFoundationPush zur Aktivierung von Push hinzu. |
|IBMMobileFirstPlatformFoundationJSONStore|Implementiert das JSONStore-Feature. Nehmen Sie diesen Pod in Ihre Podfile auf, wenn Sie das JSONStore-Feature in Ihrer App verwenden möchten.|
|IBMMobileFirstPlatformFoundationOpenSSLUtils|Enthält das in {{ site.data.keys.product_adj }} eingebettete OpenSSL-Feature und lädt automatisch das Framework openssl. Nehmen Sie diesen Pod in Ihre Podfile auf, wenn Sie MobileFirst-OpenSSL verwenden möchten.|

1. Öffnen Sie Ihr Projekt in Xcode.
2. Löschen Sie den Ordner **WorklightAPI**. (Verschieben Sie es ihn den Papierkorb.) 
3. Modifizieren Sie Ihren vorhandenen Code wie folgt: 
    * Entfernen Sie **$(SRCROOT)/WorklightAPI/include** aus dem Headersuchpfad.
    * Entfernen Sie **$(PROJECTDIR)/WorklightAPI/frameworks** aus dem
Frameworksuchpfad. 
    * Entfernen Sie alle Verweise auf die statische Bibliothek **libWorklightStaticLibProjectNative.a**. 
4. Entfernen Sie auf der Registerkarte **Build Phases** alle Verbindungen zu den folgenden
Frameworks und Bibliotheken (die von
CocoaPods automatisch wieder hinzugefügt werden):
    * libWorklightStaticLibProjectNative.a
    * SystemConfiguration.framework
    * MobileCoreServices.framework
    * CoreData.framework
    * CoreLocation.framework
    * Security.framework
    * sqlcipher.framework
    * libstdc++.6.dylib
    * libz.dylib
5. Schließen Sie Xcode.
6. Rufen Sie mit CocoaPods das
{{ site.data.keys.product_adj }}-iOS-SDK
ab. Führen Sie die folgenden Schritte aus, um das SDK abzurufen: 
    * Öffnen Sie von der Position Ihres neuen Xcode-Projekts aus ein **Terminal**. 
    * Führen Sie den Befehl `pod init` aus, um eine
**Podfile** zu erstellen. 
    * Öffnen Sie in einem Texteditor die Podfile, die sich im Stammverzeichnis
des Projekts befindet. 
    * Setzen Sie den vorhandenen Inhalt auf Kommentar oder entfernen Sie ihn. 
    * Fügen Sie die folgenden Zeilen hinzu und speichern Sie die Änderungen, einschließlich der iOS-Version:

      ```xml
      use_frameworks!
      platform :ios, 9.0
      pod 'IBMMobileFirstPlatformFoundation'
      ```

    * Geben Sie weitere Pods aus der obigen Liste in der Datei an, wenn Ihre App die Funktionalität dieser Pods benötigt. Wenn Ihre App beispielsweise OpenSSL verwendet, könnte die **Podfile** etwa wie folgt aussehen:

      ```xml
      use_frameworks!
      platform :ios, 9.0
      pod 'IBMMobileFirstPlatformFoundation'
      pod 'IBMMobileFirstPlatformFoundationOpenSSLUtils'
      ```

      > **Hinweis:** Mit der oben dargestellten Syntax wird die neueste Version des Pods **IBMMobileFirstPlatformFoundation** importiert. Wenn Sie nicht die neueste Version von {{ site.data.keys.product_adj }} verwenden, müssen Sie die vollständige Versionsnummer (einschließlich der übergenordneten Version, der untergeordneten Version und des Patches) angeben. Die Patch-Nummer hat das Format AAAAMMDDHH. Für den Import der Patch-Version 8.0.2016021411 des Pods **IBMMobileFirstPlatformFoundation** würde die Zeile wie folgt aussehen:

      ```xml
      pod 'IBMMobileFirstPlatformFoundation', '8.0.2016021411'
      ```

      Zum Abrufen des neuesten Patch für die untergeordnete Versionsnummer lautet die Syntax wie folgt:

      ```xml
      pod 'IBMMobileFirstPlatformFoundation', '~>8.0.0'
      ```

    * Vergewissern Sie sich, dass das Xcode-Projekt geschlossen ist. 
    * Führen Sie den Befehl `pod install` aus. 

Dieser Befehl installiert
das **IBMMobileFirstPlatformFoundation.framework** aus dem {{ site.data.keys.product_adj }}-SDK
und weitere in der Podfile angegebene Frameworks mit den zugehörigen Abhängigkeiten.
Anschließend generiert er das Pods-Projekt und integriert das {{ site.data.keys.product_adj }}-SDK in das Clientprojekt.
7. Öffnen Sie Ihre Datei **Projektname.xcworkspace** in Xcode. Geben Sie dazu in einer Befehlszeile open **Projektname.xcworkspace** ein. Die Datei befindet sich in demselben Verzeichnis wie die Datei **Projektname.xcodeproj**.
8. Ersetzen Sie alle vorhandenen {{ site.data.keys.product_adj }}-Importe in Headern durch nur einen Eintrag im folgenden neuen Umbrella-Header:

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundation
   ```

   Wenn Sie Push oder JSONStore verwenden, müssen Sie einen unabhängigen Import aufnehmen.

   #### Push
   {: #push }

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundationPush/IBMMobileFirstPlatformFoundationPush.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundationPush
   ```

   ##### JSONStore
   {: #jsonstore }

   **Objective-C**

   ```objc
   #import <IBMMobileFirstPlatformFoundationJSONStore/IBMMobileFirstPlatformFoundationJSONStore.h>
   ```

   **Swift**

   ```swift
   import IBMMobileFirstPlatformFoundationJSONStore
   ```

9. Fügen Sie auf der Registerkarte **Build Settings** unter **Other Linker Flags** am Anfang des Flags "-ObjC" `$(inherited)` hinzu. Beispiel:

      

    ![$(inherited) zum Flag ObjC in den Xcode-Buildeinstellungen hinzufügen](add_inherited_to_ObjC.jpg)

10. Ab Xcode 7 muss TLS umgesetzt werden (siehe
TLS-gesicherte Verbindungen in iOS-Apps erzwingen).   

<br/>
Ihre Anwendung ist jetzt aktualisiert und kann mit dem iOS-SDK von {{ site.data.keys.product }} Version 8.0 verwendet werden. 

#### Nächste Schritte
{: #what-next }
Ersetzen Sie die clientseitigen APIs, die
weggefallen oder nicht in Version 8.0 enthalten sind. 

## Verschlüsselung in iOS umstellen
{: #migrating-encryption-in-ios }
Wenn Ihre iOS-Anwendung die OpenSSL-Verschlüsselung verwendet hat, möchten Sie Ihre App vielleicht auf die neue
native Verschlüsselung von Version 8.0 umstellen. Wenn Sie
OpenSSL weiterhin verwenden möchten, müssen Sie einige zusätzliche Frameworks installieren. 

Weitere Informationen zu den Optionen für die iOS-Verschlüsselung bei der Migration finden Sie unter
[OpenSSL für iOS aktivieren](../../../application-development/sdk/ios/additional-information/#enabling-openssl-for-ios).

## iOS-Code aktualisieren
{: #updating-the-ios-code }
Nachdem Sie das iOS-Framework aktualisiert und die erforderlichen Konfigurationsänderungen vorgenommen haben,
kann Ihr konkreter Anwendungscode von einigen Problemen betroffen sein.   
In der folgenden Tabelle sind die iOS-API-Änderungen aufgelistet.

|API-Element |Migrationspfad |
|-------------|----------------|
| {::nomarkdown}<ul><li><code>[WLClient getWLDevice][WLClient transmitEvent:]</code></li><li><code>[WLClient setEventTransmissionPolicy]</code></li><li><code>[WLClient purgeEventTransmissionBuffer]</code></li></ul>{:/} |Die Geoortung wurde entfernt. Verwenden Sie für die Geoortung native iOS-Optionen oder Pakete von anderen Anbietern.|
| {::nomarkdown}<ul><li><code>WL.Client.getUserInfo(realm, key)</code></li><li><code>WL.Client.updateUserInfo(options)</code></li></ul>{:/} |Kein Ersatz |
|`WL.Client.deleteUserPref(key, options)` |Kein Ersatz Sie können einen Adapter und die API [`MFP.Server.getAuthenticatedUser`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refjavascript-server/html/MFP.Server.html?view=kc#MFP.Server.getAuthenticatedUser:) verwenden, um Benutzervorgaben zu verwalten. |
|`[WLClient getRequiredAccessTokenScopeFromStatus]` |Verwenden Sie [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:). |
|`[WLClient login:withDelegate:]` |Verwenden Sie [`WLAuthorizationManager login`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/login:withCredentials:withCompletionHandler:). |
|`[WLClient logout:withDelegate:]` |Verwenden Sie [`WLAuthorizationManager logout`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/logout:withCompletionHandler:). |
| {::nomarkdown}<ul><li><code>[WLClient lastAccessToken]</code></li><li><code>[WLClient lastAccessTokenForScope:]</code></li></ul>{:/} |Verwenden Sie [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:). |
| {::nomarkdown}<ul><li><code>[WLClient obtainAccessTokenForScope:withDelegate:]</code></li><li><code>[WLClient getRequiredAccessTokenScopeFromStatus:authenticationHeader:]</code></li></ul>{:/} |Verwenden Sie [`WLAuthorizationManager obtainAccessTokenForScope`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLAuthorizationManager.html?view=kc#//api/name/obtainAccessTokenForScope:withCompletionHandler:). |
|`[WLClient isSubscribedToAdapter:(NSString *) adaptereventSource:(NSString *) eventSource` |Verwenden Sie die [clientseitige Objective-C-Push-API für iOS-Apps](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_objc_push_api_native_ios_apps.html?view=kc#nativeobjective-capiforandroidapps) aus dem Framework IBMMobileFirstPlatformFoundationPush.|
|`[WLClient - (int) getEventSourceIDFromUserInfo: (NSDictionary *) userInfo]` |Verwenden Sie die [clientseitige Objective-C-Push-API für iOS-Apps](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_objc_push_api_native_ios_apps.html?view=kc#nativeobjective-capiforandroidapps) aus dem Framework IBMMobileFirstPlatformFoundationPush.|
|`[WLClient invokeProcedure: (WLProcedureInvocationData *) ]` |Nicht mehr verwendet. Verwenden Sie stattdessen [`WLResourceRequest`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc#/api/name/sendWithDelegate:). |
|`[WLClient sendUrlRequest:delegate:]` |Verwenden Sie stattdessen [`[WLResourceRequest sendWithDelegate:delegate]`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/WLResourceRequest.html?view=kc#/api/name/sendWithDelegate:). |
|`[WLClient (void) logActivity:(NSString *) activityType]`	|Gelöscht. Verwenden Sie einen Objective-C-Logger. |
| {::nomarkdown}<ul><li><code>[WLSimpleDataSharing setSharedToken: myName value: myValue]</code></li><li><code>[WLSimpleDataSharing getSharedToken: myName]]</code></li><li><code>[WLSimpleDataSharing clearSharedToken: myName]</code></li></ul>{:/} |Verwenden Sie für die anwendungsübergreifende Nutzung von Token die Betriebssystem-APIs.|
|`BaseChallengeHandler.submitFailure(WLResponse *)challenge` |Verwenden Sie [`BaseChallengeHandler.cancel()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/BaseChallengeHandler.html?view=kc). |
|`BaseProvisioningChallengeHandler` |Kein Ersatz. Die Bereitstellung für Geräte erfolgt jetzt automatisch über das Sicherheitsframework. |
|`ChallengeHandler` |Verwenden Sie für angepasste Gateway-Abfragen [`GatewayChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc). Verwenden Sie für Abfragen von {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc). |
|`WLChallengeHandler` |Verwenden Sie [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc). |
|`ChallengeHandler.isCustomResponse()` |Verwenden Sie [`GatewayChallengeHandler.canHandleResponse()`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/GatewayChallengeHandler.html?view=kc). |
|`ChallengeHandler.submitAdapterAuthentication` |Implementieren Sie ähnliche Logik in Ihrem Abfrage-Handler. Verwenden Sie für angepasste Gateway-Abfrage-Handler [`GatewayChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/GatewayChallengeHandler.html?view=kc). Verwenden Sie für Abfrage-Handler für {{ site.data.keys.product_adj }}-Sicherheitsüberprüfungen [`SecurityCheckChallengeHandler`](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/html/refobjc-worklight-ios/html/Classes/SecurityCheckChallengeHandler.html?view=kc). |
