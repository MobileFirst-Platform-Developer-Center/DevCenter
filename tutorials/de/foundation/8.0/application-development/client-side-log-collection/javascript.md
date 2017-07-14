---
layout: tutorial
title: Protokollierung in JavaScript-Anwendungen (Cordova, Web)
breadcrumb_title: Protokollierung in JavaScript
relevantTo: [javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Dieses Lernprogramm enthält die Code-Snippets, die erforderlich sind, um Protokollierungsfähigkeiten zu JavaScript-Anwendungen (Cordova, Web) hinzuzufügen. 

**Voraussetzung:** Sie müssen die [Übersicht über die clientseitige Protokollerfassung](../) gelesen haben.

## Protokollerfassung aktivieren
{: #enabling-log-capture }
Die Protokollerfassung ist standardmäßig
aktiviert. Sie speichert Protokolle im Client und kann programmgesteuert aktiviert oder inaktiviert werden. Protokolle werden mit einem expliziten Sendeaufruf oder automatisch an den Server gesendet. 

> **Hinweis:** Die Aktivierung der Protokollerfassung auf einer Ebene mit großer Ausführlichkeit kann sich
auf die CPU-Nutzung des Geräts, auf den Dateisystemspeicher und den Umfang der Nutzdaten, die der Client mit den Protokollen über das Netz sendet, auswirken. Inaktivieren Sie die Protokollerfassung wie folgt: 

### Cordova
{: #cordova }
```javascript
WL.Logger.config({capture: false});
```

### Web
{: #web }
```javascript
ibmmfpfanalytics.logger.enable(false);
```

## Erfasste Protokolle senden
{: #sending-captured-logs }
Sie können Protokolle gemäß Ihrer Anwendungslogik an {{ site.data.keys.product_adj }} senden. Sie können auch das automatische Senden von Protokollen aktivieren. Wenn Protokolle nicht vor dem Erreichen ihrer maximalen Größe gesendet werden, wird die Protokolldatei zugunsten aktuellerer Protokolle bereinigt. 

> **Hinweis:** Übernehmen Sie das folgende Muster für die Erfassung von Protokolldaten. Durch das Senden von Daten in einem Intervall stellen Sie sicher, dass Sie Ihre Protokolldaten in der
{{ site.data.keys.mf_analytics_console }} annähernd in Echtzeit sehen.#### Cordova-Apps
{: #cordova-apps }

```javascript
setInterval(function() {
    WL.Logger.send();
}, 60000);
```

#### Web-Apps
{: #web-apps }

```javascript
setInterval(function() {
   ibmmfpfanalytics.logger.send();
}, 60000);
```

Mit folgenden Strategien können Sie sicherstellen, dass alle erfassten Protokolle gesendet werden: 

* Rufen Sie die Methode `send` in einem bestimmten Zeitintervall auf. 
* Rufen Sie die Methode `send` innerhalb von Callbacks zu Lebenszyklusereignissen auf. 
* Erhöhen Sie den Wert für die maximale Größe des persistenten Protokollpuffers (in Bytes).

#### Cordova-Apps
{: #cordova-apps }

```javascript
WL.Logger.config({ maxFileSize: 150000 });
```

#### Web-Apps
{: #web-apps }
Die maximale Dateigröße für die
Web-API ist 5 MB und kann nicht geändert werden. 

## Protokolle automatisch senden
{: auto-log-sending }
Das automatische Senden von Protokollen ist standardmäßig inaktiviert. Immer, wenn eine Ressourcenanforderung erfolgreich an den Server gesendet wird, werden auch die erfassten Protokolle gesendet, wobei zwischen den Sendevorgängen ein zeitlicher Abstand von mindestens 60 Sekunden liegen muss. Das automatische Senden von Protokollen kann vom Client aktiviert oder inaktiviert werden. Standardmäßig ist das automatische Senden von Protokollen inaktiviert. 

#### Cordova-Apps
{: #cordova-apps }
Aktivierung: 

```javascript
WL.Logger.config({autoSendLogs: true});
```

Inaktivierung: 

```javascript
WL.Logger.config({autoSendLogs: false});
```

#### Web-Apps
{: #web-apps }
Aktivierung: 

```javascript
ibmmfpfanalytics.autoSendLogs(true);
```

Inaktivierung: 

```javascript
ibmmfpfanalytics.autoSendLogs(false);
```

## Optimierung mit der Logger-API
{: #fine-tuning-with-the-logger-api }
Das {{ site.data.keys.product_adj }}-Client-SDK
nutzt intern die Logger-API. Vom SDK erstellte Protokolleinträge werden standardmäßig erfasst. Zur Optimierung der Protokollerfassung können Sie
Logger-Instanzen mit Paketnamen verwenden. Mit serverseitigen Filtern können Sie außerdem die Protokollierungsstufe
steuern.


Wenn Sie beispielsweise für das Paket `myApp` nur Protokolle der Stufe ERROR erfassen möchten, gehen Sie wie folgt vor: 

#### Cordova-Apps
{: #cordova-apps }
1. Verwenden Sie eine `WL.Logger`-Instanz mit dem Paketnamen `myApp`. 

   ```javascript
   var logger = WL.Logger.create({ pkg: 'MyApp' });
   ```

2. **Bei Bedarf** können Sie einen Filter angeben, um die Protokollerfassung und -ausgabe programmgesteuert auf die angegebene Stufe und das angegebene Paket zu beschränken. 

   ```javascript
   WL.Logger.config({
        filters: {
            'MyApp': 'ERROR'
        }
   });
   ```

3. **Optional:** Steuern Sie die Filter über Fernzugriff. Rufen Sie dazu ein Serverkonfigurationsprofil ab. 

#### Web-Apps
{: #web-apps }
Bei Verwendung des Web-SDK kann die Stufe nicht vom
Client festgelegt werden. Die gesamte Protokollierung wird an den Server gesendet, bis die Konfiguration durch Abrufen des Serverkonfigurationsprofils geändert wird. 

## Serverkonfigurationsprofile abrufen
{: #fetching-server-configuration-profiles }
Die Protokollierungsstufen können vom Client festgelegt werden
oder über das Abrufen von Konfigurationsdateien vom Server. In der
{{ site.data.keys.mf_analytics_console }} kann eine Protokollierungsstufe global
(für alle Logger-Instanzen) oder für bestimmte Pakete festgelegt werden. Informationen zum KOnfigurieren der Filter in der {{ site.data.keys.mf_analytics_console }} finden Sie unter [Protokollfilter konfigurieren](../../../analytics/console/log-filters/).

Damit der Client die auf dem Server festgelegten
prioritären Konfigurationswerte abruft, muss die Methode
`updateConfigFromServer`
von einem Abschnitt des Codes aufgerufen werden, der regulär ausgeführt wird, z. B. von den App-Lebenszyklus-Callbacks. 

#### Cordova-Apps
{: #cordova-apps }

```javascript
WL.Logger.updateConfigFromServer();
```

#### Web-Apps
{: #web-apps }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

## Protokollierungsbeispiel
{: #logging-example }
Die Ausgabe erfolgt in einem Browser in einer JavaScript-Konsole, in LogCat oder in der Xcode-Konsole. 

### Cordova
{: #cordova }

```javascript
var MathUtils = function(){
   var logger = WL.Logger.create({pkg: 'MathUtils'});
   var sum = function(a, b){
      var sum = a + b;
      logger.debug('sum called with args ' + a + ' and ' + b + '. Returning ' + sum);
      return sum;
   };
}();
```

### Web
{: #web }
Verwenden Sie für die Protokollierung in Webanwendungen das vorangegangene Beispiel und ersetzen Sie Folgendes: 

```javascript
var logger = WL.Logger.create({pkg: 'MathUtils'});
```

durch diese Zeilen: 

```javascript
var logger = ibmmfpfanalytics.logger.create({pkg: 'MathUtils'});
```
