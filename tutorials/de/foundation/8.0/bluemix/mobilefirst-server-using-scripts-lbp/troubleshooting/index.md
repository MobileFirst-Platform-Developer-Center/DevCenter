---
layout: tutorial
title: Fehlerbehebung
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### Probleme mit der {{ site.data.keys.product_full }} in einer Liberty-for-Java-Laufzeit lösen	
{: resolving-problems-with-ibm-mobilefirst-foundation-on-liberty-for-java-runtime }
Wenn beim Arbeiten mit der IBM MobileFirst Foundation in einer Liberty-for-Java-Laufzeit
ein Problem auftritt, das Sie nicht lösen können,
stellen Sie die folgenden wichtigen Informationen zusammen, bevor Sie Kontakt zum
IBM Support aufnehmen.

Stellen Sie die folgenden Informationen zusammen, um den Fehlerbehebungsprozess zu beschleunigen: 

* Verwendete Version der IBM
MobileFirst Foundation (Version 8.0.0 oder eine aktuellere
Version) und alle angewendeten vorläufigen Fixes 
* Gewählte Größe der Liberty-for-Java-Laufzeit, z. B. 2 GB.
* Art des Bluemix-dashDB-Datenbankplans, z. B. EnterpriseTransactional 2.8.500
* Route für die MobileFirst-Platform-Konsole (mfpconsole)
* Cloud-Foudry-Versionen: `cf -v` 
* Von den folgenden CLI-Befehlen zurückgegebene Informationen zur Organisation und zu dem Bereich, in der bzw. in dem Ihr MobileFirsts Foundation Server implementiert ist: 
 - `cf app APP_NAME`

### Datei mfpfsqldb.xml kann nicht erstellt werden
{: #unable-to-create-the-mfpfsqldbxml-file }
Bei Ausführung des Scripts **prepareserverdbs.sh** tritt gegen Ende der folgende Fehler auf: 

> Error: unable to create mfpfsqldb.xml

**Problemlösung**  
Es könnte eine vorübergehende Störung der Datenbankverbindungen vorliegen. Versuchen Sie erneut, das Script auszuführen. 

### Script schlägt fehl und gibt eine Nachricht zu Token zurück	
{: #script-fails-and-returns-message-about-tokens }
Die Ausführung eines Scripts ist nicht erfolgreich. Eine Nachricht wie "Refreshing cf tokens" oder "Failed to refresh token" wird zurückgegeben.

**Erläuterung**  
Möglicherweise wurde das zulässige Zeitlimit für die Bluemix-Sitzung überschritten. Der Benutzer muss sich bei Bluemix angemeldet haben, bevor er die Scripts ausführt. 

**Verwendungshinweise**
Führen Sie erneut das Script initenv.sh aus, um sich bei Bluemix anzumelden. Führen Sie dann nochmals das fehlgeschlagene Script aus. 

### Verwaltungsdatenbank, Liveaktualisierungsservice und Push-Service werden als inaktiv angezeigt	
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
In der MobileFirst Foundation Operations Console werden die Verwaltungsdatenbank, der Liveaktualisierungsservice und
der Push-Service als inaktiv angezeigt oder es sind keine Laufzeiten aufgelistet, obwohl das Script **prepareserver.sh** erfolgreich ausgeführt wurde. 

**Erläuterung**  
Es ist möglich, dass eine Verbindung zur Datenbank nicht hergestellt wurde oder dass in der Datei server.env beim Anfügen zusätzlicher Werte während der Implementierung
ein Formatierungsproblem aufgetreten ist. 

Wenn zur Datei server.env zusätzliche Werte ohne Zeilenvorschubzeichen hinzugefügt wurden, können die Eigenschaften nicht aufgelöst werden. Sie können feststellen, ob dieses Problem besteht,
indem Sie die Protokolldateien auf Fehler wegen nicht aufgelöster Eigenschaften überprüfen.
Solche Fehler könnten wie folgt aussehen: 

> FWLSE0320E: Failed to check whether the admin services are ready. Caused by: [project Sample] java.net.MalformedURLException: Bad host: "${env.IP_ADDRESS}"

**Problemlösung**  
Starten Sie die Liberty-App manuell. Besteht das Problem weiterhin, überprüfen Sie, ob die Anzahl der Verbindungen zum Datenbankservice
die in Ihrem Datenbankplan vorgesehene Anzahl Verbindungen überschreitet. Ist das der Fall, nehmen Sie die erforderlichen Anpassungen vor. 

Wenn das Problem durch nicht aufgelöste Eigenschaften hervorgerufen wurde, stellen Sie sicher, dass Ihr Editor beim Bearbeiten der bereitgestellten Dateien
das Zeilenvorschubzeichen (LF)
hinzufügt, um das Ende einer Zeile zu markieren. Die App TextEdit für macOS könnte das Zeilenende beispielsweise mit dem Zeichen CR und nicht mit LF markieren, was dann zu diesem Problem führen würde. 

