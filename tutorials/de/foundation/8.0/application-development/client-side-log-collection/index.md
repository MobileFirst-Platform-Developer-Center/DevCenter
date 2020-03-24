---
layout: tutorial
title: Clientseitige Protokollerfassung
breadcrumb_title: Clientseitige Protokollerfassung
relevantTo: [ios,android,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Für die Protokollierung wird der Quellcode so instrumentiert, dass mithilfe von API-Aufrufen Nachrichten aufgezeichnet werden, die Diagnose und Debug erleichtern. Die {{ site.data.keys.product_full }} stellt zu diesem Zweck eine Reihe von API-Methoden für die Protokollierung bereit. 

Die {{ site.data.keys.product_adj }}-`Logger`-API ist mit allgemein verwendeten Logger-APIs wie `console.log` (JavaScript), `java.util.logging` (Java) und `NSLog` (Objective-C) vergleichbar und
hat zusätzlich die Fähigkeit, protokollierte Daten persistent zu erfassen, damit sie an {{ site.data.keys.mf_server }}
gesendet werden können, wo sie für Analysen zusammengestellt und von Entwicklern untersucht werden können. Verwenden Sie die
`Logger`-APIs, um Daten der jeweils angemessenen Protokollebenen zu dokumentieren, sodass Entwickler, die die Protokolle prüfen, Probleme sichten und korrigieren können, ohne in ihrem Labor Probleme reproduzieren zu müssen.

#### Verfügbarkeit
{: #availability }
Die von {{ site.data.keys.product_adj }} bereitgestellten `Logger`-API-Methoden können mit iOS-, Android-, Web- und Cordova-Anwendungen genutzt werden. 

## Protokollierungsstufen
{: #logging-levels }
Die Protokollierungsbibliotheken stellen in der Regel Steuerelemente für die Ausführlichkeit bereit, die häufig auch als **Stufen** bezeichnet werden.   
Es gibt die folgenden Protokollierungsstufen (von der größten bis zur geringsten Ausführlichkeit): 

* TRACE - für Ein- und Austrittspunkte von Methoden
* DEBUG - für die Ergebnisausgabe von Methoden
* LOG - für die Klasseninstanziierung
* INFO - für die Initialisierung der Berichterstellung
* WARN - für die Protokollierung von Warnungen zur Verwendung veralteter Elemente
* ERROR - für unerwartete Ausnahmen
* FATAL - für nicht behebbare Abstürze oder Blockierungen

> **Hinweis:** Bei Verwendung von FATAL wird ein App-Absturz erfasst. Es wird empfohlen, diees Schlüsselwort nicht zu verwenden, um eine Verzerrung der App-Absturzdaten zu vermeiden.



Die Client-SDKs sind standardmäßig mit der Ausführlichkeitsebene FATAL konfiguriert. Es werden also kaum oder gar
keine unformatierten Debugprotokolle ausgegeben oder erfasst. Sie können die Ausführlichkeit programmgestützt angepasst werden oder durch das Festlegen eines Konfiguationsprofils in der
{{ site.data.keys.mf_analytics_console }}, das von Ihrer App explizit abgerufen werden muss. 

### Protokollierung von Clientanwendungen
{: #logging-from-client-applications }
* [Protokollierung in JavaScript-Anwendungen (Cordova-Anwendungen, Webanwendungen)](javascript/)
* [Protokollierung in iOS-Anwendungen](ios/)
* [Protokollierung in Android-Anwendungen](android/)

### Ausführlichkeit der Protokolle anpassen
{: #adjusting-log-verbosity }
Wenn die Protokollierungsstufe über die Konfiguration des Clients oder durch das Abrufen des Serverprofils
definiert ist, filtert der Client die von ihm gesendeten Protokollierungsnachrichten. Wenn eine Nachricht unterhalb des Schwellenwertes explizit gesendet wird, ignoriert der Cient diese Nachricht. 

Gehen Sie beispielsweise wie folgt vor, um die Ausführlichkeit
auf DEBUG zu setzen:

#### iOS
{: #ios}
**Objective-C**

```objc
[OCLogger setLevel:OCLogger_DEBUG];
```

**Swift**

```swift
 OCLogger.setLevel(OCLogger_DEBUG);
 ```

#### Android
{: #android }
```java
Logger.setLevel(Logger.LEVEL.DEBUG);
```

#### JavaScript (Cordova)
{: #javascript-cordova }
```javascript
WL.Logger.config({ level: 'DEBUG' });
```

#### JavaScript (Web)
{: #javascript-web }
Bei Verwendung des Web-SDK kann die Standardstufe "trace" nicht vom Client geändert werden.

## Absturzerfassung
{: #crash-capture }
Das {{ site.data.keys.product_adj }}-Client-SDK erfasst für Android- und iOS-Anwendungen bei einem Absturz einen Stack-Trace und protokolliert den Absturz auf der Ebene FATAL. Diese Art von Absturz ist ein echter Absturz, bei dem die Benutzerschnittstelle nicht mehr für den Benutzer angezeigt wird. Für Cordova-Anwendungen werden globale JavaScript-Fehler und nach Möglichkeit ein JavaScript-Aufruf-Stack erfasst und auf der Ebene FATAL protokolliert. Diese Art von Absturz ist kein Absturzereignis. Diese Art von Absturz kann sich negativ auf die Benutzererfahrung in der Laufzeit auswirken, was aber nicht zwingend der Fall sein muss. 

Abstürze, nicht abgefangene Ausnahmen und globale Fehler werden automatisch abgefangen und protokolliert, sobald die App wieder aktiv ist. 

## Protokolle anzeigen
{: #viewing-the-logs }
Die erfassten und an den Server gesendeten Protokolle können Sie in der {{ site.data.keys.mf_analytics_console }} anzeigen. Wählen Sie in der Navigationsleiste
die Anzeige **Apps** aus und klicken Sie auf das Register **Clientprotokollsuche**. 

![Protokolle suchen und anzeigen](consoleViewClientLogs.png)
