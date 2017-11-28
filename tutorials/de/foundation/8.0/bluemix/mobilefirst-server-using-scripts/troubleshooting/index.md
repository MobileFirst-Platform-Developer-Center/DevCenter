---
layout: tutorial
title: Fehlerbehebung
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### Probleme mit der {{ site.data.keys.product_full }} in IBM Containern lösen	
{: #resolving-problems-with-ibm-mobilefirst-foundation-on-ibm-containers }
Wenn beim Arbeiten mit der {{ site.data.keys.product_full }} in IBM Containern ein Problem auftritt, das Sie nicht lösen können, stellen Sie die folgenden wichtigen Informationen zusammen, bevor Sie Kontakt zum
IBM Support aufnehmen.

Stellen Sie die folgenden Informationen zusammen, um den Fehlerbehebungsprozess zu beschleunigen: 

* Verwendete Version der {{ site.data.keys.product }} (Version 8.0.0 oder eine aktuellere Version) und alle angewendeten vorläufigen Fixes 
* Gewählte Containergröße, z. B. Medium 2GB
* Art des Bluemix-dashDB-Datenbankplans, z. B. EnterpriseTransactional 2.8.50
* Container-ID
* Öffentliche IP-Adresse (sofern zugewiesen)
* Version von Docker und Cloud Foundry: `cf -v` und `docker version`
* Von den folgenden Befehlen des Cloud-Foundry-CLI-Plug-ins für IBM Container (cf ic) zurückgegebene Informationen von der Organisation und dem Bereich, in der bzw. in dem Ihr Container mit der {{ site.data.keys.product }} implementiert ist: 
 - `cf ic info`
 - `cf ic ps -a` (Falls mehrere Containerinstanzen aufgelistet sind, bezeichnen Sie die Instanz, bei der das Problem besteht.) 
* Wenn während der Containererstellung, d. h. beim Ausführen des Scripts **startserver.sh**, Secure Shell (SSH) und Datenträger aktiviert waren, stellen Sie alle Dateien aus den Ordnern /opt/ibm/wlp/usr/servers/mfp/logs und /var/log/rsyslog/syslog zusammen. 
* Wenn nur Datenträger aktiviert waren, SSH jedoch nicht, stellen Sie über das Bluemix-Dashboard die verfügbaren Protokolldaten zusammen. Wenn Sie im Bluemix-Dashboard auf die Containerinstanz geklickt haben, klicken Sie in der Seitenleiste auf den Link "Monitoring and Logs". Öffnen Sie die Registgerkarte "Logging" und klicken Sie auf ADVANCED VIEW. Das Kibana-Dashboard wird
separat geöffnet. Verwenden Sie die Suchsymbolleiste für den Stack-Trace für Ausnahmebedingungen. Stellen Sie die vollständigen Details der Ausnahme (@Zeitmarke, _ID) zusammen.

### Docker-Fehler nach der Scriptausführung	
{: #docker-related-error-while-running-script }
Wenn nach Ausführung des Scripts initenv.sh oder prepareserver.sh Docker-bezogene Fehler angezeigt werden, versuchen Sie, den Docker-Service neu zu starten. 

**Beispielnachricht** 

> Pulling repository docker.io/library/ubuntu  
> Error while pulling image: Get https://index.docker.io/v1/repositories/library/ubuntu/images: dial tcp: lookup index.docker.io on 192.168.0.0:00: DNS message ID mismatch

**Erläuterung**  
Der Fehler kann auftreten, wenn sich die Internetverbindung geändert hat (z. B. Herstellung oder Trennung einer VPN-Verbindung oder eine Änderung der
Netzkonfiguration) und die Docker-Laufzeitumgebung noch nicht neu gestartet wurde. In einer solchen Situation treten Fehler auf, wenn Docker-Befehle abgesetzt
werden. 

**Problemlösung**  
Starten Sie den Docker-Service neu. Tritt der Fehler erneut auf, starten Sie den Computer neu und dann den Docker-Service. 

### Bluemix-Registryfehler	
{: #bluemix-registry-error }
Wenn nach Ausführung des Scripts prepareserver.sh oder prepareanalytics.sh ein Registry-bezogener Fehler angezeigt wird, versuchen Sie zuerst, das Script initenv.sh auszuführen. 

**Erläuterung**  
Netzprobleme, die während der Ausführung des Scripts prepareserver.sh oder
prepareanalytics.sh auftreten, können dazu führen, dass die Verarbeitung blockiert wird und dann fehlschlägt. 

**Problemlösung**  
Führen Sie zunächst erneut das Script initenv.sh aus, um sich bei der
Container-Registry in Bluemix anzumelden. Führen Sie dann erneut
das zuvor fehlgeschlagene Script aus. 

### Datei mfpfsqldb.xml kann nicht erstellt werden
{: #unable-to-create-the-mfpfsqldbxml-file }
Bei Ausführung des Scripts **prepareserverdbs.sh** tritt gegen Ende der folgende Fehler auf: 

> Error: unable to create mfpfsqldb.xml

**Problemlösung**  
Es könnte eine vorübergehende Störung der Datenbankverbindungen vorliegen. Versuchen Sie erneut, das Script auszuführen. 

### Übertragung des Image dauert lange	
{: #taking-a-long-time-to-push-image }
Wenn Sie das Script prepareserver.sh ausführen, dauert es mehr als 20 Minuten, ein Image mit Push in die IBM Container-Registry zu übertragen. 

**Erläuterung**  
Das Script **prepareserver.sh** überträgt den gesamten Stack der {{ site.data.keys.product }} per Push-Operation. Dieser Prozess kann 20 bis 60 Minuten dauern. 

**Problemlösung**  
Wenn das Script nach 60 Minuten noch nicht abgeschlossen ist, wurde der Prozess vielleicht wegen eines Verbindungsproblems blockiert. Starten Sie das Script erneut, nachdem Sie eine
stabile Verbindung hergestellt haben. 

### Fehler wegen unvollständiger Bindung	
{: #binding-is-incomplete-error }
Wenn Sie ein Script zum Starten eines Containers ausführen (z. B. **startserver.sh** oder **startanalytics.sh**),
werden Sie wegen einer unvollständigen Bindung aufgefordert, manuell eine IP-Adresse zu binden. 

**Erläuterung**  
Das Script ist so konzipiert, dass es nach einer bestimmten Zeitspanne beendet wird. 

**Problemlösung**  
Binden Sie die IP-Adresse manuell, indem Sie den zugehörigen Befehl cf ic ausführen, z. B. cf ic ip bind.

Wenn das manuelle Binden der IP-Adresse nicht erfolgreich ist, stellen Sie sicher, dass der Container aktiv ist. Wiederholen Sie dann den Bindungsversuch.
                      
**Hinweis:** Für eine erfolgreiche Bindung müssen Container aktiv sein. 

### Script schlägt fehl und gibt eine Nachricht zu Token zurück	
{: #script-fails-and-returns-message-about-tokens }
Die Ausführung eines Scripts ist nicht erfolgreich. Eine Nachricht wie "Refreshing cf tokens" oder "Failed to refresh token" wird zurückgegeben.

**Erläuterung**  
Möglicherweise wurde das zulässige Zeitlimit für die Bluemix-Sitzung überschritten. Der Benutzer muss sich bei Bluemix angemeldet haben, bevor er die Containerscripts ausführt. 

**Verwendungshinweise**
Führen Sie erneut das Script initenv.sh aus, um sich bei Bluemix anzumelden. Führen Sie dann nochmals das fehlgeschlagene Script aus. 

### Verwaltungsdatenbank, Liveaktualisierungsservice und Push-Service werden als inaktiv angezeigt	
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
In der {{ site.data.keys.mf_console }} werden die Verwaltungsdatenbank, der Liveaktualisierungsservice und der Push-Service als inaktiv angezeigt oder es sind keine Laufzeiten aufgelistet, obwohl das Script **prepareserver.sh** erfolgreich ausgeführt wurde. 

**Erläuterung**  
Es ist möglich, dass eine Verbindung zur Datenbank nicht hergestellt wurde oder dass in der Datei server.env beim Anfügen zusätzlicher Werte während der Implementierung
ein Formatierungsproblem aufgetreten ist. 

Wenn zur Datei server.env zusätzliche Werte ohne Zeilenvorschubzeichen hinzugefügt wurden, können die Eigenschaften nicht aufgelöst werden. Sie können feststellen, ob dieses Problem besteht,
indem Sie die Protokolldateien auf Fehler wegen nicht aufgelöster Eigenschaften überprüfen.
Solche Fehler könnten wie folgt aussehen: 

> FWLSE0320E: Failed to check whether the admin services are ready. Caused by: [project Sample] java.net.MalformedURLException: Bad host: "${env.IP_ADDRESS}"



**Problemlösung**  
Starten Sie die Container manuell neu. Besteht das Problem weiterhin, überprüfen Sie, ob die Anzahl der Verbindungen zum Datenbankservice
die in Ihrem Datenbankplan vorgesehene Anzahl Verbindungen überschreitet. Ist das der Fall, nehmen Sie die erforderlichen Anpassungen vor. 

Wenn das Problem durch nicht aufgelöste Eigenschaften hervorgerufen wurde, stellen Sie sicher, dass Ihr Editor beim Bearbeiten der bereitgestellten Dateien
das Zeilenvorschubzeichen (LF)
hinzufügt, um das Ende einer Zeile zu markieren. Die App TextEdit für macOS könnte das Zeilenende beispielsweise mit dem Zeichen CR und nicht mit LF markieren, was dann zu diesem Problem führen würde. 

### Script prepareserver.sh schlägt fehl	
{: #prepareserversh-script-fails }
Das Script **prepareserver.sh** schlägt fehl und gibt den Fehler "405 Method Not Allowed" zurück.

**Erläuterung**  
Wenn Sie das Script **prepareserver.sh** ausführen, um das Image per Push an die IBM Container-Registry zu senden, tritt der folgende Fehler auf. 

> Pushing the {{ site.data.keys.mf_server }} image to the IBM Containers registry.  
> Error response from daemon:  
> 405 Method Not Allowed  
> Method Not Allowed  
> The method is not allowed for the requested URL.

Dieser Fehler tritt in der Regel auf, wenn in der Hostumgebung Docker-Variablen modifiziert wurden. Nach der Ausführung des Scripts initenv.sh stellen die Tools eine Option zum Überschreiben der lokalen Docker-Umgebung bereit, um mit nativen Docker-Befehlen eine Verbindung zum Service "IBM Containers" herstellen zu können. 

**Problemlösung**  
Modifizieren Sie die Docker-Variablen (z. B. DOCKER\_HOST und DOCKER\_CERT\_PATH) nicht so, dass sie auf die Umgebung der IBM Container-Registry zeigen. Wenn das Script **prepareserver.sh** ordnungsgemäß funktionieren soll, müssen die Docker-Variablen
auf die lokale Docker-Umgebung zeigen. 
