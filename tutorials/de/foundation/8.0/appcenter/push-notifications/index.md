---
layout: tutorial
title: Push-Benachrichtigung über Anwendungsaktualisierungen
breadcrumb_title: Push-Benachrichtigungen
relevantTo: [ios,android,windows,javascript]
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können den Application-Center-Client so konfigurieren, dass
Push-Benachrichtigungen an Benutzer gesendet werden, wenn für eine Anwendung im Store eine Aktualisierung verfügbar ist. 

Der Administrator des Application Center
kann automatisch per Push-Benachrichtigung Mitteilungen an jedes iOS- oder Android-Gerät senden. Benachrichtigungen werden wegen verfügbarer Updates für bevorzugte Anwendungen
und wegen der Implementierung neuer empfohlener Anwendungen auf dem Application-Center-Server gesendet. 

### Push-Benachrichtigungsprozess
{: #push-notification-process }
Unter folgenden Umständen werden Push-Benachrichtigungen an ein Gerät gesendet: 

* Das Application Center
ist auf dem Gerät installiert und wurde mindestens einmal gestartet. 
* Der Benutzer hat die Push-Benachrichtigungen für dieses Gerät vom
Application Center nicht auf der Schnittstelle unter
**Einstellungen → Benachrichtigungen** inaktiviert. 
* Der Benutzer ist berechtigt, die Anwendung zu installieren. Die entsprechenden Berechtigungen werden mithilfe der Application-Center-Zugriffsrechte gesteuert.
* Die Anwendung ist für den Benutzer, der das Application Center auf dem Gerät verwendet, als empfohlene oder bevorzugte Anwendung gekennzeichnet. Entsprechende Markierungen werden automatisch gesetzt, wenn der Benutzer eine Anwendung über das Application Center installiert. Auf dem Gerät können Sie auf der Registerkarte **Favoriten** des Application Center sehen, welche Anwendungen als bevorzugte Anwendungen gekennzeichnet sind. 
* Die Anwendung ist nicht auf dem Gerät installiert oder es ist eine neuere Anwendungsversion als die auf dem Gerät installierte verfügbar. 

Wenn der Application-Center-Client
zum ersten Mal auf einem Gerät gestartet wird,
wird der Benutzer möglicherweise gefragt, ob er eingehende Push-Benachrichtigungen akzeptieren möchte. Bei mobilen iOS-Geräten ist das der Fall. Das Feature für Push-Benachrichtigungen
funktioniert nicht, wenn der Service auf dem mobilen Gerät inaktiviert ist. 

iOS-Versionen
und moderne Android-Betriebssystemversionen bieten eine Möglichkeit an, diesen Service auf Anwendungsebene ein- oder auszuschalten. 

Der Anbieter Ihres Gerätes kann
Ihnen mitteilen, wie Ihr mobiles Gerät für Push-Benachrichtigungen konfiguriert wird.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Push-Benachrichtigungen für Anwendungsaktualisierungen konfigurieren](#configuring-push-notifications)
* [Application-Center-Server für die Verbindung zum Google Cloud Messaging konfigurieren](#gcm)
* [Application-Center-Server für die Verbindung zum Apple Push Notification Service konfigurieren](#apns)
* [Nicht von der GCM-API abhängige Version des mobilen Clients erstellen](#no-gcm)

## Push-Benachrichtigungen für Anwendungsaktualisierungen konfigurieren
{: #configuring-push-notifications }
Sie müssen die Berechtigungsnachweise oder Zertifikate für die
Application-Center-Services konfigurieren, um mit Push-Benachrichtigungsservern anderer Anbieter
kommunizieren zu können. 

### Server-Scheduler des Application Center konfigurieren
{: #configuring-the-server-scheduler }
Der Server-Scheduler ist ein Hintergrundservice, der automatisch mit dem Server gestartet und gestoppt wird. Dieser Scheduler wird verwendet, um
in regelmäßigen Intervallen einen Stapelspeicher zu leeren, der durch Administratoraktionen automatisch mit zu sendenden Push-Aktualisierungsnachrichten
gefüllt wird. Das Standardintervall zwischen dem Senden zweier Stapel von Push-Aktualisierungsnachrichten liegt bei zwölf Stunden. Wenn dieser Standardwert für Sie nicht passt, können
Sie ihn mit den Serverumgebungsvariablen **ibm.appcenter.push.schedule.period.amount** und **ibm.appcenter.push.schedule.period.unit** ändern. 

Der Wert von
**ibm.appcenter.push.schedule.period.amount** ist eine ganze Zahl. Die Variable **ibm.appcenter.push.schedule.period.unit** kann den Wert "seconds", "minutes" oder "hours" haben.
Wenn die Einheit nicht angegeben ist, wird die Zahl als Intervall in Stunden interpretiert. Diese
Variablen werden verwendet, um die Zeit zwischen zwei Stapeln mit Push-Nachrichten
zu definieren.

Verwenden Sie zum Definieren dieser Variablen JNDI-Eigenschaften.

> **Wichtiger Hinweis:** In der Produktion dürfen Sie
die Einheit nicht auf
"seconds" setzen. Je kürzer das Zeitintervall ist, desto größer ist die Last für den Server. Ein in Sekunden (seconds) angegebenes
Intervall ist nur für Test- und Bewertungszwecke gedacht.
Wenn die Zeit beispielsweise auf zehn Sekunden gesetzt ist, werden Push-Nachrichten fast sofort
gesendet.

Unter [JNDI-Eigenschaften für das Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) sind alle Eigenschaften aufgeführt, die Sie festlegen können.

### Beispiel für Apache-Tomcat-Server
{: tomcat }
Definieren Sie diese Variablen wie folgt mit JNDI-Eigenschaften in der Datei server.xml:

```xml
<Environment name="ibm.appcenter.push.schedule.period.unit" override="false" type="java.lang.String" value="hours"/>
<Environment name="ibm.appcenter.push.schedule.period.amount" override="false" type="java.lang.String" value="2"/>
```

#### WebSphere Application Server Version 8.5
{: #websphere }
Gehen Sie wie folgt vor, um JNDI-Variablen für WebSphere Application Server Version 8.5 zu konfigurieren: 

1. Klicken Sie auf **Anwendungen → Anwendungstypen → Websphere-Unternehmensanwendungen**.
2. Wählen Sie die Anwendung "Application-Center-Services" aus. 
3. Klicken Sie auf **Eigenschaften des Webmoduls → Umgebungseinträge für Webmodule**.
4. Bearbeiten Sie die Zeichenfolge in der Spalte **Wert**. 

#### WebSphere Application Server Liberty Profile
{: #liberty }
Informationen
zum Konfigurieren von JNDI-Variablen für WebSphere Application Server Liberty Profile
finden Sie
im Artikel [JNDI-Bindung
für Konstanten in den Serverkonfigurationsdateien verwenden](http://ibm.biz/knowctr#SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_dep_jndi.html). 

Die übrigen Aktionen zum Einstellen des Service für Push-Benachrichtigungen
sind vom Anbieter des Gerätes abhängig, auf dem die Zielanwendung installiert wird. 

## Application-Center-Server für die Verbindung zum Google Cloud Messaging konfigurieren
{: #gcm }
Wenn Sie das Google Cloud Messaging (GCM) für eine Anwendung aktivieren möchten,
müssen Sie die GCM-Services einem Google-Entwicklerkonto mit aktivierter Google-API zuordnen. Einzelheiten
enthält der Artikel [Getting
Started with GCM](http://developer.android.com/google/gcm/gs.html).

> Wichtiger Hinweis: Beim Application-Center-Client ohne Google Cloud Messaging ist das Application Center auf die Verfügbarkeit der
GCM-API (Google Cloud Messaging) angewiesen. Möglicherweise ist diese API in einigen Gebieten, z. B. in China, nicht verfügbar. Zur Unterstützung solcher Gebiete können Sie eine
Version des
Application-Center-Clients erstellen, die nicht von der GCM-API abhängig ist.
In einer solchen Version des
Application-Center-Clients funktionieren keine Push-Benachrichtigungen. Einzelheiten finden Sie unter
[Nicht von der GCM-API abhängige Version des mobilen Clients erstellen](#no-gcm).



1. Wenn Sie kein entsprechendes Google-Konto haben,
rufen Sie die Seite [Google-Konto erstellen](https://mail.google.com/mail/signup) auf und erstellen Sie ein Konto für den Application-Center-Client.
2. Registrieren Sie dieses Konto mit der Google-API
in der [Google-API-Konsole](https://code.google.com/apis/console/).Mit der Registrierung wird ein neues Standardprojekt erstellt, das Sie umbenennen können. Der Name, den Sie diesem GCM-Projekt geben,
hat keinen Bezug zum Namen Ihres Android-Anwendungspakets. Wenn das Projekt erstellt wird, wird
am Ende der Projekt-URL eine GCM-Projekt-ID angehängt. Sie sollten diese Nummer am Ende als Ihre Projekt-ID notieren.
3. Aktivieren Sie den GCM-Service für Ihr Projekt. Klicken Sie in der Google-API-Konsole links auf das Register **Services**
und aktivieren Sie den Service "Google Cloud Messaging for Android" aus der Liste der Services.
4. Stellen Sie sicher, dass ein Simple API Access Server Key für Ihre Anwendungskommunikation
verfügbar ist.
    * Klicken Sie links in der Konsole auf das vertikale Register **API Access**.
    * Erstellen Sie einen Simple API Access Server Key. Falls bereits ein Standardschlüssel erstellt wurde, notieren Sie die Details.Es gibt noch zwei andere Arten von Schlüsseln, die jedoch momentan nicht von Interesse sind.
    * Speichern Sie den Simple API Access Server Key für die spätere Verwendung bei der Anwendungskommunikation über GCM.Der Schlüssel besteht aus ungefähr
40 Zeichen und wird als Google API Key
bezeichnet. Sie werden ihn später serverseitig benötigen.
5. Geben Sie die GCM-Projekt-ID im
JavaScript-Projekt als Zeichenfolgeressourceneigenschaft des
Android-Application-Center-Clients ein. Modifizieren Sie in der Schablonendatei **IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** die folgende Zeile mit Ihrem eigenen Wert:

   ```xml
   gcmProjectId:""// Für Android-Push erforderliche Google-API-Projekt-ID (project name = com.ibm.appcenter)
   // Beispiel: 123456789012
   ```

6. Registrieren Sie den Google API Key als JNDI-Eigenschaft für den
Application-Center-Server. Der Schlüsselname ist: **ibm.appcenter.gcm.signature.googleapikey**. Sie können diesen
Schlüssel beispielsweise für einen Apache-Tomcat-Server als eine JNDI-Eigenschaft in der Datei **server.xml** konfigurieren.


   ```xml
   <Context docBase="AppCenterServices" path="/applicationcenter" reloadable="true" source="org.eclipse.jst.jee.server:AppCenterServices">
        <Environment name="ibm.appcenter.gcm.signature.googleapikey" override="false" type="java.lang.String" 
        value="AIxaScCHg0VSGdgfOZKtzDJ44-oi0muUasMZvAs"/>
   </Context>
   ```

   Die JNDI-Eigenschaft muss in Übereinstimmung mit Ihren Anwendungsserveranforderungen definiert werden.  
Unter [JNDI-Eigenschaften für das Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) sind alle Eigenschaften aufgeführt, die Sie festlegen können.
    
**Wichtiger Hinweis:**

* Wenn Sie GCM mit früheren Android-Versionen verwenden,
müssen Sie Ihr Gerät möglicherweise mit einem vorhandenen Google-Konto für GCM verbinden, um effektiv arbeiten zu können. Laut
[GCM-Service](http://developer.android.com/google/gcm/gcm.html) wird eine vorhandene Verbindung für Google-Dienste verwendet. Bei Geräten mit einer älteren Version als 3.0 müssen Benutzer ihr Google-Konto auf dem mobilen Gerät einrichten. Auf
Geräten mit
Android ab Version 4.0.4 ist kein Google-Konto erforderlich.
* Sie müssen außerdem sicherstellen, dass Ihre Firewall für Push-Benachrichtigung am Port 443 abgehende Verbindungen
zu android.googleapis.com
akzeptiert. 

## Application-Center-Server für die Verbindung zum Apple Push Notification Service konfigurieren
{: #apns }
Konfigurieren Sie Ihr iOS-Projekt für den Apple Push Notification Service (APN). Stellen Sie sicher, das über den Application-Center-Server die folgenden Server zugänglich sind: 

**Sandbox-Server**  
gateway.sandbox.push.apple.com:2195
feedback.sandbox.push.apple.com:2196

**Produktionsserver**  
gateway.push.apple.com:2195
feedback.push.apple.com:2196

Sie müssen ein registrierter Apple-Entwickler sein, um Ihr iOS-Projekt erfolgreich mit dem Apple Push Notification Service (APN) konfigurieren zu können.
Im Unternehmen
beantragt der für Apple-Entwicklung verantwortliche Administrator eine APN-Aktivierung. In der Antwort auf diesen Antrag sollte Ihnen ein
Bereitstellungsprofil mit aktiviertem APN für Ihr iOS-Anwendungsbundle zur Verfügung gestellt werden, d. h. ein Zeichenfolgewert, der auf der Konfigurationsseite Ihres Xcode-Projekts definiert wird. Dieses
Bereitstellungsprofil wird verwendet, um eine Signaturzertifikatdatei zu generieren.Es gibt zwei Arten von
Bereitstellungsprofilen, einmal die Entwicklungsprofile für Entwicklungsumgebungen und zum anderen die Produktionsprofile für Produktionsumgebungen. Entwicklungsprofile sind exklusiv
für Apple-Entwicklungsserver mit APN bestimmt. Produktionsprofile sind exklusiv
für Apple-Produktionsserver mit APN bestimmt. Diese Servertypen bieten nicht dieselbe Servicequalität.

Hinweis: Geräte, die mit einem Unternehmens-WiFi-Netz hinter einer Firewall
verbunden sind, können Push-Benachrichtigungen nur empfangen, wenn Verbindungen zu den folgenden Arten von Adressen nicht
von der Firewall blockiert werden.


`x-courier.sandbox.push.apple.com:5223`  
Hier steht x für eine ganze Zahl. 

1. Fordern Sie das Bereitstellungsprofil mit aktiviertem APN für das Application-Center-Xcode-Projekt an. Das Ergebnis des APN-Aktivierungsantrags Ihres Administrators wird als Liste angezeigt,
auf die über [https://developer.apple.com/ios/my/bundles/index.action](https://developer.apple.com/ios/my/bundles/index.action) zugegriffen werden kann. Für jeden Listeneintrag ist angezeigt, ob
das Profil APN-Funktionen hat oder nicht. Wenn Sie das Profil haben, können Sie es herunterladen und im Xcode-Projektverzeichnis des Application-Center-Clients installieren, indem Sie doppelt auf das Profil klicken. Das Profil
wird dann automatisch in Ihrem Keystore und in Ihrem Xcode-Projekt installiert.

2. Wenn Sie das Application Center auf einem Gerät testen oder debuggen möchten, indem Sie das Application Center direkt
von Xcode aus im Fenster "Xcode-Organizer" starten, navigieren Sie zum Abschnitt "Provisioning Profiles" und installieren Sie das Profil auf Ihrem mobilen Gerät.

3. Erstellen Sie ein Signaturzertifikat, das die Application-Center-Services verwenden, um die Kommunikation mit dem APN-Server zu schützen.Dieser Server verwendet das Zertifikat, um jede an den APN-Server gerichtete Push-Anforderung zu signieren. Dieses Signaturzertifikat wird aus Ihrem Bereitstellungsprofil generiert.
    
* Öffnen Sie das Dienstprogramm Keychain Access und klicken Sie im linken Bereich auf **My
Certificates**.
* Suchen Sie das Zertifikat, das Sie installieren möchten, und legen Sie den Inhalt des Zertifikats offen.Sie sehen sowohl ein Zertifikat als auch einen privaten Schlüssel. Für das Application Center
enthält die Zertifikatzeile das Application-Center-Anwendungsbundle **com.ibm.imf.AppCenter**.
* Wählen Sie **File → Export
Items** aus, um das Zertifikat und den Schlüssel auszuwählen und als
Personal-Information-Exchange-Datei (.p12) zu exportieren. Diese .p12-Datei enthält den privaten Schlüssel, den Sie benötigen, wenn für die Kommunikation mit dem APN-Server das sichere Handshaking-Protokoll verwendet wird.
* Kopieren Sie das .p12-Zertifikat auf den Computer, der die Application-Center-Services ausführt, und installieren Sie es an der entsprechenden Position. Sowohl die Zertifikatdatei als auch das Kennwort werden benötigt, um einen sicheren Tunnel zum APN-Server aufzubauen. Sie benötigen auch einige Informationen, aus denen hervorgeht, ob
ein Entwicklungszertifikat oder ein Produktionszertifikat verwendet wird.
Aus einem Bereitstellungsprofil für Entwicklung wird ein Entwicklungszertifikat und
aus einem Produktionsprofil ein Produktionszertifikat generiert. Die Webanwendung für die Application-Center-Services verweist mit JNDI-Eigenschaften auf diese geschützten Daten.

Die Beispiele in der Tabelle zeigen, wie die JNDI-Eigenschaften in der Datei server.xml von Apache Tomcat Server definiert sind.

| JNDI-Eigenschaft | Typ und Beschreibung| Beispiel für Apache-Tomcat-Server| 
|---------------|----------------------|----------------------------------|
| ibm.appcenter.apns.p12.certificate.location| Zeichenfolgewert, der den vollständigen Pfad zum .p12-Zertifikat definiert| `<Environment name="ibm.appcenter.apns.p12.certificate.location" override="false" type="java.lang.String" value="/Users/someUser/someDirectory/apache-tomcat/conf/AppCenter_apns_dev_cert.p12"/>` |
| ibm.appcenter.apns.p12.certificate.password| Zeichenfolgewert, der das Kennwort für den Zugriff auf das Zertifikat definiert| `<Environment name="ibm.appcenter.apns.p12.certificate.password" override="false" type="java.lang.String" value="this_is_a_secure_password"/>` | 
| ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate|	Boolescher Wert (true oder false), der definiert, ob das zum Generieren des Authentifizierungszertifikats verwendete Bereitstellungsprofil ein Entwicklungsprofil ist| `<Environment name="ibm.appcenter.apns.p12.certificate.isDevelopmentCertificate" override="false" type="java.lang.String" value="true"/>` | 

Unter [JNDI-Eigenschaften für das Application Center](../../installation-configuration/production/appcenter/#jndi-properties-for-application-center) sind alle JNDI-Eigenschaften aufgeführt, die Sie festlegen können.

## Nicht von der GCM-API abhängige Version des mobilen Clients erstellen
{: #no-gcm }
In Anpassung an die Einschränkungen in bestimmten Gebieten können Sie die Abhängigkeit der Android-Version des Clients von der GCM-API (Google Cloud Messaging)
vermeiden. Push-Benachrichtigungen funktionieren mit einer solchen Version des Clients nicht.

Das Application Center ist auf die Verfügbarkeit der
GCM-API (Google Cloud Messaging) angewiesen. Möglicherweise ist diese API in einigen Gebieten, z. B. in China, nicht verfügbar. Zur Unterstützung solcher Gebiete können Sie eine
Version des
Application-Center-Clients erstellen, die nicht von der GCM-API abhängig ist.
In einer solchen Version des
Application-Center-Clients funktionieren keine Push-Benachrichtigungen.

1. Stellen Sie fest, ob die Push-Benachrichtigungen inaktiviert sind. Überprüfen Sie dazu, ob die Datei
**IBMAppCenter/apps/AppCenter/common/js/appcenter/config.json** die Zeile
`"gcmProjectId": "" ,` enthält.
2. Entfernen Sie an zwei Stellen der Datei **IBMAppCenter/apps/AppCenter/android/native/AndroidManifest.xml** alle Zeilen
zwischen den beiden Kommentaren `<!-- AppCenter-Push-Konfiguration -->` und `<!-- Ende der AppCenter-Push-Konfiguration -->`.
3. Löschen Sie die Klasse **IBMAppCenter/apps/AppCenter/android/native/src/com/ibm/appcenter/GCMIntenteService.java**.
4. Führen Sie in Eclipse im Ordner IBMAppCenter/apps/AppCenter/android den Befehl "Build Android Environment" aus.
5. Löschen Sie die Datei **IBMAppCenter/apps/AppCenter/android/native/libs/gcm.jar**, die bei Ausführung des Befehls
"Build Android Environment" vom MobileFirst-Plug-in erstellt wurde. 
6. Aktualisieren Sie die Anzeige des neu erstellten Projekts IBMAppCenterAppCenterAndroid, um den Wegfall der
GCM-Bibliothek zu sehen.
7. Erstellen Sie die .apk-Datei für das Application Center.

Die Bibliothek **gcm.jar** wird vom
MobileFirst-Eclipse-Plug-in automatisch bei jeder Erstellung der
Android-Umgebung hinzugefügt. Deshalb muss diese Java-Archivdatei bei jeder Ausführung des Android-Buildprozesses in
MobileFirst aus dem Verzeichnis
**IBMAppCenter/apps/AppCenter/android/native/libs/** gelöscht werden. Andernfalls wäre die Bibliothek
**gcm.jar** in der resultierenden Datei
**appcenter.apk** enthalten.
