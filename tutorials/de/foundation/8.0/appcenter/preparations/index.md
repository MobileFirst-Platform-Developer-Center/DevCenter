---
layout: tutorial
title: Vorbereitungen für die Verwendung des mobilen Clients
breadcrumb_title: Vorbereitungen
relevantTo: [ios,android,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Das Application-Center-Installationsprogramm wird verwendet, um Apps auf mobilen Geräten zu installieren. Sie können diese Anwendung mithilfe der bereitgestellten Cordova-, Visual-Studio- oder MobileFirst-Studio-Projekte generieren. Sie können aber auch direkt eine vorab erstellte Version
des MobileFirst-Studio-Projekts für Android, iOS oder Windows 8 Universal verwenden. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Voraussetzungen](#prerequisites)
* [Cordova-basierter IBM Application-Center-Client](#cordova-based-ibm-appcenter-client)
* [MobileFirst-Studio-basierter IBM Application-Center-Client](#mobilefirst-studio-based-ibm-appcenter-client)
* [Funktionen anpassen (für Fachleute): Android, iOS, Windows Phone](#customizing-features-for-experts-android-ios-windows-phone)
* [Mobilen Client im Application Center implementieren](#deploying-the-mobile-client)

## Voraussetzungen
{: #prerequisites }
### Spezifische Voraussetzungen für das Android-Betriebssystem
{: #prerequisites-specific-to-the-android-operating-system }
Die
native Android-Version des mobilen Clients wird in Form einer Android-Anwendungspaketdatei (.apk) bereitgestellt. Die Datei **IBMApplicationCenter.apk** befindet
sich im Verzeichnis **ApplicationCenter/installer**.
Push-Benachrichtigungen sind inaktiviert. Wenn
Sie Push-Benachrichtigungen aktivieren wollen, müssen Sie einen neuen Build der .apk-Datei erstellen. Weitere Informationen zu Push-Benachrichtigungen im Application Center finden Sie unter
[Push-Benachrichtigung über Anwendungsaktualisierungen](../push-notifications). 

Um
die Android-Version zu erstellen, müssen Sie die neueste Version der Android-Entwicklungstools haben.

### Spezifische Voraussetzungen für das Apple-Betriebssystem iOS
{: #prerequisites-specific-to-apple-ios-operating-system }
Die native iOS-Version für iPad und iPhone wird
nicht als kompilierte Anwendung bereitgestellt. Die Anwendung muss aus dem IBM MobileFirst-Foundation-Projekt **IBMAppCenter**
erstellt werden. Dieses Projekt wird mitgeliefert und im Verzeichnis **ApplicationCenter/installer** bereitgestellt.

Zum Erstellen
der iOS-Version benötigen Sie die entsprechende {{ site.data.keys.product_full }}- und Apple-Software. Die Version der
{{ site.data.keys.mf_studio }} muss mit der Version von
{{ site.data.keys.mf_server }} übereinstimmen, auf die sich diese Dokumentation
bezieht. Die Apple-Xcode-Version ist
Version 6.1. 

### Spezifische Voraussetzungen für das Betriebssystem Microsoft Windows Phone
{: #prerequisites-specific-to-microsoft-windows-phone-operating-system }
Die Windows-Phone-Version des mobilen Clients wird als
nicht signierte Windows-Phone-Anwendungspaketdatei (.xap)
bereitgestellt. Die Datei **IBMApplicationCenterUnsigned.xap** befindet sich im Verzeichnis
**ApplicationCenter/installer**. 

> **Wichtiger Hinweis:** Die nicht signierte .xap-Datei kann nicht direkt verwendet werden. Sie müssen die Datei vor der Installation auf einem Gerät mit Ihrem Unternehmenszertifikat signieren, das
Sie von
Symantec/Microsoft erhalten haben. Optional: Sie können die
Windows-Phone-Version ggf. auch aus Quellen erstellen. Dazu benötigen Sie die neueste Version von
Microsoft Visual Studio.

### Spezifische Voraussetzungen für das Betriebssystem Microsoft Windows 8
{: #prerequisites-specific-to-microsoft-windows-8-operating-system }
Die Windows-8-Version des mobilen Clients wird als .zip-Archivdatei
bereitgestellt. Die Datei **IBMApplicationCenterWindowsStore.zip** enthält eine
ausführbare Datei (.exe) und die zugehörigen abhängigen .dll-Dateien (Dynamic Link Libraries). Laden Sie das Archiv an eine Position auf Ihrem lokalen Laufwerk herunter und führen Sie die
ausführbare Datei aus, um den Inhalt dieses Archivs zu verwenden. 

Optional: Sie können die
Windows-8-Version ggf. auch aus Quellen erstellen. Dazu benötigen Sie die neueste Version von
Microsoft Visual Studio.

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

## MobileFirst-Studio-basierter IBM Application-Center-Client
{: #mobilefirst-studio-based-ibm-appcenter-client }
Anstatt das Cordova-Projekt für iOS und Android zu verwenden, können Sie auch
das Vorgängerrelease des Application-Center-Clients verwenden,
das auf MobileFirst Studio 7.1 basiert und iOS, Android sowie Windows Phone unterstützt.

### Projekt importieren und erstellen (Android, iOS, Windows Phone)
{: #importing-and-building-the-project-android-ios-windows-phone }
Sie müssen das Projekt **IBMAppCenter** in
{{ site.data.keys.mf_studio }} importieren und dann erstellen.

> **Hinweis:** Verwenden Sie für Version 8.0.0 MobileFirst Studio 7.1. Sie können
MobileFirst Studio von der Seite [Downloads]({{site.baseurl}}/downloads) herunterladen. Installationsanweisungen finden Sie im IBM Knowledge Center für Version 7.1 unter [MobileFirst Studio installieren](https://www.ibm.com/support/knowledgecenter/SSHS8R_7.1.0/com.ibm.worklight.installconfig.doc/devenv/t_installing_ibm_worklight_studi.html).

1. Wählen Sie **Datei → Importieren** aus.
2. Wählen Sie **Allgemein → Vorhandenes Projekt in den Arbeitsbereich** aus.
3. Wählen Sie auf der nächsten Seite **Stammverzeichnis auswählen** aus und navigieren Sie zum Stammverzeichnis des Projekts **IBMAppCenter**.
4. Wählen Sie das Projekt **IBMAppCenter** aus. 
5. Wählen Sie **Projekte in Arbeitsbereich kopieren** aus. Bei Auswahl dieser Option wird eine Kopie des Projekts in Ihrem Arbeitsbereich erstellt. Auf
UNIX-Systemen ist das Projekt IBMAppCenter an der ursprünglichen Position schreibgeschützt. Durch das Kopieren von Projekten in den
Arbeitsbereich werden Probleme mit Dateiberechtigungen vermieden.
6. Klicken Sie auf **Fertigstellen**, um das Projekt **IBMAppCenter** in MobileFirst Studio zu importieren.

Erstellen Sie einen Build für das Projekt **IBMAppCenter**. Das MobileFirst-Projekt
enthält eine Anwendung mit dem Namen **AppCenter**.
Klicken Sie mit der rechten Maustaste auf die Anwendung und wählen
Sie **Ausführen als → Build All Environments** aus. 

#### Android
{: #android }
MobileFirst Studio generiert ein natives Android-Projekt in **IBMAppCenter/apps/AppCenter/android/native**. Ein natives ADT-Projekt
(Android Development Tools) befindet sich im Ordner
android/native. Sie können dieses Projekt mit den Android Development Tools kompilieren und signieren. Für dieses Projekt muss
das Android-SDK Level 16 installiert werden, damit das resultierende Anwendungspaket (APK) mit allen
Android-Versionen ab Version 2.3 kompatibel ist.
Wenn Sie beim Erstellen des Projekts ein höheres Level des Android-SDK auswählen, ist das resultierende Anwendungspaket (APK) nicht
mit Android Version 2.3 kompatibel.

Auf der [Android-Site für Entwickler](https://developer.android.com/index.html) finden Sie genauere Android-Informationen bezüglich des mobilen Clients.

Wenn Sie
Push-Benachrichtigungen für Anwendungsaktualisierungen aktivieren wollen, müssen Sie zuerst die Eigenschaften des Application-Center-Clients konfigurieren. Weitere Informationen
finden Sie unter [Push-Benachrichtigungen für Anwendungsaktualisierungen konfigurieren](../push-notifications).

#### iOS
{: #ios }
MobileFirst Studio generiert ein natives iOS-Projekt in **IBMAppCenter/apps/AppCenter/iphone/native**. Die Datei **IBMAppCenterAppCenterIphone.xcodeproj** befindet sich im Ordner iphone/native. Diese Datei ist das
Xcode-Projekt, das Sie mit Xcode kompilieren und signieren müssen.

Auf der [Apple-Site
für Entwickler](https://developer.apple.com/) erfahren Sie, wie die mobile iOS-Clientanwendung signiert wird. Zum Signieren einer iOS-Anwendung müssen Sie die Bundle-ID
der Anwendung durch eine Bundle-ID ersetzen, die mit Ihrem Bereitstellungsprofil verwendet werden kann. Der Wert ist in den
Xcode-Projekteinstellungen als **com.Name_Ihrer_Internetdomäne.appcenter** definiert. Hier steht **Name_Ihrer_Internetdomäne** für den Namen Ihrer Internetdomäne.

Wenn Sie
Push-Benachrichtigungen für Anwendungsaktualisierungen aktivieren wollen, müssen Sie zuerst die Eigenschaften des Application-Center-Clients konfigurieren. Weitere Informationen
finden Sie unter [Push-Benachrichtigungen für Anwendungsaktualisierungen konfigurieren](../push-notifications).

#### Windows Phone 8
{: #windows-phone-8 }
MobileFirst Studio generiert ein natives Windows-Phone-8-Projekt in **IBMAppCenter/apps/AppCenter/windowsphone8/native**.
Die Datei **AppCenter.csproj** befindet sich im Ordner windowsphone8/native. Diese Datei ist das
Visual-Studio-Projekt, das Sie mit Visual Studio und dem SDK für Windows Phone 8.0 kompilieren müssen.

Die Anwendung wird mit dem [SDK für Windows Phone 8.0](https://www.microsoft.com/en-in/download/details.aspx?id=35471) erstellt, sodass sie auf Geräten mit Windows Phone 8.0 und 8.1 ausgeführt werden kann. Sie wird nicht mit dem SDK für
Windows Phone 8.1 erstellt, weil sie dann nicht auf älteren Geräten mit
Windows Phone 8.0 ausgeführt werden könnte. 

Wenn Sie
Visual Studio 2013 installiert haben, können Sie zusätzlich zum SDK für Windows
Phone 8.1 das SDK von Version 8.0 zur Installation auswählen. Das SDK für Windows Phone 8.0
ist auch unter [Windows Phone SDK Archives](https://developer.microsoft.com/en-us/windows/downloads/sdk-archive) verfügbar.

Im
[Windows Phone Dev Center](https://developer.microsoft.com/en-us) erfahren Sie, wie die mobile
Windows-Phone-Clientanwendung erstellt und signiert wird.

#### Projektbuild für Microsoft Windows 8 erstellen
{: #microsoft-windows-8-building-the-project }
Das universelle Windows-8-Projekt wird als
Visual-Studio-Projekt in **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj** bereitgestellt.  
Sie müssen den Projektbuild für das Clientprojekt in Microsoft Visual Studio
2013 erstellen, um das Projekt verteilen zu können. 

Die Erstellung des Projektbuilds ist eine Voraussetzung für die Verteilung an Ihre Benutzer.
Die Windows-8-Anwendung kann nicht im Application Center implementiert und von dort aus verteilt werden.

Gehen Sie wie folgt vor, um den Projektbuild für Windows 8 zu erstellen:

1. Öffnen Sie die Visual-Studio-Projektdatei **IBMApplicationCenterWindowsStore\AppCenterClientWindowsStore.csproj** in Microsoft Visual Studio 2013.
2. Erstellen Sie einen vollständigen Anwendungsbuild.

Für die anschließende Verteilung des mobilen Clients an Ihre Application-Center-Benutzer können Sie
ein Installationsprogramm generieren, das die generierte ausführbare Datei
(.exe) und die zugehörigen abhängigen DLL-Dateien (Dynamic Link Libraries)
installiert. Alternativ können Sie diese Dateien bereitstellen, ohne sie in ein Installationsprogramm aufzunehmen.

####  Nativer IBM Application-Center-Client für Microsoft Windows 10 Universal
{: #microsoft-windows-10-universal-(native)-ibm-appcenter-client}

Der native IBM Application Center Client für Windows 10 Universal kann für die Installation universeller Windows-10-Apps auf Windows-10-Telefonen verwendet werden. Nutzen Sie **IBMApplicationCenterWindowsStore** für die Installation von
Windows-10-Apps auf dem Windows-Desktop.

#### Projektbuild für Microsoft Windows 10 Universal erstellen
{: #microsoft-windows-10-universal-building-the-project}

Das universelle Windows-10-Projekt wird als Visual-Studio-Projekt in **IBMAppCenterUWP\IBMAppCenterUWP.csproj** bereitgestellt.             
Sie müssen den Projektbuild für das Clientprojekt in Microsoft Visual Studio
2015 erstellen, um das Projekt verteilen zu können. 
>Die Erstellung des Projekts ist eine Vorbedingung für die Verteilung des Projekts an Benutzer.

Gehen Sie wie folgt vor, um den Projektbuild für Windows 10 Universal zu erstellen:
1.  Öffnen Sie die Visual-Studio-Projektdatei **IBMAppCenterUWP\IBMAppCenterUWP.csproj** in Microsoft Visual Studio 2015.
+ Erstellen Sie einen vollständigen Anwendungsbuild.
+ Führen Sie den folgenden Schritt aus, um die Datei **.appx** zu generieren: 
  * Klicken Sie mit der rechten Maustaste auf das Projekt und wählen Sie **Store → App-Pakete erstellen** aus.

## Funktionen anpassen (für Fachleute): Android, iOS, Windows Phone
{: #customizing-features-for-experts-android-ios-windows-phone }
Sie können Funktionen anpassen, indem Sie eine zentrale Eigenschaftendatei bearbeiten und einige andere Ressourcen modifizieren.
>Dies wird nur unter Android, iOS, Windows 8 (nur Windows-Store-Pakete) oder Windows Phone 8 unterstützt.


Anpassung von Features. Diverse Features werden von einer zentralen Eigenschaftendatei mit dem Namen
**config.json** im Verzeichnis
**IBMAppCenter/apps/AppCenter/common/js/appcenter/** oder **ApplicationCenter/installer/CordovaAppCenterClient/www/js/appcenter** gesteuert.
Wenn Sie das Standardverhalten einer Anwendung ändern möchten, können Sie diese Eigenschaftendatei vor dem Erstellen des Projekts
anpassen.

Diese Datei enthält die in der folgenden Tabelle angegebenen Eigenschaften.

| Eigenschaft | Beschreibung |
|----------|-------------|
| url | Fest codierte Adresse des Application-Center-Servers. Wenn diese Eigenschaft gesetzt ist, werden die Adressfelder der Anmeldeansicht nicht angezeigt. |
| defaultPort | Wenn die Eigenschaft url den Wert null hat,
trägt diese Eigenschaft den Wert des Feldes port in der Anmeldeansicht eines Telefons ein. Dies ist ein Standardwert.
Das Feld kann vom Benutzer bearbeitet werden. |
| defaultContext | Wenn die Eigenschaft url den Wert null hat,
trägt diese Eigenschaft den Wert des Feldes context in der Anmeldeansicht eines Telefons ein. Dies ist ein Standardwert.
Das Feld kann vom Benutzer bearbeitet werden. |
| ssl | Standardwert des SSL-Schalters in der Anmeldeansicht |
| allowDowngrade | Diese Eigenschaft gibt an, ob die Installation älterer Versionen autorisiert wird oder nicht.
Eine ältere Version kann nur installiert werden. wenn das Betriebssystem und die Version ein Downgrade zulassen. |
| showPreviousVersions | Diese Eigenschaft gibt an, ob der Gerätebenutzer die Details aller Anwendungsversionen oder nur Details der neuesten Version anzeigen kann. |
| showInternalVersion | Diese Eigenschaft gibt an, ob die interne Version angezeigt wird oder nicht. Wenn der Wert "false" lautet,
wird die interne Version nur angezeigt, wenn keine kommerzielle Version definiert ist. |
| listItemRenderer | Diese Eigenschaft kann einen der folgenden Werte haben:<br/>- **full**: Bei Verwendung dieses Standardwerts werden in den Anwendungslisten Name, Bewertung und neueste Version angezeigt.<br/>- **simple**: In den Anwendungslisten wird nur der Anwendungsname angezeigt. |
| listAverageRating | Diese Eigenschaft kann einen der folgenden Werte haben:<br/>-  **latestVersion**: In den Anwendungslisten sehen Sie die durchschnittliche Bewertung der neuesten Version der Anwendung.<br/>-  **allVersions**: In den Anwendungslisten sehen Sie die durchschnittliche Bewertung aller Versionen der Anwendung. |
| requestTimeout | Diese Eigenschaft gibt das Zeitlimit für Anfragen an den Application-Center-Server in Millisekunden an. |
| gcmProjectId | Google-API-Projekt-ID (Projektname = com.ibm.appcenter), die für
Android-Push-Benachrichtigungen erforderlich ist, z. B. 123456789012 |
| allowAppLinkReview | Diese Eigenschaft gibt an, ob lokale Rezensionen zu Anwendungen aus externen Application Stores im Application Center registriert
und angezeigt werden können. Diese lokalen Rezensionen sind im externen Application Store nicht sichtbar. Sie werden auf dem
Application-Center-Server gespeichert. |

### Weitere Ressourcen
{: #other-resources }
Weitere verfügbare Ressourcen sind Anwendungssymbole,
Anwendungsname, Bilder der Begrüßungsanzeige, Symbole und übersetzbare Ressourcen der Anwendung.

#### Anwendungssymbole
{: #application-icons }
* **Android:** Datei mit dem Namen **icon.png** in den Verzeichnissen unter **/res/drawable/Schwärzung** des Android-Studio-Projekts.
Es gibt für jeden Schwärzungsgrad ein Verzeichnis.
* **iOS:** Dateien mit dem Namen **iconsize.png** im Verzeichnis **Resources** des Xcode-Projekts
* **Windows Phone:** Dateien mit dem Namen **ApplicationIcon.png**, **IconicTileSmallIcon.png** und
**IconicTileMediumIcon.png** im Verzeichnis **native** des MobileFirst-Studio-Umgebugnsordners für Windows Phone
* **Windows 10 Universal:** Dateien mit dem Namen **Square\*Logo\*.png**, **StoreLogo.png** und **Wide\*Logo\*.png** im Verzeichnis **IBMAppCenterUWP/Assets** in Visual Studio


#### Anwendungsname
{: #application-name }
* **Android:** Bearbeiten Sie die Eigenschaft **app_name** in der Datei
**res/values/strings.xml** des Android-Studio-Projekts. 
* **iOS:** Bearbeiten Sie den Schlüssel **CFBundleDisplayName** in der Datei
**IBMAppCenterAppCenterIphone-Info.plist** des Xcode-Projekts. 
* **Windows Phone:** Bearbeiten Sie das Attribut **Title** des Eintrags "App" in
der Visual-Studio-Datei **Properties/WMAppManifest.xml**. 
* **Windows 10 Universal:** Bearbeiten Sie das Attribut **Title** des Eintrags "App" in der Visual-Studio-Datei **IBMAppCenterUWP/Package.appxmanifest** file.


#### Bilder der Begrüßungsanzeige
{: #splash-screen-images }
* **Android:** Bearbeiten Sie die Datei **splashimage.9.png**
in den Verzeichnissen **res/drawable/Schwärzung** des Android-Studio-Projekts. Es gibt für jeden Schwärzungsgrad ein Verzeichnis. Diese Datei ist eine Patch-9-Grafik.
* **iOS:** Dateien mit dem Namen **Default-size.png** im Verzeichnis **Resources** des Xcode-Projekts
* Begrüßungsanzeige von Cordova- bzw. MobileFirst-Studio-basierten Projekten während der automatischen Anmeldung: **js/idx/mobile/themes/common/idx/Launch.css**
* **Windows Phone:** Bearbeiten Sie die Datei **SplashScreenImage.png**
im Verzeichnis **native** des MobileFirst-Studio-Umgebungsordners für Windows Phone.
* **Windows 10 Universal:** Bearbeiten Sie die Dateien mit dem Namen **SplashScreen*.png**
im Verzeichnis **IBMAppCenterUWP/Assets** in Visual Studio.

#### Symbole der Anwendung (Schaltflächen, Sterne und ähnliche Objekte)
{: #icons }
**IBMAppCenter/apps/AppCenter/common/css/images**

#### Übersetzbare Ressourcen der Anwendung
{: #translatable-resources }
**IBMAppCenter/apps/AppCenter/common/js/appcenter/nls/common.js**

## Mobilen Client im Application Center implementieren
{: #deploying-the-mobile-client }
Implementieren Sie die verschiedenen Versionen der Clientanwendung im
Application Center.

Der mobile Client für
Windows 8 wird nicht im Application Center implementiert und nicht über das Application Center verteilt. Sie können den mobilen Client
für Windows 8 verteilen, indem Sie Benutzern ein gepacktes Archiv mit der ausführbaren Clientdatei
und den .dll-Dateien
(Dynamic Link Library) bereitstellen oder indem Sie ein ausführbares Installationsprogramm für den mobilen
Windows-8-Client erstellen. 

Die Android-, iOS-, Windows-Phone- und Windows-10-Universal-Version (Phone) des
mobilen Clients muss im Application Center
implementiert werden. Dazu müssen Sie die Dateien
des Android-Anwendungspakets (.apk), die iOS-Anwendungsdateien (.ipa),
die Windows-Phone-Anwendungsdateien (.xap) und die universellen Windows-10-Dateien (.appx) in das
Application Center hochladen. 

Führen Sie die im Artikel [Mobile Anwendung hinzufügen](../appcenter-console/#adding-a-mobile-application) beschriebenen Schritte aus, um die mobile Clientanwendung für Android, iOS, Windows Phone und Windows 10 hinzuzufügen.
Sie müssen die Anwendungseigenschaft "Installer" auswählen, um anzugeben, dass die Anwendung
ein Installationsprogramm ist. Bei Auswahl dieser Eigenschaft
können Benutzer mobiler Geräte die mobile Anwendung ohne großen Aufwand über eine Funkverbindung installieren. Lesen Sie zum Installieren des mobilen Clients die
Beschreibung der Aufgabe für die Version der mobilen Client-App für das entsprechende Betriebssystem.
