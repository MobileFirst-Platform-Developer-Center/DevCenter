---
layout: tutorial
title: Migration Studio
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
# Mobile Foundation Migration Studio
{: #mf-migration-studio}

> Laden Sie [Mobile Foundation Migration Studio](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/releases/download/20200421-1300/Mobile-Foundation-Migration-Studio-20200421-1300.zip) herunter.

## Was ist Migration Studio?
{: #what-is-migration-studio}

Das Mobile-Foundation-Migration-Studio-Plug-in ist ein Eclipse-Plug-in, das ein direktes Upgrade für Hybridprojekte aus MobileFirst Platform Foundation Version 7.1 durchführt und diesen Projekten ermöglicht, eine Verbindung zu einem Server von Mobile Foundation Version 8 herzustellen. Dieses Plug-in ist mit dem MobileFirst-Studio-Plug-in der Version 7.1 vergleichbar und kann in den gleichen unterstützten Umgebungen wie MobileFirst Platform Foundation Studio Version 7.1 installiert werden.

## Warum sollte das Migration Studio verwendet werden?
{: #why-use-migration-studio}

Das Mobile-Foundation-Migration-Studio-Plgu-in bietet einen direkten Pfad für das Upgrade vorhandener Hybrid-Apps von MobileFirst Platform Foundation Version 7.1 an, damit diese mit Mobile Foundation Version 8 arbeiten können.

> Mobile Foundation Migration Studio führt eine begrenzte Migration auf Mobile Foundation Version 8 durch. Sie sollten sich daher bevorzugt für die Standardmigration entscheiden. 

## Migration mit dem Migration Studio und Standardmigration im Vergleich
{: #compare-with-standard-migration}

Der Standardmigrationsansatz für eine Hybrid-App aus MobileFirst Platform Foundation Version 7.1 ist im [Migrations-Cookbook]({{site.baseurl}}/tutorials/en/foundation/8.0/upgrading/migration-cookbook/) beschrieben. Er führt zu einer qualifizierten Cordova-App, die eine Verbindung zu einem Server in Mobile Foundation Version 8 herstellt. Beim Ansatz mit dem Migration Studio bleibt dagegen die traditionelle Hybridstruktur der App gewahrt (d. h. die Struktur eines MobileFirst-Projekts mit eingebettetem Cordova-Plug-in). Aus diesem Grund steht für Apps, die mit dem Migration Studio migriert werden, nicht das gesamte und für eine traditionelle App in Mobile Foundation Version 8.0 verfügbare Funktionsspektrum zur Verfügung. In [diesem Abschnitt](#known-limitations-of-migration-studio) finden Sie eine vollständige Liste der bekannten Einschränkungen.  

## Erste Schritte mit dem Migration Studio
{: #get-started-with-migration-studio}

Für den Einstieg in das Migration Studio müssen Sie die folgenden Schritte ausführen:

* **Schritt 1**: Richten Sie Ihr Projekt ein.

  Gehen Sie dazu wie folgt vor:

  1. Installieren Sie eine vom Studio-Plug-in für MobileFirst Platform Foundation Version 7.1 unterstützte Eclipse-Version.

  2. Laden Sie das [Migration Studio](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/releases/download/20200421-1300/Mobile-Foundation-Migration-Studio-20200421-1300.zip) herunter und installieren Sie das Plug-in in Ihrer Eclipse-IDE. Dieser Schritt unterscheidet sich nicht von der Installation des Studio-Plug-ins von MobileFirst Platform Foundation Version 7.1.
     > **Wichtiger Hinweis:** Führen Sie ein direktes Upgrade über eine vorhandene MobileFirst-Studio-Installation aus.

  3. Importieren Sie Ihr Projekt von MobileFirst Platform Foundation Version 7.1 in das Mobile Foundation Migration Studio, indem Sie **Datei > Importieren > Dateisystem** auswählen. Falls Sie das Projekt bereits in Ihr Dateisystem exportiert hatten, können Sie auch die exportierte `.zip`-Datei importieren. Sie werden feststellen, dass die Migration-Studio-Schnittstelle der Schnittstelle von MobileFirst Platform Foundation Studion Version 7.1 sehr ähnlich ist.

  4. Bewahren Sie eine Sicherung Ihrer Umgebungsordner auf (android, iphone, ipad). Öffnen Sie die Datei `application-descriptor.xml` und löschen Sie die Umgebungen. Wählen Sie die Option für das Löschen aller Arbeitsbereichsressourcen aus.
  ![Projekt einrichten](set-up-project.gif)

  5. Fügen Sie die Umgebungen wieder zu Ihrem Projekt hinzu und warten Sie, bis der Build erstellt ist. Falls es in Ihrem früheren Projekt Anpassungen gab (Sie also beispielsweise ein angepasstes Cordova-Plug-in hinzugefügt hatten), müssen Sie diese Anpassungen jetzt erneut vornehmen.
  > Das Migration Studio aktualisiert die Cordova-Version innerhalb des Projekts, weshalb einige Cordova-Plug-ins anderer Anbieter möglicherweise nicht mit der neuen Cordova-Version kompatibel sind. Sollte das der Fall sein, prüfen Sie, ob ein Update für Ihr Plug-in verfügbar ist. Aktualisieren Sie dann das Cordova-Plug-in auf die entsprechende Version.

* **Schritt 2**: Richten Sie Ihre Anwendung ein.

  Gehen Sie dazu wie folgt vor:

  1. Angepasste Abfrage-Handler werden modifiziert, damit sie mit dem Abfrage-Handler-Framework von Mobile Foundation Version 8 arbeiten können. Sie müssen jedoch die Methode `createChallengeHandler` von Abfrage-Handlern und die auf Abfragen gegebene Antwort so modifizieren, dass diese zur Sicherheitsüberprüfung in Mobile Foundation Version 8.0 passen.
      **App der Version 7.1**
      ```JavaScript
      var loginChallengeHandler = WL.Client.createChallengeHandler("UserLoginRealm");
      options.parameters = {
              j_username : $('#AuthUsername').val(),
              j_password : $('#AuthPassword').val()
       };
      ```

      **Migrierte App**
      ```JavaScript
      var loginChallengeHandler = WL.Client.createChallengeHandler("UserLoginSecurityCheck");
      options.parameters = {
              username : $('#AuthUsername').val(),
              password : $('#AuthPassword').val()
       };
      ```

      >**Hinweis**: Die Parameter und der Name hängen davon ab, wie Sie Ihre Sicherheitsüberprüfung konfigurieren.

  2. [**Optional**] Falls es in Ihrer App mehrere HTML-Seiten gibt, bearbeiten Sie jede HTML-Datei und die Pfadverweise auf die JavaScript- und CSS-Dateien so, dass diese in dem neuen Projekt funktionieren.

* **Schritt 3**: Konfigurieren Sie Mobile Foundation Version 8.0.

  Gehen Sie dazu wie folgt vor:

  1. Starten Sie den Server von Mobile Foundation Version 8 (Sie können den Server aus dem Developer Kit von Mobile Foundation Version 8, eine OpenShift-Container-Platform-Installation der Mobile Foundation oder eine traditionelle lokale Installation der Mobile Foundation verwenden) und registrieren Sie Ihre App bei diesem Server. Weitere Details zur Registrierung der Cordova-App für Version 8 finden Sie [hier](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/quick-start/cordova/#2-creating-and-registering-an-application).

  2. Migrieren Sie Ihre Adapter und Ihre Authentifizierung oder Ihre Anmeldemodule und implementieren Sie sie in Ihrer Mobile-Foundation-Instanz. Weitere Informationen zur Migration von Adapter finden Sie in [diesem Abschnitt](../migrating-adapters/).

* **Schritt 4**: Führen Sie Ihre Anwendung aus.

  Gehen Sie dazu wie folgt vor:

  **Android**

  1. Öffnen Sie Android Studio (ab Version 3.2).
  2. Klicken Sie auf **Open an existing Android Studio Project** und navigieren Sie zum Ordner `Eclipse Workspace/<Projektname>/apps/<App-Name>/android/native`.
  3. Bestätigen Sie alle Aufforderungen, den Gradle-Wrapper neu zu erstellen, zu aktualisieren oder die Version des Wrappers zu ändern, sowie alle Aufforderungen, den Schreibschutz für Dateien aufzuheben.
  4. Navigieren Sie in der **Projektansicht** zur Datei `mfpclient.properties` und modifzieren Sie die Serververbindungsparameter.
  5. Führen Sie das Projekt aus. Ändern Sie ggf. die Version von `compileSdk` sowie von Buildtools in der Datei `build.gradle`.
  6. Wenn Sie Push-Benachrichtigungen verwenden, müssen Sie eine Datei `google-services.json` generieren und die entsprechende Datei im Projekt ersetzen. Weitere Informationen finden Sie in [diesem Blogbeitrag]({{site.baseurl}}/blog/2018/10/09/FCM-Support-in-MFP-7.1-Android/). 

  **iOS**

  1. Öffnen Sie in Xcode das native iOS-Projekt, das sich unter `Eclipse_Workspace/<Projektname>/apps/<App-Name>/iphone/native` befindet.
  2. Navigieren Sie in der **Projektansicht** zur Datei `mfpclient.plist` und modifzieren Sie die Serververbindungsparameter.
  3. Wenn Ihre Anwendung das Feature für Push-Benachrichtigungen verwendet, aktivieren Sie die Push-Benachrichtigungsfunktion in den Xcode-Projekteinstellungen und fügen Sie ein gültiges Bereitstellungsprofil hinzu. Weitere Details finden Sie [hier]({{site.baseurl}}/tutorials/en/foundation/8.0/notifications/handling-push-notifications/cordova/#ios-platform).
  4. Es ist keine zusätzliche Konfiguration für iOS erforderlich. Sie können das Projekt in Xcode ausführen.
  > Für eine iPad-Umgebung müssen Sie ebenso vorgehen.

  >**Hinweis**: In der Datei `static_app_props.js` (`www/default/plugins/cordova-plugin-mfp/worklight`) müssen für alle Umgebungen (Android, iOS und iPad) Anwendungsdetails wie Version, Paketname oder Bundlekennung modifiziert werden, bevor die App erstellt und ausgeführt wird.

## Bekannte Einschränkungen für das Migration Studio
{: #known-limitations-of-migration-studio}

* Das Migration Studio kann nur Android-, iPhone- und iPad-Umgebungen aktualisieren. Für andere Umgebungen wird kein Upgrade durchgeführt.
* Dieses Plug-in bietet keine Unterstützung für eine Vorschau.
* Das Migration Studio aktualisiert die eingebettete Version von `cordova-android` auf Version 8.1.0 und `cordova-ios` auf Version 5.1.1. Diese Versionen sind festgelegt und können nicht modifiziert werden.
* Es wird nur die Standardoberfläche unterstützt.
* Sie können mit diesem Projekt keine Pakete für direkte Aktualisierung per Push zu MobileFirst Server übertragen.
* JSONStore-APIs werden in diesem Release noch nicht unterstützt.
  > **Hinweis**: JSONStore kann dennoch verwendet werden. Fügen Sie dazu die Dateien manuell zum Projekt hinzu. Sie müssen `cordova-plugin-mfp-jsonstore` zum Plug-in-Ordner und den Plug-in-Verweis zur Datei `cordova_plugins.js` hinzufügen und die erforderlichen JAR/Framework-Dateien verknüpfen.

* Neue Funktionen von Mobile Foundation Version 8.0 werden nicht unterstützt.
* Das Verhalten von APIs, die [nicht mehr verwendet oder unterstützt]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/release-notes/deprecated-discontinued/#client-side-api-changes) werden, ändert sich. Im folgenden Abschnitt finden Sie Einzelheiten zu den Verhaltensänderungen.

## Anwendungen mit JSONStore migrieren
{: #migrating-apps-using-jsonstore}

Die Migration des JSONStore-Plug-ins von Anwendungen unter Verwendung von JSONStore ist im Migration Studio nicht automatisiert. Gehen Sie für eine manuelle Migration der JSONStore-Projekte wie folgt vor.

Laden Sie `cordova-plugin-mfp-jsonstore` von [hier](https://us-south.git.cloud.ibm.com/ibmmfpf/cordova-plugin-mfp-jsonstore/tree/master) herunter.

### Android

1. Kopieren Sie die folgende Datei `cordova-plugin-mfp-jsonstore/bootstrap.js` und den Ordner `cordova-plugin-mfp-jsonstore/worklight` in den Ordner `<Projektname>/apps/<App-Name>/android/native/<Projektname><App-Name>android/src/main/assets/www/default/plugins/cordova-plugin-mfp-jsonstore`.

2. Öffnen Sie die Datei `<Projektname>/apps/<App-Name>/android/native/<Projektname><App-Name>android/src/main/assets/www/default/cordova_plugins.js` und fügen Sie den folgenden Eintrag für JSONStore zum Array `module.exports` hinzu.
 ```json
 {
      "id": "cordova-plugin-mfp-jsonstore.jsonstore",
      "file": "plugins/cordova-plugin-mfp-jsonstore/bootstrap.js",
      "pluginId": "cordova-plugin-mfp-jsonstore",
      "runs": true
   }
 ```

3. Kopieren Sie die Abhängigkeiten (nur JAR-Dateien) aus dem heruntergeladenen Ordner `cordova-plugin-mfp-jsonstore/src/android/libs` in den Ordner `<Projektname>/apps/<App-Name>/android/native/<Projektname><App-Name>android/libs und fügen Sie die folgenden Einträge zum Abschnitt für Abhängigkeiten in der Datei `<Projektname>/apps/<App-Name>/android/native/<Projektname><App-Name>android/build.gradle hinzu.
   ```text
   compile files('libs/commons-codec.jar')
   compile files('libs/guava.jar')
   compile files('libs/jackson-core-asl.jar')
   compile files('libs/jackson-mapper-asl.jar')
   compile files('libs/ibmmobilefirstplatformfoundationjsonstore.jar')
   compile files('libs/sqlcipher.jar')
   ```

4. Fügen Sie den folgenden Eintrag zur Datei `<Projektname>/apps/<App-Name>/android/native/<Projektname><App-Name>android/src/main/res/config.xml` hinzu.
   ```xml
   <feature name="StoragePlugin">        
   <param name="android-package" value="com.worklight.androidgap.jsonstore.dispatchers.StoragePlugin" />    
   </feature>
   ```

### iOS

1. Kopieren Sie die folgende Datei `cordova-plugin-mfp-jsonstore/bootstrap.js` und den Ordner `cordova-plugin-mfp-jsonstore/worklight` in den Ordner `<Projektname>/apps/<App-Name>/iphone/native/www/default/plugins/cordova-plugin-mfp-jsonstore`.

2. Öffnen Sie die Datei `<Projektname>/apps/<App-Name>/iphone/native/www/default/cordova_plugins.js` und fügen Sie den folgenden Eintrag für JSONStore zum Array `module.exports` hinzu.
  ```JSON
  {
      "id": "cordova-plugin-mfp-jsonstore.jsonstore",
      "file": "plugins/cordova-plugin-mfp-jsonstore/bootstrap.js",
      "pluginId": "cordova-plugin-mfp-jsonstore",
      "runs": true
      }
  ```
3. Kopieren Sie das heruntergeladene Framework `cordova-plugin-mfp-jsonstore/src/ios/Frameworks/IBMMobileFirstPlatformFoundationHybridJSONStore.framework` in den Ordner `<Projektname>/apps/<App-Name>/iphone/native/Frameworks` und fügen Sie es in Xcode auf der Registerkarte "General" zu **Frameworks, Libraries and Embedded Content** hinzu.

   >**Hinweis**: Ersetzen Sie nicht das bereits im Xcode-Projekt vorhandene SQLCipher-Framework.



## Verwendung veralteter oder eingestellter APIs
{: #deprecated-n-discontinued-apis}

Die folgenden APIs werden nicht weiter verwendet und müssen manuell durch alternative APIs ersetzt werden.
Genauere Informationen zu dieser Ersetzung finden Sie in [dieser Dokumentation]({{site.baseurl}}/tutorials/en/foundation/8.0/product-overview/release-notes/deprecated-discontinued/#client-side-api-changes).

|API |
|-----------------------|
|WL.App.BackgroundHandler|
|WL.Badge|
|WL.EncryptedCache|
|WL.TabBar|
|WL.TabBarItem|
|WL.Trusteer|
|WL.Client.createProvisioningChallengeHandler|
|WL.Client.createWLChallengeHandler|
|WL.SecurityUtils.remoteRandomString|

Die folgenden APIs werden nicht mehr unterstützt. Werden diese APIs aufgerufen, erscheint in der Konsole eine Fehlernachricht.

|API |
|-----------------------|
|WL.Client.checkForDirectUpdate|
|WL.Client.close (android only)|
|WL.Client.getLoginName|
|WL.Client.getUserInfo|
|WL.Client.getUserName|
|WL.Client.getUserPref|
|WL.Client.getLoginName|
|WL.Client.isUserAuthenticated|
|WL.Client.getUserPref|
|WL.Client.setUserPrefs|
|WL.Client.hasUserPrefs|
|WL.Client.deleteUserPref|
|WL.Client.updateUserInfo|
|WL.Toast.show (android only)|
|WLAuthorizationManager.getUserIdentity|
|WLAuthorizationManager.getDeviceIdentity|
|WLAuthorizationManager.getAppIdentity|

## Unterstützung
{: #ms-support}

Mobile Foundation Migration Studio ist ein Add-on, das für eine einfache Migration von MobileFirst Platform Foundation Version 7.1 auf Mobile Foundation Version 8.0 bereitgestellt wird. Der reguläre Prozess des IBM Support, bei dem im IBM Support Portal ein Fall geöffnet wird, gilt nicht für Probleme in Bezug auf das Migration Studio. Falls Sie Unterstützung benögigen, können Sie [eine Möglichkeit des Beitritts zu unserem Slack-Kanal anfragen]({{site.baseurl}}/blog/2017/05/26/come-chat-with-us/) oder ein [GitHub Issue](https://github.com/MobileFirst-Platform-Developer-Center/Mobile-Foundation-Migration-Studio/issues) öffnen.
