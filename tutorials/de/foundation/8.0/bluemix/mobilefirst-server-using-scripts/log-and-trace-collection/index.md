---
layout: redirect
new_url: /404/
sitemap: false
#layout: tutorial
#title: Log and trace collection
#relevantTo: [ios,android,windows,javascript]
#weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
IBM Container für IBM Cloud stellen einige integrierte Protokollierungs- und Überwachungsfunktionen für Container-CPU, Speicher und Netzbetrieb bereit. Bei Bedarf können Sie die Protokollebene für Ihre {{ site.data.keys.product_adj }}-Container ändern. 

Die Option für die Erstellung von Protokolldateien für den Container mit {{ site.data.keys.mf_server }}, den Container mit {{ site.data.keys.mf_analytics }} und den Container mit dem {{ site.data.keys.mf_app_center }} ist standardmäßig (mit der Ebene `*=info`) aktiviert. Sie können die Protokollebenen ändern, indem Sie manuell Korrekturcode hinzufügen oder indem Sie Code mit einer Scriptdatei injizieren. In einer IBM Cloud-Logmet-Konsole können Containerprotokolle und Server- oder Laufzeitprotokolle mit dem Visualisierungstool Kibana angezeigt werden. Die Überwachung kann in einer IBM Cloud-Logmet-Konsole mithilfe des Open-Source-Metrikdashboards und -Diagrammeditors durchgeführt werden.

Wenn Ihr {{ site.data.keys.product_adj }}-Container mit einem SSH-Schlüssel erstellt und an eine öffentliche IP-Adresse gebunden wurde, können Sie die Protokolle für die Containerinstanz mithilfe eines passenden privaten Schlüssels in einer geschützten Ansicht anzeigen. 

### Vorrangwerte für die Protokollierung
{: #logging-overrides }
Sie können die Protokollebenen ändern, indem Sie manuell Korrekturcode hinzufügen oder indem Sie Code mit einer Scriptdatei injizieren. Das manuelle Hinzufügen von Korrekturcode zum Ändern der Protokollebene muss ausgeführt werden, wenn das Image zum ersten Mal erstellt wird. Sie müssen die neue Protokollierungskonfiguration als separates Code-Snippet zu den Ordnern **Paketstammverzeichnis/mfpf-[analytics|server]/usr/config** und **Paketstammverzeichnis/mfp-appcenter/usr/config** hinzufügen. Das Snippet wird dann in den Ordner configDropins/overrides des Liberty-Servers kopiert. 

Wenn Sie zum Ändern der Protokollebene mit einer Scriptdatei Code injizieren möchten, können Sie bei der Ausührung der start*.sh-Scriptdateien aus dem Paket für Version 8.0.0 (**startserver.sh**, **startanalytics.sh**, **startservergroup.sh**, **startanalyticsgroup.sh**, **startappcenter.sh**, **startappcentergroup.sh**) bestimmte Befehlszeilenargumente angeben.
Die folgenden optionalen Befehlszeilenargumente können angewendet werden: 

* `[-tr|--trace]` Tracespezifikation
* `[-ml|--maxlog]` maximale_Anzahl_Protokolldateien
* `[-ms|--maxlogsize]` maximale_Größe_der_Protokolldateien

## Containerprotokolldateien
{: #container-log-files }
Für jede Containerinstanz werden Protokolldateien zu den Laufzeitaktivitäten von {{ site.data.keys.mf_server }} und Liberty Profile generiert. Diese Dateien befinden sich an folgenden Positionen: 

* /opt/ibm/wlp/usr/servers/mfp/logs/messages.log
* /opt/ibm/wlp/usr/servers/mfp/logs/console.log
* /opt/ibm/wlp/usr/servers/mfp/logs/trace.log
* /opt/ibm/wlp/usr/servers/mfp/logs/ffdc/*

Für jede Containerinstanz werden Protokolldateien zu den Laufzeitaktivitäten von MobileFirst-Application-Center-Server- und Liberty Profile generiert. Diese Dateien befinden sich an folgenden Positionen: 

* /opt/ibm/wlp/usr/servers/appcenter/logs/messages.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/console.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/trace.log
* /opt/ibm/wlp/usr/servers/appcenter/logs/ffdc/*

Sie können sich beim Container anmelden (siehe Schritte unter "Zugriff auf Protokolldateien") und auf die Protokolldateien zugreifen. 

Wenn Sie Protokolldateien persistent speichern möchten, um sie zu erhalten, auch wenn ein Container nicht mehr vorhanden ist, müssen Sie einen Datenträger aktivieren. (Standardmäßig ist kein Datenträger aktiviert.) Bei aktiviertem Datenträger können Sie die Protokolle auch in IBM Cloud über die Logmet-Schnittstelle anzeigen (z. B. https://logmet.ng.bluemix.net/kibana).

**Datenträger aktivieren**
Ein Datenträger ermöglicht das persistente Speichern von Protokolldateien für Container. Der Datenträger für die Protokolle des MobileFirst-Server-Containers und des Containers mit {{ site.data.keys.mf_analyics }} ist standardmäßig nicht aktiviert. 

Sie können den Datenträger aktivieren, wenn Sie die Scripts **start*.sh** ausführen. Setzen Sie dazu `ENABLE_VOLUME  [-v | --volume]` auf `Y`. Für eine interaktive Ausführung der Scripts kann diese Eigenschaft auch in den Dateien **args/startserver.properties** und **args/startanalytics.properties** konfiguriert werden. 

Die persistent gespeicherten Protokolldateien befinden sich in den Ordnern **/var/log/rsyslog** und **/opt/ibm/wlp/usr/servers/mfp/logs** des Containers.   
Sie können auf die Protokolle zugreifen, indem Sie eine SSH-Anforderung an den Container absetzen. 

## Zugriff auf Protokolldateien
{: #accessing-log-files }
Protokolle werden für jede Containerinstanz erstellt. Sie können mit der REST-API des Cloud-Service "IBM Containers", mit `cf ic`-Befehlen oder über die IBM Cloud-Logmet-Konsole auf Protokolldateien zugreifen.

### REST-API des Cloud-Service 'IBM Containers'
{: #ibm-container-cloud-service-rest-api }
Die Dateien **docker.log** und **/var/log/rsyslog/syslog** für jede Containerinstanz können mit dem [IBM Cloud-Service 'Logmet'](https://logmet.ng.bluemix.net/kibana/) angezeigt werden. Die Protokollaktivitäten sehen Sie im Kibana-Dashboard dieses Service. 

Mit CLI-Befehlen des Service "IBM Containers" (`cf ic exec`) können Sie Zugriff auf aktive Containerinstanzen erhalten. Alternativ können Sie Containerprotokolldateien über Secure Shell (SSH) abrufen. 

### SSH aktivieren
{: #enabling-ssh}
Zum Aktivieren von
SSH müssen Sie den öffentlichen Schlüssel für SSH in den Ordner **Paketstammverzeichnis/[mfpf-server oder mfpf-analytics]/usr/ssh** kopieren, bevor Sie das Script **prepareserver.sh** oder **prepareanalytics.sh** ausführen. Diese Befehle erstellen das Image mit aktiviertem SSH. Für jeden Container, der mit einem solchen Image erstellt wird, ist SSH aktiviert. 

Wenn SSH im Zuge der Image-Anpassung nicht aktiviert wird, können Sie SSH bei Ausführung des Scripts **startserver.sh** oder **startanalytics.sh** aktivieren, indem Sie das Script mit den Argumenten
SSH\_ENABLE und SSH\_KEY ausführen.
Bei Bedarf können Sie die zugehörigen Eigenschaftendateien der Scripts anpassen und den Schlüsselinhalt aufnehmen. 

Der Endpunkt für Containerprotokolle ruft mit der ID der jeweiligen Containerinstanz stdout-Protokolle ab. 

Beispiel: `GET /containers/{container_id}/logs`

#### Zugriff auf Container über die Befehlszeile
{: #accessing-containers-from-the-command-line }
Sie können über die Befehlszeile auf aktive MobileFirst-Server- und MobileFirst-Analytics-Containerinstanzen zugreifen, um Protokolle und Traces zu erhalten. 

1. Erstellen Sie ein interaktives Terminal in der Containerinstanz. Führen Sie dazu den Befehl `cf ic exec -it Containerinstanz-ID "bash"` aus.
2. Für die Suche nach den Protokolldateien oder Traces können Sie den folgenden Beispielbefehl verwenden: 

   ```bash
   container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
   container_instance@root# vi messages.log
   ```

3. Zum Kopieren der Protokolle auf Ihre lokale Workstation können Sie den folgenden Beispielbefehl verwenden: 

   ```bash
   my_local_workstation# cf ic exec -it container_instance_id
   "cat" " /opt/ibm/wlp/usr/servers/mfp/messages.log" > /tmp/local_messages.log
   ```

#### Zugriff auf Container mit SSH
{: #accessing-containers-using-ssh }
Mit SSH (Secure Shell) können Sie auf Ihren MobileFirst-Server-Container und Ihren Container mit {{ site.data.keys.mf_analytics }} zugreifen und die Systemprotokolle und Liberty-Protokolle abrufen. 

Wenn Sie eine Containergruppe ausführen, können Sie an jede Instanz eine öffentliche IP-Adresse binden und die Protokolle sicher über SSH anzeigen. Zum Aktivieren von
SSH müssen Sie den öffentlichen SSH-Schlüssel in den Ordner **mfp-server\server\ssh** kopieren, bevor Sie das Script **startservergroup.sh** ausführen. 

1. Richten Sie eine SSH-Anforderung an den Container. Beispiel: `mylocal-workstation# ssh -i ~/ssh_key_directory/id_rsa root@public_ip`
2. Archivieren Sie die Position der Protokolldateien. Beispiel:


```bash
container_instance@root# cd /opt/ibm/wlp/usr/servers/mfp
container_instance@root# tar czf logs_archived.tar.gz logs/
```

Laden Sie das Protokollarchiv auf Ihre lokale Workstation herunter. Beispiel:


```bash
mylocal-workstation# scp -i ~/ssh_key_directory/id_rsa root@public_ip:/opt/ibm/wlp/usr/servers/mfp/logs_archived.tar.gz /local_workstation_dir/target_location/
```
