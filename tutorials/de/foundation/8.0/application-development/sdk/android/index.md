---
layout: tutorial
title: MobileFirst-Foundation-SDK zu Android-Anwendungen hinzufügen
breadcrumb_title: Android
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Das SDK der {{ site.data.keys.product_full }}
besteht aus einer Reihe von Abhängigkeiten, die über [Maven Central](http://search.maven.org/) verfügbar sind und zu einem Android-Studio-Projekt hinzugefügt werden können. Die Abhängigkeiten entsprechen Kernfunktionen und anderen Funktionen:  

* **IBMMobileFirstPlatformFoundation** - Implementiert Client-Server-Konnektivität, handhabt Authentifizierungs- und Sicherheitsaspekte, Ressourcenanforderungen und weitere erforderliche Kernfunktionen
* **IBMMobileFirstPlatformFoundationJSONStore** - Enthält das JSONStore-Framework. Weitere Informationen enthält das Lernprogramm [JSONStore für Andoid](../../jsonstore/android/).
* **IBMMobileFirstPlatformFoundationPush** - Enthält das Framework für Push-Benachrichtigungen. Weitere Informationen enthalten die Lernprogramme zu [Benachrichtigungen](../../../notifications/).

In diesem Lernprogramm erfahren Sie, wie das native {{ site.data.keys.product_adj }}-SDK mithilfe von Gradle
zu einer neuen oder vorhandenen Android-Anwendung hinzugfügt wird. Sie werden auch lernen,
wie {{ site.data.keys.mf_server }} konfiguriert werden muss, um die Anwendung zu erkennen.
Außerdem erfahren Sie, wie Sie Informationen zu den {{ site.data.keys.product_adj }}-Konfigurationsdateien, die zum Projekt hinzugefügt werden, finden können. 

**Voraussetzungen:**

- Android Studio und die {{ site.data.keys.mf_cli }} sind auf der Entwicklerworkstation installiert.   
- Eine lokale oder ferne Instanz von {{ site.data.keys.mf_server }} ist aktiv. 
- Sie haben die Lernprogramme [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/development/mobilefirst)
und [Android-Entwicklungsumgebung einrichten](../../../installation-configuration/development/android) durchgearbeitet. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Natives {{ site.data.keys.product_adj }}-SDK hinzufügen](#adding-the-mobilefirst-native-sdk)
- [Natives {{ site.data.keys.product_adj }}-SDK manuell hinzufügen](#manually-adding-the-mobilefirst-native-sdk)
- [Natives {{ site.data.keys.product_adj }}-SDK aktualisieren](#updating-the-mobilefirst-native-sdk)
- [Generierte Artefakte des nativen {{ site.data.keys.product_adj }}-SDK](#generated-mobilefirst-native-sdk-artifacts)
- [Unterstützung für Javadoc und den Android-Service](#support-for-javadoc-and-android-service)
- [Nächste Lernprogramme](#tutorials-to-follow-next)

## Natives {{ site.data.keys.product_adj }}-SDK hinzufügen
{: #adding-the-mobilefirst-native-sdk }
Folgen Sie den nachstehenden Anweisungen, um das native {{ site.data.keys.product_adj }}-SDK
zu einem neuen oder vorhandenen Android-Studio-Projekt hinzuzufügen und die Anwendung bei der MobileFirst-Server-Instanz zu registrieren.

Vergewissern Sie sich als Erstes, dass {{ site.data.keys.mf_server }} aktiv
ist.   
Wenn Sie einen lokal installierten Server verwenden,
navigieren Sie in einem **Befehlszeilenfenster** zum Serverordner und führen Sie den Befehl
`./run.sh` für ein Mac- oder Linux-Betriebssystem bzw. `run.cmd` für Windows aus. 

### Android-Anwendung erstellen
{: #creating-an-android-application }
Erstellen Sie ein Android-Studio-Projekt oder verwenden Sie ein vorhandenes Projekt.   

### SDK hinzufügen
{: #adding-the-sdk }
1. Wählen Sie unter **Android → Gradle Scripts** die Datei
**build.gradle (Module: app)** aus. 

2. Fügen Sie unter `apply plugin: 'com.android.application'` die folgenden Zeilen hinzu:



   ```xml
   repositories{
        jcenter()
   }
   ```

3. Fügen Sie im Abschnitt `android` die folgende Zeile hinzu: 

   ```xml
   packagingOptions {
        pickFirst 'META-INF/ASL2.0'
        pickFirst 'META-INF/LICENSE'
        pickFirst 'META-INF/NOTICE'
   }
   ```

4. Fügen Sie im Abschnitt `dependencies` die folgenden Zeilen hinzu:

   ```xml
   compile group: 'com.ibm.mobile.foundation',
   name: 'ibmmobilefirstplatformfoundation',
   version: '8.0.+',
   ext: 'aar',
   transitive: true
   ```

   Oder in einer einzelnen Zeile:

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.+'
   ```

5. Öffnen Sie unter **Android → app → manifests** die Datei `AndroidManifest.xml`. Fügen Sie Folgendes über dem Element **application** hinzu: 

   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
   ```

6. Fügen Sie die {{ site.data.keys.product_adj }}-Benutzerschnittstellenaktivität neben dem vorhandenen Element **activity** hinzu: 

   ```xml
   <activity android:name="com.worklight.wlclient.ui.UIActivity" />
   ```

> Wenn eine Gradle-Synchronisationsaufforderung angezeigt wird, stimmen Sie zu. 

### Natives {{ site.data.keys.product_adj }}-SDK manuell hinzufügen
{: #manually-adding-the-mobilefirst-native-sdk }
Sie können das SDK der {{ site.data.keys.product_adj }} auch manuell hinzufügen: 

<div class="panel-group accordion" id="adding-the-sdk-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>Für Anweisungen hier klicken</b></a>
            </h4>
        </div>

        <div id="collapse-android-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk">
            <div class="panel-body">
                <p>Wenn Sie das {{ site.data.keys.product_adj }}-SDK manuell hinzufügen möchten, müssen Sie zunächst über das Download-Center der {{ site.data.keys.mf_console }} die SDK-ZIP-Datei auf der Registerkarte <b>SDKs</b> herunterladen. Wenn Sie die obigen Schritte ausgeführt haben, gehen Sie wie nachfolgend beschrieben vor. </p>

                <ul>
                    <li>Entpacken Sie die heruntergeladene ZIP-Datei und stellen Sie die relevanten aar-Dateien in den Ordner <b>app\libs</b>.</li>
                    <li>Fügen Sie am Ende von <b>dependencies</b> Folgendes hinzu:
{% highlight xml %}
compile(name:'ibmmobilefirstplatformfoundation', ext:'aar')
compile 'com.squareup.okhttp3:okhttp-urlconnection:3.4.1'   
compile 'com.squareup.okhttp3:okhttp:3.4.1'
{% endhighlight %}
                    </li>
                    <li>Fügen Sie am Ende von <b>repositories</b> Folgendes hinzu:
{% highlight xml %}
repositories {
    flatDir {
        dirs 'libs'
    }
}
{% endhighlight %}
                    </li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>Abschnitt schließen</b></a>
            </div>
        </div>
    </div>
</div>



### Anwendung registrieren
{: #registering-the-application }
1. Öffnen Sie ein **Befehlszeilenfenster** und navigieren Sie zum Stammverzeichnis des Android-Studio-Projekts.   

2. Führen Sie den folgenden Befehl aus: 

    ```bash
    mfpdev app register
    ```
    - Wenn ein ferner Server verwendet wird, fügen Sie ihn mit dem [Befehl `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) hinzu.

Der CLI-Befehl `mfpdev app register` stellt zunächst eine Verbindung zu
{{ site.data.keys.mf_server }} her, um die Anwendung zu registrieren.
Anschließend wird die Datei **mfpclient.properties** im Ordner **[Projektstammverzeichnis]/app/src/main/assets/**
des Android-Studio-Projekts generiert. Zu der Datei werden Metadaten hinzugefügt, die den
{{ site.data.keys.mf_server }} angeben.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Tipp:** Sie können
Anwendungen auch über die {{ site.data.keys.mf_console }} registrieren:    
>
> 1. Laden Sie die {{ site.data.keys.mf_console }}.  
> 2. Klicken Sie neben **Anwendungen** auf die Schaltfläche **Neu**, um eine neue Anwendung zu registrieren. Folgen Sie den angezeigten Anweisungen.   
> 3. Navigieren Sie nach der Anwendungsregistrierung zum Anwendungsregister **Konfigurationsdateien** und kopieren Sie die Datei **mfpclient.properties** laden Sie diese Datei herunter. Folgen Sie den angezeigten Anweisungen, um die entsprechende Datei zu Ihrem Projekt hinzuzufügen. 

### WLClient-Instanz erstellen
{: #creating-a-wlclient-instance }
Erstellen Sie eine `WLClient`-Instanz, bevor Sie {{ site.data.keys.product_adj }}-APIs verwenden. 

```java
WLClient.createInstance(this);
```

**Hinweis:** Eine `WLClient`-Instanz
sollte im gesamten Anwendungslebenszyklus nur einmal erstellt werden. Es wird empfohlen, dafür die Android-Application-Klasse zu verwenden. 

## Natives {{ site.data.keys.product_adj }}-SDK aktualisieren
{: #updating-the-mobilefirst-native-sdk }
Wenn Sie das native {{ site.data.keys.product_adj }}-SDK auf den neuesten Releasestand
bringen möchten, suchen Sie die neueste Releaseversion und aktualisdieren Sie die Eigenschaft `version` in der Datei **build.gradle** entsprechend.   
(Vergleichen Sie dazu oben Schritt 4.) 

SDK-Releases sind im [JCenter-Repository](https://bintray.com/bintray/jcenter/com.ibm.mobile.foundation%3Aibmmobilefirstplatformfoundation/view#) für das jeweilige SDK enthalten.

## Generierte Artefakte des nativen {{ site.data.keys.product_adj }}-SDK
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.properties
{: #mfpclient.properties }
Diese Datei befindet sich im Ordner **./app/src/main/assets/** des Android-Studio-Projekts. Sie
enthält die clientseitigen Eigenschaften für die Registrierung Ihrer
Android-App bei {{ site.data.keys.mf_server }}. 

| Eigenschaft | Beschreibung | Beispielwerte |
|---------------------|---------------------------------------------------------------------|----------------|
| wlServerProtocol | Protokoll für die Kommunikation mit {{ site.data.keys.mf_server }} | http oder https |
| wlServerHost | Hostname von {{ site.data.keys.mf_server }} | 192.168.1.63 |
| wlServerPort | Port von {{ site.data.keys.mf_server }} | 9080 |
| wlServerContext | Kontextstammverzeichnis der Anwendung auf dem {{ site.data.keys.mf_server }} | /mfp/ |
| languagePreferences | Legt die Standardsprache für Client-SDK-Systemnachrichten fest | en |

## Unterstützung für Javadoc und den Android-Service
{: #support-for-javadoc-and-android-service }
Informationen zur Unterstützung für Javadoc und den Android-Service finden Sie auf der Seite [Zusätzliche Informationen](additional-information). 

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Jetzt, da das native {{ site.data.keys.product_adj }}-SDK integriert ist, können Sie Folgendes tun: 

- Gehen Sie die Lernprogramme zu [SDKs der {{ site.data.keys.product }}](../) durch. 
- Gehen Sie die Lernprogramme zur [Adapterentwicklung](../../../adapters/) durch. 
- Gehen Sie die Lernprogramme zu [Authentifizierung und Sicherheit](../../../authentication-and-security/) durch. 
- Gehen Sie die Lernprogramme zu [Benachrichtigungen](../../../notifications/) durch. 
- Sehen Sie sich [alle Lernprogramme](../../../all-tutorials) an. 
