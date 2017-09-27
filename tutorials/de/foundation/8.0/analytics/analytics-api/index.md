---
layout: tutorial
title: Analytics-API in Clientanwendungen verwenden
breadcrumb_title: Analytics-API
relevantTo: [ios,android,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

{{ site.data.keys.mf_analytics_full }} stellt clientseitige APIs bereit, die dem Benutzer den Einstieg in die Erfassung von Analysedaten zur Anwendung erleichtern sollen. In diesem Lernprogramm erfahren Sie, wie
die Analyseunterstützung für die Clientanwendung eingerichtet wird. Darüber hinaus informiert Sie das Lernprogramm über verfügbare APIs. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Analytics auf der Clientseite konfigurieren](#configuring-analytics-on-the-client-side)
* [Analysedaten senden](#sending-analytics-data)
* [Clientereignisse aktivieren/inaktivieren](#enablingdisabling-client-event-types)
* [Kundenspezifische Ereignisse](#custom-events)
* [Benutzer verfolgen](#tracking-users)

## Analytics auf der Clientseite konfigurieren
{: #configuring-analytics-on-the-client-side }

Bevor Sie mit der Erfassung der in
{{ site.data.keys.mf_analytics }} vordefinierten Daten beginnen können, müssen Sie die entsprechenden
Bibliotheken für die Initialisierung der Analytics-Unterstützung importieren. 

### JavaScript (Cordova)
{: #javascript-cordova }

In Cordova-Anwendungen ist kein Setup erforderlich. Die Initialisierung erfolgt integriert.   

### JavaScript (Web)
{: #javascript-web }

In Webanwendungen müssen die Analytics-JavaScript-Dateien referenziert werden. Vergewissern Sie sich, dass das
{{ site.data.keys.product_adj }}-Web-SDK hinzugefügt wurde. Weitere Informationen enthält das Lernprogramm
[{{ site.data.keys.product_adj }}-SDK zu Webanwendungen hinzufügen](../../application-development/sdk/web).   

Wählen Sie in Abhängigkeit davon, wie Sie das {{ site.data.keys.product_adj }}-Web-SDK hinzugefügt haben, eine der folgenden Vorgehensweisen: 


Referenzieren Sie {{ site.data.keys.mf_analytics }} im Element `HEAD`: 

```html
<head>
    ...
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics.js"></script>
    <script type="text/javascript" src="node_modules/ibm-mfp-web-sdk/ibmmfpf.js"></script>
</head>
```

Wenn Sie RequireJS verwenden, schreiben Sie Folgendes: 

```javascript
require.config({
	'paths': {
		'ibmmfpfanalytics': 'node_modules/ibm-mfp-web-sdk/lib/analytics/ibmmfpfanalytics',
		'mfp': 'node_modules/ibm-mfp-web-sdk/ibmmfpf'
	}
});

require(['ibmmfpfanalytics','mfp'], function(ibmmfpfanalytics, WL) {
    // Anwendungslogik
});
```

Sie können "ibmmfpfanalytics" durch Ihren eigenen Naspace ersetzen.


```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

 **Wichtiger Hinweis**: Die JavaScript-APIs von Cordova und Web-SDKs unterscheiden sich. Lesen Sie hierzu den Abschnitt
[API Reference](../../api/) in
der Benutzerdokumentation. 

### iOS
{: #ios }

#### WLAnalytics-Bibliothek importieren
{: #importing-the-wlanalytics-library }

**Objective-C**

```objc
import "WLAnalytics.h"
```

**Swift**

```Swift
import IBMMobileFirstPlatformFoundation
```

#### Analytics initialisieren
{: #initialize-analytics-ios }

**Objective-C**  
Es ist kein Setup erforderlich. Analytics ist standardmäßig bereits initialisiert. 

**Swift**  
Rufen Sie vor anderen Methoden der Klasse **WLAnalytics** die Methode `WLAnalytics.sharedInstance()` auf.

### Android
{: #android }

#### WLAnalytics importieren
{: #import-wlanalytics }

```java
import com.worklight.common.WLAnalytics;
```

#### Analytics initialisieren
{: #initialize-analytics-android }

Nehmen Sie in die Methode `onCreate` Ihrer Hauptaktivität Folgendes auf: 

```java
WLAnalytics.init(this.getApplication());
```


## Clientereignistypen aktivieren/inaktivieren
{: #enablingdisabling-client-event-types }

Durch die Analytics-API hat der Anwendungsentwickler die Freiheit,
die Erfassung von Analysedaten für Ereignisse, die in
der {{ site.data.keys.mf_analytics_console }} dargestellt werden sollen, zu aktivieren oder zu inaktivieren.

Mit der API von {{ site.data.keys.mf_analytics }}
können Sie die folgenden Metriken erfassen: 

* **Lebenszyklusereignisse**: App-Nutzungshäufigkeit und -Nutzungsdauer, Häufigkeit von App-Abstürzen
* **Netzverwendung**: Aufgliederung zur Häufigkeit von API-Aufrufen und Netzleistungsmetriken
* **Benutzer**: Benutzer der App, die über eine angegebene Benutzer-ID identifiziert werden können
* **Kundenspezifische Analysen**: vom App-Entwickler definierte, kundenspezifische Schlüssel-Wert-Paare

Die Initialisierung der
Analytics-API muss auch für Cordova-Apps in nativem Code geschrieben sein. 

 * Für die Erfassung der App-Nutzung müssen Sie vor dem Eintreten der relevanten App-Lebenszyklusereignisse und vor dem Senden der Daten an den Server Listener für diese Ereignisse registrieren. 
 * Für die Verwendung von Dateisystemfeatures oder nativen Sprach- und Gerätefeatures muss die API initialisiert werden. Wenn die API so verwendet wird, dass native Gerätefeatures (wie das Dateisystem) erforderlich sind,
und die API ohne vorherige Initialisierung aufgerufen wird, schlägt der Aufruf fehl. Dieses Verhalten ist insbesondere unter
Android zu beobachten.

**Hinweis**: Für die Erstellung von
Cordova-Anwendungen gibt es in der JavaScript-Analytics-API keine Methoden, um die Erfassung von
Lebenszyklus- oder Netzereignissen (`LIFECYCLE` oder `NETWORK`) zu aktivieren oder zu inaktivieren. Bei Cordova-Anwendungen sind die Ereignisse
`LIFECYCLE` und `NETWORK` standardmäig vorab aktiviert. Falls Sie diese Ereignisse inaktivieren möchten,
lesen Sie die Informationen unter [Clientlebenszyklusereignisse](#client-lifecycle-events) und
[Clientnetzereignisse](#client-lifecycle-events).

### Clientlebenszyklusereignisse
{: #client-lifecycle-events }

Wenn das Analytics-SDK konfiguriert ist, werden auf dem Gerät des Benutzers App-Sitzungen aufgezeichnet. Wenn
die App vom Vordergrund in den Hintergrund gelangt, wird in der
{{ site.data.keys.mf_analytics_console_short }} eine Sitzung erstellt, die in {{ site.data.keys.mf_analytics }} aufgezeichnet wird. 

Wenn das Gerät für die Aufzeichnung von Sitzungen konfiguriert ist und Sie Ihre Daten senden,
wird die {{ site.data.keys.mf_analytics_console_short }} mit Daten gefüllt (siehe unten). 

![Sitzungsdiagramm](analytics-app-sessions.png)

Mit der {{ site.data.keys.mf_analytics_short }}-API können Sie die Erfassung von App-Sitzungen aktivieren oder inaktivieren.

#### JavaScript
{: #javascript-lifecycle-events }

**Web**  
Initialisieren Sie Analytics wie folgt, um Clientlebenszyklusereignisse zu verwenden: 

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
Wenn die Erfassung von Lebenszyklusereignissen aktiviert werden soll, muss sie auf der nativen Plattform der Cordova-App initialisiert werden. 

* iOS-Plattform: 
	* Öffnen Sie den Ordner **[Cordova-Anwendungsstammverzeichnis] → platforms → ios → Classes** und suchen Sie
die Datei **AppDelegate.m** (Objective-C) oder **AppDelegate.swift** (Swift). 
	* Folgen Sie dem nachstehenden Leitfaden für iOS, um Lebenszyklusaktivitäten (`LIFECYCLE`) zu aktivieren oder zu inaktivieren. 
	* Führen Sie für die Erstellung des Cordova-Projekts den Befehl `cordova build` aus.

* Android-Plattform: 
	* Öffnen Sie die Datei **[Cordova-Anwendungsstammverzeichnis] → platforms → android → src → com → sample → [App-Name] → MainActivity.java**. 
	* Suchen Sie die Methode `onCreate` und folgen Sie dem nachstehenden Leitfaden für Android, um
Lebenszyklusaktivitäten (`LIFECYCLE`) zu aktivieren oder zu inaktivieren. 
	* Führen Sie für die Erstellung des Cordova-Projekts den Befehl `cordova build` aus.

#### Android
{: #android-lifecycle-events }

Aktivieren Sie wie folgt die Protokollierung von Clientlebenszyklusereignissen: 

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

Inaktivieren Sie wie folgt die Protokollierung von Clientlebenszyklusereignissen: 

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.LIFECYCLE);
```

#### iOS
{: #ios-lifecycle-events }

Aktivieren Sie wie folgt die Protokollierung von Clientlebenszyklusereignissen: 

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:LIFECYCLE];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

Inaktivieren Sie wie folgt die Protokollierung von Clientlebenszyklusereignissen: 

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:LIFECYCLE];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(LIFECYCLE);
```

### Clientnetzaktivitäten
{: #client-network-activities }

Die Erfassung für Adapter und das Netz wird auf dem Client und auf dem Server durchgeführt. 

* Der Client erfasst Informationen wie die Umlaufzeit und das Nutzdatenvolumen, wenn Sie mit der Erfassung des Gerätenetzereignissen (`NETWORK`) beginnen. 

* Der Server erfasst Back-End-Daten wie die Serververarbeitungszeit, die Adapternutzung und die verwendeten Prozeduren. 

Da Client und Server jeweils eigene Daten erfassen, werden Diagramme erst angezeigt, wenn der Client entsprechend konfiguriert wurde. Für die Konfiguration Ihres Clients müssen Sie mit
der Erfassung von Gerätenetzereignissen (`NETWORK`) beginnen und die Daten an den Server senden. 

#### JavaScript
{: #javascript }

**Web**  
Initialisieren Sie Analytics wie folgt, um Clientnetzereignisse zu verwenden: 

```javascript
ibmmfpfanalytics.logger.config({analyticsCapture: true});
```

**Cordova**  
Wenn die Erfassung von Netzereignissen aktiviert werden soll, muss sie auf der nativen Plattform der Cordova-App initialisiert werden. 

* iOS-Plattform: 
	* Öffnen Sie den Ordner **[Cordova-Anwendungsstammverzeichnis] → platforms → ios → Classes** und suchen Sie
die Datei **AppDelegate.m** (Objective-C) oder **AppDelegate.swift** (Swift). 
	* Folgen Sie dem nachstehenden Leitfaden für iOS, um Netzaktivitäten (`NETWORK`) zu aktivieren oder zu inaktivieren. 
	* Führen Sie für die Erstellung des Cordova-Projekts den Befehl `cordova build` aus.

* Navigieren Sie auf der Android-Plattform zu der zu inaktivierenden Unteraktivität der Hauptaktivität. 
	* Öffnen Sie die Datei **[Cordova-Anwendungsstammverzeichnis] → platforms → ios → src → com → sample → [App-Name] → MainActivity.java**. 
	* Suchen Sie die Methode `onCreate` und folgen Sie dem nachstehenden Leitfaden für Android, um
Netzaktivitäten (`NETWORK`) zu aktivieren oder zu inaktivieren. 
	* Führen Sie für die Erstellung des Cordova-Projekts den Befehl `cordova build` aus.

#### iOS
{: #ios-network-activities }

Aktivieren Sie wie folgt die Protokollierung von Clientnetzereignissen: 

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] addDeviceEventListener:NETWORK];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().addDeviceEventListener(NETWORK);
```

Inaktivieren Sie wie folgt die Protokollierung von Clientnetzereignissen: 

**Objective-C:**

```objc
[[WLAnalytics sharedInstance] removeDeviceEventListener:NETWORK];
```

**Swift:**

```swift
WLAnalytics.sharedInstance().removeDeviceEventListener(NETWORK);
```

#### Android
{: #android-network-activities }

Aktivieren Sie wie folgt die Protokollierung von Clientnetzereignissen: 

```java
WLAnalytics.addDeviceEventListener(DeviceEvent.NETWORK);
```

Inaktivieren Sie wie folgt die Protokollierung von Clientnetzereignissen: 

```java
WLAnalytics.removeDeviceEventListener(DeviceEvent.NETWORK);
```

## Kundenspezifische Ereignisse
{: #custom-events }

Mit den folgenden API-Methoden können Sie kundenspezifische Ereignisse erstellen. 

#### JavaScript (Cordova)
{: #javascript-cordova-custom-events }

```javascript
WL.Analytics.log({"key" : 'value'});
```

#### JavaScript (Web)
{: #javascript-web-custom-events }

Bei Verwendung der Web-API werden kundenspezifische Daten mit der Methode
`addEvent`
gesendet. 

```javascript
ibmmfpfanalytics.addEvent({'Purchases':'radio'});
ibmmfpfanalytics.addEvent({'src':'App landing page','target':'About page'});
```

#### Android
{: #android-custom-events }

Wenn Sie die beiden ersten Konfigurationen erstellt haben, können Sie mit der Protokollierung von Daten wie im folgenden Beispiel beginnen: 

```java
JSONObject json = new JSONObject();
try {
    json.put("key", "value");
} catch (JSONException e) {
    // TODO automatisch generierter Catch-Block
    e.printStackTrace();
}

WLAnalytics.log("Message", json);
```

#### iOS
{: #ios-custom-events }

Nach dem Import von WLAnalytics können Sie die API wie folgt für die Erfassung kundenspezifischer Daten verwenden: 

**Objective-C:**

```objc
NSDictionary *inventory = @{
    @"property" : @"value",
};

[[WLAnalytics sharedInstance] log:@"Custom event" withMetadata:inventory];
[[WLAnalytics sharedInstance] send];
```

**Swift:**

```swift
let metadata: [NSObject: AnyObject] = ["foo": "bar"];  
WLAnalytics.sharedInstance().log("hello", withMetadata: metadata);
```

## Benutzer verfolgen
{: #tracking-users }

Verwenden Sie für die Verfolgung einzelner Benutzer die Methode `setUserContext`. 

#### Cordova
{: #cordova-tracking-users }

Nicht unterstützt

#### Webanwendungen
{: #web-applications }

```javascript
ibmmfpfanalytics.setUserContext(user);
```

#### iOS
{: #ios-tracking-users }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] setUserContext:@"John Doe"];
```

**Swift**

```swift
WLAnalytics.sharedInstance().setUserContext("John Doe")
```

#### Android
{: #android-tracking-users }

```java
WLAnalytics.setUserContext("John Doe");
```

Wenn Sie einzelne Benutzer nicht verfolgen möchten, verwenden Sie die Methode `unsetUserContext`. 

#### Cordova
{: #cordova-untracking-users }

Nicht unterstützt

#### Webanwendungen
{: #web-applications-untracking-users }

Es gibt keine Methode `unsetUserContext` im {{ site.data.keys.product_adj }}-Web-SDK. Die Benutzersitzung endet nach 30 Minuten Inaktivität, sofern nicht
`ibmmfpfanalytics.setUserContext(user)` erneut aufgerufen wird. 

#### iOS
{: #ios-untracking-users }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] unsetUserContext];
```

**Swift**

```swift
WLAnalytics.sharedInstance().unsetUserContext
```

#### Android
{: #android-untracking-users }

```java
WLAnalytics.unsetUserContext();
```

## Analysedaten senden
{: #sending-analytics-data }

Das Senden von Analysedaten ist der entscheidende Schritt, wenn in Analytics Server cleintseitige Analysen angezeigt werden sollen. Wenn die Daten für die konfigurierten
Ereignistypen von Analytics erfasst wurden, werden die Anlyseprotokolle in einer Protokolldatei auf dem Clientgerät gespeichert. Die Daten aus der Datei werden
mit der Methode `send` der Analytics-API an {{ site.data.keys.mf_analytics_server }} gesendet. 

Sie sollten die erfassten Protokolle regelmäßig an den Server senden. Durch das Senden der Daten in regelmäßigen Abständen stellen Sie sicher,
dass Sie in der
{{ site.data.keys.mf_analytics_console }} aktuelle Analysedaten sehen.

#### JavaScript (Cordova)
{: #javascript-cordova-sending-data }

Verwenden Sie in einer Cordova-Anwendung die folgende JavaScript-API-Methode: 

```javascript
WL.Analytics.send();
```

#### JavaScript (Web)
{: #javascript-web-sending-data }

Verwenden Sie in einer Webanwendung (abhängig vom ausgewählten Namespace) die folgende JavaScript-API-Methode: 

```javascript
ibmmfpfanalytics.send();
```

#### iOS
{: #ios-sending-data }

**Objective-C**

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```swift
WLAnalytics.sharedInstance().send();
```

#### Android
{: #android-sending-data }

Verwenden Sie in einer Android-Anwendung die folgende Java-API-Methode: 

```java
WLAnalytics.send();
```
