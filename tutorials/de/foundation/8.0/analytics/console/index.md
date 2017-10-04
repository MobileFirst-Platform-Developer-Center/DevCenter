---
layout: tutorial
title: Operations Console und Analytics Console
breadcrumb_title: Analytics Console
relevantTo: [ios,android,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->

## Übersicht
Sie können konfigurieren, wie der Client mit
{{ site.data.keys.mf_analytics_server }} zusammenarbeitet. Außerdem können Sie in der Operations Console und der Analytics Console ein breites Spektrum von
Berichten konfigurieren und anzeigen. 

## {{ site.data.keys.mf_analytics_console_full }}
In der {{ site.data.keys.mf_analytics_console }} können Sie die Analytics-Berichte anzeigen und konfigurieren sowie Alerts verwalten und Clientprotokolle anzeigen. 

Sie können die {{ site.data.keys.mf_analytics_console_short }} von der {{ site.data.keys.mf_console }} aus öffnen.
Klicken Sie dazu oben rechts in der Navigationsleiste auf den Link **Analytics Console**. 

![Schaltfläche für Analytics Console](analytics-console-button.png)

Wenn Sie zur {{ site.data.keys.mf_analytics_console_short }} gelangt sind, erscheint das **Dashboard** als Standardanzeige. Falls eine Clientanwendung bereits Protokolle und Analysedaten
an den Server gesendet hat, werden die betreffenden Berichte mit Daten gefüllt. In der Navigationsleiste können Sie
**Apps** und **Infrastruktur** auswählen. 

![Analytics Console](analytics-console.png)

### Dashboard
Im **Dashboard** können Sie die zu Anwendungsabstürzen,
zu Anwendungssitzungen und zur Serververarbeitungszeit erfassten Analysedaten überprüfen. Zudem können Sie kundenspezifische Diagramme erstellen und Alerts verwalten. 

### Apps
In der Anzeige **Apps** können Sie die detaillierten Analysedaten zu Nutzung und Geräten (z. B.
Summe der Geräte- und App-Sitzungen, aktive Nutzer, App-Nutzung, neue Geräte, Modellnutzung und Betriebssystem) sowie absturzbezogene Daten überprüfen. Durchsuchen Sie die Clientprotokolle nach bestimmten
Apps und Geräten (**Apps → Clientprotokollsuche**).


### Infrastruktur
In der Anzeige **Infrastruktur** können Sie sich Analysedaten
zu Folgendem ansehen: Sitzungsverarbeitungszeit, durchschnittliche Anforderungsgröße, Serveranforderungen,
Netzanforderungen, Adapterantwortzeit,
Prozedurantwortzeit und Adapternutzung sowie Daten zu Push-Benachrichtigungen wie
Benachrichtigungsanforderungen pro Mediator. Sie können auch Serverprptokolle durchsuchen. 

> Weitere Informationen enthält das Lernprogramm [Abläufe in Analytics](../workflows/).



## Analytics-Features

### App-Analyse
Auf der Registerkarte **Apps → Nutzung und Geräte** können Sie Diagramme zu App-Sitzungen und zur App-Nutzung anzeigen, um herauszufinden,
welche App von Ihren Benutzern
am meisten genutzt wird. 

### Integrierte Analyse
Wenn Sie das {{ site.data.keys.product_adj }}-Client-SDK zusammen mit
{{ site.data.keys.mf_server }} verwenden, werden für jede Anforderung, die Ihre App an
{{ site.data.keys.mf_server }} richtet, automatisch Analysedaten erfasst. In der Ansicht **Dashboard → Übersicht**
können Sie grundlegende Gerätemetadaten anzeigen, die erfasst und dem {{ site.data.keys.mf_analytics_server }} gemeldet werden.

### Kundenspezifische Analysen
Sie können Ihre App kundenspezifische Daten senden lassen und aus diesen Daten kundenspezifische Diagramme erstellen. 

> Im Lernprogramm [Analytics-API](../analytics-api/) erfahren Sie, wie kundenspezifische Analysen gesendet werden. 

### Kundenspezifische Diagramme
Mit kundenspezifischen Diagrammen können Sie erfasste
Analysedaten aus Ihrem Anatytics-Datastore in Diagrammen darstellen, die standardmäßig nicht in
der {{ site.data.keys.mf_analytics_console_short }} verfügbar sind (**Dashboard → Kundenspefische
Diagramme**). Diese Darstellungsoption ist eine wirksame Methode für die Analyse geschäftskritischer Daten. 

> Im Lernprogramm [Kundenspezifische Diagramme erstellen](custom-charts/) erfahren Sie, wie kundenspezifische Diagramme erstellt werden. 

### Alerts verwalten
Alerts ermöglichen eine Überwachung des Zustands Ihrer mobilen Apps, ohne regelmäßig in der
{{ site.data.keys.mf_analytics_console }}
nachschauen zu müssen. 

Auf der Registerkarte **Dashboard → Alert-Management** können Sie Schwellenwerte konfigurieren, bei deren Überschreitung
Alerts für die Benachrichtigung von Administratoren ausgelöst werden. Sie können die ausgelösten Alerts in der Konsole
darstellen oder mit einem angepassten Web-Hook handhaben. Über einen angepassten Web-Hook können Sie steuern, wer bei Auslösung eines Alerts wie benachrichtigt werden soll. 

> Im Lernprogramm [Alerts verwalten](alerts/) erfahren Sie, wie Alerts verwaltet werden. 

### App-Abstürze überwachen
App-Abstürze werden in der {{ site.data.keys.mf_analytics_console_short }} (unter **Apps → Abstürze**) dargestellt, sodass
Sie sich schnell einen Überblick über Abstürze verschaffen und entsprechend reagieren können. Auf dem Gerät werden standardmäßig Absturzprotokolle erfasst
und an den Server gesendet, *sobald die Anwendung wieder ausgeführt werden kann*. Wenn Absturzprotokolle an den Analyseserver gesendet werden, werden sie automatisch genutzt, um die Absturzdiagramme mit Daten zu füllen. 

### Server- und Netzdaten überwachen
Die {{ site.data.keys.mf_analytics_console_short }} überwacht Netzdaten, die an Analytics Server gesendet werden,
und ermöglicht dem Benutzer, diese Informationen auf unterschiedlichen Wegen abzufragen (**Infrastruktur → Server und Netze**).


### Clientprotokolle erfassen, durchsuchen und für die Berichterstellung nutzen
Clientprotokolle können an den Server gesendet und in Analyseberichte aufgenommen werden. 

Gehen Sie wie folgt vor, wenn Sie Protokolldaten in einen Bericht aufnehmen möchten: 

1. Wählen Sie in der {{ site.data.keys.mf_analytics_console_short }} das Register **Dashboard → Kundenspezifische Diagramme** aus. 

2. Wählen Sie im Pulldown-Menü **Ereignistyp** den Eintrag **Clientprotokolle** aus. 

Weitere Informationen zu **kundenspezifischen Diagrammen** finden Sie unter [Kundenspezifische Diagramme erstellen](custom-charts/).

Protokolldaten können gefiltert werden. Sie können Protokollfilter in Analytics Server konfigirieren und speichern. Clientanwendungen können diese Filter dann abrufen. 

Informationen zum Konfigurieren von Protokollfiltern enthält das Lernprogramm [Clientprotokolle durchsuchen](log-filters/). 

Weitere Informationen zum Senden der Protokolle vom Client aus finden Sie unter [Clientprotokolle erfassen](../../application-development/client-side-log-collection/).



## {{ site.data.keys.mf_console_full }}
In der {{ site.data.keys.mf_console }} können Sie Analytics Server konfigurieren und verwalten.

Wenn die {{ site.data.keys.mf_analytics_console_short }} geöffnet ist, können Sie auf die
{{ site.data.keys.mf_console }} zugreifen, indem Sie oben in der Navigationsleiste auf die Schaltfläche **Operations Console** klicken. 

### Analysedaten anderer Logger-Pakete erfassen
Standardmäßig wird nur die Protokollierung des Pakets `com.worklight` an Analytics gesendet. Wenn Sie die Protokollierung
weiterer Pakete hinzufügen möchten, lesen Sie
die Informationen unter
[Protokolle an Analytics Server weiterleiten](../../adapters/server-side-log-collection/java-adapter/#forwarding-logs-to-the-analytics-server).


### Analytics-Unterstützung aktivieren/inaktivieren
{: #enabledisable-analytics-support}

Die Erfassung von Analysen durch den Analyseserver ist standardmäßig aktiviert. Sie können sie inaktivieren, um
Verarbeitungszeit einzusparen. 

1. Klicken Sie in der Navigationsseitenleiste auf **Laufzeiteinstellungen**. Laufzeiteigenschaften werden nur im Lesezugriffsmodus angezeigt, um unbeabsichtigte Änderungen zu vermeiden. 
2. Wenn Sie die Einstellungen bearbeiten müssen, klicken Sie auf die Schaltfläche **Bearbeiten**. Wenn Sie nicht mit der Rolle *Administrator* oder
*Deployer* angemeldet sind, ist die Schaltfläche **Bearbeiten** nicht sichtbar, weil Sie nicht berechtigt sind, Laufzeiteigenschaften zu modifizieren. 
3. Wählen Sie im Dropdown-Menü **Datenerfassung aktiviert** die Option
**falsch** aus, um die Datenerfassung zu inaktivieren. 
4. Klicken Sie auf **Speichern**.
5. Klicken Sie auf die Schaltfläche **Lesezugriff**, um die Eigenschaften wieder zu sperren. 


![Analytics-Unterstützung in der Konsole aktivieren oder inaktivieren](enable-disable-analytics.png)


### Rollenbasierte Zugriffssteuerung
Der Inhalt in der {{ site.data.keys.mf_analytics_console_short }}
ist nur für vordefinierte Sicherheitsrollen bestimmt.   
In der {{ site.data.keys.mf_analytics_console_short }}
werden ausgehend von der Sicherheitsrolle des angemeldeten Benutzers unterschiedliche Inhalte angezeigt. In der folgenden Tabelle sind die
Sicherheitsrollen und ihre Zugriffsrechte für die {{ site.data.keys.mf_analytics_console_short }} aufgeführt. 

| Rolle| Rollenname| Anzeigezugriff| Bearbeitungszugriff|
|----------------|--------------------------|--------------------------------------------------------------------|-----------------|
| Administrator| analytics_administrator| Für alles | Für alles  |
| Infrastruktur | analytics_infrastructure | Für alles | Für alles  |
| Anwendungsentwickler | analytics_developer| Für alles mit Ausnahme der Verwaltungsseiten| Für alles  |
| Support| analytics_support| Für alles mit Ausnahme der Verwaltungsseiten| Für alles  |
| Geschäft | analytics_business| Für alles mit Ausnahme der Verwaltungs- und Infrastrukturseiten| Für alles  |

> Informationen zum Einrichten von Rollen finden Sie unter [Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren](../../installation-configuration/production/server-configuration#configuring-user-authentication-for-mobilefirst-server-administration).


## Zugehörige Blogbeiträge
* [More on Instrumenting Custom Analytics]({{site.baseurl}}/blog/2016/01/22/howto-custom-in-app-behavior-analytics/)
* [More on Instrumenting Webhooks]({{site.baseurl}}/blog/2015/10/19/using-mfp-adapters-endpoint-analytics-alerts-webhooks/)
