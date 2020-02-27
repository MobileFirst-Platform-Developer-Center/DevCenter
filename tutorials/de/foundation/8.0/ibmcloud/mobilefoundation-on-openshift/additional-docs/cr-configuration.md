---
layout: tutorial
breadcrumb_title: Konfiguration angepasster Ressourcen für die Mobile Foundation
title: Konfiguration angepasster Ressourcen für die IBM Mobile Foundation
weight: 3
show_in_nav: false
---
<!-- NLS_CHARSET=UTF-8 -->

### Parameter

|Qualifikationsmerkmal |Parameter |Definition |Zulässiger Wert |
|---|---|---|---|
| global.arch | amd64 | Planervorgabe für einen amd64-Worker-Knoten in einem Hybridcluster | amd64 |
| global.image     |pullPolicy |Richtlinie für Image-Übertragung per Pull-Operation | Always, Never oder IfNotPresent. Standardeinstellung: **IfNotPresent** |
|      |  pullSecret    | Geheimer Image-Pull-Schlüssel | Nur erforderlich, wenn Images nicht von der OCP-Image-Registry bereitgestellt werden |
| global.ingress | hostname |Externer Hostname oder IP-Adresse für externe Clients | Lassen Sie das Parameterfeld leer, um standardmäßig die IP-Adresse des Cluster-Proxy-Knotens zu verwenden. |
|         | secret | Name des geheimen TLS-Schlüssels | Gibt den Namen des geheimen Schlüssels für das Zertifikat an, der in der Zugriffsdefinition (Ingress) verwendet werden muss. Der geheime Schlüssel muss vorab mit dem relevanten Zertifikat und Schlüssel erstellt worden sein. Obligatorisch, wenn SSL/TLS aktiviert ist. Erstellen Sie den geheimen Schlüssel mit dem Zertifikat und dem geheimen Schlüssel, bevor Sie hier den Namen angeben. Weitere Informationen finden Sie [hier](#optional-creating-tls-secret-for-ingress-configuration).
|
|         | sslPassThrough | SSL-Durchgriff aktivieren | Gibt an, dass die SSL-Anforderung an den Mobile Foundation Servie übergeben werden soll. Der SSL-Abschluss erfolgt im Mobile Foundation-Service. **false** (Standardwert) oder true |
| global.dbinit | enabled | Initialisierung von Server-, Push- und Application-Center-Datenbank aktivieren | Initialisiert Datenbanken und erstellt Schemata/Tabellen für die Server-, Push- und Application-Center-Implementierung. (Für Analytics nicht erforderlich.) **true** (Standardwert) oder false |
|  | repository | Docker-Image-Repository für die Datenbankinitialisierung | Repository des Docker-Image für die Mobile-Foundation-Datenbank. Der Platzhalter REPO_URL muss durch die richtige Docker-Registry-URL ersetzt wreden. |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
| mfpserver | enabled          | Flag zum Aktivieren des Servers | **true** (Standardwert) oder false |
| mfpserver.image | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Server. Der Platzhalter REPO_URL muss durch die richtige Docker-Registry-URL ersetzt wreden. |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|           | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Weitere Informationen finden Sie [hier](#optional-creating-custom-defined-console-login-secrets).
|  mfpserver.db | type | Name des unterstützten Datenbankanbieters | **DB2** (Standardwert) / MySQL / Oracle |
|               | host | IP-Adresse oder Hostname der Datenbank, für die Mobile-Foundation-Server-Tabellen konfiguriert werden müssen | |
|                       | port | 	Port, der für die Datenbank eingerichtet ist | |
|                       | secret | Vorab erstellter geheimer Schlüssel, der Datenbankberechtigungsnachweise enthält| |
|                       |name | Name der Mobile-Foundation-Server-Datenbank | |
|                       | schema |Zu erstellendes Server-DB2-Schema | Ein bereits vorhandenes Schema wird verwendet. Andernfalls wird ein Schema erstellt. |
|                       | ssl | Datenbankverbindungstyp  | Geben Sie an, ob die Datenbankverbindung über http oder https erfolgt. Der Standardwert ist **false** (http). Stellen Sie sicher, dass der Datenbankport für denselben Verbindungsmodus konfiguriert ist. |
|                       | driverPvc | Anforderung eines persistenten Datenträgers für den Zugriff auf den JDBC-Datenbanktreiber | Geben Sie der Anforderung eines persistenten Datenträgers für den JDBC-Datenbanktreiber an. Erforderlich, wenn der ausgewählte Datenbanktyp nicht DB2 ist. |
|                       | adminCredentialsSecret | Geheimer Schlüssel für MFP-Server-Datenbankverwaltung | Wenn Sie die Datenbankinitialisierung aktiviert haben, geben Sie den geheimen Schlüssel an, um Datenbanktabellen und Schemata für Mobile-Foundation-Komponenten zu erstellen. |
| mfpserver | adminClientSecret | Geheimer Clientschlüssel für Verwaltung | Geben Sie den Namen des erstellten geheimen Clientschlüssels an. Weitere Informationen finden Sie [hier](#optional-creating-secrets-for-confidential-clients).
|
|  | pushClientSecret | Geheimer Clientschlüssel für Push | Geben Sie den Namen des erstellten geheimen Clientschlüssels an. Weitere Informationen finden Sie [hier](#optional-creating-secrets-for-confidential-clients).
|
| mfpserver.replicas |  | Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Server | Positive ganze Zahl (Standardwert: **3**) |
| mfpserver.autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicas" inaktiviert. | **false** (Standardwert) oder true |
|           | minReplicas  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: **1**) |
|           | maxReplicas | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "min" sein. | Positive ganze Zahl (Standardwert: **10**) |
|           | targetCPUUtilizationPercentage | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: **50**) |
| mfpserver.pdb     | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | **true** (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
|    mfpserver.customConfiguration |  |  Angepasste Serverkonfiguration (optional)  | Geben Sie einen zusätzlichen serverspezifische Verweis auf eine vorab erstellte configMap an. Weitere Informationen finden Sie [hier](#optional-custom-server-configuration). |
| mfpserver.jndiConfigurations |mfpfProperties |JNDI-Eigenschaften von Mobile Foundation Server für die Anpassung der Implementierung | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
| mfpserver | keystoreSecret | Im [Konfigurationsabschnitt](#optional-creating-custom-keystore-secret-for-the-deployments) ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
| mfpserver.resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität | Standardeinstellung: **2000m**. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität |Standardeinstellung: **2048Mi** Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. |Standardeinstellung: **1000m** Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Standardeinstellung: **1536Mi**. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfppush | enabled          | Flag zur Aktivierung von Mobile Foundation Push | **true** (Standardwert) oder false |
|           | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Push. Der Platzhalter REPO_URL muss durch die richtige Docker-Registry-URL ersetzt wreden. |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
| mfppush.replicas | | Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Server | Positive ganze Zahl (Standardwert: **3**) |
| mfppush.autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | **false** (Standardwert) oder true |
|           | minReplicas  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: **1**) |
|           | maxReplicas | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: **10**) |
|           | targetCPUUtilizationPercentage | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: **50**) |
| mfppush.pdb     | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | **true** (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: 1) |
| mfppush.customConfiguration |  |  Angepasste Konfiguration (optional)  | Geben Sie einen zusätzlichen Push-spezifischen Verweis auf eine vorab erstellte configMap an. Weitere Informationen finden Sie [hier](#optional-custom-server-configuration).
|
| mfppush.jndiConfigurations |mfpfProperties |JNDI-Eigenschaften von Mobile Foundation Server für die Anpassung der Implementierung | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
| mfppush |keystoresSecretName | Im [Konfigurationsabschnitt](#optional-creating-custom-keystore-secret-for-the-deployments) ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
| mfppush.resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität |Standardeinstellung: **1000m** Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität |Standardeinstellung: **2048Mi** Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Standardeinstellung: **750m**. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. |Standardeinstellung: **1024Mi** Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpanalytics | enabled          | Flag zum Aktivieren von Analytics | **false** (Standardwert) oder true |
| mfpanalytics.image | repository | Docker-Image-Repository | Repository des Docker-Image für Mobile Foundation Operational Analytics. Der Platzhalter REPO_URL muss durch die richtige Docker-Registry-URL ersetzt wreden. |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|           | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Weitere Informationen finden Sie [hier](#optional-creating-custom-defined-console-login-secrets). |
| mfpanalytics.replicas |  | Anzahl der zu erstellenden Instanzen (Pods) von Mobile Foundation Operational Analytics | Positive ganze Zahl (Standardwert: **2**) |
| mfpanalytics.autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | **false** (Standardwert) oder true |
|           | minReplicas  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: **1**) |
|           | maxReplicas | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: **10**) |
|           | targetCPUUtilizationPercentage | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: 50) |
|  mfpanalytics.shards|  | Anzahl der Elasticsearch-Shards für Mobile Foundation Analytics | Standardwert: 2|             
|  mfpanalytics.replicasPerShard|  | Anzahl der pro Shard für Mobile Foundation Analytics zu verwaltenden Elasticsearch-Replikate | Standardwert: **2** |
| mfpanalytics.persistence | enabled         | Verwenden Sie eine Anforderung eines persistenten Datenträgers zum persistenten Speichern von Daten. | **true** |                                                 |
|            |useDynamicProvisioning      | Geben Sie eine Speicherklasse an oder lassen Sie das Feld leer. | **false**  |                                                  |
|           |volumeName| Geben Sie einen Datenträgernamen an.  | **data-stor** (Standardwert) |
|           |claimName|Geben Sie eine vorhandene Anforderung eines persistenten Datenträgers an. | nil |
|           |storageClassName     | Speicherklasse der unterstützenden Anforderung eines persistenten Datenträgers | nil |
|           |size    | Größe des Datenträgers | 20Gi |
| mfpanalytics.pdb     | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | **true** (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: **1**) |
|    mfpanalytics.customConfiguration |  |  Angepasste Konfiguration (optional)  | Geben Sie einen zusätzlichen Analytics-spezifischen Verweis auf eine vorab erstellte configMap an (siehe [hier] (#optional-custom-server-configuration)). |
| mfpanalytics.jndiConfigurations |mfpfProperties | Mobile-Foundation-JNDI-Eigenschaften, die für die Anpassung von Operational Analytics angegeben werden müssen | Geben Sie eine Liste mit Name-Wert-Paaren, jeweils getrennt durch ein Komma, an. |
| mfpanalytics | keystoreSecret | Im [Konfigurationsabschnitt](#optional-creating-custom-keystore-secret-for-the-deployments) ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
| mfpanalytics.resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität |Standardeinstellung: **1000m** Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität |Standardeinstellung: **2048Mi** Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Standardeinstellung: **750m**. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Der Standardwert ist 1024Mi. Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |
| mfpappcenter | enabled          | Flag zum Aktivieren des Application Center | **false** (Standardwert) oder true |  
| mfpappcenter.image | repository | Docker-Image-Repository | Repository des Docker-Image für das Mobile Foundation Application Center. Der Platzhalter REPO_URL muss durch die richtige Docker-Registry-URL ersetzt wreden. |
|           |tag |Docker-Image-Tag | Siehe Docker-Tag-Beschreibung |
|           | consoleSecret | Vorab erstellter geheimer Schlüssel für die Anmeldung | Weitere Informationen finden Sie [hier](#optional-creating-custom-defined-console-login-secrets). |
|  mfpappcenter.db | type | Name des unterstützten Datenbankanbieters | **DB2** (Standardwert) / MySQL / Oracle |
|                   | host | IP-Adresse oder Hostname für die Konfiguration der Application-Center-Datenbank | |
|                       | port | 	Port der Datenbank  | |             
|                       |name |Name der zu verwendenden Datenbank |Die Datenbank muss zuvor erstellt worden sein. |
|                       | secret | Vorab erstellter geheimer Schlüssel, der Datenbankberechtigungsnachweise enthält| |
|                       | schema | Zu erstellendes Application-Center-Datenbankschema | Ein bereits vorhandenes Schema wird verwendet. Andernfalls wird ein Schema erstellt. |
|                       | ssl | Datenbankverbindungstyp  | Geben Sie an, ob die Datenbankverbindung über http oder https erfolgt. Der Standardwert ist **false** (http). Stellen Sie sicher, dass der Datenbankport für denselben Verbindungsmodus konfiguriert ist. |
|                       | driverPvc | Anforderung eines persistenten Datenträgers für den Zugriff auf den JDBC-Datenbanktreiber | Geben Sie der Anforderung eines persistenten Datenträgers für den JDBC-Datenbanktreiber an. Erforderlich, wenn der ausgewählte Datenbanktyp nicht DB2 ist. |
|                       | adminCredentialsSecret | Geheimer Schlüssel für Application-Center-Datenbankverwaltung | Wenn Sie die Datenbankinitialisierung aktiviert haben, geben Sie den geheimen Schlüssel an, um Datenbanktabellen und Schemata für Mobile-Foundation-Komponenten zu erstellen. |
| mfpappcenter.autoscaling     | enabled | Gibt an, ob ein HPA (Horizontal Pod Autoscaler) implementiert ist. Bei Aktivierung dieses Feldes wird das Feld "replicaCount" inaktiviert. | **false** (Standardwert) oder true |
|           | minReplicas  | Untergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann | Positive ganze Zahl (Standardwert: **1**) |
|           | maxReplicas | Obergrenze für die Anzahl der Pods, die vom Autoscaler eingestellt werden kann. Dieser Wert darf nicht kleiner als der von "minReplicas" sein. | Positive ganze Zahl (Standardwert: **10**) |
|           | targetCPUUtilizationPercentage | Angestrebte durchschnittliche CPU-Auslastung über alle Pods (dargestellt als Prozentsatz der erforderlichen CPU-Kapazität) | Ganze Zahl zwischen 1 und 100 (Standardwert: **50**) |
| mfpappcenter.pdb     | enabled | Gibt an, ob PDB aktiviert oder inaktiviert werden soll. | **true** (Standardwert) oder false |
|           | min  | Minimum der verfügbaren Pods | Positive ganze Zahl (Standardwert: **1**) |
| mfpappcenter.customConfiguration |  |  Angepasste Konfiguration (optional)  | Geben Sie einen zusätzlichen Application-Center-spezifischen Verweis auf eine vorab erstellte configMap an. Weitere Informationen finden Sie [hier](#optional-custom-server-configuration).
|
| mfpappcenter | keystoreSecret | Im [Konfigurationsabschnitt](#optional-creating-custom-keystore-secret-for-the-deployments) ist beschrieben, wie der geheime Schlüssel vorab mit den Keystores und den zugehörigen Kennwörtern erstellt werden muss. |
| mfpappcenter.resources |limits.cpu |Beschreibt die maximal zulässige CPU-Kapazität |Standardeinstellung: **1000m** Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|                  |limits.memory |Beschreibt die maximal zulässige Speicherkapazität |Standardeinstellung: **2048Mi** Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory)|
|           |requests.cpu | Beschreibt die erforderliche CPU-Mindestkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. | Standardeinstellung: **750m**. Siehe Kubernetes-Artikel [Meaning of CPU](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-cpu) |
|           |requests.memory |Beschreibt die erforderliche Mindestspeicherkapazität. Fehlt die Angabe, wird standardmäßig der Wert von "limits" verwendet (sofern angegeben) oder der für die Implementierung definierte Wert. |Standardeinstellung: **1024Mi** Siehe Kubernetes-Artikel [Meaning of Memory](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#meaning-of-memory) |

## Kundenspezifische geheime Anmeldeschlüssel für die Konsole erstellen [optional]

Standardmäßig werden die geheimen Anmeldeschlüssel für die Konsole für alle Mobile-Foundation-Komponenten automatisch während der Implementierung erstellt. Sie haben aber die Möglichkeit, explizit einen **geheimen Anmeldeschlüssel** für den Zugriff auf die Server-, Analytics- und Application-Center-Konsole zu erstellen. Nachfolgend sehen Sie ein Beispiel. 

Server:

```
kubectl create secret generic serverlogin --from-literal=MFPF_ADMIN_USER=admin --from-literal=MFPF_ADMIN_PASSWORD=admin
```

Analytics:

```
kubectl create secret generic analyticslogin --from-literal=MFPF_ANALYTICS_ADMIN_USER=admin --from-literal=MFPF_ANALYTICS_ADMIN_PASSWORD=admin
```

Application Center:

```
kubectl create secret generic appcenterlogin --from-literal=MFPF_APPCNTR_ADMIN_USER=admin --from-literal=MFPF_APPCNTR_ADMIN_PASSWORD=admin
```

> HINWEIS: Wenn diese geheimen Schlüssel nicht zur Verfügung gestellt werden, werden sie während der Installation der Mobile Foundation mit dem Standardbenutzernamen admin und dem Kennwort admin erstellt.

## Geheimen TLS-Schlüssel für die Ingress-Konfiguration erstellen [optional]

Mobile-Foundation-Komponenten können so konfiguriert werden, dass externe Clients unter Verwendung des Hostnamens auf die Komponenten zugreifen. Der Zugriff kann mit einem privaten TLS-Schlüssel und einem TLS-Zertifikat geschützt werden. Der private TLS-Schlüssel und das TLS-Zertifikat müssen in einem geheimen Schlüssel mit den Schlüsselnamen `tls.key` und `tls.crt` definiert werden.

Der geheime Schlüssel **mf-tls-secret** wird in demselben Namespace wie die Zugriffsressource (Ingress) erstellt. Verwenden Sie dafür den folgenden Befehl.

```
kubectl create secret tls mf-tls-secret --key=/path/to/tls.key --cert=/path/to/tls.crt
```

Der Name des geheimen Schlüssels wird dann im Feld *global.ingress.secret* der angepassten YAML-Ressourcenkonfigurationsdatei angegeben.

## Kundenspezifischen geheimen Keystore-Schlüssel für Implementierungen erstellen [optional]

Sie können Ihren eigenen Keystore und Truststore für die Implementierung von Server, Analytics und Application Center angeben, indem Sie mit Ihrem eigenen Keystore und Truststore einen geheimen Schlüssel erstellen.

Erstellen Sie vorab einen geheimen Schlüssel mit `keystore.jks` und `truststore.jks` sowie ein Keystore- und Truststore-Kennwort. Verwenden Sie dafür die Literale KEYSTORE_PASSWORD und TRUSTSTORE_PASSWORD. Geben Sie den Namen des geheimen Schlüssels im Feld "keystoreSecret" für die betreffende Komponente an.

Im folgenden Beispiel wird ein geheimer Keystore-Schlüssel für die Serverimplementierung unter Verwendung von `keystore.jks` und `truststore.jks` erstellt. Außerdem werden die zugehörigen Kennwörter festgelegt.
```
kubectl create secret generic server-secret --from-file=./keystore.jks --from-file=./truststore.jks --from-literal=KEYSTORE_PASSWORD=worklight --from-literal=TRUSTSTORE_PASSWORD=worklight
```

> HINWEIS: Die Namen der Dateien und Literale müssen mit den Angaben im obigen Befehl übereinstimmen. Geben Sie diesen Namen des geheimen Schlüssels im Eingabefeld `keystoresSecretName` der jeweiligen Komponente an, um die Standard-Keystores beim Konfigurieren des Helm-Charts außer Kraft zu setzen. 


## Geheime Schlüssel für vertrauliche Clients erstellen [optional]

Mobile Foundation Server ist vorab mit vertraulichen Clients für den Verwaltungsservice definiert. Die Berechtigungsnachweise für diese Clients werden in den Feldern `mfpserver.adminClientSecret` und `mfpserver.pushClientSecret` angegeben.

Sie können diese geheimen Schlüssel wie folgt erstellen: 

```
kubectl create secret generic mf-admin-client --from-literal=MFPF_ADMIN_AUTH_CLIENTID=admin --from-literal=MFPF_ADMIN_AUTH_SECRET=admin

kubectl create secret generic mf-push-client --from-literal=MFPF_PUSH_AUTH_CLIENTID=admin --from-literal=MFPF_PUSH_AUTH_SECRET=admin
```

Wenn die Werte für die Felder `mfpserver.pushClientSecret` und `mfpserver.adminClientSecret` nicht während der Helm-Chart-Installation angegeben werden, werden standardmäßig geheime Clientschlüssel mit den folgenden Berechtigungsnachweisen erstellt: 

* `admin / nimda` für `mfpserver.adminClientSecret`
* `push / hsup` für `mfpserver.pushClientSecret`

## Angepasste Serverkonfiguration [optional]

Zur Anpassung der Konfiguration (beispielsweise zur Änderung einer Protokolltraceeinstellung, zum Hinzufügen einer neuen JNDI-Eigenschaft usw.) müssen Sie eine Konfigurationszuordnung (configMap) mithilfe der XML-Konfigurationsdatei erstellen. So können Sie eine neue Konfigurationseinstellung hinzufügen oder die vorhandene Konfiguration der Mobile-Foundation-Komponenten überschreiben.

Die Mobile-Foundation-Komponenten greifen auf die angepasste Konfiguration über eine configMap (mfpserver-custom-config) zu, die wie folgt erstellt wird:

```
kubectl create configmap mfpserver-custom-config --from-file=<Konfigurationsdatei im XML-Format>
```

Die mit dem obigen Befehl erstellte Konfigurationszuordnung (configMap) muss während der Mobile-Foundation-Implementierung in der **angepassten Serverkonfiguration** im Helm-Chart angegeben werden.

Es folgt ein Beispiel für die Einstellung der Traceprotokollspezifikation auf Warnungen mithilfe der configMap mfpserver-custom-config. (Standardmäßig ist die Spezifikation auf Informationen eingestellt.)

- XML-Beispielkonfiguration (logging.xml)

```
<server>
        <logging maxFiles="5" traceSpecification="com.ibm.mfp.*=debug:*=warning"
        maxFileSize="20" />
</server>
```

- ConfigMap erstellen und während der Helm-Chart-Implementierung hinzufügen

```
kubectl create configmap mfpserver-custom-config --from-file=logging.xml
```

- Beachten Sie die Änderung in der Datei messages.log (von Mobile-Foundation-Komponenten): ***Property traceSpecification will be set to com.ibm.mfp.=debug:\*=warning.***

## Generierte kundenspezifische STPA-Schlüssel verwenden [optional]

Die Mobile-Foundation-Images enthalten standardmäßig eine Reihe von LTPA-Schlüsseln (`ltpa.keys`) für die Mobile-Foundation-Komponenten. Wenn die sofort einsatzfähigen LTPA-Schlüssel (`ltpa.keys`) in einer Produktionsumgebung durch generierte kundenspezifische Schlüssel ersetzt werden müssen, können Sie die angepasste Konfiguration nutzen, um generierte kundenspezifische `ltpa.keys` zusammen mit der Datei config.xml hinzuzufügen.

Nachfolgend sehen Sie eine Beispielkonfigurationsdatei `ltpa.xml`.

```xml
<server description="mfpserver">
    <ltpa
        keysFileName="ltpa.keys" />
    <webAppSecurity ssoUseDomainFromURL="true" />
</server>
```

Der folgende Beispielbefehl fügt die kundenspezifischen LTPA-Schlüssel hinzu. 

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys
```

Weitere Einzelheiten zum Generieren von LTPA-Schlüsseln finden Sie in der [Liberty-Dokumentation](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/twlp_sec_ltpa.html).

**Hinweis:** Wenn Sie eine kundenspezifische Konfiguration hinzufügen möchten, dürfen Sie nicht mehrere angepasste configMaps verwenden. Sie sollten stattdessen wie folgt eine *configmap* für die kundenspezifische Konfiguration erstellen: 

```bash
kubectl create configmap mfpserver-custom-config --from-file=ltpa.xml --from-file=ltpa.keys --from-file=moreconfig.xml
```
