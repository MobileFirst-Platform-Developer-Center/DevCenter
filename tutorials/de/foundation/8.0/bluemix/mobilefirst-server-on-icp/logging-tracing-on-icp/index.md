---
layout: tutorial
title: Protokollierung und Traceerstellung in IBM Cloud Private
breadcrumb_title: Logging and Tracing
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{site.data.keys.product_full }} protokolliert Fehler, Warnungen und Informationsnachrichten in einer Protokolldatei. Der zugrunde liegende Mechanismus der Protokollierung variiert je nach Anwendungsserver. In  {{site.data.keys.prod_icp }} ist Liberty der einzige unterstützte Anwendungsserver. 

Im folgenden Dokument wird erläutert wie für einen in einem Kubernetes-Cluster in {{ site.data.keys.prod_icp }} ausgeführten {{ site.data.keys.mf_server }} der Trace aktiviert wird und Protokolle erfasst werden. 


#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Voraussetzungen](#prereqs)
* [Protokollierungs- und Überwachungsmechanismus konfigurieren](#configure-log-monitor)
* [*kubectl*-Protokolle erfassen](#collect-kubectl-logs)
* [Protokolle mit einem angepassten Script von IBM erfassen](#collect-logs-custom-script)


## Voraussetzungen
{: #prereqs}

Installieren und konfigurieren Sie die folgenden Tools, die für die Protokollerfassung und die Fehlerbehebung erforderlich sind:
* Docker (`docker`)
* Kubernetes-CLI (`kubectl`)

Führen Sie die  [hier](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_2.1.0/manage_cluster/cfc_cli.html) beschriebenen Schritte aus, um den `kubectl`-Client für Ihren Cluster in {{ site.data.keys.prod_icp }} zu konfigurieren.


## Protokollierungs- und Überwachungsmechanismus konfigurieren
{: #configure-log-monitor}

Die gesamte Protokollierung der {{ site.data.keys.product }} erfolgt standardmäßig in den Protokolldateien des Anwendungsservers. Die Standardtools, die in Liberty verfügbar sind, können zum Steuern der Serverprotokollierung in der {{site.data.keys.product }}  verwendet werden. Weitere Informationen finden Sie in der Dokumentation im Abschnitt [Protokollierungs- und Überwachungsmechanismen konfigurieren](https://www.ibm.com/support/knowledgecenter/de/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html).

Unter [Protokollierungs- und Überwachungsmechanismen konfigurieren](https://www.ibm.com/support/knowledgecenter/de/SSHS8R_8.0.0/com.ibm.worklight.installconfig.doc/admin/r_logging_and_monitoring_mechanisms.html) erfahren Sie genau, wie die Datei `server.xml` aktualisiert werden kann, um die Protokollierung zu konfigurieren. Zudem enthält der Abschnitt Informationen zur Traceaktivierung. Verwenden Sie den Filter `com.ibm.ws.logging.trace.specification` für eine selektive Traceaktivierung. [Weitere Informationen finden Sie hier](https://www.ibm.com/support/knowledgecenter/de/SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html). Diese Eigenschaft kann mit JVM-Optionen (`jvm.options`) oder in der Datei `bootstrap.properties` der Serverinstanz angegeben werden. 

Wenn Sie zu `jvm.options` beispielsweise den folgenden Eintrag hinzufügen, wird die Traceerstellung für alle mit `com.ibm.mfp` beginnenden Methoden aktiviert und die Tracestufe auf *all* gesetzt.
```
-Dcom.ibm.ws.logging.trace.specification=com.ibm.mfp.*=all=enabled
```
 Sie können diesen Eintrag auch mithilfe der JNDI-Konfiguration festlegen. Weitere Informationen finden Sie [hier]({{ site.baseurl }}/tutorials/en/foundation/8.0/bluemix/mobilefirst-server-on-icp/#env-mf-server).


## *kubectl*-Protokolle erfassen
{: #collect-kubectl-logs}

Mit dem Befehl `kubectl logs` können Sie Informationen zu dem im Kubernetes-Cluster implementierten Container abrufen. Der folgende Befehl ruft beispielsweise die Protokolle für den Pod ab, dessen *Podname* im Befehl angegeben ist:

```bash
kubectl logs po/<Podname>
```
Weitere Informationen zum Befehl `kubectl logs` finden Sie in der [Kubernetes-Dokumentation](https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_logs/).

## Protokolle mit einem angepassten Script von IBM erfassen
{: #collect-logs-custom-script}

Die MobileFirts-Server und Containerprotokolle können mit dem Script [get-icp-logs.sh](get-icp-logs.sh) erfasst werden. Das Script verwendet den *Helm-Releasenamen* als Eingabe und erfasst die Protokolle von allen implementierten Pods. 

Das Script kann wie folgt ausgeführt werden: 
```bash
get-icp-logs <Helm-Releasename> [<Ausgabeverzeichnis>] [<Namespace>]
```
In der folgenden Tabelle sind die von dem angepassten Script verwendeten Parameter beschrieben. 

| Option | Beschreibung | Bemerkungen |
|--------|-------------|---------|
| Helm-Releasename | Releasename der jeweiligen Helm-Chart-Installation| **Obligatorisch** |
| Ausgabeverzeichnis | Ausgabeverzeichnis, in das die erfassten Protokolle gestellt werden sollen | **Optional**<br/>Standardeinstellung: Unterverzeichnis **mfp-icp-logs** unter dem aktuellen Arbeitsverzeichnis |
| Namespace | Namespace, in dem das jeweilige Helm-Chart installiert ist | **Optional**<br/>Standardeinstellung: **default** |
