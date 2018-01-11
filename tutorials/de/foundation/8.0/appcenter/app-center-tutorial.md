---
layout: tutorial
title: Mobile Anwendungen über das IBM Application Center verteilen
relevantTo: [ios,android,windows8,cordova]
show_in_nav: false
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Das {{ site.data.keys.mf_app_center_full }} ist ein **Repository für mobile Anwendungen**.
Es ist mit öffentlichen App Stores vergleichbar, jedoch speziell auf die Anforderungen einer Organisation oder eines Teams abgestellt. Das Application Center ist ein privater App Store. 

Das Application Center vereinfacht die gemeinsame Nutzung mobiler Anwendungen: 

* Sie können **Feedback und Bewertungen** teilen.   
* Über Zugriffssteuerungslisten können Sie festlegen, wer Anwendungen installieren darf. 

Das Application Center arbeitet mit {{ site.data.keys.product_adj }}-Apps und Nicht-{{ site.data.keys.product_adj }}-Apps
und unterstützt **iOS**-, **Android**-, **BlackBerry-6/7**- und
**Windows/Windows-Phone-8.x**-Anwendungen. 

> **Hinweis:** Archiv- bzw. IPA-Dateien, die
für die Übergabe von iOS-Apps an einen Store oder für die Validierung von iOS-Apps mit Test Flight oder iTunes Connect generiert werden,
können zu Laufzeitfehlern oder zu einem Laufzeitabsturz führen.
Weitere Informationen hierzu finden Sie im Blog [Preparing iOS apps for App Store submission in IBM MobileFirst Foundation 8.0](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/).


Sie können das Application Center in verschiedenen Kontexten verwenden. Beispiel: 

* Unternehmens-App-Store für eine Organisation
* Verteilung von Anwendungen innerhalb eines Teams während der Entwicklung

> **Hinweis:** Für die Erstellung des iOS-Application-Center-Installationsprogramms ist MobileFirst 7.1 erforderlich. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to}
* [Installation und Konfiguration](#installing-and-configuring)
* [Cordova-basierter IBM Application-Center-Client](#cordova-based-ibm-appcenter-client)
* [Mobile Clients erstellen](#preparing-mobile-clients)
* [Anwendungen in der Application-Center-Konsole verwalten](#managing-applications-in-the-application-center-console)
* [Mobiler Application-Center-Client](#the-application-center-mobile-client)
* [Befehlszeilentools des Application Center](#application-center-command-line-tools)

## Installation und Konfiguration
{: #installing-and-configuring }
IBM Installation Manager installiert das Application Center zusammen mit {{ site.data.keys.mf_server }}. 

**Voraussetzung:** Bevor Sie das Application Center installieren, müssen Sie einen Anwendungsserver und eine Datenbank installiert haben: 

* Anwendungsserver: Tomcat, WebSphere Application Server Full Profile oder WebSphere Application Server Liberty Profile
* Datenbank: DB2, Oracle oder MySQL

Wenn Sie keine installierte Datenbank haben, kann der Installationsprozess eine Apache-Derby-Datenbank installieren. Die Derby-Datenbank ist allerdings nicht für Produktionsszenarien zu empfehlen. 

1. IBM Installation Manager führt Sie durch die Installation des Application Center und bietet Optionen für die Datenbank und den Anwendungsserver an. 

    > Weitere Informationen finden Sie unter [{{ site.data.keys.mf_server }} installieren](../../installation-configuration).

    Da iOS 7.1 nur das HTTPS-Protokoll unterstützt, muss der
Application-Center-Server mit SSL (d. h. zumindest mit TLS Version 1) geschützt werden, wenn Sie
Apps für Geräte mit iOS ab Version 7.1 verteilen möchten. Selbst signierte Zertifikate werden nicht empfohlen, können jedoch für Testzwecke verwendet werden,
sofern
an die Geräte selbst signierte Zertifikate einer Zertifizierungsstelle verteilt werden. 

2. Öffnen Sie nach der Installation des Application Center  mit IBM Installation Manager die Konsole (`http://localhost:9080/appcenterconsole`). 

3. Melden Sie sich mit der Benutzer-Kennwort-Kombination demo/demo an. 

4. Jetzt können Sie die Benutzerauthentifizierung konfigurieren. Sie können beispielsweise keine Verbindung zu einem LDAP-Repository herstellen. 

    > Weitere Informationen finden Sie unter [Application Center nach der Installation konfigurieren](../../installation-configuration/production/appcenter/#configuring-application-center-after-installation).



5. Erstellen Sie den mobilen Client für Android, iOS, BlackBerry 6/7 und Windows Phone 8. 

Der mobile Client ist die mobile Anwendung, die Sie zum Anzeigen des Katalogs und zum Installieren der Anwendung verwenden. 

> **Hinweis:** Für eine Produktionsinstallation sollten Sie das Application Center mit bereitgestellten Ant-Tasks installieren, damit Sie
den Server unabhängig vom Application Center aktualisieren können.



## Cordova-basierter IBM Application-Center-Client
{: #cordova-based-ibm-appcenter-client }
Das Cordova-basierte Clientprojekt "AppCenter" befindet sich im Verzeichnis
`install` unter **Installationsverzeichnis/ApplicationCenter/installer/CordovaAppCenterClient**.

Dieses Projekt basiert ausschließlich auf dem Cordova-Framework, sodass es keine Abhängigkeit von Client/Server-APIs der
{{ site.data.keys.product }} gibt.   
Da es sich um eine Cordova-Standard-App handelt, gibt es auch keine Abhängigkeit von {{ site.data.keys.mf_studio }}. Diese App verwendet Dojo für die Benutzerschnittstelle. 

Starten Sie wie folgt: 

1. Installieren Sie Cordova.

```bash
npm install -g cordova@latest
```

2. Installieren Sie das Android-SDK und definieren Sie `ANDROID_HOME`.  
3. Erstellen Sie einen Projektbuild und führen Sie dieses Projekt aus. 

Build für alle Plattformen: 

```bash
cordova build
```

Build nur für Android:

```bash
cordova build android
```

Build nur für iOS:

```bash
cordova build ios
```

### Application-Center-Installationsprogramm anpassen
{: #customizing-appcenter-installer-application }
Sie können die Anwendung weiter Anpassen. Sie können beispielsweise die Benutzerschnittstelle entsprechend den Anforderungen oder Bedürfnissen
Ihres konkreten Unternehmens aktualisieren. 

> **Hinweis:** Es steht Ihnen frei, die Benutzerschnittstelle und das Verhalten der Anwendung anzupassen. Solche Änderungen sind jedoch nicht vom IBM Unterstützungsvertrag abgedeckt.



#### Android
{: #android }
* Öffnen Sie Android Studio.
* Wählen Sie **Import project (Eclipse ADT, Gradle, etc.)** aus. 
* Wählen Sie den Ordner "android" aus (**Installationsverzeichnis/ApplicationCenter/installer/CordovaAppCenterClient/platforms/android**).

Dies kann eine Weile dauern. Sobald dieser Schritt abgeschlossen ist, können Sie mit der Anpassung beginnen. 

> **Hinweis:** Wählen Sie im Popup-Fenster aus, dass Sie das Upgrade für die Gradle-Version überspringen möchten. Informationen zur Version finden Sie in `grade-wrapper.properties`.



#### iOS
{: #ios }
* Navigieren Sie zu **Installationsverzeichnis/ApplicationCenter/installer/CordovaAppCenterClient/platforms**.
* Klicken Sie auf die Datei **IBMAppCenterClient.xcodeproj**, um sie zu öffnen. Das Projekt wird in Xcode geöffnet, sodass Sie mit der Anpassung beginnen können. 

## Mobile Clients erstellen
{: #preparing-mobile-clients }
### Android-Mobiltelefone und -Tablets
{: #for-android-phones-and-tablets }
Der mobile Client wird als kompilierte Anwendung (APK) unter **Installationsverzeichnis/ApplicationCenter/installer/IBMApplicationCenter.apk** bereitgestellt. 

> **Hinweis:** Wenn Sie das Cordova-Framework für die Erstellung des Android- und iOS-Application-Center-Clients verwenden, lesen Sie die Informationen
unter [Cordova-basierter IBM Application-Center-Client](#cordova-based-ibm-appcenter-client).



### iPad und iPhone
{: #for-ipad-and-iphone }
1. Kompilieren und signieren Sie die als Quellcode bereitgestellte Clientanwendung. Dieser Schritt ist obligatorisch. 

2. Öffnen Sie in MobileFirst Studio das Projekt IBMAppCenter unter **Installationsverzeichnis/ApplicationCenter/installer**. 

3. Verwenden Sie **Ausführen als → Run on MobileFirst Development Server**, um den Projektbuild zu erstellen. 

4. Verwenden Sie Xcode, um den Anwendungsbuild zu erstellen und die Anwendung mit Ihrem Apple-iOS-Unternehmensprofil zu signieren.   
Sie können das resultierende native Projekt
(unter **iphone\native**) manuell in Xcode öffnen oder mit der rechten Maustaste auf den
iPhone-Ordner klicken und **Ausführen als → Xcode-Projekt** auswählen. Diese Aktion generiert das Projekt und öffnet es in Xcode. 

> **Hinweis:** Wenn Sie das Cordova-Framework für die Erstellung des Android- und iOS-Application-Center-Clients verwenden, lesen Sie die Informationen
unter [Cordova-basierter IBM Application-Center-Client](#cordova-based-ibm-appcenter-client).



### BlackBerry
{: #for-blackberry }
* Wenn Sie die BlackBerry-Version erstellen möchten, benötigen Sie die BlackBerry-Eclipse-IDE
(oder Eclipse mit dem BlackBerry-Java-Plug-in) mit dem BlackBerry SDK 6.0. Wenn die Anwendung mit dem BlackBerry SDK 6.0 kompiliert wird, kann sie auch unter
BlackBerry 7 ausgeführt werden. 

Unter **Installationsverzeichnis/ApplicationCenter/installer/IBMAppCenterBlackBerry6** wird ein BlackBerry-Projekt bereitgestellt. 

### Windows Phone 8
{: #for-windows-phone-8}
1.  Registrieren Sie bei Microsoft ein Unternehmenskonto.   
Das Application Center verwaltet nur Unternehmensanwendungen, die mit dem Unternehmenszertifikat Ihres Unternehmenskontos signiert wurden. 

2. Die Windows-Phone-Version des mobilen Clients ist in **Installationsverzeichnis/ApplicationCenter/installer/IBMApplicationCenterUnsigned.xap** enthalten.

* Stellen Sie sicher, dass der mobile Application-Center-Client mit diesem Unternehmenszertifikat signiert wurde. 

* Wenn Sie Unternehmensanwendungen auf einem Gerät installieren möchten, müssen Sie zunächst ein Token für die Unternehmensregistrierung installieren, um das Gerät im Unternehmen zu registrieren.

> Weitere Informationen zu Unternehmenskonten und Registrierungstoken finden Sie
auf der Microsoft-Website für Entwickler auf der Seite [Company app distribution for Windows Phone](http://msdn.microsoft.com/library/windows/apps/jj206943(v=vs.105).



> Weitere Informationen zum Signieren von mobilen Windows-Phone-Clientanwendungen finden Sie auf der
[Microsoft-Website für Entwickler](http://dev.windows.com/en-us/develop).



<br/>

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Wichtiger Hinweis:**  Sie
können die nicht signierte `.xap`-Datei **nicht** direkt verwenden. Bevor Sie die Datei auf einem Gerät installieren, müssen Sie sie mit Ihrem Unternehmenszertifikat, das Sie von Symantec oder Microsoft erhalten haben, signieren.



### Windows-Store-Apps für Windows 8.1 Pro
{: #for-windows-store-apps-for-windows-81-pro }
* Die Datei **Installationsverzeichnis/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** enthält
die ausführbare Datei des Application-Center-Clients. Geben Sie diese Datei an den Clientcomputer weiter und entpacken Sie sie dort. Die Datei enthält das ausführbare Programm. 

* Die Installation einer Windows-Store-App (d. h. einer Datei vom Typ
`appx`) ohne Verwendung des Microsoft Windows Store wird als das <em>Querladen</em> einer App
bezeichnet. Für das Querladen einer App müssen Sie die
unter
["Prepare to sideload apps"](https://technet.microsoft.com/fr-fr/library/dn613842.aspx.Mit dem Update auf Windows 8.1.1 gelten vereinfachte Voraussetzungen für das Querladen.
Weitere Informationen finden Sie unter ) beschriebenen Voraussetzungen erfüllen. 


## Anwendungen in der Application-Center-Konsole verwalten
{: #managing-applications-in-the-application-center-console }
![Anwendungsmanagement im Application Center]({{ site.baseurl }}/assets/backup/overview1.png)

Verwenden Sie die Application-Center-Konsole, um Anwendungen im Katalog mit folgenden Aktionen zu verwalten: 

* Anwendungen hinzufügen und entfernen
* Anwendungsversionen verwalten    
* Details einer Anwendung anzeigen
* Zugriff auf eine Anwendung auf bestimmte Benutzer oder Benutzergruppen beschränken
* Rezensionen zu Anwendungen lesen
* Registrierte Benutzer und Geräte überprüfen

### Neue Anwendungen zum Store hinzufügen
{: #adding-new-applications-to-the-store }
![Apps zum Application Center hinzufügen]({{ site.baseurl }}/assets/backup/addAppFile_smaller.png)

Gehen Sie wie folgt vor, um neue Anwendungen zum Store hinzuzufügen:

1. Öffnen Sie die Application-Center-Konsole. 
2. Klicken Sie auf **Anwendung hinzufügen**.
3. Wählen Sie eine Anwendungsdatei aus:
    * `.ipa`: iOS
    * `.apk`: Android
    * `.zip`: BlackBerry 6/7
    * `.xap`: Windows Phone 8.x
    * `.appx`: Windows Store 8.x

* Klicken Sie auf **Weiter**.

    In den Ansichten mit den Anwendungsdetails können Sie die Informationen zu der neuen Anwendung überprüfen und weitere Informationen eingeben, z. B. eine Beschreibung. Später können Sie zu dieser Ansicht für alle Anwendungen im Katalog zurückkehren. 

    ![Anzeige der Anwendungsdetails]({{ site.baseurl }}/assets/backup/appDetails1.png)

* Klicken Sie auf **Fertig**, um die Aufgabe abzuschließen. 

Die neue Anwendung wird zum Store hinzugefügt. 

![Zugriffssteuerung im Application Center]({{ site.baseurl }}/assets/backup/accessControlEnabled.png)

Standardmäßig kann eine Anwendung von jedem autorisierten Benutzer des Stores installiert werden. 

### Zugriff auf eine Benutzergruppe beschränken
{: #restricting-access-to-a-group-of-users }
Gehen Sie wie folgt vor, um den Zugriff auf eine Benutzergruppe zu beschränken: 

1. Klicken Sie in der Katalogansicht neben dem Anwendungsnamen auf den Link **unrestricted**. Die Seite "Installation Access Control" wird geöffnet. 
2. Wählen Sie **Access control enabled** aus. Sie können die Liste der Benutzer oder Gruppen eingeben, die berechtigt sind, die Anwendung zu installieren. 
3. Wenn Sie LDAP konfiguriert haben, fügen Sie im LDAP-Repository definierte Benutzer und Gruppen hinzu. 

Sie können auch Anwendungen aus öffentlichen App Stores wie Google Play oder dem Apple App Store hinzufügen. Geben Sie dazu die entsprechenden URLs ein.

## Mobiler Application-Center-Client
{: #the-application-center-mobile-client }
Der mobile Application-Center-Client ist eine mobile Anwendung für die Verwaltung der Anwendungen auf einem Gerät. Mit dem mobilen Client können Sie folgende Aufgaben ausführen: 

* Auflisten aller Anwendungen im Katalog (für die Sie die Zugriffsberechtigung haben)
* Auflisten der bevorzugten Anwendungen
* Installieren einer Anwendung oder Upgrade auf eine neue Version
* Bereitstellen von Feedback und einer Bewertung (bis zu fünf Sterne) für eine Anwendung

### Mobilen Client zum Katalog hinzufügen
{: #adding-mobile-client-applications-to-the-catalog }
Sie müssen den mobilen Application-Center-Client zum Katalog hinzufügen. 

1. Öffnen Sie die Application-Center-Konsole. 
2. Klicken Sie auf die Schaltfläche **Anwendung hinzufügen**, um die Datei `.apk`, `.ipa`, `.zip` oder `.xap` des mobilen Clients hinzuzufügen. 
3. Klicken Sie auf **Weiter**, um die Seite mit den Anwendungsdetails zu öffnen.
4. Wählen Sie auf der Seite mit den Anwendungsdetails **Installationsprogramm** aus, um anzugeben, dass diese Anwendung ein mobiler Client ist.
5. Klicken Sie auf **Fertig**, um die Application-Center-App zum Katalog hinzuzufügen.

Der Application-Center-Client für Windows 8.1 Pro muss nicht zum Katalog hinzugefügt werden. Dieser Client ist ein reguläres Windows-Programm (`.exe`),
das in der Datei **Installationsverzeichnis/ApplicationCenter/installer/IBMApplicationCenterWindowsStore.zip** enthalten ist. Sie können dieses Programm einfach auf den Clientcomputer kopieren. 

### Windows Phone 8
{: #windows-phone-8 }
Unter Windows Phone 8 müssen Sie zusätzlich das Registrierungstoken, das Sie mit Ihrem Unternehmenskonto erhalten haben,
in der Application-Center-Konsole installieren, damit Benutzer ihre Geräte registrieren können. Verwenden Sie die Seite mit den Application-Center-Einstellungen, die Sie über das Zahnradsymbol öffnen können. 

![Registrierung von Windows-Phone-8-Apps]({{ site.baseurl }}/assets/backup/wp8Enrollment.png)

Bevor Sie den mobilen Client installieren, müssen Sie das Gerät im Unternehmen registrieren, indem Sie das Registrierungstoken installieren: 

1. Öffnen Sie den Web-Browser auf dem Gerät. 
2. Geben Sie die URL `http://hostname:9080/appcenterconsole/installers.html` ein. 
3. Geben Sie den Benutzernamen und das Kennwort ein. 
4. Klicken Sie auf **Token**, um die Liste der Registrierungstoken zu öffnen. 
5. Wählen Sie in der Liste das Unternehmen aus. Die Details des Unternehmenskontos werden angezeigt. 
6. Klicken Sie auf **Unterehmenskonto hinzufügen**. Ihr Gerät wird registriert. 

### Mobilen Client auf dem mobilen Gerät installieren
{: #installing-the-mobile-client-on-the-mobile-device }
Gehen Sie wie folgt vor, um den mobilen Client auf dem mobilen Gerät zu installieren:
![App für Anwendungsinstallation]({{ site.baseurl }}/assets/backup/installers_smaller.png)

1. Öffnen Sie den Web-Browser auf dem Gerät. 
2. Geben Sie die URL `http://hostname:9080/appcenterconsole/installers.html` ein. 
3. Geben Sie den Benutzernamen und das Kennwort ein. 
4. Wählen Sie die Application-Center-Anwendung aus, um die Installation zu starten. 

Auf **Android**-Geräten müssen Sie die Android-Download-Anwendung öffnen und
**IBM App Center** zur Installation auswählen. 

### Anmeldung beim mobilen Client
{: #logging-in-to-the-mobile-client }
Gehen Sie wie folgt vor, um sich beim mobilen Client anzumelden: 

1. Geben Sie Ihre Berechtigungsnachweise für den Zugriff auf den Server ein. 
2. Geben Sie den Hostnamen oder die IP-Adresse des Servers ein. 
3. Geben Sie im Feld **Server-Port** die Portnummer ein, sofern nicht die Standardportnummer (`9080`) verwendet wird.
4. Geben Sie im Feld **Anwendungskontext** den Kontext `applicationcenter` ein.

![Anmeldeanzeige]({{ site.baseurl }}/assets/backup/login.png)

### Ansichten des mobilen Application-Center-Clients
{: #application-center-mobile-client-views }
* In der Ansicht **Katalog** wird die Liste der verfügbaren Anwendungen angezeigt. 
* Wenn Sie eine Anwendung auswählen, wird die Ansicht **Details** für die Anwendung angezeigt. In der Detailansicht können Sie Anwendungen installieren. Sie können auch Anwendungen als Fovoriten markieren. Verwenden Sie dazu den roten Stern in der Detailansicht. 

    ![Katalogdetails]({{ site.baseurl }}/assets/backup/catalog_details.001.jpg)

* In der Ansicht **Favoriten** werden die bevorzugten Anwendungen aufgelistet. Die Liste ist auf allen Geräten eines bestimmten Benutzers verfügbar. 
* In der Ansicht **Aktualisierungen** werden alle verfügbaren Aktualisierungen aufgelistet. In der Ansicht "Aktualisierungen" können Sie zur Detailansicht navigieren. Sie können
eine neuere Anwendungsversion auswählen oder die aktuellste verfügbare Version übernehmen. Wenn das Application Center für das Senden von Push-Benachrichtigungen konfiguriert ist, werden Sie möglicherweise mittels Push-Benachrichtigung über Aktualisierungen informiert. 

Vom
mobilen Client aus können Sie die Anwendung bewerten und eine Rezension senden. Rezensionen können in der Konsole oder auf dem mobilen Gerät angezeigt werden. 

![Rezensionen]({{ site.baseurl }}/assets/backup/reviewss.png)

## Befehlszeilentools des Application Center
{: #application-center-command-line-tools }
Das Verzeichnis **Installationsverzeichnis/ApplicationCenter/tools** enthält alle Dateien, die für die Verwendung des Befehlszeilentools oder der Ant-Tasks
für die Verwaltung der Anwendungen im Store benötigt werden: 

* `applicationcenterdeploytool.jar`: Befehlszeilentool für Uploads
* `json4.jar`: Bibliothek für das vom Uploadtool benötigte JSON-Format
* `build.xml`: Ant-Beispiel-Script, mit dem Sie eine einzelne Datei oder eine Reihe von Dateien in das Application Center hochladen können
* `acdeploytool.sh` und `acdeploytool.bat`: Beispiel-Scripts zum Aufrufen von Java mit `applicationcenterdeploytool.jar`

Wenn Sie beispielsweise eine Anwendungsdatei `app.apk`
im Store unter `localhost:9080/applicationcenter` mit der Benutzer-ID `demo` und dem Kennwort
`demo` implementieren möchten, müssen Sie Folgendes schreiben: 

```bash
Java com.ibm.appcenter.Upload -s http://localhost:9080 -c applicationcenter -u demo -p demo app.apk
```
