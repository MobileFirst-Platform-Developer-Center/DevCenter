---
title: Serverseitige Protokollerfassung
breadcrumb_title: Serverseitige Protokollerfassung
relevantTo: [ios,android,windows,javascript]
weight: 7
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Für die Protokollierung wird der Quellcode so instrumentiert, dass mithilfe von API-Aufrufen Nachrichten aufgezeichnet werden, die Diagnose und Debug erleichtern. In {{ site.data.keys.mf_server }} können Sie steuern, welche Protokolle über Fernzugriff erfasst werden sollten. Der Serveradministrator hat somit eine optimierte Steuerungsmöglichkeit für die Serverressourcen. 

Die Protokollierungsbibliotheken stellen in der Regel Steuerelemente für die Ausführlichkeit bereit, die häufig auch als **Stufen** bezeichnet werden. Von der geringsten bis zur größten Ausführlichkeit sind dies die Stufen ERROR, WARN, INFO und DEBUG. 

## Protokollerfassung in Adaptern
{: #log-collection-in-adapters }

Protokolle von Adaptern können über den Protokollierungsmechanismen des zugrunde liegenden Anwendungsservers angezeigt werden.   
In WebSphere Full Profile und Liberty Profile werden
je nach angegebener Protokollierungsstufe die Dateien **messages.log** und **trace.log** verwendet.  

Diese Protokolle können auch an die Analytics Console weitergeleitet werden.
Diesbezügliche Informationen enthalten die Lernprogramme für [Java-Adapter](java-adapter) und [JavaScript-Adapter](javascript-adapter).

## Zugriff auf Protokolldateien
{: #accessing-the-log-files }

* Bei einer Vor-Ort-Installation von {{ site.data.keys.mf_server }} richtet sich die Verfügbarkeit der Dateien nach dem zugrunde liegenden Anwendungsserver.  
    * [IBM WebSphere Application Server Full Profile](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html)
    * [IBM WebSphere Application Server Liberty Profile](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0)
    * [Apache Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html)
* Abruf der Protokolle in einer Cloudimplementierung: 
    * IBM Container- oder Liberty-Buildpack (siehe Lernprogramm [Protokoll und Traceerfassung in IBM Containern](../../bluemix/mobilefirst-server-using-scripts/log-and-trace-collection/))
    * Mobile-Foundation-Bluemix-Service (siehe Abschnitt [Zugriff auf Serverprotokolle](../../bluemix/using-mobile-foundation/#accessing-server-logs) im Lernprogramm [Mobile Foundation verwenden](../../bluemix/using-mobile-foundation))
