---
layout: tutorial
title: Protokollierung in iOS-Anwendungen
breadcrumb_title: Protokollierung in iOS
relevantTo: [ios]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Dieses Lernprogramm enthält die Code-Snippets, die erforderlich sind, um Protokollierungsfähigkeiten zu iOS-Anwendungen hinzuzufügen. 

**Voraussetzung:** Sie müssen die [Übersicht über die clientseitige Protokollerfassung](../) gelesen haben.

> **Hinweis:** Die Verwendung von `OCLogger` in Swift erfordert die Erstellung einer `OCLogger`-Erweiterungsklasse. (Diese Klasse kann eine gesonderte Swift-Datei oder eine Erweiterung Ihrer bestehenden Swift-Datei sein.)

```swift
extension OCLogger {
    // Protokollmethoden ohne Metadaten

    func logTraceWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_TRACE, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logDebugWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_DEBUG, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logInfoWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_INFO, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logWarnWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_WARN, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logErrorWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ERROR, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logFatalWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_FATAL, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    func logAnalyticsWithMessages(message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ANALYTICS, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }

    // Protokollmethoden mit Metadaten

    func logTraceWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_TRACE, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logDebugWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_DEBUG, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logInfoWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_INFO, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logWarnWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_WARN, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logErrorWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ERROR, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logFatalWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_FATAL, message: message, args:getVaList(args), userInfo:userInfo)
    }

    func logAnalyticsWithUserInfo(userInfo:Dictionary<String, String>, message:String, _ args: CVarArgType...) {
        logWithLevel(OCLogger_ANALYTICS, message: message, args:getVaList(args), userInfo:userInfo)
    }
}
```

Nach Aufnahme der Erweiterungsklasse können Sie `OCLogger` in Swift verwenden.

## Protokollerfassung aktivieren
{: #enabling-log-capture }
Die Protokollerfassung ist standardmäßig
aktiviert. Sie speichert Protokolle im Client und kann programmgesteuert aktiviert oder inaktiviert werden. Protokolle werden mit einem expliziten Sendeaufruf oder automatisch an den Server gesendet. 

> **Hinweis:** Die Aktivierung der Protokollerfassung auf einer Ebene mit großer Ausführlichkeit kann sich
auf die CPU-Nutzung des Geräts, auf den Dateisystemspeicher und den Umfang der Nutzdaten, die der Client mit den Protokollen über das Netz sendet, auswirken. Inaktivieren Sie die Protokollerfassung wie folgt: 

**Objective-C**

```objc
[OCLogger setCapture:NO];
```

**Swift**

```swift
OCLogger.setCapture(false);
```

## Erfasste Protokolle senden
{: #sending-captured-logs }
Sie können Protokolle gemäß Ihrer Anwendungslogik an {{ site.data.keys.product_adj }} senden. Sie können auch das automatische Senden von Protokollen aktivieren. Wenn Protokolle nicht vor dem Erreichen ihrer maximalen Größe gesendet werden, wird die Protokolldatei zugunsten aktuellerer Protokolle bereinigt. 

> **Hinweis:** Übernehmen Sie das folgende Muster für die Erfassung von Protokolldaten. Durch das regelmäßige Senden von Daten stellen Sie sicher, dass Sie Ihre Protokolldaten in der
{{ site.data.keys.mf_analytics_console }} annähernd in Echtzeit sehen.**Objective-C**

```objc
[NSTimer scheduledTimerWithTimeInterval:60
  target:[OCLogger class]
  selector:@selector(send)
  userInfo:nil
  repeats:YES];
```

**Swift**

```swift
var timer = NSTimer.scheduledTimerWithTimeInterval(60,
  target:OCLogger.self,
  selector: #selector(OCLogger.send),
  userInfo: nil,
  repeats: true)
```

Mit folgenden Strategien können Sie sicherstellen, dass alle erfassten Protokolle gesendet werden: 

* Rufen Sie die Methode `send` in einem bestimmten Zeitintervall auf. 
* Rufen Sie die Methode `send` innerhalb von Callbacks zu Lebenszyklusereignissen auf. 
* Erhöhen Sie den Wert für die maximale Größe des persistenten Protokollpuffers (in Bytes).

**Objective-C**

```objc
[OCLogger setMaxFileSize:150000];

```

**Swift**

```swift
OCLogger.setMaxFileSize(150000);
```

## Protokolle automatisch senden
{: #auto-log-sending }
Das automatische Senden von Protokollen ist standardmäßig inaktiviert. Immer, wenn eine Ressourcenanforderung erfolgreich an den Server gesendet wird, werden auch die erfassten Protokolle gesendet, wobei zwischen den Sendevorgängen ein zeitlicher Abstand von mindestens 60 Sekunden liegen muss. Das automatische Senden von Protokollen kann vom Client aktiviert oder inaktiviert werden. Standardmäßig ist das automatische Senden von Protokollen inaktiviert. 

**Objective-C**

Aktivierung: 

```objc
[OCLogger setAutoSendLogs:YES];
```

Inaktivierung: 

```objc
[OCLogger setAutoSendLogs:NO];
```

**Swift**

Aktivierung: 

```swift
OCLogger.setAutoSendLogs(true);
```

Inaktivierung: 

```swift
OCLogger.setAutoSendLogs(false);
```

## Optimierung mit der Logger-API
{: #fine-tuning-with-the-logger-api }
Das {{ site.data.keys.product_adj }}-Client-SDK
nutzt intern die Logger-API. Vom SDK erstellte Protokolleinträge werden standardmäßig erfasst. Zur Optimierung der Protokollerfassung können Sie
Logger-Instanzen mit Paketnamen verwenden. Mit serverseitigen Filtern können Sie außerdem die Protokollierungsstufe
steuern.


### Objective-C
{: #objective-c}
Wenn Sie beispielsweise für das Paket `myApp` nur Protokolle der Stufe `ERROR` erfassen möchten, gehen Sie wie folgt vor: 

1. Verwenden Sie eine `Logger`-Instanz mit dem Paketnamen `myApp`. 

   ```objc
   OCLogger *logger = [OCLogger getInstanceWithPackage:@"MyApp"];
   ```

2. **Bei Bedarf** können Sie einen Filter angeben, um die Protokollerfassung und -ausgabe programmgesteuert auf die angegebene Stufe und das angegebene Paket zu beschränken. 

   ```objc
   [OCLogger setFilters:@{@"MyApp": @(OCLogger_ERROR)}];
   ```

3. **Optional:** Steuern Sie die Filter über Fernzugriff. Rufen Sie dazu ein Serverkonfigurationsprofil ab. 

### Swift
{: #swift }
1. Erstellen Sie eine Logger-Instanz für Ihr Paket. Verwenden Sie dazu die Erweiterung wie in der Übersicht erläutert. 

   ```swift
   let logger : OCLogger = OCLogger.getInstanceWithPackage("MyTestLoggerPackage");
   ```

2. **Optional:** GebenSie eine Protokollierungsstufe an. 

   ```swift
   OCLogger.setLevel(OCLogger_DEBUG);
   ```

3. **Optional:** Steuern Sie die Filter über Fernzugriff. Rufen Sie dazu ein Serverkonfigurationsprofil ab. 

## Serverkonfigurationsprofile abrufen
{: #fetching-server-configuration-profiles }
Die Protokollierungsstufen können vom Client festgelegt werden
oder über das Abrufen von Konfigurationsdateien vom Server. In der
{{ site.data.keys.mf_analytics_console }} kann eine Protokollierungsstufe global
(für alle Logger-Instanzen) oder für bestimmte Pakete festgelegt werden. Informationen zum KOnfigurieren der Filter in der {{ site.data.keys.mf_analytics_console }} finden Sie unter [Protokollfilter konfigurieren](../../../analytics/console/log-filters/).

Damit der Client die Konfiguration vom Server
abruft, muss die Methode
`updateConfigFromServer`
von einem Abschnitt des Codes aufgerufen werden, der regulär ausgeführt wird, z. B. von den App-Lebenszyklus-Callbacks. 

**Objective-C**

```objc
[OCLogger updateConfigFromServer];
```

**Swift**

```swift
 OCLogger.updateConfigFromServer();
 ```

## Protokollierungsbeispiel
{: #logging-example }
Die Ausgabe erfolgt in einem Browser in einer JavaScript-Konsole, in LogCat oder in der Xcode-Konsole. 

#### Objective-C
{: #objective-c-example }

```objc
#import "OCLogger.h"
+ (int) sum:(int) a with:(int) b{
    int sum = a + b;
    [OCLogger setLevel:DEBUG];
    OCLogger* mathLogger = [OCLogger getInstanceWithPackage:@"MathUtils"];
    NSString* logMessage = [NSString stringWithFormat:@"sum called with args %d and %d. Returning %d", a, b, sum];
    [mathLogger debug:logMessage];
    return sum;
}
```

### Swift
{: #swift-logging }

```swift
func sum(a: Int, b: Int) -> Int{
    var sum = a + b;
    let logger = OCLogger.getInstanceWithPackage("MathUtils");

    logger.logInfoWithMessages("sum called with args /(a) and /(b). Returning /(sum)");
    return sum;
}
```
