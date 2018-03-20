---
layout: tutorial
title: Anwendungen in Test- und Produktionsumgebungen implementieren

breadcrumb_title: Deploying apps to environments
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn der Entwicklungszyklus Ihrer Anwendung abgeschlossen ist, implementieren Sie die Anwendung in einer Testumgebung und dann in einer Produktionsumgebung.

### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to }

* [Adapter in einer Produktionsumgebung implementieren oder aktualisieren](#deploying-or-updating-an-adapter-to-a-production-environment)
* [SSL zwischen MobileFirst-Adaptern und Back-End-Servern mit selbst signierten Zertifikaten konfigurieren](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates)
* [Anwendungsbuild für eine Test- oder Produktionsumgebung erstellen](#building-an-application-for-a-test-or-production-environment)
* [Anwendung in einer Produktionsumgebung registrieren](#registering-an-application-to-a-production-environment)
* [Serverseitige Artefakte auf einen Test- oder Produktionsserver übertragen](#transferring-server-side-artifacts-to-a-test-or-production-server)
* [{{ site.data.keys.product_adj }}-Apps in der Produktion aktualisieren](#updating-mobilefirst-apps-in-production)

## Adapter in einer Produktionsumgebung implementieren oder aktualisieren
{: #deploying-or-updating-an-adapter-to-a-production-environment }
Adapter enthalten den serverseitigen Code von Anwendungen, die in der {{ site.data.keys.product }} implementiert werden und für die die {{ site.data.keys.product }} Services bereitstellt.
Lesen Sie die folgende Checkliste, bevor Sie einen Adapter in einer Produktionsumgebung implementieren oder aktualisieren. Weitere Informationen zum Erstellen von Adaptern finden Sie unter [Serverseite einer {{ site.data.keys.product_adj }}-Anwendung entwickeln](../../adapters).

Adapter können hochgeladen, aktualisiert oder konfiguriert werden, während der Produktionsserver aktiv ist.
Wenn alle Knoten einer Server-Farm den neuen Adapter oder die neue Konfiguration empfangen haben, werden für alle beim Adapter eingehenden Anforderungen die neuen Einstellungen
verwendet. 

1. Wenn Sie einen vorhandenen Adapter in einer Produktionsumgebung aktualisieren möchten, vergewissern Sie sich, dass es bei diesem Adapter keine Inkompatibilität oder Regression mit vorhandenen, bei einem Server registrierten Anwendungen gibt.

    Ein Adapter kann von mehreren Anwendungen genutzt werden oder von mehreren Versionen einer Anwendung, die bereits im Store veröffentlicht sind und verwendet werden. Führen Sie auf einem Testserver mit dem neuen Adapter und mit App-Kopien, die für den Testserver erstellt wurden, Regressionstests durch, bevor Sie den Adapter in einer Produktionsumgebung aktualisieren.

2. Wenn ein Java-Adapter Java URLConnection mit HTTPS verwendet, vergewissern Sie sich, dass die Back-End-Zertifikate im Keystore von
{{ site.data.keys.mf_server }}
enthalten sind. 
        
    Weitere Informationen finden Sie unter
[SSL in HTTP-Adaptern verwenden](../../adapters/javascript-adapters/js-http-adapter/using-ssl/). Weitere Informationen zur Verwendung selbst signierter Zertifikate finden Sie unter [SSL zwischen MobileFirst-Adaptern und Back-End-Servern mit selbst signierten Zertifikaten konfigurieren](#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates).

    > **Hinweis:** Wenn der Anwendungsserver WebSphere Application Server Liberty ist, müssen sich die Zertifikate auch im Liberty-Truststore befinden.


3. Überprüfen Sie die serverseitige Konfiguration des Adapters. 
4. Verwenden Sie die Befehle `mfpadm deploy adapter` und `mfpadm adapter set
user-config`, um den Adapter und seine Konfiguration hochzuladen. 

    Weitere Informationen zu **mfpadm** für Adapter finden Sie unter [Befehle für Adapter](../using-cli/#commands-for-adapters).
        
## SSL zwischen Adaptern und Back-End-Servern mit selbst signierten Zertifikaten konfigurieren
{: #configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates }
Sie können SSL zwischen Adaptern und Back-End-Servern konfigurieren, indem Sie das selbst signierte SSL-Zertifikat des Servers in den {{ site.data.keys.product_adj }}-Keystore importieren.

1. Exportieren Sie das öffentliche Zertifikat des Servers aus dem Back-End-Server-Keystore.

    > **Hinweis:** Exportieren Sie öffentliche Back-End-Zertifikate aus dem Back-End-Keystore mit keytool oder openssl lib. Verwenden Sie
das Exportfeature export nicht in einem Web-Browser.


2. Importieren Sie das Back-End-Serverzertifikat in den {{ site.data.keys.product_adj }}-Keystore.
3. Implementieren Sie das neue Zertifikat im {{ site.data.keys.product_adj }}-Keystore. Weitere Informationen finden Sie unter [Keystore von {{ site.data.keys.mf_server }} konfigurieren](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).

### Beispiel
{: #example }
Der **CN**-Name des Back-End-Zertifikats muss mit dem Wert übereinstimmen, der in der Adapterdeskriptordatei **adapter.xml** konfiguriert wurde.
Angenommen, es wurde eine Datei **adapter.xml** mit dem folgenden Inhalt konfiguriert:


```xml
<protocol>https</protocol>
<domain>mybackend.com</domain>
```

In diesem Fall muss das Back-End-Zertifikat mit **CN=mybackend.com** generiert werden.

Verwenden Sie die folgende
Adapterkonfiguration als weiteres Beispiel:


```xml
<protocol>https</protocol>
<domain>123.124.125.126</domain>
```

In diesem Fall muss das Back-End-Zertifikat mit **CN=123.124.125.126** generiert werden.

Das folgende Beispiel veranschaulicht, wie Sie die
Konfiguration mit dem Programm "keytool" durchführen. 

1. Erstellen Sie einen Back-End-Server-Keystore mit einem privatem Zertifikat, das
365 Tage gültig ist. 
        
    ```bash
    keytool -genkey -alias backend -keyalg RSA -validity 365 -keystore backend.keystore -storetype JKS
    ```

    > **Hinweis:** Das Feld
**First
and Last Name** enthält Ihre Server-URL, die Sie in der Konfigurationsdatei
**adapter.xml** verwenden, z. B.
**mydomain.com** oder **localhost**.

2. Konfigurieren Sie Ihren Back-End-Server für die Interaktion mit dem Keystore.
Für Apache Tomcat müssen Sie beispielsweise die Datei
**server.xml** wie folgt ändern: 

   ```xml
   <Connector port="443" SSLEnabled="true" maxHttpHeaderSize="8192" 
      maxThreads="150" minSpareThreads="25" maxSpareThreads="200"
      enableLookups="false" disableUploadTimeout="true"         
      acceptCount="100" scheme="https" secure="true"
      clientAuth="false" sslProtocol="TLS"
      keystoreFile="backend.keystore" keystorePass="password" keystoreType="JKS"
      keyAlias="backend"/>
   ```
        
3. Prüfen Sie die Konnektivitätskonfiguration in der Datei **adapter.xml**:

   ```xml
   <connectivity>
      <connectionPolicy xsi:type="http:HTTPConnectionPolicyType">
        <protocol>https</protocol>
        <domain>mydomain.com</domain>
        <port>443</port>
        <!-- Mit den folgenden Eigenschaften wählt der Key Manager des Adapters ein bestimmtes Zertifikat aus dem Keystore aus.
        <sslCertificateAlias></sslCertificateAlias>
        <sslCertificatePassword></sslCertificatePassword>
        -->		
      </connectionPolicy>
      <loadConstraints maxConcurrentConnectionsPerNode="2"/>
   </connectivity>
   ```
        
4. Exportieren Sie das öffentliche Zertifikat aus dem erstellten Back-End-Server-Keystore:

   ```bash
   keytool -export -alias backend -keystore backend.keystore -rfc -file backend.crt
   ```
        
5. Importieren Sie das exportierte Zertifikat wie folgt in Ihren MobileFirst-Server-Keystore:

   ```bash
   keytool -import -alias backend -file backend.crt -storetype JKS -keystore mfp.keystore
   ```
        
6. Prüfen Sie, ob das Zertifikat ordnungsgemäß in den Keystore importiert wurde: 

   ```bash
   keytool -list -keystore mfp.keystore
   ```
        
7. Implementieren Sie das neue Zertifikat im {{ site.data.keys.mf_server }}-Keystore. 

## Anwendungsbuild für eine Test- oder Produktionsumgebung erstellen
{: #building-an-application-for-a-test-or-production-environment }
Wenn Sie einen Anwendungsbuild für eine Test- oder Produktionsumgebung erstellen möchten, müssen Sie die Anwendung für den Zielserver konfigurieren. Bei einem Anwendungsbuild für eine
Produktionsumgebung sind zusätzliche Schritte erforderlich. 

1. Vergewissern Sie sich, dass der Keystore des Zielservers konfiguriert ist. Weitere Informationen finden Sie unter [Keystore von {{ site.data.keys.mf_server }} konfigurieren](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).

2. Wenn Sie das installierbare App-Artefakt verteilen möchten, erhöhen Sie die App-Version.
3. Bevor Sie den App-Build erstellen, müssen Sie die App für den Zielserver konfigurieren.

    Die URL und den Laufzeitnamen des Zielservers definieren Sie in der Clienteigenschaftendatei. Sie können auch den Zielserver über die {{ site.data.keys.mf_cli }} ändern. Wenn Sie die App für einen Zielserver konfigurieren möchten, ohne sie bei einem aktiven Server zu registrieren, können Sie dafür die Befehle `mfpdev app config server <Server-URL>` und `mfpdev app config runtime <Laufzeitname>` verwenden. Mit dem Befehl `mfpdev app register` können Sie die App bei einem aktiven Server registrieren. Verwenden Sie die öffentliche URL des Servers. Über diese URL stellt die mobile App eine Veribindung zu {{ site.data.keys.mf_server }} her.
    
    Wenn Sie die App beispielsweise für den Zielserver mfp.mycompany.com mit einer Laufzeit, deren Standardname "mfp" ist, konfigurieren möchten, führen Sie `mfpdev app config server https://mfp.mycompany.com` und `mfpdev app config runtime mfp` aus.
    
4. Konfigurieren Sie die geheimen Schlüssel und autorisierten Server für Ihre Anwendung.
    * Wenn Ihre App das Certificate Pinning implementiert, verwenden Sie das Zertifikat Ihres Zielservers. Weitere Informationen zum Certificate Pinning finden Sie unter [Certificate Pinning](../../authentication-and-security/certificate-pinning).
    * Wenn Ihre iOS-App mit ATS (App-Transportsicherheit) arbeitet, konfiguieren Sie ATS für Ihren Zielserver.
    * Wie eine sichere direkte Aktualisierung für eine Apache-Cordova-Anwendung konfiguriert wird, erfahren Sie unter [Sichere direkte Aktualisierung auf der Clientseite implementieren](../../application-development/direct-update).
    * Wenn Sie Ihre App mit Apache Cordova entwickeln, konfigurieren Sie die Cordova-Inhaltssicherheitsrichtlinie (CSP, Content Security Policy).    

5. Falls Sie die direkte Aktualisierung auf eine mit Apache Cordova entwickelte Anwendung anwenden möchten, archivieren Sie die für den App-Build verwendeten Cordova-Plug-in-Versionen.

    Nativer Code kann nicht mithilfe der direkten Aktualisierung aktualisiert werden. Wenn Sie die native Bibliothek oder eines der Buildtools in einem Cordova-Projekt geändert und eine solche Datei auf den {{ site.data.keys.mf_server }} hochgeladen haben, erkennt der Server den Unterschied und sendet keine Aktualisierungen für die Clientanwendung. Bei der Änderung der nativen Bibliothek kann es sich um eine andere Cordova-Version oder ein neueres Cordova-iOS-Plug-in handeln oder auch um ein Plug-in-Fixpack für mfpdev, das aktueller ist, als das für den Build der ursprünglichen Anwendung verwendete.
    
6. Konfigurieren Sie die App für den Produktionseinsatz.
    * Überlegen Sie, ob Ausgaben im Geräteprotokoll inaktiviert werden sollen.
    * Wenn Sie {{ site.data.keys.mf_analytics }} verwenden möchten, vergewissern Sie sich, dass Ihre App erfasste Daten an {{ site.data.keys.mf_server }} sendet.
    * Sie sollten die Inaktivierung von Features Ihrer App, die die API `setServerURL` aufrufen, in Erwägung ziehen, es sei denn, Sie möchten einen Build für mehrere Testserver erstellen.

7. Wenn Sie einen Build für einen Produktionsserver erstellen und das installierbare Artefakt verteilen möchten, archivieren Sie den App-Quellcode, damit Sie auf einem Testserver Regressionstests für diese App durchführen können.

    Sollten Sie später einen Adapter aktualisieren, können Sie für bereits verteilte Apps, die diesen Adapter verwenden, Regressionstests durchführen. Weitere Informationen finden Sie unter [Adapter in einer Produktionsumgebung implementieren oder aktualisieren](#deploying-or-updating-an-adapter-to-a-production-environment).
    
8. Erstellen Sie die Anwendungsauthentizitätsdatei für Ihre Anwendung (optional).

    Nach der Registrierung der Anwendung beim Server verwenden Sie die Anwendungsauthentizitätsdatei, um die Sicherheitsüberprüfung der Anwendungsauthentizität zu aktivieren.
    * Weitere Informationen finden Sie unter [Sicherheitsüberprüfung der Anwendungsauthentizität aktivieren](../../authentication-and-security/application-authenticity).
    * Weitere Informationen zum Registrieren einer Anwendung bei einem Produktionsserver finden Sie unter [Anwendung in einer Produktionsumgebung registrieren](#registering-an-application-to-a-production-environment).

## Anwendung in einer Produktionsumgebung registrieren
{: #registering-an-application-to-a-production-environment }
Wenn Sie eine Anwendung auf einem Produktionsserver registrieren, ladenSie den Anwendungsdeskriptor hoch, definieren Sie den Lizenztyp der Anwendung und aktivieren Sie ggf. die Anwendungsauthentizität. 

#### Vorbereitungen
{: #before-you-begin }
* Vergewissern Sie sich, dass der Keystore von {{ site.data.keys.mf_server }} konfiguriert und nicht der Standard-Keystore ist. Verwenden Sie einen Server in der Produktion nicht mit dem Standard-Keystore. Der Keystore von {{ site.data.keys.mf_server }} definiert die Identität von MobileFirst-Server-Instanzen und wird zum digitalen Signieren von OAuth-Token und Paketen für direkte Aktualisierung verwendet. Bevor Sie den Keystore des Servers in der Produktion verwenden, müssen Sie ihn mit einem geheimen Schlüssel konfigurieren. Weitere Informationen finden Sie unter [Keystore von {{ site.data.keys.mf_server }} konfigurieren](../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).
* Implementieren Sie die von der App verwendeten Adapter. Weitere Informationen finden Sie unter [Adapter in einer Produktionsumgebung implementieren oder aktualisieren](#deploying-or-updating-an-adapter-to-a-production-environment).
* Erstellen Sie den Anwendungsbuild für Ihren Zielserver. Weitere Informationen finden Sie unter
[Anwendungsbuild für eine Test- oder Produktionsumgebung erstellen](#building-an-application-for-a-test-or-production-environment).

Wenn Sie eine Anwendung bei einem Produktionsserver registrieren, laden Sie den Anwendungsdeskriptor hoch, definieren Sie den Lizenztyp der Anwendung und aktivieren Sie ggf. die Anwendungsauthentizität. Sie können auch eine Aktualisierungsstrategie definieren, wenn bereits eine Version Ihrer App implementiert ist. In den folgenden Abschnitten lernen Sie wichtige Schritte und Möglichkeiten für die Automation dieser Schritte mit dem Programm **mfpadm** kennen.

1. Wenn Ihr {{ site.data.keys.mf_server }} für die Tokenlizenzierung konfiguriert ist, vergewissern Sie sich, dass auf dem License Key Server genug Token verfügbar sind. Weitere Informationen finden Sie unter [Validierung von Tokenlizenzen](../license-tracking/#token-license-validation) und [Verwendung der Tokenlizenzierung planen](../../installation-configuration/production/token-licensing/#planning-for-the-use-of-token-licensing).

   > **Tipp:** Bevor Sie die erste Version Ihrer App registrieren, können Sie den Tokenlizenztyp für Ihre App festlegen. Weitere Informationen finden Sie unter [Angaben zur Anwendungslizenz festlegen](../license-tracking/#setting-the-application-license-information).



2. Übertragen Sie den Anwendungsdeskriptor von einem Testserver auf einen Produktionsserver.

   Damit wird Ihre Anwendung beim Produktionsserver registriert und die Konfiguration Ihrer Anwendung hochgeladen. Weitere Informationen zum Übertragen eines Anwendungsdeskriptors finden Sie unter [Serverseitige Artefakte auf einen Test- oder Produktionsserver übertragen](#transferring-server-side-artifacts-to-a-test-or-production-server).

3. Legen Sie die Daten der Anwendungslizenz fest. Weitere Informationen finden Sie unter [Daten der Anwendungslizenz festlegen](../license-tracking/#setting-the-application-license-information).
4. Konfigurieren Sie die Sicherheitsüberprüfung der Anwendungsauthentizität. Weitere Informationen zum Konfigurieren der Sicherheitsüberprüfung der Anwendungsauthentizität finden Sie unter [Sicherheitsüberprüfung der Anwendungsauthentizität konfigurieren](../../authentication-and-security/application-authenticity/#configuring-application-authenticity).

   > **Hinweis:** Zum Erstellen der Anwendungsauthentizitätsdatei benötigen Sie die Anwendungsbinärdatei. Weitere Informationen finden Sie unter [Sicherheitsüberprüfung der Anwendungsauthentizität aktivieren](../../authentication-and-security/application-authenticity/#enabling-application-authenticity).

5. Wenn Ihre Anwendung Push-Benachrichtigungen verwendet, laden Sie die Zertifikate für Push-Benachrichtigungen auf den Server hoch. Sie können die Push-Zertifikate für Ihre Anwendung in der {{ site.data.keys.mf_console }} hochladen. Der Zertifikate gelten für alle Versionen einer Anwendung.

   > **Hinweis:** Unter Umständen können Sie die Push-Benachrichtigungen für Ihre App mit Produktionszertifikaten erst testen, wenn Ihre App im Store veröffentlicht ist.



6. Überprüfen Sie die folgenden Punkte, bevor Sie die Anwendung im Store veröffentlichen:
    * Testen Sie die von Ihnen geplanten Verwaltungsfeatures für mobile Anwendungen, z. B. die Inaktivierung von Anwendungen über Fernzugriff oder die Anzeige einer Administratornachricht. Weitere Informationen finden Sie unter [Mobile Anwendungen verwalten](../using-console/#mobile-application-management).
    * Definieren Sie im Falle eines Updates eine passende Strategie. Weitere Informationen finden Sie unter [{{ site.data.keys.product_adj }}-Apps in der Produktion aktualisieren](#updating-mobilefirst-apps-in-production).

## Serverseitige Artefakte auf einen Test- oder Produktionsserver übertragen
{: #transferring-server-side-artifacts-to-a-test-or-production-server }
Mit Befehlszeilentools oder einer REST-API können Sie eine Anwendungskonfiguration auf einen anderen Server übertragen. 

Die Anwendungsdeskriptordatei ist eine JSON-Datei mit der Beschreibung und Konfiguration Ihrer Anwendung. Wenn Sie eine App ausführen, die eine Verbindung zu einer MobileFirst-Server-Instanz herstellt, muss die App bei diesem Server registriert und für diesen Server konfiguriert sein. Wenn Sie eine Konfiguration für Ihre App definiert haben, können Sie den Anwendungsdeskriptor auf einen anderen Server übertragen, z. B. auf einen Test- oder Produktionsserver. Nach der Übertragung des Anwendungsdeskriptors auf den neuen Server ist die App bei dem neuen Server registriert. Abhängig davon, ob Sie mobile Anwendungen entwickeln und Zugriff auf den Code haben oder Server verwalten und keinen Zugriff auf den Code der mobilen App haben, sind verschiedene Vorgehensweisen möglich.

> **Wichtiger Hinweis:** Wenn Sie eine Anwendung mit Authentizitätsdaten importieren und diese Anwendung seit der Generierung der Authentizitätsdaten erneut kompiliert wurde, müssen Sie die Authentizitätsdaten aktualisieren. Weitere Informationen finden Sie unter [Sicherheitsüberprüfung der Anwendungsauthentizität konfigurieren](../../authentication-and-security/application-authenticity/#configuring-application-authenticity).



* Wenn Sie auf den Code der mobilen App zugreifen können, verwenden Sie die Befehle `mfpdev app pull` und `mfpdev app push`.
* Wenn Sie keinen Zugriff auf den Code der mobilen App haben, verwenden Sie den Verwaltungsservice.

#### Fahren Sie mit folgenden Abschnitten fort:
{: #jump-to-1 }

* [Anwendungskonfiguration mit mfpdev übertragen](#transferring-an-application-configuration-by-using-mfpdev)
* [Anwendungskonfiguration mit dem Verwaltungsservice übertragen](#transferring-an-application-configuration-with-the-administration-service)
* [Serverseitige Artefakte mit der REST-API übertragen](#transferring-server-side-artifacts-by-using-the-rest-api)
* [Anwendungen und Adapter in der MobileFirst Operations Console exportieren und importieren](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)

### Anwendungskonfiguration mit mfpdev übertragen
{: #transferring-an-application-configuration-by-using-mfpdev }
Wenn Sie Ihre Anwendung entwickelt haben, können Sie sie von Ihrer Entwicklungsumgebung auf eine Test- oder Produktionsumgebung übertragen. 

* Auf Ihrem lokalen Computer muss eine {{ site.data.keys.product_adj }}-App vorhanden sein. Die App muss bei einem {{ site.data.keys.mf_server }} registriert sein. Führen Sie **mfpdev app register** aus, um Informationen zur Erstellung eines Serverprofils zu erhalten, oder lesen Sie in dieser Dokumentation unter "Anwendungen entwickeln" den Abschnitt zur Registrierung Ihres App-Typs.
* Von Ihrem lokalen Computer muss es eine Verbindungsmöglichkeit zu dem Server geben, bei dem Ihre App derzeit registriert ist, sowie zu dem Server, auf den Sie Ihre App übertragen möchten.
* Auf dem lokalen Computer muss es ein Serverprofil für den ursprünglichen {{ site.data.keys.mf_server }} geben sowie für den Server, auf den Sie Ihre App übertragen möchten. Führen Sie **mfpdev server add**, um Informationen zur Erstellung eines Serverprofils zu erhalten.
* Die {{ site.data.keys.mf_cli }} muss installiert sein.

Senden Sie mit dem Befehl **mfpdev app pull** eine Kopie der serverseitigen Konfigurationsdateien für Ihre App an Ihren lokalen Computer. Senden Sie die Dateien dann mit dem Befehl **mfpdev app push** an einen anderen {{ site.data.keys.mf_server }}. Der Befehl **mfpdev app push** registriert die App auch bei dem angegebenen Server.

Mit diesen Befehlen können Sie auch eine Laufzeitkonfiguration auf einen anderen Server übertragen.

Zu den Konfigurationsdaten gehören der Inhalt des Anwendungsdeskriptors, über den der Server die App eindeutig identifizieren kann, und weitere, für die App spezifische Informationen. Die Konfigurationsdateien werden als komprimierte Dateien (im ZIP-Format) bereitgestellt. Die ZIP-Dateien werden in das Verzeichnis **App-Name/mobilefirst** gestellt, und wie folgt benannt:

```bash
appID-platform-version-artifacts.zip
```

Hier steht **App-ID** für den Anwendungsnamen, **Plattform** für **android**, **ios** oder **windows** und **Version** für den Versionsstand Ihrer App. Bei Cordova-Apps wird für jede Zielplattform eine gesonderte ZIP-Datei erstellt.

Wenn Sie den Befehl **mfpdev app push** verwenden, werden die Clienteigenschaftendateien der Anwendung modifiziert, damit sie den Profilnamen und die URL des neuen {{ site.data.keys.mf_server }} widerspiegeln.

1. Navigieren Sie auf Ihrem Entwicklungscomputer zum Stammverzeichnis Ihrer App oder einem der zugehörigen Unterverzeichnisse.
2. Führen Sie den Befehl **mfpdev app pull** aus. Wenn Sie den Befehl ohne Parameter angeben, wird die App per Pull-Operation vom Standard-MobileFirst-Server übertragen. Sie können auch einen bestimmten Server und das zugehörige Administratorkennwort angeben. Für eine Android-Anwendung mit dem Namen **myapp1** müssten Sie beispielsweise Folgendes angeben:

   ```bash
   cd myapp1
   mfpdev app pull Server10 -password secretPassword!
   ```
    
   Dieser Befehl findet die Konfigurationsdateien für die aktuelle Anwendung auf dem {{ site.data.keys.mf_server }}, dessen Serverprofil den Namen Server10 hat. Anschließend sendet der Befehl die komprimierte Datei **myapp1-android-1.0.0-artifacts.zip**, die diese Konfigurationsdateien enthält, an den lokalen Computer und stellt sie dort in das Verzeichnis **myapp1/mobilefirst**.
    
3. Führen Sie den Befehl **mfpdev app push** aus. Wenn Sie den Befehl ohne Parameter angeben, wird die App per Push-Operation zum Standard-MobileFirst-Server übertragen. Sie können auch einen bestimmten Server und das zugehörige Administratorkennwort angeben. Für unser Beispiel verwenden wir wieder die Anwendung, die beim vorherigen Schritt per Pull übertragen wurde: `mfpdev app push Server12 -password secretPass234!`.
    
   Dieser Befehl sendet die Datei **myapp1-android-1.0.0-artifacts.zip** an den {{ site.data.keys.mf_server }}, dessen Serverprofil den Namen Server12 hat und dessen Administratorkennwort **secretPass234!** lautet. Die Clienteigenschaftendatei **myapp1/app/src/main/assets/mfpclient.properties** wird modifiziert, um anzugeben, dass der Server, bei dem die App registriert ist, Server12 ist. Außerdem gibt die Datei die URL dieses Servers an.

Die serverseitigen Konfigurationsdateien der App befinden sich auf dem {{ site.data.keys.mf_server }}, den Sie im Befehl mfpdev app push angegeben haben. Die App ist bei diesem neuen Server registriert.

### Anwendungskonfiguration mit dem Verwaltungsservice übertragen
{: #transferring-an-application-configuration-with-the-administration-service }
Als Administrator können Sie eine Anwendungskonfiguration mit dem Verwaltungsservice von {{ site.data.keys.mf_server }} auf einen anderen Server übertragen. Ein Zugriff auf den Anwendungscode ist nicht erforderlich. Es muss aber einen Build der Client-App für den Zielserver geben.

#### Vorbereitungen
{: #before-you-begin-1 }
Erstellen Sie den Build der Client-App für Ihren Zielserver. Weitere Informationen finden Sie unter
[Anwendungsbuild für eine Test- oder Produktionsumgebung erstellen](#building-an-application-for-a-test-or-production-environment).

Laden Sie den Anwendungsdeskriptor von dem Server, auf dem die Anwendung konfiguriert ist, herunter und implementieren Sie ihn auf dem neuen Server. Den Anwendungsdeskriptor können Sie in der {{ site.data.keys.mf_console }} anzeigen.

1. Überprüfen Sie den Anwendungsdeskriptor auf dem Server, auf dem der Anwendungsserver konfiguriert ist (optional). Öffnen Sie die {{ site.data.keys.mf_console }} fürdiesen Server, wählen Sie Ihre Anwendungsversion aus und öffnen Sie die Registerkarte **Konfigurationsdateien**.

2. Laden Sie den Anwendungsdeskriptor von dem Server herunter, auf dem die Anwendung konfiguriert ist. Für den Download können Sie die REST-API oder **mfpadm** verwenden.

   > **Hinweis:** Sie können in der {{ site.data.keys.mf_console }} auch eine Anwendung oder Anwendungsversion exportieren (siehe [Anwendungen und Adapter in der {{ site.data.keys.mf_console }} exportieren und importieren](#exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console)).

    * Wenn Sie den Anwendungsdeskriptor mit der REST-API herunterladen möchten, verwenden Sie die REST-API [Application Descriptor (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_descriptor_get.html?view=kc#Application-Descriptor--GET-).

    Die folgende URL gibt den Anwendungsdeskriptor der Anwendung mit der App-ID **my.test.application** für die Plattform **ios** und die Version **0.0.1** zurück. Der Aufruf wird an {{ site.data.keys.mf_server }} gerichtet: `http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/applications/my.test.application/ios/0.0.1/descriptor`.
    
    Eine solche URL können Sie beispielsweise mit einem Tool wie curl verwenden: `curl -user admin:admin http://[...]/ios/0.0.1/descriptor > desc.json`.
    
    <br/>
    Passen Sie die folgenden Elemente der URL an Ihre Serverkonfiguration an:
     * **9080** ist der Standard-HTTP-Port von {{ site.data.keys.mf_server }} während der Entwicklung.
     * **mfpadmin** ist das standardmäßige Kontextstammverzeichnis des Verwaltungsservice. 

    Weitere Informationen zu der REST-API finden Sie unter "REST-API für den MobileFirst-Server-Verwaltungsservice".
     * Laden Sie den Anwendungsdeskriptor mit **mfpadm** herunter.

       Das Programm **mfpadm** wird installiert, wenn sie das Installationsprogramm für {{ site.data.keys.mf_server }} ausführen. Sie können das Programm im Verzeichnis **Produktinstallationsverzeichnis/shortcuts** starten. Hier steht **Produktinstallationsverzeichnis** für das Installationsverzeichnis von {{ site.data.keys.mf_server }}.
    
       Mit dem folgenden Beispiel wird eine Kennwortdatei erstellt, die der Befehl **mfpadm** benötigt. Anschließend wird der Anwendungsdeskriptor der Anwendung mit der App-ID **my.test.application** für die Plattform **ios** und die Version **0.0.1** heruntergeladen. Die angegebene URL ist die HTTPS-URL von {{ site.data.keys.mf_server }}  während der Entwicklung.
    
       ```bash
       echo password=admin > password.txt
       mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app version mfp my.test.application ios 0.0.1 get descriptor > desc.json
       rm password.txt
       ```
    
       Passen Sie die folgenden Elemente der Befehlszeile an Ihre Serverkonfiguration an:
        * **9443** ist der Standard-HTTPS-Port von {{ site.data.keys.mf_server }} während der Entwicklung.
        * **mfpadmin** ist das standardmäßige Kontextstammverzeichnis des Verwaltungsservice. 
        * --secure false gibt an, dass das SSL-Zertifikat des Servers auch dann akzeptiert wird, wenn es selbst signiert ist oder für einen anderen als den in der URL angegebenen Hostnamen erstellt wurde.

       Weitere Informationen zum Programm **mfpadm** finden Sie unter [{{ site.data.keys.product_adj }}-Anwendungen über die Befehlszeile verwalten](../using-cli).
    
3. Laden Sie den Anwendungsdeskriptor auf den neuen Server hoch, um die App zu registrieren oder ihre Konfiguration zu aktualisieren. Für den Upload können Sie die REST-API oder **mfpadm** verwenden.
   * Wenn Sie den Anwendungsdeskriptor mit der REST-API hochladen möchten, verwenden Sie die REST-API [Application (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_application_post.html?view=kc#Application--POST-).
    
     Mit der folgenden URL wird der Anwendungsdeskriptor für die Laufzeit mfp hochgeladen. Sie können eine POST-Anforderung mit dem JSON-Anwendungsdeskriptor als Nutzdaten senden. Der Aufruf im folgenden Beispiel ist an den Server gerichtet, der auf dem lokalen Computer ausgeführt wird und dessen HTTP-Port auf 9081 gesetzt ist.
    
     ```bash
     http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```
    
     Eine solche URL können Sie beispielsweise mit einem Tool wie curl verwenden.
    
     ```bash
     curl -H "Content-Type: application/json" -X POST -d @desc.json -u admin:admin \ http://localhost:9081/mfpadmin/management-apis/2.0/runtimes/mfp/applications/
     ```    
    
   * Laden Sie den Anwendungsdeskriptor mit mfpadm hoch.

     Mit dem folgenden Beispiel wird eine Kennwortdatei erstellt, die der Befehl mfpadm benötigt. Anschließend wird der Anwendungsdeskriptor der Anwendung mit der App-ID my.test.application für die Plattform ios und die Version 0.0.1 hochgeladen. Die angegebene URL ist die HTTPS-URL eines Servers, der auf dem lokalen Computer ausgeführt wird und dessen HTTPS-Port auf 9444 gesetzt ist, für eine Laufzeit mit dem Namen mfp.

     ```bash
     echo password=admin > password.txt
     mfpadm --url https://localhost:9444/mfpadmin --secure false --user admin \ --passwordfile password.txt \ deploy app mfp desc.json 
     rm password.txt
     ```

### Serverseitige Artefakte mit der REST-API übertragen
{: #transferring-server-side-artifacts-by-using-the-rest-api }
Mit dem MobileFirst-Server-Verwaltungsservice können Sie unabhängig von Ihrer Rolle
Anwendungen, Adapter und Ressourcen zur Sicherung oder Wiederverwendung exportieren. Als Administrator oder Deployer können Sie außerdem ein Exportarchiv auf einem anderen
Server implementieren. Ein Zugriff auf den Anwendungscode ist nicht erforderlich. Es muss aber einen Build der Client-App für den Zielserver geben.

#### Vorbereitungen
{: #before-you-begin-2 }
Erstellen Sie den Build der Client-App für Ihren Zielserver. Weitere Informationen finden Sie unter
[Anwendungsbuild für eine Test- oder Produktionsumgebung erstellen](#building-an-application-for-a-test-or-production-environment).

Die Export-API ruft die ausgewählten Artefakte für eine Laufzeit als
.zip-Archiv ab. Nutzen Sie die Implementierungs-API, wenn Sie archivierte Inhalte wiederverwenden möchten. 

> **Wichtiger Hinweis:** Überdenken Sie Ihren Anwendungsfall gründlich.  
>  
> * Die Exportdatei enthält die Anwendungsauthentizitätsdaten. Diese Daten sind spezifisch für den Build einer mobilen App. Die mobile App enthält die URL und den Laufzeitnamen des Servers. Wenn Sie also einen anderen Server oder eine andere Laufzeit verwenden möchten, müssen Sie einen neuen App-Build erstellen. Eine Übertragung der exportierten App-Dateien ist nicht ausreichend.

> * Bestimmte Artefakte können je nach Server verschieden sein. In einer Entwicklungsumgebung werden beispielsweise andere Push-Berechtigungsnachweise als in einer Produktionsumgebung verwendet.

> * Die Anwendungslaufzeitkonfiguration (mit dem Aktivierungs-/Inaktivierungszustand und den Protokollprofilen) kann nicht in allen Fällen übertragen werden.
> * Die Übertragung von Webressourcen ist in einigen Fällen nicht sinnvoll, z. B. wenn Sie einen neuen App-Build erstellen, weil Sie einen neuen Server verwenden möchten.

* Wenn Sie alle oder ausgewählte Ressourcen für einen Adapter oder für alle Adapter exportieren möchten, verwenden Sie die API [Export Adapter Resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapter_resources_get.html?view=kc) oder [Export Adapters (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_adapters_get.html?view=kc).
* Wenn Sie alle Ressourcen einer bestimmten Anwendungsumgebung (wie Android oder iOS) exportieren möchten, d. h. alle Versionen und alle Ressourcen der Versionen in dieser Umgebung, verwenden Sie die API [Export Application Environment (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_get.html?view=kc).
* Wenn Sie alle Ressourcen für eine bestimmte Anwendungsversion (z. B. Version 1.0 oder 2.0 einer Android-Anwendung) exportieren möchten, verwenden Sie die API [Export Application Environment Resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_environment_resources_get.html?view=kc).
* Wenn Sie eine bestimmte Anwendung oder alle Anwendungen für eine Laufzeit exportieren möchten, verwenden Sie die API [Export Applications (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_applications_get.html?view=kc) oder [Export Application Resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_application_resources_get.html?view=kc). **Hinweis:** Berechtigungsnachweise für Push-Benachrichtigungen gehören nicht zu den exportierten Anwendungsressourcen.
* Wenn Sie für eine Anwendung den Adapterinhalt, den Deskriptor, die Lizenzkonfiguration, den Inhalt, die Benutzerkonfiguration, den Keystore und die Webressourcen exportieren möchten, verwenden Sie die API [Export Resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_resources_get.html?view=kc#Export-resources--GET-).
* Wenn Sie alle oder ausgewählte Ressourcen für eine Laufzeit exportieren möchten, verwenden Sie die API [Export Runtime Resources (GET)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_export_runtime_resources_get.html?view=kc). Mit dem folgenden allgemeinen curl-Befehl können Sie beispielsweise alle Ressourcen als .zip-Datei abrufen:

  ```bash
  curl -X GET -u admin:admin -o exported.zip
  "http://localhost:9080/worklightadmin/management-apis/2.0/runtimes/mfp/export/all"
  ```
    
* Wenn Sie ein Archiv mit Webanwendungsressourcen wie Adapter-, Anwendungs- und Lizenzkonfiguation, Keystore und Webressourcen implementieren möchten, verwenden Sie die API [Deploy (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_post.html?view=kc). Mit dem folgenden curl-Befehl können Sie beispielsweise eine vorhandene .zip-Datei mit Artefakten implementieren:

  ```bash
  curl -X POST -u admin:admin -F
  file=@/Users/john_doe/Downloads/export_applications_adf_ios_2.zip
  "http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/deploy/multi"
  ```

* Wenn Sie Anwendungsautzentizitätsdaten implementieren möchten, verwenden Sie die API [Deploy Application Authenticity Data (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_application_authenticity_data_post.html?view=kc).
* Verwenden Sie zum Implementieren der Webressourcen einer Anwendung die API [Deploy a Web Resource (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_deploy_a_web_resource_post.html?view=kc).

Wenn Sie ein Exportarchiv wieder in derselben Laufzeit implementieren, wird es nicht zwirngend so wiederhergestellt, wie es exportiert wurde. Änderungen, die nachträglich vorgenommen wurden, werden bei der erneuten Implmentierung nicht entfernt. Wurden zwischen dem Export und der erneuten Implementierung Anwendungsressourcen modifiziert, werden nur die im exportierten Archiv enthaltenen Dateien in ihrem ursprünglichen Zustand wiederhergestellt. Angenommen, Sie exportieren eine Anwendung ohne Authentizitätsdaten, laden danach die Authentizitäten hoch und importieren dann das ursprünglich exportierte Archiv. Die Authentizitätsdaten werden in dem Fall nicht gelöscht.

### Anwendungen und Adapter in der {{ site.data.keys.mf_console }} exportieren und importieren
{: #exporting-and-importing-applications-and-adapters-from-the-mobilefirst-operations-console }
Unter bestimmten Bedingungen können Sie in der Konsole eine Anwendung oder eine Version einer Anwendung exportieren und anschließend in eine andere Laufzeit auf demselben oder einem anderen Server importieren. Sie können auch Adapter exportieren und reimportieren. Nutzen Sie diese Möglichkeit für Wiederverwendungs- und Sicherungszwecke.

Wenn Ihnen die Administratorrolle **mfpadmin** oder die Deployer-Rolle **mfpdeployer** zugeordnet ist, können Sie eine Version oder alle Versionen einer Anwendung exportieren. Die Anwendung oder Version wird als komprimierte Datei (.zip) exportiert, in der die Anwendungs-ID, Deskriptoren, Authentizitätsdaten und Webressourcen gespeichert sind. Später können Sie das Archiv importieren, um die Anwendung oder Version in einer anderen Laufzeit bzw. auf demselben oder einem anderen Server zu implementieren.

> **Wichtiger Hinweis:** Überdenken Sie Ihren Anwendungsfall gründlich.  
> 
> * Die Exportdatei enthält die Anwendungsauthentizitätsdaten. Diese Daten sind spezifisch für den Build einer mobilen App. Die mobile App enthält die URL und den Laufzeitnamen des Servers. Wenn Sie also einen anderen Server oder eine andere Laufzeit verwenden möchten, müssen Sie einen neuen App-Build erstellen. Eine Übertragung der exportierten App-Dateien ist nicht ausreichend.

> * Bestimmte Artefakte können je nach Server verschieden sein. In einer Entwicklungsumgebung werden beispielsweise andere Push-Berechtigungsnachweise als in einer Produktionsumgebung verwendet.

> * Die Anwendungslaufzeitkonfiguration (mit dem Aktivierungs-/Inaktivierungszustand und den Protokollprofilen) kann nicht in allen Fällen übertragen werden.
> * Die Übertragung von Webressourcen ist in einigen Fällen nicht sinnvoll, z. B. wenn Sie einen neuen App-Build erstellen, weil Sie einen neuen Server verwenden möchten.

Sie können auch Anwendungsdeskriptoren übertragen. Verwenden Sie dazu die REST-API oder das Tool mfpadm. Weitere Informationen finden Sie unter [Anwendungskonfiguration mit dem Verwaltungsservice übertragen](#transferring-an-application-configuration-with-the-administration-service).

1. Wählen Sie in der Navigationsseitenleiste eine Anwendung oder Anwendungsversion aus.
2. Wählen Sie **Aktionen → Anwendung exportieren** oder **Version exportieren** oder **Adapter exportieren** aus.

    Sie werden aufgefordert, das ZIP-Archiv (.zip), in dem die exportierten Ressourcen zusammengefasst sind, zu speichern. Das genaue Aussehen des Dialogfensgters hängt von Ihrem Browser ab und der gewählte Zielordner von Ihren Browsereinstellungen.

3. Speichern Sie die Archivdatei.

    Der Name der Archivdatei enthält den Namen und die Version der Anwendung oder des Adapters, z. B. **export_applications_com.sample.zip**.

4. Wenn Sie ein vorhandenes Exportarchiv wiederverwenden möchten, wählen Sie **Aktionen → Anwendung importieren** oder **Version importieren** aus, navigieren Sie zu dem Archiv und klicken Sie auf **Implementieren**.

Im Hauptrahmen der Konsole werden die Details der importieren Anwendung bzw. des importierten Adapters The main console frame displays the details of the angezeigt.

Wenn Sie die Anwendung oder Version wieder in dieselbe Laufzeit importieren, wird sie nicht zwirngend so wiederhergestellt, wie sie exportiert wurde. Änderungen, die nachträglich vorgenommen wurden, werden beim Reimport und bei der damit verbundenen Implmentierung nicht entfernt. Wurden zwischen dem Export und der erneuten Implementierung beim Reimport Anwendungsressourcen modifiziert, werden nur die im exportierten Archiv enthaltenen Dateien in ihrem ursprünglichen Zustand wiederhergestellt. Angenommen, Sie exportieren eine Anwendung ohne Authentizitätsdaten, laden danach die Authentizitäten hoch und importieren dann das ursprünglich exportierte Archiv. Die Authentizitätsdaten werden in dem Fall nicht gelöscht.

## {{ site.data.keys.product_adj }}-Apps in der Produktion aktualisieren
{: #updating-mobilefirst-apps-in-production }
Für das Durchführen eines Upgrades für {{ site.data.keys.product_adj }}-Apps, die sich bereits in der Produktionsumgebung im Application Center oder in App Stores befinden, gibt es allgemeine Richtlinien.

Wenn Sie ein Upgrade für eine App durchführen, können Sie eine neue App-Version implementieren und die alte Version weiter verwenden oder blockieren. Bei einer mit Apache Cordova entwickelten App haben Sie außerdem die Möglichkeit, nur die Webressourcen zu aktualisieren.

### Neue App-Version implementieren und alte Version erhalten
{: #deploying-a-new-app-version-and-leaving-the-old-version-working }
Der am häufigsten gewählte Upgradepfad bei Einführung neuer Features oder Modifikation des nativen Codes ist, eine neue Version der App herauszugeben. Folgende Schritte könnten Sie ausführen:

1. Erhöhen Sie die App-Versionsnummer.
2. Erstellen und testen Sie Ihre Anwendung. Weitere Informationen finden Sie unter
[Anwendungsbuild für eine Test- oder Produktionsumgebung erstellen](#building-an-application-for-a-test-or-production-environment).
3. Registrieren Sie die App bei {{ site.data.keys.mf_server }} und konfigurieren Sie sie.
4. Übergeben Sie die neuen .apk-, .ipa-, .appx- oder .xap-Dateien an die jeweiligen App Stores.
5. Warten Sie, bis die Apps geprüft und freigegeben wurden und verfügbar sind.
6. Senden Sie ggf. Benachrichtigungen an Benutzer der alten Version, um die neue Version anzukündigen (siehe [Administratornachricht anzeigen](../using-console/#displaying-an-administrator-message) und [Administratornachrichten in mehreren Sprachen definieren](../using-console/#defining-administrator-messages-in-multiple-languages)).


### Neue App-Version implementieren und alte Version blockieren
{: #deploying-a-new-app-version-and-blocking-the-old-version }
Dieser Upgradepfad wird verwendet, wenn Sie Benutzer veranlassen möchten, das Upgrade auf die neue Version durchzuführen, und dafür den Zugriff der Benutzer auf die alte Version blockieren. Folgende Schritte könnten Sie ausführen:

1. Senden Sie ggf. Benachrichtigungen an Benutzer der alten Version, um anzukündigen, dass in wenigen Tagen eine obligatorische Aktualisierung anstehen wird (siehe [Administratornachricht anzeigen](../using-console/#displaying-an-administrator-message) und [Administratornachrichten in mehreren Sprachen definieren](../using-console/#defining-administrator-messages-in-multiple-languages)).
2. Erhöhen Sie die App-Versionsnummer.
3. Erstellen und testen Sie Ihre Anwendung. Weitere Informationen finden Sie unter
[Anwendungsbuild für eine Test- oder Produktionsumgebung erstellen](#building-an-application-for-a-test-or-production-environment).
4. Registrieren Sie die App bei {{ site.data.keys.mf_server }} und konfigurieren Sie sie.
5. Übergeben Sie die neuen .apk-, .ipa-, .appx- oder .xap-Dateien an die jeweiligen App Stores.
6. Warten Sie, bis die Apps geprüft und freigegeben wurden und verfügbar sind.
7. Kopieren Sie Links zur neuen App-Version.
8. Blockieren Sie die alte App-Version in der {{ site.data.keys.mf_console }}. Stellen Sie eine Nachricht und einen Link zu der neuen Version bereit (siehe [Zugriff auf geschützte Ressourcen per Fernzugriff inaktivieren](../using-console/#remotely-disabling-application-access-to-protected-resources)).

> **Hinweis:** Wenn Sie die alte App inaktivieren, ist keine Kommunikation mit {{ site.data.keys.mf_server }} mehr möglich. Benutzer können die App noch starten und damit offline arbeiten, bis Sie beim App-Start das Herstellen einer Serververbindung durchsetzen.



### Direkte Aktualisierung (keine Änderungen am nativen Code)
{: #direct-update-no-native-code-changes }
Die direkte Aktualisierung ist ein obligatorischer Upgrademechanismus für die Implementierung von Schnellkorrekturen in einer Produktions-App. Wenn Sie eine App erneut in {{ site.data.keys.mf_server }} implementieren, ohne die Version der App zu ändern, sendet {{ site.data.keys.mf_server }} die aktualisierten Webressourcen per Push-Operation direkt an das Gerät, sobald der Benutzer eine Verbindung zum Server herstellt. Aktualisierter nativer Code wird nicht per Push-Operation gesendet. Nachfolgend sind Faktoren aufgelistet, die Sie beachten müssen, wenn Sie eine direkte Aktualisierung durchführen möchten:

1. Bei einer direkten Aktualisierung wird die App-Version nicht aktualisiert. Der Versionsstand der App bleibt gleich, nur die Webressourcen der App ändern sich. Die nicht geänderte Versionsnummer kann zu Irritationen führen, wenn die direkte Aktualisierung nicht richtig eingesetzt wird.
2. Eine direkte Aktualisierung durchläuft nicht den Prüfprozess des App Store, weil es sich technisch nicht um ein neues Release handelt. Dieser Umstand sollte nicht missbraucht werden, denn Anbieter könnten ungehalten werden, wenn Sie eine komplett neue Version Ihrer App unter Umgehung der Prüfungen implementieren. Es liegt in Ihrer Verantwortlichkeit, die Nutzungsvereinbarungen der einzelnen Stores zu lesen und zu berücksichtigen. Eine direkte Aktualisierung ist am besten für die Lösung dringender Probleme geeignet, die keinen Aufschub von mehreren Tagen zulassen.
3. Die direkte Aktualisierung ist als ein Sicherheitsmechanismus gedacht und daher obligatorisch und nicht optional. Wenn Sie die direkte Aktualisierung einleiten, müssen alle Benutzer ihre App aktualisieren, da sie sie andernfalls nicht mehr verwenden können.
4. Die direkte Aktualisierung funktioniert nicht, wenn eine Anwendung nicht mit der für die Erstimplementierung verwendeten Version von {{ site.data.keys.product }} kompiliert (erstellt) wird.

> **Hinweis:** Archiv- bzw. IPA-Dateien, die für die Übergabe von iOS-Apps an einen Store oder für die Validierung von iOS-Apps mit Test Flight oder iTunes Connect generiert werden, können zu Laufzeitfehlern oder zu einem Laufzeitabsturz führen. Weitere Informationen hierzu finden Sie im Blog [Preparing iOS apps for App Store submission in {{ site.data.keys.product }}](https://mobilefirstplatform.ibmcloud.com/blog/2016/10/17/prepare-ios-apps-for-app-store-submission/).

