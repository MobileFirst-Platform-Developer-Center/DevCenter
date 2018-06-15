---
layout: tutorial
title: Abläufe in Analytics
breadcrumb_title: Workflows
relevantTo: [ios,android,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Nutzen Sie {{ site.data.keys.mf_analytics_full }} für Ihre
Geschäftsanforderungen. Wenn Sie Ihre Ziele benannt haben, erfassen Sie mit dem
Analytics-Client-SDK die entsprechenden Daten und erstellen Sie in
der {{ site.data.keys.mf_analytics_console }} Berichte. Die folgenden typischen Szenarien veranschaulichen die Möglichkeiten für die Erfassung von Analysedaten und die Erstellung von Analyseberichten. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Analyse der App-Nutzung](#app-usage-analytics)
* [Absturzerfassung](#crash-capture)

## Analyse der App-Nutzung
{: #app-usage-analytics }

### Client-App für die Erfassung der App-Nutzung initialisieren
{: #initializing-your-client-app-to-capture-app-usage }

Bei der App-Nutzung wird gemessen, wie oft eine bestimmte App in den Vordergrund und dann wieder in den Hintergrund gebracht wird. Wenn Sie für Ihre mobile App die App-Nutzung erfassen möchten,
muss das {{ site.data.keys.mf_analytics }}-Client-SDK für den Empfang von App-Lebenszyklusereignissen konfiguriert sein. 

Mit der API von {{ site.data.keys.mf_analytics }}
können Sie die App-Nutzung erfassen. Zunächst müssen Sie aber einen passenden Gerätelistener erstellt haben. Dann können Sie die Daten an den Server senden. 

#### iOS
{: #ios }

Fügen Sie den folgenden Code zur Methode
`application:didFinishLaunchingWithOptions` Ihres Anwendungsdelegaten in der Datei **AppDelegate.m/AppDeligate.swift** hinzu. 

**Objective-C**

```objc
WLAnalytics *analytics = [WLAnalytics sharedInstance];
[analytics addDeviceEventListener:LIFECYCLE];
```

 Senden von Analysedaten: 

```objc
[[WLAnalytics sharedInstance] send];
```

**Swift**

```Swift
WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE);
```

Senden von Analysedaten: 

```Swift
WLAnalytics.sharedInstance().send;
```

#### Android
{: #android }

Fügen Sie den folgenden Code zur Methode `onCreate` Ihrer Application-Unterklasse hinzu. 

```Java
WLAnalytics.init(this);
WLAnalytics.addDeviceEventListener(DeviceEvent.LIFECYCLE);
```

Senden von Analysedaten: 

```Java
WLAnalytics.send();
```

#### Cordova
{: #cordova }

Ähnlich wie bei iOS- und Android-Apps muss bei Cordova-Apps der Listener in nativem Plattformcode erstellt werden. Senden Sie die Daten wie folgt an den Server: 

```javascript
WL.Analytics.send();
```

#### Web-Apps
{: #web-apps }

Für Web-Apps sind keine Listener erforderlich. Analytics
kann über die Klasse `WLlogger`
aktiviert und inaktiviert werden.


```javascript                                    
ibmmfpfanalytics.logger.config({analyticsCapture: true});                
ibmmfpfanalytics.send();
```

### Standarddiagramm für Nutzung und Geräte
{: #default-usage-and-devices-charts }

In der
{{ site.data.keys.mf_analytics_console }}
können auf der Seite **Nutzung und Geräte** im Abschnitt "Apps" einige Standarddiagramme angezeigt werden, die Ihnen helfen, die Nutzung Ihrer Apps zu verwalten. 

#### Geräte insgesamt
{: #total-devices }

Das Diagramm **Geräte insgesamt** zeigt die Gesamtanzahl der Geräte an. 

#### App-Sitzungen insgesamt
{: #total-app-sessions }

Das Diagramm **App-Sitzungen insgesamt** zeigt die Gesamtanzahl der App-Sitzungen an. Eine App-Sitzung wird erfasst, wenn eine App auf einem Gerät in den
Vordergrund kommt. 

#### Aktive Benutzer
{: #active-users }

Das Diagramm **Aktive Benutzer** ist ein interaktives Kurvendiagramm mit folgenden Daten: 

* Aktive Benutzer - eindeutige Benutzer für den angezeigten Zeitrahmen
* Neue Benutzer - neue Benutzer für den angezeigten Zeitrahmen

Der angezeigte Standardzeitrahmen ist ein Tag mit einem Datenpunkt für jede Stunde. Wenn Sie den angezeigten Zeitrahmen über einen Tag hinaus erweitern, repräsentieren die Datenpunkte
einzelne Tage. Sie können in der Legende auf den entsprechenden Schlüssel klicken, um die Anzeige der Linie ein-/auszuschalten. Standardmäßig werden Linien für alle Schlüssel angezeigt. Die Anzeige von Linien kann nicht für alle Schlüssel
ein-/ausgeschaltet werden. 

Sie müssen Ihren App-Code für die Bereitstellung der
`userID` über einen Aufruf der API `setUserContext` instrumentieren, um präzise Daten für das Kurvendiagramm zu erhalten. Wenn Sie
für die
`userID` Anonymität ermöglichen wollen, müssen Sie den Wert zuvor in einen Hashwert umwandeln. Wenn keine
`userID` angegeben ist, wird standardmäßig die ID des Geräts verwendet. Wenn ein Gerät von mehreren Benutzern verwendet wird und die
`userID` nicht angegeben ist, bildet das Kurvendiagramm keine genauen Daten ab, da die ID des Geräts als ein Benutzer gezählt wird. 

#### App-Sitzungen
{: #app-sessions }
Das Diagramm **App-Sitzungen** ist ein Balkendiagramm für die App-Sitzungen über der Zeit. 

#### App-Nutzung
{: #app-usage }

Das Diagramm **App-Nutzung** ist ein Kreisdiagramm mit dem Prozentsatz der App-Sitzungen pro App. 

#### Neue Geräte
{: #new-devices }

Das Diagramm **Neue Geräte** ist ein Balkendiagramm für neue Geräte über der Zeit. 

#### Modellnutzung
{: #model-usage }

Das Diagramm **Modellnutzung** ist ein Kreisdiagramm mit dem Prozentsatz der App-Sitzungen pro Gerätemodell. 

#### Betriebssystemnutzung
{: #operating-system-usage }
Das Diagramm **Betriebssystemnutzung** ist ein Kreisdiagramm
mit dem Prozentsatz der App-Sitzungen pro Gerätebetriebssystem. 

### Kundenspezifisches Diagramm für die durchschnittliche Sitzungsdauer erstellen
{: #creating-acustom-chart-for-average-session-duration }

Die Dauer einer App-Sitzung ist eine wertvolle Messgröße. Sie können für jede App erfahren, wie lange eine bestimmte Benutzersitzung dauert. 

1. Klicken Sie in der {{ site.data.keys.mf_analytics_console }} auf der Seite
**Kundenspezifische Diagramme** des Abschnitts "Dashboard" auf **Diagramm erstellen**. 
2. Geben Sie Ihrem Diagramm einen Namen. 
3. Wählen Sie **App-Sitzung** als **Ereignistyp** aus.
4. Wählen Sie **Balkendiagramm** als **Diagrammtyp** aus.
5. Klicken Sie auf
**Weiter**.
6. Wählen Sie **Zeitachse** für die **X-Achse** aus.
7. Wählen Sie **Durchschnitt** für die **Y-Achse** aus.
8. Wählen Sie die **Dauer** als **Eigenschaft** aus.
9. Klicken Sie auf **Speichern**.

## Absturzerfassung
{: #crash-capture }

In {{ site.data.keys.mf_analytics }} gibt es auch Daten und Berichte zu Anwendungsabstürzen. Diese Daten werden zusammen mit anderen Daten von Lebenszyklusereignissen automatisch erfasst. Die Absturzdaten werden vom Client erfasst und an den Server gesendet, sobald die Anwendung wieder betriebsbereit ist. 

Ein App-Absturz wird aufgezeichnet, wenn eine nicht behandelte Ausnahme eintritt und das Programm in einen nicht korrigierbaren Zustand versetzt. Bevor die App geschlossen wird,
protokolliert das SDK von {{ site.data.keys.mf_analytics }}
ein Absturzereignis. Diese Daten werden mit dem nächsten Logger-Sendeaufruf an den Server gesendet. 

### App für die Erfassung von Absturzdaten initialisieren
{: #initializing-your-app-to-capture-crash-data }

Vergewissern Sie sich, dass die Absturzdaten an den Server gesendet wurden, damit sie
erfasst und in die Berichte in der {{ site.data.keys.mf_analytics_console }} aufgenommen werden. 

Vergewissern Sie sich, dass App-Lebenszyklusereignisse erfasst werden (siehe [Client-App für die Erfassung der App-Nutzung initialisieren](#initializing-your-client-app-to-capture-app-usage)).

Sobald die App wieder Betriebsbereit ist, müssen die Clientprotokolle gesendet werden, um den Stack-Trace zum Absturz zu erhalten. Mit einem Zeitgeber können Sie sicherstellen,
dass die Protokolle regelmäßig gesendet werden. 

#### iOS
{: #ios-crash-data }

**Objective-C**

```objc
- (void)sendMFPAnalyticData {
  [OCLogger send];
  [[WLAnalytics sharedInstance] send];
}

// an anderer Stelle derselben Implementierungsdatei:

[NSTimer scheduledTimerWithTimeInterval:60
  target:self
  selector:@selector(sendMFPAnalyticData)
  userInfo:nil
  repeats:YES]
```

**Swift**

```swift
overridefuncviewDidLoad() {
       super.viewDidLoad()
       WLAnalytics.sharedInstance();
       lettimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(sendMFPAnalyticData), userInfo: nil, repeats: true);
       timer.fire();
       // Weitere Eichrichtungsschritte nach dem Laden der Ansicht ausführen, in der Regel mit einem NIB
   }

   funcsendMFPAnalyticData() {
       OCLogger.send()
       WLAnalytics.sharedInstance().send()
   }
```

#### Android
{: #android-crash-data }

```Java
Timer timer = new Timer();
timer.schedule(new TimerTask() {
  @Override
  public void run() {
    Logger.send();
    WLAnalytics.send();
  }
}, 0, 60000);
```

#### Cordova
{: #cordova-crash-data }

```Java
setInterval(function() {
  WL.Logger.send();
  WL.Analytics.send();
}, 60000)
```

#### Web
{: #web-crash-data }

```Java
setInterval(function() {
  ibmmfpfanalytics.logger.send();
}, 60000);
```

### Abstürze von Apps überwachen
{: #app-crash-monitoring }

Wenn die App nach einem Absturz neu gestartet wird, werden die Protokolle an {{ site.data.keys.mf_analytics_server }} gesendet. Im Abschnitt
**Dashboard** der {{ site.data.keys.mf_analytics_console }}
können Sie sich schnell einen Überblick über die Abstürze Ihrer Apps verschaffen.   
Das Balkendiagramm **Abstürze** auf der Seite **Übersicht** des Abschnitts
**Dashboard** zeigt ein Histogramm der Abstürze über der Zeit. 

Die Daten können auf zwei Arten angezeigt werden. 

* **Absturzrate anzeigen**: Absturzrate über der Zeit
* **Gesamtzahl der Abstürze anzeigen**: Gesamtzahl der Abstürze über der Zeit

> **Hinweis:** Das Diagramm "Abstürze" fragt die `MfpAppSession`-Dokumente ab. Sie müssen Ihre App instrumentieren, um Daten zur App-Nutzung und zu App-Abstürzen zu erhalten und in den Diagrammen anzuzeigen. Wenn keine
`MfpAppSession`-Daten erfasst werden, werden `MfpAppLog`-Dokumente abgefragt. In dem Fall kann das
Diagramm die Anzahl der Abstürze darstellen, aber keine Absturzrate berechnen, weil die
Anzahl der App-Nutzungen unbekannt ist. Dies führt zu folgender Einschränkung:

>
> * Das Balkendiagramm **Crashes** zeigt keine Daten an, wenn **Display Crash
Rate** ausgewählt wird. 

### Standarddiagramme für Abstürze
{: #default-charts-for-crashes }

In der
{{ site.data.keys.mf_analytics_console }}
können auf der Seite **Abstürze** im Abschnitt **Apps** einige Standarddiagramme angezeigt werden, die Ihnen helfen, die
Abstürze Ihrer Apps zu verwalten. 

Das Diagramm **Absturzübersicht** enthält eine Tabelle mit einer Übersicht über die Abstürze.   
Das Balkendiagramm **Abstürze** zeigt ein Histogramm der Abstürze über der Zeit. Sie können die Daten nach
der Absturzrate oder der Gesamtanzahl der Abstürze anzeigen. Das Balkendiagramm Abstürze wird auch auf der Seite
Abstürze im Abschnitt Anwendungen
angezeigt. 

Das Diagramm **Absturzzusammenfassung** enthält eine sortierbare Tabelle mit einer Zusammenfassung der Abstürze.
Sie können Einzelheiten zu den einzelnen Abstürzen einblenden, indem Sie auf das Symbol + klicken. Daraufhin wird eine Tabelle
**Absturzdetails** mit weiteren Details zu den Abstürzen angezeigt. In der Tabelle
Absturzdetails können Sie auf das Symbol **>** klicken, um noch mehr Details zu einer bestimmten
Absturzinstanz anzuzeigen. 

### Fehlersuche beim Absturz von Apps
{: #app-crash-troubleshooting }

Im Abschnitt **Anwendungen** der
{{ site.data.keys.mf_analytics_console }} können Sie die Seite **Abstürze** anzeigen, um Ihre
Apps besser verwalten zu können. 

Die Tabelle **Absturzübersicht** hat die folgenden Datenspalten: 

* **App:** App-Name
* **Abstürze:** Gesamtzahl der Abstürze für diese App
* **Gesamtnutzung:** Häufigkeit des Öffnens und Schließens dieser App durch einen Benutzer
* **Absturzrate:** Prozentsatz der Abstürze pro Nutzung

Das Balkendiagramm **Abstürze** ist dasselbe Diagramm wie auf der Seite
**Übersicht** im Abschnitt **Dashboard**. 

> **Hinweis:** Beide Diagramme fragen die `MfpAppSession`-Dokumente ab. Sie müssen Ihre App instrumentieren, um Daten zur App-Nutzung und zu App-Abstürzen zu erhalten und in den Diagrammen anzuzeigen. Wenn keine
`MfpAppSession`-Daten erfasst werden, werden `MfpAppLog`-Dokumente abgefragt. In dem Fall können die Diagramme die Anzahl der Abstürze darstellen, aber keine Absturzrate berechnen, weil die
Anzahl der App-Nutzungen unbekannt ist. Dies führt zu folgenden Einschränkungen:

>
> * In der Tabelle "Absturzübersicht" sind die Spalten "Gesamtnutzung" und "Absturzrate" leer.
> * Das Balkendiagramm "Abstürze" zeigt keine Daten an, wenn "Absturzrate anzeigen" ausgewählt wird. 

Die Tabelle **Absturzzusammenfassung** kann sortiert werden. Sie enthält die folgenden Datenspalten: 

* Abstürze
* Geräte
* Letzter Absturz
* App
* Betriebssystem
* Nachricht

Wenn Sie neben einem Eintrag auf das Zeichen **+** klicken, wird die Tabelle
**Absturzdetails** mit folgenden Spalten angezeigt: 

* Absturzzeitpunkt
* App-Version
* Betriebssystemversion
* Gerätemodell
* Geräte-ID
* Herunterladen: Link zum Herunterladen der Protokolle, die zum Absturz geführt haben

In der Tabelle **Absturzdetails** können Sie die Anzeige für jeden Eintrag erweitern, um weitere Details, einschließlich eines Stack-Trace, zu erhalten. 

> **Hinweis:** Die Tabelle **Absturzzusammenfassung** wird durch Abfragen der Clientprotokolle mit
schwerwiegenden Fehlern mit Daten gefüllt. Wenn Ihre App keine Clientprotokolle mit schwerwiegenden Fehlern erfasst, sind auf der Registerkarte
keine Daten verfügbar. 

