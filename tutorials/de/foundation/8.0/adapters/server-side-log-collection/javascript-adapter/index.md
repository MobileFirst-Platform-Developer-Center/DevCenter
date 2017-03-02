---
layout: tutorial
title: Protokollierung in JavaScript-Adaptern
relevantTo: [ios,android,windows,javascript]
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Dieses Lernprogramm enthält die Code-Snippets, die erforderlich sind, um Protokollierungsfähigkeiten zu einem JavaScript-Adapter hinzuzufügen. 

## Protokollierungsbeispiel
{: #logging-example }

Die folgende Nachricht wird in der Datei `trace.log` des Anwendungsservers ausgegeben. Wenn der Serveradministrator Protokolle von
{{ site.data.keys.mf_server }} zu {{ site.data.keys.mf_analytics_server }} weiterleitet, erscheint die
`logger`-Nachricht auch in der Ansicht **Infrastruktur → Serverprotokollsuche** der {{ site.data.keys.mf_analytics_console }}.

```javascript
MFP.Logger.debug("This is a debug message from a JavaScript adapter");
```

Zusätzliche Protokollierungsstufen von der geringsten bis zur größten Ausführlichkeit sind ERROR, WARN, INFO, LOG und DEBUG. 

## Zugriff auf Protokolldateien
{: #accessing-the-log-files }

* Bei einer Vor-Ort-Installation von {{ site.data.keys.mf_server }} richtet sich die Verfügbarkeit der Dateien nach dem zugrunde liegenden Anwendungsserver.  
    * [IBM WebSphere Application Server Full Profile](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server Liberty Profile](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* Abruf der Protokolle in einer Cloudimplementierung: 
    * IBM Container- oder Liberty-Buildpack (siehe Lernprogramm [Protokoll und Traceerfassung in IBM Containern](../../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/))
    * Mobile-Foundation-Bluemix-Service (siehe Abschnitt [Zugriff auf Serverprotokolle](../../../bluemix/using-mobile-foundation/#accessing-server-logs) im Lernprogramm [Mobile Foundation verwenden](../../../bluemix/using-mobile-foundation))

## Protokolle zum Analytics Server weiterleiten
{: #forwarding-logs-to-the-analytics-server }

Protokolle können an die Analytics Console weitergeleitet werden.

1. Wählen Sie in der {{ site.data.keys.mf_console }} in der Seitenleistennavigation die Option **Einstellungen** aus. 
2. Klicken Sie auf der Registerkarte **Laufzeiteigenschaften** auf die Schaltfläche **Bearbeiten**.
3. Geben Sie im Abschnitt **Analytics → Zusätzliche Pakete** für die
Weiterleitung von JavaScript-Adapter-Protokollen
an {{ site.data.keys.mf_server }} **MFP.Logger** an. 

![Filtern von Protokollen in der Konsole](javascript-filter.png)

