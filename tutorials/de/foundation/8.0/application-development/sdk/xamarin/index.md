---
layout: tutorial
title: MobileFirst-Foundation-SDK zu Xamarin-Anwendungen hinzufügen
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview
Das SDK der {{ site.data.keys.product }} besteht aus einer Reihe von Abhängigkeiten, die in ein NuGet-Paket gepackt sind, das Sie mit dem [Nuget Package Manager](https://www.nuget.org/packages?q=mobilefirst) zu Ihrem Xamarin-Projekt hinzufügen können.

Die Pakete entsprechen Kernfunktionen und anderen Funktionen:  

* **IBM.MobileFirstPlatformFoundation** - Enthält MobileFirst-Client-SDK-Bibliotheken, die die Client-Server-Konnektivität implementieren und zusammen mit dem JSONStore-Framework Authentifizierungs- und Sicherheitsaspekte, Ressourcenanforderungen und andere erforderliche Kernfunktionen handhaben.
 
* **IBM.MobileFirstPlatformFoundationPush** - Enthält das Framework für Push-Benachrichtigungen. Weitere Informationen enthalten die Lernprogramme zu [Benachrichtigungen](../../../notifications/).

In diesem Lernprogramm erfahren Sie, wie das native {{ site.data.keys.product_adj }}-SDK mit dem NuGet Package Manager zu einer neuen oder vorhandenen Xamarin-Android- oder Xamarin-iOS-Anwendung hinzugefügt wird. Sie werden auch lernen,
wie {{ site.data.keys.mf_server }} konfiguriert werden muss, um die Anwendung zu erkennen.

**Voraussetzungen:**

- Visual Studio 2017 für Mac OS ist auf der Entwicklerworkstation installiert.
- Visual Studio 2015 oder Visual Studio 2017 (Community Version) für Windows ist auf der Entwicklerworkstation installiert. Sie dürfen nicht die Express Edition von Visual Studio verwenden. Sollte das der Fall sein, führen Sie ein Update auf eine Community Edition durch.  
- Eine lokale oder ferne Instanz von {{ site.data.keys.mf_server }} ist aktiv. 
- Sie haben die Lernprogramme
[{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/development/)
und [Xamarin-Entwicklungsumgebung einrichten](../../../installation-configuration/development/xamarin/) durchgearbeitet. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Natives {{ site.data.keys.product_adj }}-SDK hinzufügen](#adding-the-mobilefirst-native-sdk)
- [Natives {{ site.data.keys.product_adj }}-SDK aktualisieren](#updating-the-mobilefirst-native-sdk)
- [Nächste Lernprogramme](#tutorials-to-follow-next)

## Natives {{ site.data.keys.product_adj }}-SDK hinzufügen
{: #adding-the-mobilefirst-native-sdk }
Folgen Sie den nachstehenden Anweisungen, um das native {{ site.data.keys.product_adj }}-SDK
zu einem neuen oder vorhandenen Xcode-Projekt hinzuzufügen und die Anwendung bei {{ site.data.keys.mf_server }} zu registrieren.

Vergewissern Sie sich als Erstes, dass der {{ site.data.keys.mf_server }} aktiv
ist.   
Wenn Sie einen lokal installierten Server verwenden,
navigieren Sie in einem **Befehlszeilenfenster** zum Serverordner und führen Sie den Befehl
`./run.sh` aus.

### Anwendung erstellen
{: #creating-an-application }
Erstellen Sie in Xamarin Studio oder Visual Studio eine Xamarin-Lösung oder verwenden Sie eine bereits bestehende Lösung. 

### SDK hinzufügen
{: #adding-the-sdk }
1. Das native {{ site.data.keys.product_adj }}-SDK wird über die NuGet Gallery bzw. das NuGet Repository bereitgestellt.
2. Verwenden Sie für den Import von {{ site.data.keys.product_adj }}-Paketen den NuGet Package Manager. NuGet ist ein Paketmanager für die Microsoft-Entwicklungsplattform, einschließlich .NET. Mit den NuGet-Client-Tools können Sie Pakete erzeugen und verwenden. Die NuGet Gallery ist das zentrale Paketrepository, das alle Ersteller und Nutzer von Paketen verwenden. Klicken Sie mit der rechten Maustaste auf das Paketverzeichnis und wählen Sie "Add Packages" aus. Suchen Sie dann mit der Suchoption nach *IBM MobileFirst Platform*. Wählen Sie **IBM.MobileFirstPlatformFoundation** aus.
![SDK von nuget.org hinzufügen]({{site.baseurl}}/assets/xamarin-tutorials/add-package1.png)
3. Klicken Sie auf "Add Packages". Mit dieser Aktion werden das native SDK der {{ site.data.keys.product }} und die zugehörigen Abhängigkeiten installiert.
![SDK von nuget.org hinzufügen]({{site.baseurl}}/assets/xamarin-tutorials/add-package2.png)


### Anwendung registrieren
{: #registering-the-application }
1. Laden Sie die {{ site.data.keys.mf_console }}.
2. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**, um eine neue Anwendung zu registrieren. Folgen Sie den angezeigten Anweisungen. 
3. Android- und iOS-Anwendungen müssen gesondert registriert werden. Dadurch wird sichergestellt, dass sowohl eine Android- als auch eine iOS-Anwendung erfolgreich eine Verbindung zum Server herstellen kann. Die Registrierungsdetails für Android- und iOS-Anwendungen finden Sie jeweils in den Dateien `AndroidManifest.xml` und `Info.plist`. 
3. Navigieren Sie nach der Anwendungsregistrierung zum Anwendungsregister "Konfigurationsdateien" und kopieren Sie die Dateien `mfpclient.plist` und `mfpclient.properties` bzw. laden Sie diese Dateien herunter. Folgen Sie den angezeigten Anweisungen, um die entsprechende Datei zu Ihrem Projekt hinzuzufügen. 

### Setup-Prozess abschließen
{: #completing-the-setup-process }
#### mfpclient.plist
{: #complete-setup-mfpclientplist }
1. Klicken Sie mit der rechten Maustaste auf das Xamarin-iOS-Projekt und wählen Sie **Add files..** aus.
Navigieren Sie zum Stammverzeichnis des Projekts und suchen Sie die Datei `mfpclient.plist`. Wenn Sie dazu aufgefordert werden, wählen Sie **Copy file to project** aus.
2. Klicken Sie mit der rechten Maustaste auf die Datei `mfpclient.plist` und wählen Sie **Build action** aus. Wählen Sie **Content** aus.

#### mfpclient.properties
{: #mfpclientproperties }
1. Klicken Sie mit der rechten Maustaste auf den Ordner *Assets* des Xamarin-Android-Projekts und wählen Sie **Add files..** aus. Navigieren Sie zur Datei `mfpclient.properties`. Wenn Sie dazu aufgefordert werden, wählen Sie **Copy file to project** aus.
2. Klicken Sie mit der rechten Maustaste auf die Datei `mfpclient.properties` und wählen Sie **Build action** aus. Wählen Sie **Android asset** aus.

### SDK referenzieren
{: #referencing-the-sdk }
Wenn Sie das native {{ site.data.keys.product_adj }}-SDK verwenden möchten, müssen Sie das Framework der {{ site.data.keys.product }} importieren: 

CommonProject:

```csharp
using Worklight;
```

iOS:

```csharp
using MobileFirst.Xamarin.iOS;
```

Android:

```csharp
using Worklight.Xamarin.Android;
```

## Natives {{ site.data.keys.product_adj }}-SDK aktualisieren
{: #updating-the-mobilefirst-native-sdk }
Wenn Sie das native {{ site.data.keys.product_adj }}-SDK auf den neuesten Releasestand bringen möchten, aktualisieren Sie die SDK-Version über die Nuget Gallery.

## Generierte Artefakte des nativen {{ site.data.keys.product_adj }}-SDK
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
In dieser Datei sind die clientseitigen Eigenschaften für die Registrierung Ihrer
iOS-App bei {{ site.data.keys.mf_server }}
definiert.

| Eigenschaft |Beschreibung |Beispielwerte |
|---------------------|---------------------------------------------------------------------|----------------|
|protocol |Protokoll für die Kommunikation mit {{ site.data.keys.mf_server }} |http oder https |
|host |Hostname von {{ site.data.keys.mf_server }} |192.168.1.63 |
|port |Port von {{ site.data.keys.mf_server }} |9080 |
|wlServerContext |Kontextstammverzeichnis der Anwendung auf dem {{ site.data.keys.mf_server }} |/mfp/ |
|languagePreferences |Legt die Standardsprache für Client-SDK-Systemnachrichten fest |en |

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Jetzt, da das native {{ site.data.keys.product_adj }}-SDK integriert ist, können Sie Folgendes tun: 

- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../../adapters/) durch. 
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../../authentication-and-security/) durch. 
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../../notifications/) durch. 
- Sehen Sie sich [alle Lernprogramme](../../../all-tutorials) an. 
