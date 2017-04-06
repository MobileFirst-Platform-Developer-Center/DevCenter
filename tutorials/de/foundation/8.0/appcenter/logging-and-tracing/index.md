---
layout: tutorial
title: Protokollierung und Traceerstellung für das Application Center im Anwendungsserver festlegen
breadcrumb_title: Protokollierung und Traceerstellung einrichten
relevantTo: [ios,android,windows,javascript]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können für bestimmte Anwendungsserver
Protokollierungs- und Traceparameter festlegen und mit JNDI-Eigenschaften
die Ausgabe in allen unterstützten Anwendungsservern steuern.

Die Festlegung der Protokollierungsstufen und der Ausgabedatei für
Traceoperationen im Application Center erfolgt nach den Regeln des jeweiligen Anwendungsservers. Die
{{ site.data.keys.product_full }} stellt darüber hinaus
JNDI-Eigenschaften bereit, mit denen
die Formatierung und Weiterleitung der Traceausgabe gesteuert
und generierte SQL-Anweisungen ausgegeben werden können.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Protokollierung und Traceerstellung in WebSphere Application Server Full Profile aktivieren](#logging-in-websphere)
* [Protokollierung und Traceerstellung in WebSphere Application Server Liberty aktivieren](#logging-in-liberty)
* [Protokollierung und Traceerstellung in Apache Tomcat aktivieren](#logging-in-tomcat)
* [JNDI-Eigenschaften zum Kontrollieren der Traceausgabe](#jndi-properties-for-controlling-trace-output)

## Protokollierung und Traceerstellung in WebSphere Application Server Full Profile aktivieren
{: #logging-in-websphere }
Sie können die Protokollierungsstufen und die Ausgabedatei für
Traceoperationen im Anwendungsserver festlegen.

Wenn Sie im Application Center (oder in anderen Komponenten der {{ site.data.keys.product }}) versuchen, Probleme zu diagnostizieren, ist es wichtig, dass die Protokollnachrichten angezeigt
werden können. Sie müssen die anwendbaren Einstellungen als JVM-Eigenschaften angeben, um in Protokolldateien lesbare Protokollnachrichten auszugeben.

1. Öffnen Sie die Administrationskonsole von WebSphere Application Server. 
2. Wählen Sie **Fehlerbehebung → Protokolle und Trace** aus.
3. Wählen Sie unter **Protokollierung und Traceerstellung** den entsprechenden Anwendungsserver aus. Wählen Sie dann
**Detaillierungsgrad für Protokolle ändern** aus.
4. Wählen Sie die Pakete und den jeweils zugehörigen Detaillierungsgrad aus. In diesem Beispiel
wird die Protokollierung für die {{ site.data.keys.product }}
und das Application Center mit der Stufe **FINEST** (die funktional der Stufe **ALL** entspricht) aktiviert.


```xml
com.ibm.puremeap.*=all
com.ibm.worklight.*=all
com.worklight.*=all
```

Für diese Angabe gilt Folgendes: 

* **com.ibm.puremeap.*** bezieht sich auf das Application Center.
* **com.ibm.worklight.*** und **com.worklight.*** beziehen sich auf andere {{ site.data.keys.product_adj }}-Komponenten.

Die Traces werden an eine Datei mit dem Namen **trace.log** und nicht an
**SystemOut.log** oder **SystemErr.log** gesendet.

## Protokollierung und Traceerstellung in WebSphere Application Server Liberty aktivieren
{: #logging-in-liberty }
Im Liberty-Anwendungsserver können Sie die Protokollierungsstufen und die Ausgabedatei für
Traceoperationen im Application Center festlegen.

Wenn Sie im Application Center versuchen, Probleme zu diagnostizieren, ist es wichtig, dass die Protokollnachrichten angezeigt
werden können. Sie müssen die anwendbaren Einstellungen angeben, um in Protokolldateien lesbare Protokollnachrichten auszugeben. 

Fügen Sie zur Datei
server.xml eine Zeile hinzu, um die Protokollierung für die {{ site.data.keys.product }}
und das Application Center mit der Stufe FINEST (die funktional der Stufe ALL entspricht) zu aktivieren. Beispiel: 

```xml
<logging traceSpecification="com.ibm.puremeap.*=all:com.ibm.worklight.*=all:com.worklight.*=all"/>
```

In diesem Beispiel sind
mehrere Einträge für Pakete
mit zugehöriger
Protokollierungsstufe jeweils durch einen Doppelpunkt (:) getrennt.

Die Traces werden an eine Datei mit dem Namen **trace.log** und nicht an
**messages.log** oder **console.log** gesendet.

Weitere Informationen finden Sie unter
[Liberty Profile: Logging and Trace](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0&view=kc).

## Protokollierung und Traceerstellung in Apache Tomcat aktivieren
{: #logging-in-tomcat }
Sie können die Protokollierungsstufen und die Ausgabedatei für
Traceoperationen im Apache Tomcat Application Server festlegen.

Wenn Sie im Application Center versuchen, Probleme zu diagnostizieren, ist es wichtig, dass die Protokollnachrichten angezeigt
werden können. Sie müssen die anwendbaren Einstellungen angeben, um in Protokolldateien lesbare Protokollnachrichten auszugeben. 

Bearbeiten Sie die Datei
**conf/logging.properties**, um die Protokollierung für die {{ site.data.keys.product }} und das Application Center mit der Stufe **FINEST** (die funktional der Stufe **ALL** entspricht) zu aktivieren. Fügen Sie beispielsweise Zeilen ähnlich den folgenden zu der Datei hinzu: 

```xml
com.ibm.puremeap.level = ALL
com.ibm.worklight.level = ALL
com.worklight.level = ALL
```

Weitere Informationen enthält
der Artikel [Logging in Tomcat](http://tomcat.apache.org/tomcat-7.0-doc/logging.html).

## JNDI-Eigenschaften zum Kontrollieren der Traceausgabe
{: #jndi-properties-for-controlling-trace-output }
Auf allen unterstützten Plattformen können Sie JNDI-Eigenschaften (Java Naming and
Directory Interface) verwenden, um die Traceausgabe für das Application Center zu formatieren und weiterzuleiten und um generierte SQL-Anweisungen
auszugeben.

Die folgenden JNDI-Eigenschaften gelten für die Webanwendung
für die Application-Center-Services
(**applicationcenter.war**).

| Eigenschaftseinstellungen | Einstellung | Beschreibung | 
|-------------------|---------|-------------|
| ibm.appcenter.logging.formatjson | true | Diese Eigenschaft ist standardmäßig auf "false" gesetzt. Setzen Sie sie auf "true", wenn Sie die JSON-Ausgabe für eine bessere Lesbarkeit der Protokolldateien mit Leerzeichen formatieren möchten.  | 
| ibm.appcenter.logging.tosystemerror | true | Diese Eigenschaft ist standardmäßig auf "false" gesetzt. Setzen Sie sie auf "true", wenn alle Protokollnachrichten zu Systemfehlern in Protokolldateien ausgegeben werden sollen. Mit dieser Eigenschaft können Sie die Protokollierung global aktivieren.  | 
| ibm.appcenter.openjpa.Log | DefaultLevel=WARN, Runtime=INFO, Tool=INFO, SQL=TRACE | Bei Verwendung dieser Einstellung werden alle generierten SQL-Anweisungen in den Protokolldateien ausgegeben. | 
