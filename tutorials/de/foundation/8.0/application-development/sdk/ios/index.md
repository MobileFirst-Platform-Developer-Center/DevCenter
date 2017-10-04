---
layout: tutorial
title: MobileFirst-Foundation-SDK zu iOS-Anwendungen hinzufügen
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Das MobileFirst-Foundation-SDK
besteht aus einer Reihe von Abhängigkeiten, die über [CocoaPods](http://guides.cocoapods.org) verfügbar sind und zu einem Xcode-Projekt hinzugefügt werden können.   
Die Pods entsprechen Kernfunktionen und anderen Funktionen:  

* **IBMMobileFirstPlatformFoundation** - Implementiert Client-Server-Konnektivität, handhabt Authentifizierungs- und Sicherheitsaspekte, Ressourcenanforderungen und weitere erforderliche Kernfunktionen
* **IBMMobileFirstPlatformFoundationJSONStore** - Enthält das JSONStore-Framework. Weitere Informationen enthält das Lernprogramm [JSONStore für iOS](../../jsonstore/ios/).
* **IBMMobileFirstPlatformFoundationPush** - Enthält das Framework für Push-Benachrichtigungen. Weitere Informationen enthalten die Lernprogramme zu [Benachrichtigungen](../../../notifications/).
* **IBMMobileFirstPlatformFoundationWatchOS** - Enthält Unterstützung für Apple WatchOS

In diesem Lernprogramm erfahren Sie, wie das native MobileFirst-SDK mithilfe von CocoaPods
zu einer neuen oder vorhandenen iOS-Anwendung hinzugfügt wird. Sie werden auch lernen,
wie {{ site.data.keys.mf_server }} konfiguriert werden muss, um die Anwendung zu erkennen.

**Voraussetzungen:**

- Xcode und die MobileFirst CLI sind auf der Entwicklerworkstation installiert.   
- Eine lokale oder ferne Instanz von {{ site.data.keys.mf_server }} ist aktiv. 
- Sie haben die Lernprogramme [MobileFirst-Entwicklungsumgebung einrichten](../../../installation-configuration/development/mobilefirst)
und [iOS-Entwicklungsumgebung einrichten](../../../installation-configuration/development/ios) durchgearbeitet. 

> **Hinweis:** Das **Keychain Sharing** ist obligatorisch, wenn Sie Xcode 8 verwenden und iOS-Apps in einem Simulator ausführen.



#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Natives MobileFirst-SDK hinzufügen](#adding-the-mobilefirst-native-sdk)
- [Natives MobileFirst-SDK manuell hinzufügen](#manually-adding-the-mobilefirst-native-sdk)
- [Unterstützung für Apple watchOS hinzufügen](#adding-support-for-apple-watchos)
- [Natives MobileFirst-SDK aktualisieren](#updating-the-mobilefirst-native-sdk)
- [Generierte Artefakte des nativen MobileFirst-SDK](#generated-mobilefirst-native-sdk-artifacts)
- [Bitcode und TLS 1.2](#bitcode-and-tls-12)
- [Nächste Lernprogramme](#tutorials-to-follow-next)

## Natives {{ site.data.keys.product_adj }}-SDK hinzufügen
{: #adding-the-mobilefirst-native-sdk }
Folgen Sie den nachstehenden Anweisungen, um das native {{ site.data.keys.product }}-SDK
zu einem neuen oder vorhandenen Xcode-Projekt hinzuzufügen und die Anwendung bei {{ site.data.keys.mf_server }} zu registrieren.

Vergewissern Sie sich als Erstes, dass der {{ site.data.keys.mf_server }} aktiv
ist.   
Wenn Sie einen lokal installierten Server verwenden,
navigieren Sie in einem **Befehlszeilenfenster** zum Serverordner und führen Sie den Befehl
`./run.sh` aus.

### Anwendung erstellen
{: #creating-an-application }
Erstellen Sie ein Xcode-Projekt oder verwenden Sie ein vorhandenes Projekt (Swift oder Objective-C).  

### SDK hinzufügen
{: #adding-the-sdk }
1. Das native SDK der {{ site.data.keys.product }} wird über CocoaPods bereitgestellt.
    - Wenn [CocoaPods](http://guides.cocoapods.org) bereits in Ihrer Entwicklungsumgebung installiert ist, fahren Sie mit Schritt 2 fort. 
    - Wenn CocoaPods nicht installiert ist, gehen Sie wie folgt vor:   
        - Öffnen Sie ein **Befehlszeilenfenster** und navigieren Sie zum Stammverzeichnis des Xcode-Projekts. 
        - Führen Sie den Befehl `sudo gem install cocoapods` und dann `pod setup` aus. **Hinweis:** Dies Ausführung dieser Befehle kann einige Zeit dauern. 
2. Führen Sie den Befehl `pod init` aus. Damit wird eine `Podfile` erstellt.
3. Öffnen Sie die `Podfile` in Ihrem bevorzugten Codeeditor.
    - Löschen Sie den Dateiinhalt oder setzen Sie ihn auf Kommentar. 
    - Fügen Sie die folgenden Zeilen hinzu und speichern Sie die Änderungen: 

      ```xml
use_frameworks!

platform :ios, 8.0
      target "Xcode-project-target" do
          pod 'IBMMobileFirstPlatformFoundation'
      end
      ```
      - Ersetzen Sie **Xcode-project-target** durch den Namen Ihres Xcode-Projektziels. 

4. Führen Sie im Befehlszeilenfenster den Befehl `pod install` und dann den Befehl `pod update` aus. Mit diesen Befehlen werden die Dateien des nativen SDK der {{ site.data.keys.product }} und die Datei **mfpclient.plist** hinzugefügt. Außerdem wird ein Pod-Projekt erstellt.  
    **Hinweis:** Die Ausführung der Befehle kann einige Zeit dauern. 

    > <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Wichtiger Hinweis**:
Ab jetzt können Sie die Datei `[Projektname].xcworkspace` verwenden, um das Projekt in Xcode zu öffnen. Verwenden Sie **nicht**
die Datei `[Projektname].xcodeproj`. Ein CocoaPods-basiertes Projekt wird als ein Arbeitsbereich verwaltet, der die (ausführbare Datei der) Anwendung und die Bibliothek
enthält. (Alle Projektabhängigkeiten werden vom CocoaPods-Manager mit Pull übertragen.)

### Natives {{ site.data.keys.product_adj }}-SDK manuell hinzufügen
{: #manually-adding-the-mobilefirst-native-sdk }
Sie können das SDK der {{ site.data.keys.product }} auch manuell hinzufügen: 

<div class="panel-group accordion" id="adding-the-sdk-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="ios-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>Für Anweisungen hier klicken</b></a>
                                </h4>
        </div>

        <div id="collapse-ios-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ios-sdk">
            <div class="panel-body">
                <p>Wenn Sie das SDK der {{ site.data.keys.product }} manuell hinzufügen möchten, müssen Sie zunächst über das Download-Center der {{ site.data.keys.mf_console }} die SDK-ZIP-Datei auf der Registerkarte <b>SDKs</b> herunterladen.</p>

                <ul>
                    <li>Fügen Sie die {{ site.data.keys.product }}-Dateien zu Ihrem Xcode-Projekt hinzu.<ul>
                            <li>Wählen Sie im Projektexplorer das Symbol für das Projektstammverzeichnis aus.</li>
                            <li>Wählen Sie <b>File → Add Files</b> aus und navigieren Sie zu dem Ordner mit den zuvor heruntergeladenen Frameworkdateien.</li>
                            <li>Klicken Sie auf die Schaltfläche <b>Options</b>.</li>
                            <li>Wählen Sie <b>Copy items if needed</b> und <b>Create groups for any added folders</b> aus.<br/>
                            <b>Hinweis:</b> Wenn Sie die Option <b>Copy items if needed</b> nicht auswählen, werden die Frameworkdateien nicht kopiert, aber an ihrer Ursprungsposition verlinkt.</li>
                            <li>Wählen Sie das Hauptprojekt aus (erste Option) und das App-Ziel.</li>
                            <li>Entfernen Sie auf der Registerkarte <b>General</b> alle Frameworks, die automatisch zum Abschnitt <b>Linked Frameworks and Libraries</b> hinzugefügt werden würden.</li>
                            <li>Erforderlich: Fügen Sie unter <b>Embedded Binaries</b> die folgenden Frameworks hinzu:
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundation.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationOpenSSLUtils.framework</li>
                                    <li>IBMMobileFirstPlatformFoundationWatchOS.framework</li>
                                </ul>
                                Bei Ausführung dieses Schrittes werden diese Frameworks automatisch zum Abschnitt <b>Linked Frameworks and Libraries</b> hinzugefügt.
                            </li>
                            <li>Fügen Sie unter <b>Linked Frameworks and Libraries</b> die folgenden Frameworks hinzu:
                                <ul>
                                    <li>IBMMobileFirstPlatformFoundationJSONStore.framework</li>
                                    <li>sqlcipher.framework</li>
                                    <li>openssl.framework</li>
                                    <li>Localizations.bundle</li>
                                </ul>
                            </li>
                            <blockquote><b>Hinweis:</b> Mit diesen Schritten werden die relevanten MobileFirst-Platform-Foundation-Frameworks zu Ihrem Projekt hinzugefügt und in der Liste Link Binary with Libraries auf der Registerkarte Build Phases verlinkt. Wenn Sie die Dateien mit ihrer Ursprungsposition verlinken (ohne wie oben beschrieben die Option Copy items if needed auszuwählen), müssen Sie die Suchpfade für Frameworks (Framework Search Paths) wie unten angegeben definieren.</blockquote>
                        </ul>
                    </li>
                    <li>Die in Schirtt 1 hinzugefügten Frameworks würden automatisch zum Abschnitt <b>Link Binary with Libraries</b> der Registerkarte <b>Build Phases</b> hinzugefügt werden.</li>
                    <li><i>Optional:</i> Wenn Sie die Frameworkdateien nicht wie oben beschrieben in Ihr Projekt kopiert haben, verwenden Sie die Option <b>Copy items if needed</b> auf der Registerkarte <b>Build Phases</b> und führen Sie die folgenden Schritte aus.
                        <ul>
                            <li>Öffnen Sie die Seite <b>Build Settings</b>. </li>
                            <li>Suchen Sie den Abschnitt <b>Search Paths</b>. </li>
                            <li>Fügen Sie zum Ordner <b>Framework Search Paths</b> den Pfad zu dem Ordner mit den Frameworks hinzu. </li>
                        </ul>
                    </li>
                    <li>Wählen Sie im Abschnitt <b>Deployment</b> der Registerkarte <b>Build Settings</b> für das Feld <b>iOS Deployment Target</b> einen Wert größer-gleich 8.0 aus.</li>
                    <li><i>Optional:</i> Ab Xcode 7 ist Bitcode als Standard festgelegt. Informationen zu Einschränkungen und Voraussetzungen finden Sie unter <a href="additional-information/#working-with-bitcode-in-ios-apps">Arbeiten mit Bitcode in iOS-Apps</a>. Sie können Bitcode wie folgt inaktivieren:
                        <ul>
                            <li>Öffnen Sie den Abschnitt <b>Build Options</b>.</li>
                            <li>Setzen Sie <b>Enable Bitcode</b> auf <b>No</b>.</li>
                        </ul>
                    </li>
                    <li>Ab Xcode 7 muss TLS umgesetzt werden (siehe <a href="additional-information/#enforcing-tls-secure-connections-in-ios-apps">TLS-gesicherte Verbindungen in iOS-Apps erzwingen</a>).</li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#ios-sdk" data-target="#collapse-ios-sdk" aria-expanded="false" aria-controls="collapse-ios-sdk"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>

### Anwendung registrieren
{: #registering-the-application }
1. Öffnen Sie ein **Befehlszeilenfenster** und navigieren Sie zum Stammverzeichnis des Xcode-Projekts.   

2. Führen Sie den folgenden Befehl aus: 

    ```bash
    mfpdev app register
    ```
    - Wenn ein ferner Server verwendet wird, fügen Sie ihn mit dem [Befehl `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) hinzu.

    Sie werden aufgefordert, die Bundle-ID anzugeben. **Wichtiger Hinweis**: Bei der Bundle-ID muss die **Groß-/Kleinschreibung beachtet** werden.  

Der CLI-Befehl `mfpdev app register` stellt zunächst eine Verbindung zu
{{ site.data.keys.mf_server }} her, um die Anwendung zu generieren.
Anschließend wird die Datei **mfpclient.plist** im Stammverzeichnis des Xcode-Projekts generiert,
zu der Metadaten, die den {{ site.data.keys.mf_server }} angeben, hinzugefügt werden.  

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Sie können
Anwendungen auch über die {{ site.data.keys.mf_console }} registrieren:    
>
> 1. Laden Sie die {{ site.data.keys.mf_console }}.
> 2. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**, um eine neue Anwendung zu registrieren. Folgen Sie den angezeigten Anweisungen.   
> 3. Navigieren Sie nach der Anwendungsregistrierung zum Anwendungsregister **Konfigurationsdateien** und kopieren Sie die Datei **mfpclient.plist** laden Sie diese Datei herunter. Folgen Sie den angezeigten Anweisungen, um die entsprechende Datei zu Ihrem Projekt hinzuzufügen.

### Setup-Prozess abschließen
{: #completing-the-setup-process }
Klicken Sie in Xcode mit der rechten Maustaste auf den Projekteintrag und wählen Sie **Add Files To [Projektname]** aus.
Wählen Sie dann die Datei **mfpclient.plist** im Stammverzeichnis des Xcode-Projekts aus. 

### SDK referenzieren
{: #referencing-the-sdk }
Wenn Sie das native {{ site.data.keys.product }}-SDK verwenden möchten, müssen Sie das Framework der {{ site.data.keys.product }} importieren: 

Objective-C:

```objc
#import <IBMMobileFirstPlatformFoundation/IBMMobileFirstPlatformFoundation.h>
```

Swift:

```swift
import IBMMobileFirstPlatformFoundation
```

<br>
#### Hinweis zu iOS ab Version 9:
{: #note-about-ios-9-and-above }
> Ab Xcode 7 ist [Application Transport Security (ATS)](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14) standardmäßig aktiviert. Sie können ATS während der Entwicklung für die Ausführung von Apps inaktivieren. ([Lesen Sie hier mehr](http://iosdevtips.co/post/121756573323/ios-9-xcode-7-http-connect-server-error).)
>   1. Klicken Sie in Xcode mit der rechten Maustaste auf **[Projekt]/info.plist → Open As → Source Code**.
>   2. Fügen Sie Folgendes ein:
>
```xml
>      <key>NSAppTransportSecurity</key>
>      <dict>
>            <key>NSAllowsArbitraryLoads</key>
>            <true/>
>      </dict>
```

## Unterstützung für Apple watchOS hinzufügen
{: #adding-support-for-apple-watchos}
Wenn Sie für Apple watchOS ab Version 2 entwickeln, muss die Podfile Abschnitte entsprechend der Haupt-App und der watchOS-Erweiterung enthalten. Es folgt ein Beispiel für
watchOS 2:

```xml
# Durch den Namen Ihrer watchOS-Anwendung ersetzen
xcodeproj 'MyWatchApp'

use_frameworks!

# Namen des iOS-Ziels verwenden
target :MyWatchApp do
    platform :ios, 9.0
    pod 'IBMMobileFirstPlatformFoundation'
    end

# Namen des watch-Erweiterungsziels verwenden
target :MyWatchApp WatchKit Extension do
    platform :watchos, 2.0
    pod 'IBMMobileFirstPlatformFoundation'
end
```

Vergewissern Sie sich, dass das Xcode-Projekt geschlossen ist, und führen Sie den Befehl `pod install` aus. 

## Natives {{ site.data.keys.product_adj }}-SDK aktualisieren
{: #updating-the-mobilefirst-native-sdk }
Wenn Sie das native SDK der {{ site.data.keys.product }} auf den neuesten Releasestand bringen wollen,
führen Sie in einem **Befehlszeilenfenster** im Stammverzeichnis des Xcode-Projekts den folgenden Befehl aus: 

```bash
pod update
```

SDK-Releases sind im [CocoaPods-Repository](https://cocoapods.org/?q=ibm%20mobilefirst) für das jeweilige SDK enthalten.

## Generierte Artefakte des nativen {{ site.data.keys.product_adj }}-SDK
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
In dieser Datei, die sich im Stammverzeichnis des Projekts befindet, sind die clientseitigen Eigenschaften für die Registrierung Ihrer
iOS-App bei {{ site.data.keys.mf_server }}
definiert.

| Eigenschaft| Beschreibung | Beispielwerte |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol | Protokoll für die Kommunikation mit {{ site.data.keys.mf_server }} | http oder https |
| host | Hostname von {{ site.data.keys.mf_server }} | 192.168.1.63 |
| port | Port von {{ site.data.keys.mf_server }} | 9080 |
| wlServerContext | Kontextstammverzeichnis der Anwendung auf dem {{ site.data.keys.mf_server }} | /mfp/ |
| languagePreferences | Legt die Standardsprache für Client-SDK-Systemnachrichten fest | en |

## Bitcode und TLS 1.2
{: #bitcode-and-tls-12 }
Informationen zur Unterstützung für Bitcode und TLS 1.2 finden Sie auf der Seite [Zusätzliche Informationen](additional-information). 

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Jetzt, da das native {{ site.data.keys.product }}-SDK integriert ist, können Sie Folgendes tun: 

- Gehen Sie die Lernprogramme zu [SDKs der {{ site.data.keys.product }}](../) durch. 
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../../adapters/) durch. 
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../../authentication-and-security/) durch. 
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../../notifications/) durch. 
- Sehen Sie sich [alle Lernprogramme](../../../all-tutorials) an. 
