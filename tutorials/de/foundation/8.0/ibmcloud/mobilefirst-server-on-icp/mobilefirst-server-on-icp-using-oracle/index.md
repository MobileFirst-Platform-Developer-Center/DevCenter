---
layout: tutorial
title: Mobile Foundation mit Oracle-Datenbank in IBM Cloud Private einrichten
breadcrumb_title: Foundation with Oracle DB on ICP
relevantTo: [ios,android,windows,javascript]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview}

Das Out-of-the-box-Paket IBM Mobile Foundation - ICP PPA unterstützt die Verwendung von IBM Db2 Server. In diesem Lernprogramm geht es vor allem um die Erweiterung der in IBM Cloud Private (ICP) implementierten Mobile Foundation mit dem Ziel, eine ferne Oracle-Datenbank zum Speichern von Mobile-Foundation-Daten zu verwenden.

## Voraussetzungen
{: #assumption }
Für die Fortsetzung des Lernprogramms wird Folgendes vorausgesetzt:

* Sie haben bereits IBM Cloud Private eingerichtet und das Passport-Advantage-Archiv für die IBM Mobile Foundation in ICP geladen.
* Die für einen fernen Oracle-Datenbankserver erstellten Mobile-Foundation-Datenbanktabellen sind eingerichtet (siehe [Download]((customizable-db-artifacts-for-mfp-icp.zip) und Datenbankscripts für Oracle-Datenbanken für Mobile Foundation Server).
* Die Befehlszeilentools von IBM Cloud Private (`bx pr`, `docker`, `kube` oder `cloudctl` usw.) wurden auf dem lokalen Computer installiert.

>**Hinweis:** Wählrend der Helm-Implementierung für Db2-Datenbanken werden die Tabellen automatisch erstellt. Für Oracle, PostgreSQL oder MySQL müssen Sie die Tabellen manuell erstellen, bevor Sie das Helm-Chart implementieren.

## Anzupassende Artefakte
{: #artifacts-to-be-customized }

Zum Docker-Image für Mobile Foundation Server gehören bestimmte Artefakte, die angepasst werden können, um die Unterstützung für Oracle-Datenbanken zu aktivieren. Nachfolgend sind die Dateien des Docker-Image angegeben, die modifiziert werden müssen, wenn die Container mit Oracle-Artefakten und -Konfigurationen erstellt werden sollen.
1.	`mfpdbconfig.sh`
2.	`mfpfsqldb.xml` (Änderung, um Oracle-Datenbanken und zugehörige Datenquellen zu unterstützen)
3.	Aufnahme des Oracle-Client-JBDC-Treibers
4.	Aktualisierung von `server.xml`

>**Hinweis:** Bei der Anpassung des Basis-Docker-Image muss die obige Reihenfolge der Dateien eingehalten werden. 


### Vorgehensweise
{: #procedure}

1.	Stellen Sie in der ICP-Konsole im **Catalog** sicher, dass die Helm-Charts `ibm-mfpf-*` geladen sind.
2.	Entpacken Sie den Anhang (`mfp-icp-oracle.zip`), um `Dockerfile` und `usr-mfpf-server` (Verzeichnisstruktur und Beispiel für eine `Dockerfile`) zu finden.
3.	Modifizieren Sie die `Dockerfile` so, dass die korrigierte Image-Version für die Erweiterung des Docker-Image verwendet wird.<br/>
     *Beispiel:*<br/>
      `In mycluster.icp:8500/default/mfpf-server:<a.b.c.d>`<br/>
       ist *a.b.c.d* die in der Image-Registry verfügbare Version.
4.	Folgen Sie den Anweisungen im Blog, um das Docker-Image anzupassen und die Mobile-Foundation-Server-Pods zu erstellen.
5.	Wenn Sie das Docker-Image mit den obigen Schritten erweitert haben, können Sie das Helm-Chart für Mobile Foundation Server in der ICP-Konsole implementieren. Stellen Sie sicher, dass das neue Image bereitgestellt wurde.

Informationen zur Erweiterung des Docker-Image finden Sie unter [How to customize the Mobile Foundation Component deployed on IBM Cloud Private (ICP)](https://mobilefirstplatform.ibmcloud.com/blog/2018/11/04/customize-mfp-on-icp/).

>**Hinweis:** Für MySQL- und PostgreSQL-Datenbanken müssen die passenden JDBC-Treiber verwendet werden.
