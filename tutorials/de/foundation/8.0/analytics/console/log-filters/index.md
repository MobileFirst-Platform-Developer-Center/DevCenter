---
layout: tutorial
title: Protokollfilter konfigurieren
breadcrumb_title: Protokollfilter
relevantTo: [ios,android,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Administratoren können in der
**{{ site.data.keys.mf_console }} unter [Ihre Anwendung] → [Version] → Protokollfilter** die Protokollerfassung und die Protokollstufe für das
{{ site.data.keys.product_adj }}-Client-SDK steuern.  
Mithilfe der Option `Protokollfilter` können Sie eine Filterstufe für die Protokollierung erstellen. Die
Protokollstufe kann global
(für alle Logger-Instanzen) oder für bestimmte Pakete festgelegt werden. 

<img class="gifplayer"  alt="Protokollfilter erstellen" src="add-log-filter.png"/>

Damit die Anwendung die auf dem Server festgelegten
prioritären Konfigurationswerte abruft, muss die Methode
`updateConfigFromServer`
von einem Abschnitt des Codes aufgerufen werden, der regulär ausgeführt wird, z. B. von den App-Lebenszyklus-Callbacks. 


#### Android
{: #android }

```java
Logger.updateConfigFromServer();
```

#### iOS
{: #ios }

```objective-c
[OCLogger updateConfigFromServer];
```

#### Cordova
{: #cordova }

```javascript
WL.Logger.updateConfigFromServer();
```

#### Web
{: #web }

```javascript
ibmmfpfanalytics.logger.updateConfigFromServer();
```

Die vom Server zurückgegebenen Konfigurationswerte für `Logger` haben Vorrang for allen auf der Clientseite festgelegten Werten. Wenn das Clientprotokollprofil entfernt wird und der Client versucht, das Clientprotokollprofil abzurufen, empfängt der Client leere Nutzdaten. Die `Logger`-Konfiguration wird in dem Fall auf die ursprünglich auf dem Client konfigurierten Werte gesetzt. 

## Serverprotokolle weiterleiten
{: #forwarding-server-logs }

In der {{ site.data.keys.mf_console }} kann der Serveradministrator
Protokolle auf Platte speichern und diese Protokolle
an die {{ site.data.keys.mf_analytics_console }} senden.

Wenn Sie Serverprotokolle weiterleiten möchten, navigieren Sie zur
Anzeige **Laufzeiteinstellungen** und geben Sie unter **Zusätzliche Pakete** das Logger-Paket an.  
Die erfassten Protokolle können in der {{ site.data.keys.mf_analytics_console_short }} angezeigt werden. Der Benutzer
kann also Adapterprotokolle in der {{ site.data.keys.mf_analytics_console_short }} sichten, ohne alle Serverprotokolle erfassen zu müssen. 
