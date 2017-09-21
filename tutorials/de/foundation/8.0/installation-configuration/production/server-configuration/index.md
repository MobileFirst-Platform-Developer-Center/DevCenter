---
layout: tutorial
title: MobileFirst Server konfigurieren
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Nachfolgend finden Sie Informationen zur Sicherungs- und Wiederherstellungsrichtlinie, zur Optimierung
der
MobileFirst-Server-Konfiguration und zum Anwenden von Zugriffsbeschränkungen und Sicherheitsoptionen.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Endpunkte
von {{ site.data.keys.mf_server }}
(Produktionsserver)](#endpoints-of-the-mobilefirst-server-production-server)
* [{{ site.data.keys.mf_server }} für die Aktivierung von TLS Version 1.2 konfigurieren](#configuring-mobilefirst-server-to-enable-tls-v12)
* [Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren](#configuring-user-authentication-for-mobilefirst-server-administration)
* [Liste der JNDI-Eigenschaften für die MobileFirst-Server-Webanwendungen](#list-of-jndi-properties-of-the-mobilefirst-server-web-applications)
* [Datenquellen konfigurieren](#configuring-data-sources)
* [Protokollierungs- und Überwachungsmechanismen konfigurieren](#configuring-logging-and-monitoring-mechanisms)
* [Mehrere Laufzeiten konfigurieren](#configuring-multiple-runtimes)
* [Lizenzüberwachung konfigurieren](#configuring-license-tracking)
* [SSL-Konfiguration von WebSphere Application Server und HTTP-Adapter](#websphere-application-server-ssl-configuration-and-http-adapters)

## Endpunkte von {{ site.data.keys.mf_server }} (Produktionsserver)
{: #endpoints-of-the-mobilefirst-server-production-server }
Sie können für die Endpunkte von
IBM {{ site.data.keys.mf_server }}. Whitelists und Blacklists erstellen.

> **Hinweis:** Informationen zu den von der {{ site.data.keys.product }} zugänglich gemachten URLs werden als Richtlinie bereitgestellt. Organisationen müssen sicherstellen, dass die URLs ausgehend von Whitelists und Blacklists in einer Unternehmensstruktur getestet werden.

| API-URL unter `<Kontextstammverzeichnis der Laufzeit>/api/` | Beschreibung | Empfohlen für Whitelist? |
|---------------------------------------------|-------------------------------------------|--------------------------|
| /adapterdoc/*	                              | Gibt die Swagger-Dokumentation des benannten Adapters zurück | Nein; nur intern vom Administrator und von den Entwicklern verwendet |
| /adapters/* | Services für Adapter | Ja |
| /az/v1/authorization/* | Autorisiert den Zugriff des Clients auf einen bestimmten Bereich | Ja |
| /az/v1/introspection | Introspektion des Zugriffstokens für den Client | Nein; API nur für vertrauliche Clients |
| /az/v1/token | Generiert ein Zugriffstoken für den Client | Ja |
| /clientLogProfile/* | Ruft das Clientprotokollprofil ab | Ja |
| /directupdate/* | Ruft die ZIP-Datei für direkte Aktualisierung ab | Ja, wenn Sie planen, die direkte Aktualisierung zu verwenden |
| /loguploader | Lädt die Clientprotokolle auf den Server hoch | Ja |
| /preauth/v1/heartbeat | Akzeptiert das Überwachungssignal vom Client und notiert die Zeit der letzten Aktivität | Ja |
| /preauth/v1/logout | Abmeldung bei einer Sicherheitsüberprüfung | Ja |
| /preauth/v1/preauthorize | Ordnet einem bestimmten Bereich Sicherheitsüberprüfungen zu und führt diese aus | Ja |
| /reach | Server erreichbar | Nein; nur für internen Gebrauch |
| /registration/v1/clients/* | API für den Registrierungsservice für Clients | Nein; API nur für vertrauliche Clients |
| /registration/v1/self/* | API des Registrierungsservice für die Selbstregistrierung von Clients | Ja |

## {{ site.data.keys.mf_server }} für die Aktivierung von TLS Version 1.2 konfigurieren
{: #configuring-mobilefirst-server-to-enable-tls-v12 }
Sie müssen die folgenden Anweisungen ausführen, wenn
{{ site.data.keys.mf_server }} mit Geräten kommunizieren können soll, die
von den SSL-Protokollen nur TLS (Transport Layer Security) Version 1.2 unterstützen. 

Mit welchen Schritten {{ site.data.keys.mf_server }} konfiguriert werden muss, um
Transport Layer Security (TLS) Version 1.2 zu ermöglichen,
hängt davon ab, wie {{ site.data.keys.mf_server }} eine Verbindung zu Geräten
herstellt. 

* Wenn sich {{ site.data.keys.mf_server }} hinter einem
Reverse Proxy befindet, der SSL-verschlüsselte Pakete von Geräten vor der Weitergabe an den Anwendungsserver entschlüsselt, müssen Sie
für Ihren Reverse Proxy die Unterstützung für
TLS Version 1.2 aktivieren. Falls Sie IBM HTTP Server als Reverse Proxy verwenden,
lesen Sie die Anweisungen unter
[IBM HTTP Server sichern](http://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.ihs.doc/ihs/welc6top_securing_ihs_container.html?view=kc). 
* Wenn {{ site.data.keys.mf_server }} direkt mit Geräten
kommuniziert, hängen die für die Aktivierung vn TLS Version 1.2 erforderlichen Konfigurationsschritte davon ab, ob Sie Apache Tomcat,
WebSphere Application Server Liberty Profile oder
WebSphere Application Server Full Profile als Anwendungsserver verwenden. 

### Apache Tomcat
{: #apache-tomcat }
1. Vergewissern Sie sich, dass die Java Runtime
Environment (JRE) TLS Version 1.2 unterstützt. Stellen Sie sicher, dass Sie eine der folgenden JRE-Versionen haben: 
    * Oracle JRE 1.7.0_75 oder eine aktuellere JRE
    * Oracle JRE 1.8.0_31 oder eine aktuellere JRE
2. Bearbeiten Sie die Datei **conf/server.xml**. Modifizieren Sie das
`Connector`-Element, das den HTTPS-Port deklariert, so, dass das Attribut
**sslEnabledProtocols** den Wert `sslEnabledProtocols="TLSv1.2,TLSv1.1,TLSv1,SSLv2Hello"` hat. 

### WebSphere Application Server Liberty Profile
{: #websphere-application-server-liberty-profile }
1. Vergewissern Sie sich, dass die Java Runtime Environment (JRE) TLS Version 1.2 unterstützt.
    * Wenn Sie ein IBM Java-SDK verwenden, stellen Sie sicher, dass das Patch zum Beseitigen der Anfälligkeit für POODLE angewendet wurde. Die älteste Version des IBM Java-SDK,
die das Patch für Ihre Version von WebSphere Application Server
enthält, finden Sie im [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173). 

        > **Hinweis:** Sie können die im Sicherheitsbulletin aufgelisteten Versionen oder aktuellere Versionen verwenden.
    * Wenn Sie ein Java-SDK von Oracle verwenden, stellen Sie sicher, dass Sie über eine der folgenden Versionen verfügen:
        * Oracle JRE 1.7.0_75 oder eine aktuellere JRE
        * Oracle JRE 1.8.0_31 oder eine aktuellere JRE
2. Wenn Sie ein IBM Java-SDK verwenden, bearbeiten Sie die Datei **server.xml**.
    * Fügen Sie die folgende Zeile hinzu: `<ssl id="defaultSSLConfig" keyStoreRef="defaultKeyStore" sslProtocol="SSL_TLSv2"/>`
    * Fügen Sie das Attribut `sslProtocol="SSL_TLSv2"` zu allen vorhandenen `<ssl>`-Elementen hinzu.

### WebSphere Application Server Full Profile
{: #websphere-application-server-full-profile }
1. Vergewissern Sie sich, dass die Java Runtime Environment (JRE) TLS Version 1.2 unterstützt.

Stellen Sie sicher, dass auf Ihr IBM Java-SDK
das Patch zur Beseitigung der Anfälligkeit für POODLE angewendet wurde. Die älteste Version des IBM Java-SDK,
die das Patch für Ihre Version von WebSphere Application Server
enthält, finden Sie im [Security Bulletin: Vulnerability in SSLv3 affects IBM WebSphere Application Server (CVE-2014-3566)](http://www.ibm.com/support/docview.wss?uid=swg21687173).

    > **Hinweis:** Sie können die im Sicherheitsbulletin aufgelisteten Versionen oder aktuellere Versionen verwenden.
2. Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an und klicken Sie auf **Sicherheit → Verwaltung von SSL-Zertifikaten und Schlüsseln → SSL-Konfigurationen**.
3. Modifizieren Sie jede aufgelistete SSL-Konfiguration so, dass TLS Version 1.2 ermöglicht wird.
    * Wählen Sie eine SSL-Konfiguration aus und klicken Sie unter **Weitere Eigenschaften** auf **Einstellungen für Datenschutzniveau**.
    * Wählen Sie in der Liste **Protokoll** den Eintrag **SSL_TLSv2** aus.
    * Klicken Sie auf **Anwenden** und speichern Sie die Änderungen.

## Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren
{: #configuring-user-authentication-for-mobilefirst-server-administration }
Für die MobileFirst-Server-Verwaltung
ist die Benutzerauthentifizierung erforderlich. Sie können die Benutzerauthentifizierung konfigurieren und eine Authentifizierungsmethode auswählen. Die Konfigurationsprozedur
richtet sich nach dem Webanwendungsserver, den Sie verwenden.

> **Wichtiger Hinweis:** Wenn Sie einen eigenständigen WebSphere Application Server Full Profile
verwenden, müssen Sie in der globalen Sicherheit eine andere Authentifizierungsmethode als SWAM (Simple
WebSphere Authentication Mechanism) verwenden. Sie können LTPA (Lightweight Third-Party Authentication)
nutzen. Wenn Sie SWAM verwenden, kann es zu nerwarteten Authentifizierungsfehlern kommen. Nachdem das Installationsprogramm die
Webanwendungen für die MobileFirst-Server-Verwaltung
im Webanwendungsserver implementiert hat, müssen Sie die Authentifizierung konfigurieren. 

Für die MobileFirst-Server-Verwaltung
sind die folgenden Java-EE-Sicherheitsrollen (Java Platform,
Enterprise Edition) definiert:

* mfpadmin
* mfpdeployer
* mfpoperator
* mfpmonitor

Diese Rollen müssen den entsprechenden Benutzergruppen zugeordnet werden. Der Benutzer mit der Rolle **mfpmonitor** kann Daten anzeigen, aber nicht
ändern. In der folgenden Tabelle sind die MobileFirst-Rollen und ihre Funktion
für Produktionsserver aufgelistet. 

#### Implementierung
{: #deployment }

|                        | Administrator | Deployer | Operator | Monitor |
|------------------------|---------------|-------------|-------------|------------|
| Java-EE-Sicherheitsrolle | mfpadmin | mfpdeployer | mfpoperator | mfpmonitor |
| Anwendung implementieren | Ja | Ja | Nein | Nein |
| Adapter implementieren | Ja | Ja | Nein | Nein |

#### MobileFirst-Server-Verwaltung
{: #mobilefirst-server-management }

|                            | Administrator | Deployer | Operator | Monitor |
|----------------------------|---------------|-------------|-------------|------------|
| Java-EE-Sicherheitsrolle | mfpadmin | mfpdeployer | mfpoperator | mfpmonitor |
| Laufzeiteinstellungen konfigurieren | Ja | Ja | Nein | Nein |

#### Anwendungsmanagement
{: #application-management }

|                                     | Administrator | Deployer | Operator | Monitor |
|-------------------------------------|---------------|-------------|-------------|------------|
| Java-EE-Sicherheitsrolle | mfpadmin | mfpdeployer | mfpoperator | mfpmonitor |
| Neue {{ site.data.keys.product_adj }}-Anwendung hochladen | Ja | Ja | Nein | Nein |
| {{ site.data.keys.product_adj }}-Anwendung entfernen | Ja | Ja | Nein | Nein |
| Neuen Adapter hochladen | Ja | Ja | Nein | Nein |
| Adapter entfernen | Ja | Ja | Nein | Nein |
| Authentizitätstests für eine Anwendung aktivieren oder inaktivieren | Ja | Ja | Nein | Nein |
| Eigenschaften für {{ site.data.keys.product_adj }}-Anwendungsstatus ändern (Active, Active Notifying und Disabled) | Ja | Ja | Ja | Nein |

Im Grunde können alle Rollen GET-Anforderungen absetzen. Die Rollen
**mfpadmin**, **mfpdeployer** und
**mfpmonitor** können außerdem POST- und PUT-Anforderungen absetzen. Die Rollen
**mfpadmin** und **mfpdeployer** könen darüber hinaus
DELETE-Anforderungen absetzen. 

#### Anforderungen in Bezug auf Push-Benachrichtigungen
{: #requests-related-to-push-notifications }

|                        | Administrator| Deployer| Operator| Monitor|
|------------------------|---------------|-------------|-------------|------------|
| Java-EE-Sicherheitsrolle| mfpadmin| mfpdeployer| mfpoperator| mfpmonitor|
| GET-Anforderungen{::nomarkdown}<ul><li>Liste aller Geräte abrufen, die Push-Benachrichtigungen für eine Anwendung verwenden</li><li>Details eines bestimmten Geräts abrufen</li><li>Liste der Abonnements abrufen</li><li>Abonnementinformationen zu einer Abonnement-ID abrufen </li><li>Details einer GCM-Konfiguration abrufen</li><li>Details einer APNS-Konfiguration abrufen</li><li>Liste der für die Anwendung definierten Tags abrufen</li><li>Details zu einem bestimmten Tag abrufen</li></ul>{:/}| Ja | Ja | Ja | Ja |
| POST- und PUT-Anforderungen{::nomarkdown}<ul><li>App für Push-Benachrichtigungen registrieren</li><li>Geräteregistrierung für Push aktualisieren</li><li>Abonnement erstellen</li><li>GCM-Konfiguration hinzufügen oder aktualisieren</li><li>APNS-Konfiguration hinzufügen oder aktualisieren</li><li>Benachrichtigungen an ein Gerät senden</li><li>Tag erstellen oder aktualisieren</li></ul>{:/} | Ja | Ja | Ja | Nein |
| DELETE-Anforderungen{::nomarkdown}<ul><li>Registrierung eines Geräts für Push-Benachrichtigungen löschen</li><li>Abonnement löschen</li><li>Abonnement eines Tags für ein Gerät beenden</li><li>GCM-Konfiguration löschen</li><li>APNS-Konfiguration löschen</li><li>Tag löschen
</li></ul>{:/} | Ja | Ja | Nein | Nein |

#### Inaktivierung
{: #disabling }

|                        | Administrator | Deployer | Operator | Monitor |
|------------------------|---------------|-------------|-------------|------------|
| Java-EE-Sicherheitsrolle | mfpadmin | mfpdeployer | mfpoperator | mfpmonitor |
| Gerät inaktivieren und Zustand als "verloren" (lost) oder "gestohlen" (stolen) angeben, um den Zugriff durch Anwendungen auf diesem Gerät zu blockieren | Ja | Ja | Ja | Nein |
| Anwendung inaktivieren und Zustand als "inaktiviert" (disabled) angeben, um den Zugriff durch diese Anwendung auf diesem Gerät zu blockieren | Ja | Ja | Ja | Nein |

Wenn Sie sich für eine Authentifizierungsmethode über ein Benutzerrepository wie LDAP entscheiden,
können Sie die {{ site.data.keys.mf_server }}-Verwaltung
so konfigurieren,
dass Sie die
Benutzer und Gruppen mit dem Benutzerrepository verwenden können, um die Zugriffssteuerungsliste (Access Control List, ACL) der
{{ site.data.keys.mf_server }}-Verwaltung
zu definieren.
Die erforderliche Vorgehensweise ist abhängig vom Typ und von der Version des verwendeten Webanwendungsservers.

### WebSphere Application Server Full Profile für die MobileFirst-Server-Verwaltung konfigurieren
{: #configuring-websphere-application-server-full-profile-for-mobilefirst-server-administration }
Konfigurieren Sie die Sicherheit, indem Sie für beide Webanwendungen
die Java-EE-Rollen der MobileFirst-Server-Verwaltung einer Gruppe von Benutzern zuordnen.

Die grundlegenden Informationen für die Benutzerkonfiguration
werden in der Konsole
von WebSphere Application Server definiert. Die Konsole wird normalerweise über die Adresse `https://localhost:9043/ibm/console/` aufgerufen. 

1. Wählen Sie **Sicherheit → Globale Sicherheit** aus.
2. Wählen Sie
**Assistent für die Sicherheitskonfiguration** aus, um die Benutzer zu konfigurieren. Sie können einzelne Benutzeraccounts verwalten, wenn Sie
**Benutzer und Gruppen → Benutzer verwalten** auswählen.
3. Ordnen Sie die Rollen **mfpadmin**, **mfpdeployer**, **mfpmonitor**
und **mfpoperator** einer Gruppe von Benutzern zu.
    * Wählen Sie **Server → Servertypen → WebSphere-Anwendungsserver** aus.
    * Wählen Sie den Server aus.
    * Wählen Sie auf der Registerkarte
**Konfiguration** die Optionen **Anwendungen → Unternehmensanwendungen** aus.
    * Wählen Sie **MobileFirst_Administration_Service** aus.
    * Wählen Sie auf der Registerkarte
**Konfiguration** die Optionen
**Details → Zuordnung von Sicherheitsrollen zu Benutzern/Gruppen** aus.
    * Passen Sie die Angaben nach Bedarf an.
    * Klicken Sie auf **OK**. 
    * Wiederholen Sie die Schritte
für die Zuordnung der Rollen für die Konsolenwebanwendung. Wählen Sie dieses Mal **MobileFirst_Administration_Console** aus.
    * Klicken Sie auf
**Speichern**, um die Änderungen zu speichern.

### WebSphere Application Server Liberty Profile für die MobileFirst-Server-Verwaltung konfigurieren
{: #configuring-websphere-application-server-liberty-profile-for-mobilefirst-server-administration }
In WebSphere Application Server Liberty Profile werden die Rollen
**mfpadmin**, **mfpdeployer**, **mfpmonitor** und **mfpoperator** in der Konfigurationsdatei
**server.xml** des Servers konfiguriert. 

Sie müssen die Datei
**server.xml** bearbeiten, um die Sicherheitsrollen zu konfigurieren.
Erstellen Sie im Element `<application-bnd>` jedes `<application>`-Elements `<security-role>`-Elemente. Jedes Element `<security-role>` ist für die Rollen **mfpadmin**, **mfpdeployer**, **mfpmonitor** und **mfpoperator** bestimmt. Ordnen Sie die Rollen dem passenden Benutzergruppennamen zu,
in diesem Beispiel **mfpadmingroup**, **mfpdeployergroup**, **mfpmonitorgroup**
oder **mfpoperatorgroup**. Diese Gruppen werden mit dem Element `<basicRegistry>` definiert. Sie können dieses Element entweder anpassen oder ganz durch ein `<ldapRegistry>`-Element oder ein `<safRegistry>`-Element ersetzen.

Anschließend
sollten Sie einen Verbindungspool für die Verwaltungsdatenbank konfigurieren,
um bei einer großen Anzahl von installierten Anwendungen (z. B. 80 Anwendungen) gute Antwortzeiten zu erzielen.

1. Bearbeiten Sie die Datei
**server.xml**. Beispiel: 

   ```xml
   <security-role name="mfpadmin">
      <group name="mfpadmingroup"/>
   </security-role>
   <security-role name="mfpdeployer">
      <group name="mfpdeployergroup"/>
   </security-role>
   <security-role name="mfpmonitor">
      <group name="mfpmonitorgroup"/>
   </security-role>
   <security-role name="mfpoperator">
      <group name="mfpoperatorgroup"/>
   </security-role>

   <basicRegistry id="mfpadmin">
      <user name="admin" password="admin"/>
      <user name="guest" password="guest"/>
      <user name="demo" password="demo"/>
      <group name="mfpadmingroup">
        <member name="guest"/>
        <member name="demo"/>
      </group>
      <group name="mfpdeployergroup">
        <member name="admin" id="admin"/>
      </group>
      <group name="mfpmonitorgroup"/>
      <group name="mfpoperatorgroup"/>
   </basicRegistry>
   ```

2. Definieren Sie die Größe für **AppCenterPool**: 

   ```xml
   <connectionManager id="AppCenterPool" minPoolSize="10" maxPoolSize="40"/>
   ```

3. Definieren Sie im Element `<dataSource>` eine Referenz auf den Verbindungsmanager:

   ```xml
   <dataSource id="MFPADMIN" jndiName="mfpadmin/jdbc/mfpAdminDS" connectionManagerRef="AppCenterPool">
   ...
   </dataSource>
   ```

### Apache Tomcat für die MobileFirst-Server-Verwaltung konfigurieren
{: #configuring-apache-tomcat-for-mobilefirst-server-administration }
Sie müssen die Java-EE-Sicherheitsrollen für die
MobileFirst-Server-Verwaltung
im Apache-Tomcat-Webanwendungsserver konfigurieren.

1. Wenn Sie die MobileFirst-Server-Verwaltung
manuell installiert haben, deklarieren Sie die folgenden Rollen in der Datei
**conf/tomcat-users.xml**:

   ```xml
   <role rolename="mfpadmin"/>
   <role rolename="mfpmonitor"/>
   <role rolename="mfpdeployer"/>
   <role rolename="mfpoperator"/>
   ```

2. Fügen Sie den ausgewählten Benutzern Rollen hinzu, z. B.:

   ```xml
   <user name="admin" password="admin" roles="mfpadmin"/>
   ```

3. Sie können die Benutzer wie in der Apache Tomcat-Dokumentation
unter [Realm Configuration HOW-TO](http://tomcat.apache.org/tomcat-7.0-doc/realm-howto.html) beschrieben definieren.

## Liste der JNDI-Eigenschaften für die MobileFirst-Server-Webanwendungen
{: #list-of-jndi-properties-of-the-mobilefirst-server-web-applications }
Konfigurieren Sie die JNDI-Eigenschaften für die MobileFirst-Server-Webanwendungen, die im Anwendungsserver
implementiert sind. 

* [Liste der JNDI-Eigenschaften für die MobileFirst-Server-Webanwendungen konfigurieren](#setting-up-jndi-properties-for-mobilefirst-server-web-applications)
* [Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice](#list-of-jndi-properties-for-mobilefirst-server-administration-service)
* [Liste der JNDI-Eigenschaften für den MobileFirst-Server-Liveaktualisierungsservice](#list-of-jndi-properties-for-mobilefirst-server-live-update-service)
* [Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit](#list-of-jndi-properties-for-mobilefirst-runtime)
* [Liste der JNDI-Eigenschaften für den MobileFirst-Server-Push-Service](#list-of-jndi-properties-for-mobilefirst-server-push-service)

### JNDI-Eigenschaften für MobileFirst-Server-Webanwendungen konfigurieren
{: #setting-up-jndi-properties-for-mobilefirst-server-web-applications }
Sie können JNDI-Eigenschaften für die im Anwendungsserver implementierten MobileFirst-Server-Webanwendungen
konfigurieren.   
Sie haben die folgenden Möglichkeiten, die JNDI-Umgebungseinträge festzulegen: 

* Konfigurieren Sie die Serverumgebungseinträge. Die Konfigurationsschritte für die Serverumgebungseinträge hängen wie folgt vom verwendeten Anwendungsserver
ab: 

    * **WebSphere Application Server:**
        1. Navigieren Sie in der Administrationskonsole von WebSphere Application Server zu
**Anwendungen → Anwendungstypen → WebSphere-Unternehmensanwendungen → Anwendungsname → Umgebungseinträge für Webmodule**.
        2. Geben Sie im Feld Wert Werte ein, die für Ihre Serverumgebung geeignet sind. 

        ![JNDI-Umgebungseinträge in WebSphere](jndi_was.jpg)
    * WebSphere Application Server Liberty:

      Bearbeiten Sie die Datei **server.xml** unter **Liberty-Installationsverzeichnis/usr/servers/Servername** und deklarieren Sie wie folgt die
JNDI-Eigenschaften: 

      ```xml
      <application id="App-Kontextstammverzeichnis" name="App-Kontextstammverzeichnis" location="App-WAR-Name.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="App-Kontextstammverzeichnis/Name_der_JNDI-Eigenschaft" value="Wert_der_JNDI-Eigenschaft" />
      ```

      Das Kontextstammverzeichnis
(im obigen Beispiel **App-Kontextstammverzeichnis**)
ist die Verbindung zwischen dem JNDI-Eintrag und einer bestimmten {{ site.data.keys.product_adj }}-Anwendung. Wenn mehrere
{{ site.data.keys.product_adj }}-Anwendungen in demselben Server vorhanden sind, können
Sie bestimmte JNDI-Einträge für jede Anwendung mit dem Kontextpfadpräfix definieren. 

      > **Hinweis:** Einige Eingenschaften werden in
WebSphere Application Server global definiert, ohne dass das Kontextstammverzeichnis
als Präfix für den Eigenschaftsnamen verwendet wird. Eine Liste dieser Eigenschaften finden Sie unter [Globale JNDI-Einträge](../appserver/#global-jndi-entries).
      Die Namen aller anderen
JNDI-Eigenschaften müssen mit dem Konstextstammverzeichis der Anwendung als Präfix versehen sein. 

       * Das Kontextstammverzeichnis für den Liveaktualisierungsservice muss **/[Kontextstammverzeichnis_des_Verwaltungsservice]config** lauten. Wenn das Kontextstammverzeichnis des Verwaltungsservice beispielsweise
**/mfpadmin** ist, muss der Liveaktualisierungsservice das Kontextstammverzeichnis
**/mfpadminconfig** haben.
       * Für den Push-Service müssen Sie **/imfpush** als Kontextstammverzeichnis festlegen.
Andernfalls können die Clientgeräte keine Verbindung zu dem Service herstellen, denn das Kontextstammverzeichnis ist im
SDK fest codiert.
       * Für den {{ site.data.keys.product_adj }}-Verwaltungsservice,
die {{ site.data.keys.mf_console }}
und die {{ site.data.keys.product_adj }}-Laufzeit können Sie das Kontextstammverzeichnis
ganz nach Wunsch definieren. Die Standardwerte lauten
**/mfpadmin** für den {{ site.data.keys.product_adj }}-Verwaltungsservice,
**/mfpconsole** für die {{ site.data.keys.mf_console }} und
**/mfp** für die {{ site.data.keys.product_adj }}-Laufzeit. 

      Beispiel: 

      ```xml
      <application id="mfpadmin" name="mfpadmin" location="mfp-admin-service.war" type="war">
            ...
      </application>
      <jndiEntry jndiName="mfpadmin/mfp.admin.actions.prepareTimeout" value = "2400000" />
      ```    

    * Apache Tomcat:

      Bearbeiten Sie die Datei **server.xml** unter
**Tomcat-Installationsverzeichnis/conf** und deklarieren Sie wie folgt die JNDI-Eigenschaften: 

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="Name_der_JNDI-Eigenschaft" override="false" type="java.lang.String" value="Wert_der_JNDI-Eigenschaft"/>
      </Context>
      ```

        * Das Präfix für den Kontextpfad ist nicht erforderlich, weil die JNDI-Einträge innerhalb des Elements `<Context>` einer Anwendung definiert werden.
        * Die Angabe `override="false"` ist obligatorisch. 
        * Das Attribut `type` hat immer den Wert `java.lang.String`,
sofern für die Eigenschaft nichts anderes angegeben ist. 

      Beispiel: 

      ```xml
      <Context docBase="app_context_root" path="/app_context_root">
            <Environment name="mfp.admin.actions.prepareTimeout" override="false" type="java.lang.String" value="2400000"/>
      </Context>
      ```

* Wenn Sie für die Installation Ant-Tasks verwenden, können Sie die Werte der JNDI-Eigenschaften
auch zur Installationszeit festlegen. 

  Bearbeiten Sie die XML-Konfigurationsdatei für die Ant-Tasks
unter **MFP-Installationsverzeichnis/MobileFirstServer/configuration-samples** und deklarieren Sie die Werte für die JNDI-Eigenschaften mit dem Element
property innerhalb folgender Tags: 

  * `<installmobilefirstadmin>` für die MobileFirst-Server-Verwaltung, die {{ site.data.keys.mf_console }} und den Liveaktualisierungsservice. Weitere Informationen finden Sie unter
[Ant-Tasks für die Installation
der {{ site.data.keys.mf_console }}, der MobileFirst-Server-Artefakte, des MobileFirst-Server-Verwaltungsservice und des
Liveaktualisierungsservice](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-operations-console-mobilefirst-server-artifacts-mobilefirst-server-administration-and-live-update-services).
  * `<installmobilefirstruntime>` für die Konfigurationseigenschaften der {{ site.data.keys.product_adj }}-Laufzeit. Weitere Informationen finden Sie unter
[Ant-Tasks für die Installation der
{{ site.data.keys.product_adj }}-Laufzeitumgebungen](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-runtime-environments).
  * `<installmobilefirstpush>` für die Konfiguration des Push-Service. Weitere Informationen finden Sie unter
[Ant-Tasks für die Installation des MobileFirst-Server-Push-Service](../installation-reference/#ant-tasks-for-installation-of-mobilefirst-server-push-service).

  Beispiel: 

  ```xml
  <installmobilefirstadmin ..>
        <property name = "mfp.admin.actions.prepareTimeout" value = "2400000" />
  </installmobilefirstadmin>
  ```

### Liste der JNDI-Eigenschaften für den MobileFirst-Server-Verwaltungsservice
{: #list-of-jndi-properties-for-mobilefirst-server-administration-service }
Wenn Sie die Verwaltungsservices von {{ site.data.keys.mf_server }}
und die {{ site.data.keys.mf_console }} für Ihren Anwendungsserver konfigurieren, definieren Sie optionale
oder obligatorische JNDI-Eigenschaften, insbesondere für Java Management Extensions (JMX). 

Für die
Webanwendung für Verwaltungsservices,
mfp-admin-service.war, können die folgenden Eigenschaften festgelegt werden: 

#### JNDI-Eigenschaften für den Verwaltungsservice: JMX
{: #jndi-properties-for-administration-service-jmx }

| Eigenschaft | Optional oder obligatorisch | Beschreibung | Einschränkungen |
|--------------------------|-----------------------|-------------|--------------|
| mfp.admin.jmx.connector | Optional | JMX-Connectortyp (Java Management Extensions)<br/>Die gültigen Werte sind `SOAP` und `RMI`. Der Standardwert ist SOAP. | Nur WebSphere Application Server |
| mfp.admin.jmx.host | Optional | Hostname für die JMX-REST-Verbindung | Nur Liberty Profile |
| mfp.admin.jmx.port	   | Optional	           | Port für die JMX-REST-Verbindung | Nur Liberty Profile |
| mfp.admin.jmx.user       | Obligatorisch für Liberty Profile und eine WebSphere-Application-Server-Farm; andernfalls optional | Benutzername für die JMX-REST-Verbindung | WebSphere Application Server Liberty Profile: Benutzername für die JMX-REST-Verbindung<br/><br/>WebSphere-Application-Server-Farm: Benutzername für die SOAP-Verbindung<br/><br/>WebSphere Application Server Network Deployment: Benutzername des WebSphere-Administrators, wenn der der Anwendung für MobileFirst-Server-Verwaltung zugeordnete virtuelle Host nicht der Standardhost ist<br/><br/>Liberty-Verbund: Benutzername des Controlleradministrators, der im Element `<administrator-role>` der Datei server.xml des Liberty-Controllers definiert ist |
| mfp.admin.jmx.pwd	| Obligatorisch für Liberty Profile und eine WebSphere-Application-Server-Farm; andernfalls optional | Benutzerkennwort für die JMX-REST-Verbindung | WebSphere Application Server Liberty Profile: Benutzerkennwort für die JMX-REST-Verbindung<br/><br/>WebSphere-Application-Server-Farm: Benutzerkennwort für die SOAP-Verbindung<br/><br/>WebSphere Application Server Network Deployment: Kennwort des WebSphere-Administrators, wenn der der Anwendung für MobileFirst-Server-Verwaltung zugeordnete virtuelle Host nicht der Standardhost ist<br/><br/>Liberty-Verbund: Kennwort des Controlleradministrators, der im Element `<administrator-role>` der Datei server.xml des Liberty-Controllers definiert ist |
| mfp.admin.rmi.registryPort | Optional | RMI-Registryport für die JMX-Verbindung über eine Firewall | Nur Tomcat |
| mfp.admin.rmi.serverPort | Optional | RMI-Serverport für die JMX-Verbindung über eine Firewall | Nur Tomcat |
| mfp.admin.jmx.dmgr.host | Obligatorisch | Hostname des Deployment Manager | Nur WebSphere Application Server Network Deployment |
| mfp.admin.jmx.dmgr.port | Obligatorisch | RMI- oder SOAP-Port des Deployment Manager | Nur WebSphere Application Server Network Deployment |

#### JNDI-Eigenschaften für den Verwaltungsservice: Zeitlimit
{: #jndi-properties-for-administration-service-timeout }

| Eigenschaft | Optional oder obligatorisch | Beschreibung |
|--------------------------|-----------------------|--------------|
| mfp.admin.actions.prepareTimeout | Optional | Zeitlimit (in Millisekunden) für die Übertragung von Daten vom Verwaltungsservice an die Laufzeitumgebung während einer Implementierungstransaktion. Wenn die Laufzeitumgebung innerhalb dieses Zeitlimits nicht erreicht werden kann, wird ein Fehler ausgelöst und die Implementierungstransaktion beendet.<br/><br/>Der Standardwert ist 1800000 ms (30 Minuten). |
| mfp.admin.actions.commitRejectTimeout | Optional | Das Zeitlimit (in Millisekunden) für das Festschreiben oder Zurückweisen einer Implementierungstransaktion, wenn eine Verbindung zur Laufzeitumgebung hergestellt wird. Wenn die Laufzeitumgebung innerhalb dieses Zeitlimits nicht erreicht werden kann, wird ein Fehler ausgelöst und die Implementierungstransaktion beendet.<br/><br/>Der Standardwert ist 120000 ms (2 Minuten). |
| mfp.admin.lockTimeoutInMillis | Optional |Das Zeitlimit (in Millisekunden) für das Abrufen der Transaktionssperre. Da Implementierungstransaktionen sequenziell ausgeführt werden, verwenden sie eine Sperre. Deshalb muss eine Transaktion warten, bis eine vorherige Transaktion beendet ist. Dieses Zeitlimit gibt an, wie lange eine Transaktion maximal wartet.<br/><br/>Der Standardwert ist 1200000 ms (20 Minuten). |
| mfp.admin.maxLockTimeInMillis | Optional | Die maximal zulässige Haltezeit für eine Transaktionssperre durch einen Prozess. Da Implementierungstransaktionen sequenziell ausgeführt werden, verwenden sie eine Sperre. Wenn der Anwendungsserver ausfällt, während eine Sperre gehalten wird, kann es in seltenen Fällen vorkommen, dass die Sperre beim nächsten Neustart des Anwendungsservers nicht freigegeben wird. In diesem Fall wird die Sperre nach Ablauf der maximalen Sperrzeit automatisch freigegeben, sodass der Server nicht für immer blockiert bleibt. Definieren Sie eine Zeit, die die normale Dauer einer Transaktion nicht überschreitet.<br/><br/>Der Standardwert ist 1800000 (30 Minuten). |

#### JNDI-Eigenschaften für den Verwaltungsservice: Protokollierung
{: #jndi-properties-for-administration-service-logging }

| Eigenschaft| Optional oder obligatorisch| Beschreibung|
|--------------------------|-----------------------|--------------|
| mfp.admin.logging.formatjson| Optional| Setzen Sie diese Eigenschaft auf true, um für JSON-Objekte eine besser lesbare Formatierung (mit zusätzlichem Leerzeichen) in Antworten und Protokollnachrichten zu aktivieren. Die Definition dieser Eigenschaft ist hilfreich, wenn Sie den Server debuggen. Der Standardwert ist false.|
| mfp.admin.logging.tosystemerror| Optional| Gibt an, ob alle Protokollierungsnachrichten auch an System.Error übertragen werden. Die Definition dieser Eigenschaft ist hilfreich, wenn Sie den Server debuggen. |

#### JNDI-Eigenschaften für den Verwaltungsservice: Proxys
{: #jndi-properties-for-administration-service-proxies }

| Eigenschaft| Optional oder obligatorisch| Beschreibung|
|--------------------------|-----------------------|--------------|
| mfp.admin.proxy.port| Optional| Wenn sich der {{ site.data.keys.product_adj }}-Verwaltungsserver hinter einer Firewall oder einem Reverse Proxy befindet, gibt diese Eigenschaft die Adresse des Hosts an. Definieren Sie diese Eigenschaft, wenn Sie einem Benutzer außerhalb der Firewall ermöglichen möchten, den {{ site.data.keys.product_adj }}-Verwaltungsserver zu erreichen. Gewöhnlich wird mit dieser Eigenschaft der Port des Proxys angegeben, z. B. 443. Die Eigenschaft ist nur erforderlich, wenn das Protokoll der externen und der internen URIs voneinander abweichen.|
| mfp.admin.proxy.protocol| Optional| Wenn sich der {{ site.data.keys.product_adj }}-Verwaltungsserver hinter einer Firewall oder einem Reverse Proxy befindet, gibt diese Eigenschaft das Protokoll an (HTTP oder HTTPS). Definieren Sie diese Eigenschaft, wenn Sie einem Benutzer außerhalb der Firewall ermöglichen möchten, den {{ site.data.keys.product_adj }}-Verwaltungsserver zu erreichen. Gewöhnlich wird diese Eigenschaft auf das Protokoll des Proxys gesetzt, z. B. wl.net. Diese Eigenschaft ist nur erforderlich, wenn das Protokoll der externen und der internen URIs voneinander abweichen.|
| mfp.admin.proxy.scheme| Optional| Diese Eigenschaft ist lediglich ein alternativer Name für mfp.admin.proxy.protocol.|
| mfp.admin.proxy.host| Optional| Wenn sich der {{ site.data.keys.product_adj }}-Verwaltungsserver hinter einer Firewall oder einem Reverse Proxy befindet, gibt diese Eigenschaft die Adresse des Hosts an. Definieren Sie diese Eigenschaft, wenn Sie einem Benutzer außerhalb der Firewall ermöglichen möchten, den {{ site.data.keys.product_adj }}-Verwaltungsserver zu erreichen. Gewöhnlich wird mit dieser Eigenschaft die Adresse des Proxys angegeben. |

#### JNDI-Eigenschaften für den Verwaltungsservice: Topologien
{: #jndi-properties-for-administration-service-topologies }

| Eigenschaft | Optional oder obligatorisch | Beschreibung |
|--------------------------|-----------------------|--------------|
| mfp.admin.audit | Optional | Setzen Sie diese Eigenschaft auf false, um das Prüffeature der {{ site.data.keys.mf_console }} zu inaktivieren. Der Standardwert ist true. |
| mfp.admin.environmentid | Optional | Die Umgebungs-ID für die Registrierung der MBeans. Verwenden Sie diese ID, wenn verschiedene {{ site.data.keys.mf_server }}-Instanzen in demselben Anwendungsserver installiert sind. Die ID bestimmt, welcher Verwaltungsservice, welche Konsole und welche Laufzeitumgebungen zu derselben Installation gehören. Der Verwaltungsservice verwaltet nur die Laufzeitumgebungen, die dieselbe Umgebungs-ID haben. |
| mfp.admin.serverid | Obligatorisch für Server-Farmen und einen Liberty-Verbund, ansonsten optional | Server-Farm: Die Serverkennung. Die ID muss für jeden Server in der Farm eindeutig sein.<br/><br/> Liberty-Verbund: Der Wert muss controller lauten. |
| mfp.admin.hsts | Optional | Setzen Sie diese Eigenschaft auf "true", um HTTP Strict Transport Security gemäß RFC 6797 zu aktivieren. |
| mfp.topology.platform | Optional | Der Servertyp. Die gültigen Werte sind im Folgenden aufgelistet: {::nomarkdown}<ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>{:/}Wenn Sie den Wert nicht definieren, versucht die Anwendung, den Servertyp zu raten. |
| mfp.topology.clustermode | Optional | Zusätzlich zum Servertyp geben Sie mit dieser Eigenschaft die Servertopologie an. Die gültigen Werte sind im Folgenden aufgelistet: {::nomarkdown}<ul><li>Standalone</li><li>Cluster</li><li>Farm</li></ul>{:/}Der Standardwert ist Standalone. |
| mfp.admin.farm.heartbeat | Optional | Mit dieser Eigenschaft können Sie für Server-Farmtopologien die Signalrate in Minuten festlegen. Der Standardwert liegt bei 2 Minuten.<br/><br/>In einer Server-Farm müssen alle Member dieselbe Signalrate verwenden. Wenn Sie diesen JNDI-Wert auf einem Server in der Farm festlegen oder ändern, müssen Sie diesen neuen/geänderten Wert auch auf allen anderen Servern der Farm festlegen. Weitere Informationen finden Sie unter [Lebenszyklus eines Server-Farm-Knotens](../appserver/#lifecycle-of-a-server-farm-node). |
| mfp.admin.farm.missed.heartbeats.timeout | Optional | Mit dieser Eigenschaft können Sie festlegen, nach wie vielen fehlenden Überwachungssignalen ein Farm-Member als ausgefallen oder inaktiviert betrachtet wird. Der Standardwert ist 2.<br/><br/>In einer Server-Farm müssen alle Member dieselbe Anzahl fehlender Überwachungssignale verwenden. Wenn Sie diesen JNDI-Wert auf einem Server in der Farm festlegen oder ändern, müssen Sie diesen neuen/geänderten Wert auch auf allen anderen Servern der Farm festlegen. Weitere Informationen finden Sie unter [Lebenszyklus eines Server-Farm-Knotens](../appserver/#lifecycle-of-a-server-farm-node). |
| mfp.admin.farm.reinitialize | Optional | Boolescher Wert (true oder false) für die erneute Registrierung oder Reinitialisierung des Farm-Members |
| mfp.server.swagger.ui.url | Optional | Diese Eigenschaft definiert die URL der Swagger-Benutzerschnitttelle, die in der Administrationskonsole angezeigt werden soll. |

#### JNDI-Eigenschaften für den Verwaltungsservice: relationale Datenbank
{: #jndi-properties-for-administration-service-relational-database }

| Eigenschaft| Optional oder obligatorisch| Beschreibung|
|--------------------------|-----------------------|--------------|
| mfp.admin.db.jndi.name| Optional| Der JNDI-Name der Datenbank. Dieser Parameter ist der normale Mechanismus für die Angabe der Datenbank. Der Standardwert ist **java:comp/env/jdbc/mfpAdminDS**.|
| mfp.admin.db.openjpa.ConnectionDriverName| Optional / Bedingt obligatorisch| Der vollständig qualifizierte Name der Treiberklasse der Datenbankverbindung. Diese Eigenschaft ist nur obligatorisch, wenn die mit der Eigenschaft **mfp.admin.db.jndi.name** angegebene Datenquelle nicht in der Anwendungsserverkonfiguration definiert ist.|
| mfp.admin.db.openjpa.ConnectionURL| Optional / Bedingt obligatorisch| Die URL für die Datenbankverbindung. Diese Eigenschaft ist nur obligatorisch, wenn die mit der Eigenschaft **mfp.admin.db.jndi.name** angegebene Datenquelle nicht in der Anwendungsserverkonfiguration definiert ist.|
| mfp.admin.db.openjpa.ConnectionUserName| Optional / Bedingt obligatorisch| Der Benutzername für die Datenbankverbindung. Diese Eigenschaft ist nur obligatorisch, wenn die mit der Eigenschaft **mfp.admin.db.jndi.name** angegebene Datenquelle nicht in der Anwendungsserverkonfiguration definiert ist.|
| mfp.admin.db.openjpa.ConnectionPassword| Optional / Bedingt obligatorisch| Das Kennwort für die Datenbankverbindung. Diese Eigenschaft ist nur obligatorisch, wenn die mit der Eigenschaft **mfp.admin.db.jndi.name** angegebene Datenquelle nicht in der Anwendungsserverkonfiguration definiert ist.|
| mfp.admin.db.openjpa.Log| Optional| Diese Eigenschaft wird an OpenJPA übergeben und aktiviert die JPA-Protokollierung. Weitere Informationen finden Sie in der Veröffentlichung [Apache OpenJPA User's Guide](http://openjpa.apache.org/docs/openjpa-0.9.0-incubating/manual/manual.html).|
| mfp.admin.db.type| Optional| Diese Eigenschaft definiert den Datenbanktyp. Der Standardwert wird aus der Verbindungs-URL hergeleitet.|

#### JNDI-Eigenschaften für den Verwaltungsservice: Lizenzierung
{: #jndi-properties-for-administration-service-licensing }

| Eigenschaft| Optional oder obligatorisch| Beschreibung|
|--------------------------|-----------------------|--------------|
| mfp.admin.license.key.server.host| {::nomarkdown}<ul><li>Optional für zeitlich unbegrenzte Lizenzen</li><li>Obligatorisch für Tokenlizenzen</li></ul>{:/} | Hostname von Rational License Key Server|
| mfp.admin.license.key.server.port| {::nomarkdown}<ul><li>Optional für zeitlich unbegrenzte Lizenzen</li><li>Obligatorisch für Tokenlizenzen</li></ul>{:/} | Portnummer von Rational License Key Server|

#### JNDI-Eigenschaften für den Verwaltungsservice: JNDI-Konfigurationen
{: #jndi-properties-for-administration-service-jndi-configurations }

| Eigenschaft| Optional oder obligatorisch| Beschreibung|
|--------------------------|-----------------------|--------------|
| mfp.jndi.configuration| Optional| Der Name der JNDI-Konfiguration, wenn die JNDI-Eigenschaften (bis auf diese) aus einer Eigenschaftendatei gelesen werden müssen, die in die WAR-Datei injiziert ist. Wenn Sie diese Eigenschaft nicht definieren, werden die JNDI-Eigenschaften nicht aus einer Eigenschaftendatei gelesen.|
| mfp.jndi.file| Optional| Der Name der Datei mit der JNDI-Konfiguration, wenn die JNDI-Eigenschaften (bis auf diese) aus einer im Web-Server installierten Datei gelesen werden müssen. Wenn Sie diese Eigenschaft nicht definieren, werden die JNDI-Eigenschaften nicht aus einer Eigenschaftendatei gelesen.|

Der Verwaltungsservice verwendet einen Liveaktualisierungsservice als Hilfseinrichtung, um verschiedene Konfigurationen zu speichern. Mit diesen Eigenschaften legen Sie fest, wie der Liveaktualisierungsservice erreicht werden kann.

#### JNDI-Eigenschaften für den Verwaltungsservice: Liveaktualisierungsservice
{: #jndi-properties-for-administration-service-live-update-service }

| Eigenschaft | Optional oder obligatorisch | Beschreibung |
|--------------------------|-----------------------|--------------|
| mfp.config.service.url | Optional | URL des Liveaktualisierungsservice. Die Standard-URL wird aus der URL des Verwaltungsservice abgeleitet, indem config zum Kontextstammverzeichnis des Verwaltungsservice hinzugefügt wird. |
| mfp.config.service.user | Obligatorisch | Benutzername für den Zugriff auf den Liveaktualisierungsservice. In einer Server-Farmtopologie muss der Benutzername für alle Member der Farm der gleiche sein. |
| mfp.config.service.password | Obligatorisch | Kennwort für den Zugriff auf den Liveaktualisierungsservice. In einer Server-Farmtopologie muss das Kennwort für alle Member der Farm das gleiche sein. |
| mfp.config.service.schema | Optional | Name des vom Liveaktualisierungsservice verwendeten Schemas |

Der Verwaltungsservice verwendet einen Push-Service als Hilfseinrichtung, um verschiedene Push-Einstellungen zu speichern. Mit diesen Eigenschaften legen Sie fest, wie der Push-Service
erreicht werden kann. Da der Push-Service mit dem OAuth-Sicherheitsmodell geschützt ist,
müssen Sie verschiedene Eigenschaften definieren, um in OAuth vertrauliche Clients zu ermöglichen. 

#### JNDI-Eigenschaften für den Verwaltungsservice: Push-Service
{: #jndi-properties-for-administration-service-push-service }

| Eigenschaft| Optional oder obligatorisch| Beschreibung|
|--------------------------|-----------------------|--------------|
| mfp.admin.push.url| Optional| URL des Push-Service. Wenn die Eigenschaft nicht angegeben ist, wird der Push-Service als inaktiviert angesehen. Wenn die Eigenschaft nicht ordnungsgemäß definiert ist, kann der Verwaltungsservice keinen Kontakt zum Push-Service aufnehmen, sodass die Verwaltung der Push-Services in der {{ site.data.keys.mf_console }} nicht funktioniert.|
| mfp.admin.authorization.server.url| Optional| URL des OAuth-Autorisierungsservers, der vom Push-Service verwendet wird. Die Standard-URL wird aus der URL des Verwaltungsservice abgeleitet, indem das Kontextstammverzeichnis in das Kontextstammverzeichnis der ersten installierten Laufzeit geändert wird. Wenn Sie mehrere Laufzeiten installieren, ist es am besten, die Eigenschaft zu definieren. Wenn die Eigenschaft nicht ordnungsgemäß definiert ist, kann der Verwaltungsservice keinen Kontakt zum Push-Service aufnehmen, sodass die Verwaltung der Push-Services in der {{ site.data.keys.mf_console }} nicht funktioniert.|
| mfp.push.authorization.client.id| Optional / Bedingt obligatorisch| Kennung des vertraulichen Clients, der die OAuth-Autorisierung für den Push-Service ausführt. Nur obligatorisch, wenn die Eigenschaft **mfp.admin.push.url** angegeben ist.|
| mfp.push.authorization.client.secret| Optional / Bedingt obligatorisch| Geheimer Schlüssel des vertraulichen Clients, der die OAuth-Autorisierung für den Push-Service ausführt. Nur obligatorisch, wenn die Eigenschaft **mfp.admin.push.url** angegeben ist.|
| mfp.admin.authorization.client.id| Optional / Bedingt obligatorisch| Kennung des vertraulichen Clients, der die OAuth-Autorisierung für den Verwaltungsservice ausführt. Nur obligatorisch, wenn die Eigenschaft **mfp.admin.push.url** angegeben ist.|
| mfp.push.authorization.client.secret| Optional / Bedingt obligatorisch| Geheimer Schlüssel des vertraulichen Clients, der die OAuth-Autorisierung für den Verwaltungsservice ausführt. Nur obligatorisch, wenn die Eigenschaft **mfp.admin.push.url** angegeben ist.|

### JNDI-Eigenschaften für die {{ site.data.keys.mf_console }}
{: #jndi-properties-for-mobilefirst-operations-console }
Für die
Webanwendung für die {{ site.data.keys.mf_console }},
mfp-admin-ui.war, können die folgenden Eigenschaften festgelegt werden: 

| Eigenschaft| Optional oder obligatorisch| Beschreibung|
|--------------------------|-----------------------|--------------|
| mfp.admin.endpoint| Optional| Ermöglicht der {{ site.data.keys.mf_console }}, die REST-Services für die MobileFirst-Server-Verwaltung zu finden. Geben Sie die externe Adresse und das Kontextstammverzeichnis der Webanwendung **mfp-admin-service.war** an. In einem Szenario mit einer Firewall oder einem geschützten Reverse Proxy muss diese URI die externe URI, nicht die interne URI im lokalen Netz sein. Beispiel: https://wl.net:443/mfpadmin|
| mfp.admin.global.logout| Optional| Löscht den WebSphere-Benutzerauthentifizierungscache während der Abmeldung von der Konsole. Diese Eigenschaft ist nur für WebSphere Application Server Version 7 hilfreich. Der Standardwert ist false.|
| mfp.admin.hsts| Optional| Setzen Sie diese Eigenschaft auf true, um [HTTP Strict Transport Security](http://www.w3.org/Security/wiki/Strict_Transport_Security) gemäß RFC 6797 zu aktivieren. Weitere Informationen finden Sie auf der W3C-Webseite Strict Transport Security. Der Standardwert ist false.|
| mfp.admin.ui.cors| Optional| Der Standardwert ist true.Weitere Informationen finden Sie auf der W3C-Webseite [Cross-Origin Resource Sharing](http://www.w3.org/TR/cors/).|
| mfp.admin.ui.cors.strictssl| Optional| Setzen Sie diese Eigenschaft auf false, um CORS-Situationen zuzulassen, in denen die {{ site.data.keys.mf_console }} mit SSL (HTTPS-Protokoll) gesichert ist, aber der MobileFirst-Server-Verwaltungsservice nicht, oder umgekehrt. Diese Eigenschaft wird nur wirksam, wenn die Eigenschaft **mfp.admin.ui.cors** aktiviert ist.|

### Liste der JNDI-Eigenschaften für den MobileFirst-Server-Liveaktualisierungsservice
{: #list-of-jndi-properties-for-mobilefirst-server-live-update-service }
Wenn Sie den MobileFirst-Server-Liveaktualisierungsservice für Ihren Anwendungsserver konfigurieren, können Sie die folgenden
JNDI-Eigenschaften festlegen. In der folgenden Tabelle sind die JNDI-Eigenschaften für den Liveaktualisierungsservice
für die relationale IBM Datenbank aufgelistet. 

| Eigenschaft| Optional oder obligatorisch| Beschreibung|
|----------|-----------------------|-------------|
| mfp.db.relational.queryTimeout| Optional| Zeitlimit für die Ausführung einer Abfrage im RDBMS in Sekunden. Der Wert null bedeutet kein Zeitlimit. Ein negativer Wert bedeutet, dass der Standardwert verwendet wird (keine Außerkraftsetzung).<br/><br/>Falls kein Wert konfiguriert ist, wird ein Standardwert verwendet. Weitere Informationen finden Sie unter [setQueryTimeout)](http://docs.oracle.com/javase/7/docs/api/java/sql/Statement.html#setQueryTimeout(int).|

Informationen zum Festlegen dieser Eigenschaften finden Sie unter [JNDI-Eigenschaften für MobileFirst-Server-Webanwendungen konfigurieren](#setting-up-jndi-properties-for-mobilefirst-server-web-applications). 

### Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit
{: #list-of-jndi-properties-for-mobilefirst-runtime }
Wenn Sie die MobileFirst-Server-Laufzeit für Ihren Anwendungsserver konfigurieren, müssen Sie die folgenden
optionalen oder obligatorischen JNDI-Eigenschaften festlegen.   
In der folgenden Tabelle
sind die {{ site.data.keys.product_adj }}-Eigenschaften aufgelistet, die immer als JNDI-Einträge
verfügbar sind:


| Eigenschaft | Beschreibung |
|----------|-------------|
| mfp.admin.jmx.dmgr.host | Diese obligatorische Eigenschaft gibt den Hostnamen des Deployment Manager an (nur WebSphere Application Server Network Deployment). |
| mfp.admin.jmx.dmgr.port | Diese obligatorische Eigenschaft gibt den RMI- oder SOAP-Port des Deployment Manager an (nur WebSphere Application Server Network Deployment). |
| mfp.admin.jmx.host | Nur Liberty. Hostname für die JMX-REST-Verbindung. Verwenden Sie in einem Liberty-Verbund den Hostnamen des Controllers. |
| mfp.admin.jmx.port | Nur Liberty. Port-Nummer für die JMX-REST-Verbindung. In einem Liberty-Verbund muss der Port des REST-Connectors mit dem Wert des Attributs httpsPort, das im Element `<httpEndpoint>` deklariert ist, übereinstimmen. Das Element ist in der Datei server.xml des Liberty-Controllers deklariert. |
| mfp.admin.jmx.user | WebSphere-Application-Server-Farm: Benutzername für die SOAP-Verbindung (optional)<br/><br/>Liberty-Verbund: Benutzername des Controlleradministrators, der im Element `<administrator-role>` der Datei server.xml des Liberty-Controllers definiert ist |
| mfp.admin.jmx.pwd | WebSphere-Application-Server-Farm: Benutzerkennwort für die SOAP-Verbindung (optional)<br/><br/>Liberty-Verbund: Kennwort des Controlleradministrators, der im Element `<administrator-role>` der Datei server.xml des Liberty-Controllers definiert ist |
| mfp.admin.serverid | Obligatorisch für Server-Farmen und einen Liberty-Verbund, ansonsten optional<br/><br/>Server-Farm: Die Serverkennung. Die ID muss für jeden Server in der Farm eindeutig sein.<br/><br/>Liberty-Verbund: die Memberkennung. Jedes Member des Verbunds muss eine andere Kennung haben. Der Wert controller kann nicht verwendet werden, weil er für den Verbundcontroller reserviert ist. |
| mfp.topology.platform | Optional. Der Servertyp. Gültige Werte: <ul><li>Liberty</li><li>WAS</li><li>Tomcat</li></ul>Wenn Sie den Wert nicht definieren, versucht die Anwendung, den Servertyp zu raten. |
| mfp.topology.clustermode | Zusätzlich zum Servertyp geben Sie mit dieser optionalen Eigenschaft die Servertopologie an. Die gültigen Werte sind im Folgenden aufgelistet: <ul><li>Standalone<li>Cluster</li><li>Farm</li></ul>Der Standardwert ist Standalone. |
| mfp.admin.jmx.replica | Nur für einen Liberty-Verbund (optional).<br/><br/>Legen Sie diese Eigenschaft nur fest, wenn die Verwaltungskomponenten, mit denen diese Laufzeit verwaltet wird, in verschiedenen Liberty-Controllern (d. h. Replikaten) implementiert sind.<br/><br/>Syntax der Endpunktliste mit den verschiedenen Controllerreplikaten: `replica-1 hostname:replica-1 port, replica-2 hostname:replica-2 port,..., replica-n hostname:replica-n port` |
| mfp.analytics.console.url | Die von IBM {{ site.data.keys.mf_analytics }} zugänglich gemachte URL für die Verbindung zur Analytics Console (optional). Wenn Sie von der {{ site.data.keys.mf_console }} auf die Analytics Console zugreifen möchten, definieren Sie diese Eigenschaft. Beispiel: `http://<Hostname>:<Port>/analytics/console` |
| mfp.analytics.password | Das Kennwort, das verwendet wird, wenn der Dateneingabepunkt für IBM {{ site.data.keys.mf_analytics }} durch Basisauthentifizierung geschützt ist. |
| mfp.analytics.url | Die von IBM {{ site.data.keys.mf_analytics }} zugänglich gemachte URL für den Empfang eingehender Analysedaten. Beispiel: `http://<Hostname>:<Port>/analytics-service/rest` |
| mfp.analytics.username | Der Benutzername, der verwendet wird, wenn der Dateneingabepunkt für IBM {{ site.data.keys.mf_analytics }} durch Basisauthentifizierung geschützt ist. |
| mfp.device.decommissionProcessingInterval | Definiert, wie häufig eine Stilllegung durchgeführt wird (Intervall in Sekunden). Standardwert: 86400 (ein Tag). |
| mfp.device.decommission.when | Anzahl von Tagen der Inaktivität, nach denen ein Clientgerät mit der Aufgabe für Gerätestilllegung stillgelegt wird. Standardwert: 90 Tage |
| mfp.device.archiveDecommissioned.when | Anzahl von Tagen der Inaktivität, nach denen ein stillgelegtes Clientgerät archiviert wird.<br/><br/>Diese Task schreibt die stillgelegten Clientgeräte in eine Archivdatei. Die archivierten Clientgeräte werden in eine Datei im MobileFirst-Server-Verzeichnis **home\devices_archive** geschrieben. Der Name der Datei enthält die Zeitmarke für den Erstellungszeitpunkt der Archivdatei. Standardwert: 90 Tage |
| mfp.licenseTracking.enabled | Mit dem Wert dieser Eigenschaft wird die Geräteüberwachung in der {{ site.data.keys.product }} aktiviert oder inaktiviert.<br/><br/>Aus Leistungsaspekten können Sie die Geräteüberwachung inaktivieren, wenn die {{ site.data.keys.product }} ausschließlich Business-to-Consumer-Apps (B2C) ausführt. Bei inaktivierter Geräteüberwachung sind auch die Lizenzberichte inaktiviert und es werden keine Lizenzmetriken generiert.<br/><br/>Gültige Werte sind true (Standard) und false. |
| mfp.runtime.temp.folder | Definiert den Laufzeitordner für temporäre Dateien. Wenn kein Wert angegeben ist, wird die Posotion des Standardordners für temporäre Dateien für den Web-Container verwendet. |
| mfp.adapter.invocation.url | URL zum Aufrufen von Adapterprozeduren in Java- oder JavaScript-Adaptern, die mit dem REST-Endpunkt aufgerufen werden. Wenn diese Eigenschaft nicht definiert ist, wird die URL der aktuell ausgeführten Anfrage verwendet. (Dies ist das Standardverhalten.) Als Wert muss eine vollständige URL mit Kontextstammverzeichnis angegeben werden. |
| mfp.authorization.server | Modus des Autorisierungsservers mit folgenden gültigen Werten:{::nomarkdown}<ul><li>embedded: Der {{ site.data.keys.product_adj }}-Autorisierungsserver wird verwendet.</li><li>external: Ein externer Autorisierungsserver wird verwendet.</li></ul>{:/}. Wenn Sie diesen Wert festlegen, müssen Sie auch die Eigenschaften **mfp.external.authorization.server.secret** und **mfp.external.authorization.server.introspection.url** für Ihren externen Server definieren. |
| mfp.external.authorization.server.secret | Geheimer Schlüssel des Autorisierungsservers. Diese Eigenschaft ist erforderlich, wenn ein externer Autorisierungsserver verwendet wird, d. h., wenn **mfp.authorization.server** auf external gesetzt ist. Andernfalls wird diese Eigenschaft ignoriert. |
| mfp.external.authorization.server.introspection.url | URL des Introspektionsendpunkts des Autorisierungsservers. Diese Eigenschaft ist erforderlich, wenn ein externer Autorisierungsserver verwendet wird, d. h., wenn **mfp.authorization.server** auf **external** gesetzt ist. Andernfalls wird diese Eigenschaft ignoriert. |
| ssl.websphere.config | Zum Konfigurieren des Keystores für einen HTTP-Adapter verwendet. Wenn diese Eigenschaft auf false gesetzt ist (Standardwert), wird die MobileFirst-Laufzeit angewiesen, den MobileFirst-Keystore zu verwenden. Der Wert true weist die MobileFirst-Laufzeit an, die WebSphere-SSL-Konfiguration zu verwenden. Weitere Informationen finden Sie unter [SSL-Konfiguration von WebSphere Application Server und HTTP-Adapter](#websphere-application-server-ssl-configuration-and-http-adapters). |

### Liste der JNDI-Eigenschaften für den MobileFirst-Server-Push-Service
{: #list-of-jndi-properties-for-mobilefirst-server-push-service }

| Eigenschaft | Optional oder obligatorisch | Beschreibung |
|----------|-----------------------|-------------|
| mfp.push.db.type | Optional | Datenbanktyp. Gültige Werte: DB, CLOUTDANT. Standardwert: DB |
| mfp.push.db.queue.connections | Optional | Anzahl Threads in dem Thread-Pool, der die Datenbankoperation ausführt. Standardwert: 3 |
| mfp.push.db.cloudant.url | Optional | URL des Cloudant-Kontos. Wenn diese Eigenschaft definiert ist, wird die Cloudant-Datenbank zu dieser URL geleitet. |
| mfp.push.db.cloudant.dbName | Optional | Name der Datenbank im Cloudant-Konto. Der Name muss mit einem Kleinbuchstaben beginnen und darf nur aus Kleinbuchstaben, Ziffern sowie den Zeichen _, $ und - bestehen. Standardwert: mfp\_push\_db |
| mfp.push.db.cloudant.username | Optional | Benutzername des Cloudant-Kontos, das zum  Speichern der Datenbank verwendet wird. Wenn diese Eigenschaft nicht definiert ist, wird eine relationale Datenbank verwendet. |
| mfp.push.db.cloudant.password | Optional | Kennwort des Cloudant-Kontos, das zum  Speichern der Datenbank verwendet wird. Diese Eigenschaft muss definiert sein, wenn mfp.db.cloudant.username definiert ist. |
| mfp.push.db.cloudant.doc.version | Optional | Cloudant-Dokumentversion |
| mfp.push.db.cloudant.socketTimeout | Optional | Zeitlimit für das Erkennen des Verlusts einer Cloudant-Netzverbindung in Millisekunden. Der Wert null bedeutet kein Zeitlimit. Ein negativer Wert bedeutet, dass der Standardwert verwendet wird (keine Außerkraftsetzung). Für den Standardwert siehe [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Optional	| Zeitlimit für das Herstellen einer Cloudant-Netzverbindung in Millisekunden. Der Wert null bedeutet kein Zeitlimit. Ein negativer Wert bedeutet, dass der Standardwert verwendet wird (keine Außerkraftsetzung). Für den Standardwert siehe [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Optional | Maximale Verbindungen für den Cloudant-Connector. Für den Standardwert siehe [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Optional | Boolescher Wert (true oder false), der angibt, ob für HTTPS-Verbindungen zur Cloudant-Datenbank die Validierung der SSL-Zertifikatkette und die Überprüfung des Hostnamens aktiviert sind. Standardwert: True |
| mfp.push.db.cloudant.ssl.configuration | Optional	| (Nur WAS Full Profile) Gibt für HTTPS-Verbindungen zur Cloudant-Datenbank den Namen einer SSL-Konfiguration in der WebSphere-Application-Server-Konfiguration an, die verwendet werden muss, wenn für den Host und Port keine Konfiguration angegeben ist. |
| mfp.push.db.cloudant.proxyHost | Optional	| Proxy-Host des Cloudant-Connectors. Für den Standardwert siehe [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Optional	| Proxy-Port des Cloudant-Connectors. Für den Standardwert siehe [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Optional	| Sicherheitserweiterungs-Plug-in |
| mfp.push.security.endpoint | Optional	| Endpunkt-URL für den Autorisierungsserver |
| mfp.push.security.user | Optional	| Benutzername für den Zugriff auf den Autorisierungsserver |
| mfp.push.security.password | Optional	| Kennwort für den Zugriff auf den Autorisierungsserver |
| mfp.push.services.ext.analytics | Optional | Erweiterungs-Plug-in für Analytics |
| mfp.push.analytics.endpoint | Optional | Endpunkt-URL für den Analyseserver |
| mfp.push.analytics.user | Optional | Benutzername für den Zugriff auf den Analyseserver |
| mfp.push.analytics.password | Optional | Kennwort für den Zugriff auf den Analyseserver |
| mfp.push.analytics.events.notificationDispatch | Optional	| Analyseereignis bei Bereitschaft zum Zustellen der Benachrichtigung. Standardwert: true |
| mfp.push.internalQueue.maxLength | Optional | Länge der Warteschlange mit den Benachrichtigungstasks vor der Zustellung. Standardwert: 200000 |
| mfp.push.gcm.proxy.enabled | Optional	| Zeigt an, ob über einen Proxy auf GCM zugegriffen werden muss. Standardwert: false |
| mfp.push.gcm.proxy.protocol | Optional | Kann http oder https sein |
| mfp.push.gcm.proxy.host | Optional | GCM-Proxy-Host. Ein negativer Wert bedeutet die Verwendung des Standardports. |
| mfp.push.gcm.proxy.port | Optional | GCM-Proxy-Port. Standardwert: -1 |
| mfp.push.gcm.proxy.user | Optional | Name des Proxybenutzers, wenn der Proxy eine Authentifizierung erfordert. Ein leerer Benutzername bedeutet, dass keine Authentifizierung stattfindet. |
| mfp.push.gcm.proxy.password | Optional | Proxykennwort, wenn der Proxy eine Authentifizierung erfordert |
| mfp.push.gcm.connections | Optional | Maximale Verbindungen für GCM-Push. Standardwert: 10 |
| mfp.push.apns.proxy.enabled | Optional | Zeigt an, ob über einen Proxy auf APNs zugegriffen werden muss. Standardwert: false |
| mfp.push.apns.proxy.type | Optional | APNS-Proxy-Typ |
| mfp.push.apns.proxy.host | Optional | APNS-Proxy-Host |
| mfp.push.apns.proxy.port | Optional | APNS-Proxy-Port. Standardwert: -1 |
| mfp.push.apns.proxy.user | Optional | Name des Proxybenutzers, wenn der Proxy eine Authentifizierung erfordert. Ein leerer Benutzername bedeutet, dass keine Authentifizierung stattfindet. |
| mfp.push.apns.proxy.password | Optional | Proxykennwort, wenn der Proxy eine Authentifizierung erfordert |
| mfp.push.apns.connections | Optional | Maximale Verbindungen für APNS-Push. Standardwert: 3 |
| mfp.push.apns.connectionIdleTimeout | Optional | Zeitlimit für inaktive APNS-Verbindungen. Standardwert: 0 |


{% comment %}
<!-- START NON-TRANSLATABLE -->
The following table contains an additional 11 analytics push events that were removed. See RTC defect 112448
| Property | Optional or mandatory | Description |
|----------|-----------------------|-------------|
| mfp.push.db.type | Optional | Database type. Possible values: DB, CLOUDANT. Default: DB |
| mfp.push.db.queue.connections | Optional | Number of threads in the thread pool that does the database operation. Default: 3 |
| mfp.push.db.cloudant.url | Optional | The Cloudant  account URL. When this property is defined, the Cloudant DB will be directed to this URL. |
| mfp.push.db.cloudant.dbName | Optional | The name of the database in the Cloudant account. It must start with a lowercase letter and consist only of lowercase letters, digits, and the characters _, $, and -. Default: mfp\_push\_db |
| mfp.push.db.cloudant.username | Optional | The user name of the Cloudant account, used to store the database. when this property is not defined, a relational database is used. |
| mfp.push.db.cloudant.password | Optional | The password of the Cloudant account, used to store the database. This property must be set when mfp.db.cloudant.username is set. |
| mfp.push.db.cloudant.doc.version | Optional | The Cloudant document version. |
| mfp.push.db.cloudant.socketTimeout | Optional	| A timeout for detecting the loss of a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.connectionTimeout | Optional	| A timeout for establishing a network connection for Cloudant, in milliseconds. A value of zero means an infinite timeout. A negative value means the default (no override). Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.maxConnections | Optional | The Cloudant connector's max connections. Default. See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.ssl.authentication | Optional | A Boolean value (true or false) that specifies whether the SSL certificate chain validation and host name verification are enabled for HTTPS connections to the Cloudant database. Default: True |
| mfp.push.db.cloudant.ssl.configuration | Optional	| (WAS Full Profile only) For HTTPS connections to the Cloudant database: The name of an SSL configuration in the WebSphere  Application Server configuration, to use when no configuration is specified for the host and port. |
| mfp.push.db.cloudant.proxyHost | Optional	| Cloudant connector's proxy host. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.db.cloudant.proxyPort | Optional	| Cloudant connector's proxy port. Default: See [https://github.com/cloudant/java-cloudant#advanced-configuration](https://github.com/cloudant/java-cloudant#advanced-configuration). |
| mfp.push.services.ext.security | Optional	| The security extension plugin. |
| mfp.push.security.endpoint | Optional	| The endpoint URL for the authorization server. |
| mfp.push.security.user | Optional	| The username to access the authorization server. |
| mfp.push.security.password | Optional	| The password to access the authorization server. |
| mfp.push.services.ext.analytics | Optional | The analytics extension plugin. |
| mfp.push.analytics.endpoint | Optional | The endpoint URL for the analytics server. |
| mfp.push.analytics.user | Optional | The username to access the analytics server. |
| mfp.push.analytics.password | Optional | The password to access the analytics server. |
| mfp.push.analytics.events.appCreate | Optional | The analytic event when the application is created. Default: true |
| mfp.push.analytics.events.appDelete | Optional | The analytic event when the application is deleted. Default: true |
| mfp.push.analytics.events.deviceRegister | Optional | The analytic event when the device is registered. Default: true |
| mfp.push.analytics.events.deviceUnregister | Optional	| The analytic event when the device is unregistered. Default: true |
| mfp.push.analytics.events.tagSubscribe | Optional | The analytic event when the device is subscribed to tag. Default: true |
| mfp.push.analytics.events.tagUnsubscribe | Optional | The analytic event when the device is unsubscribed from tag. Default: true |
| mfp.push.analytics.events.notificationSendSuccess | Optional | The analytic event when the notification is sent successfully. Default: true |
| mfp.push.analytics.events.notificationSendFailure | Optional | The analytic event when the notification is failed to send. Default: false |
| mfp.push.analytics.events.inactiveDevicePurge | Optional | The analytic event when the inactive devices are deleted. Default: true |
| mfp.push.analytics.events.msgReqAccepted | Optional | The analytic event when the notification is accepted for delivery. Default: true |
| mfp.push.analytics.events.msgDispatchFailed | Optional | The analytic event when the notification dispatch failed. Default: true |
| mfp.push.analytics.events.notificationDispatch | Optional	| The analytic event when the notification is about to be dispatched. Default: true |
| mfp.push.internalQueue.maxLength | Optional | The length of the queue which holds the notification tasks before dispatch. Default: 200000 |
| mfp.push.gcm.proxy.enabled | Optional	| Shows whether Google GCM must be accessed through a proxy. Default: false |
| mfp.push.gcm.proxy.protocol | Optional | Can be either http or https. |
| mfp.push.gcm.proxy.host | Optional | GCM proxy host. Negative value means default port. |
| mfp.push.gcm.proxy.port | Optional | GCM proxy port. Default: -1 |
| mfp.push.gcm.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.gcm.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.gcm.connections | Optional | Push GCM max connections. Default : 10 |
| mfp.push.apns.proxy.enabled | Optional | Shows whether APNs must be accessed through a proxy. Default: false |
| mfp.push.apns.proxy.type | Optional | APNs proxy type. |
| mfp.push.apns.proxy.host | Optional | APNs proxy host. |
| mfp.push.apns.proxy.port | Optional | APNs proxy port. Default: -1 |
| mfp.push.apns.proxy.user | Optional | Proxy user name, if the proxy requires authentication. Empty user name means no authentication. |
| mfp.push.apns.proxy.password | Optional | Proxy password, if the proxy requires authentication. |
| mfp.push.apns.connections | Optional | Push APNs max connections. Default : 3 |
| mfp.push.apns.connectionIdleTimeout | Optional | APNs Idle Connection Timeout. Default : 0 |
<!-- END NON-TRANSLATABLE -->
{% endcomment %}

## Datenquellen konfigurieren
{: #configuring-data-sources }
Hier können Sie sich über Details der Datenquellenkonfiguration für die unterstützten Datenbanken informieren. 

* [Größe des DB2-Transaktionsprotokolls steuern](#managing-the-db2-transaction-log-size)
* [Nahtloses Failover mit DB2 HADR für MobileFirst-Server- und Application-Center-Datenquellen konfigurieren](#configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources)
* [Behandlung von veralteten Verbindungen](#handling-stale-connections)
* [Veraltete Daten nach dem Erstellen oder Löschen von Apps in der {{ site.data.keys.mf_console }}](#stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console)

### Größe des DB2-Transaktionsprotokolls steuern
{: #managing-the-db2-transaction-log-size }
Wenn Sie eine Anwendung mit einer Größe von
mindestens 40 MB über die IBM {{ site.data.keys.mf_console }} implementieren, könnten Sie
einen Fehler transaction log full empfangen.

Die folgende Systemausgabe ist ein Beispiel für den Fehlercode transaction
log full.

```bash
DB2 SQL Error: SQLCODE=-964, SQLSTATE=57011
```

Der Inhalt jeder Anwendung ist in der
MobileFirst-Verwaltungsdatenbank gespeichert.

Die Anzahl der aktiven Protokolldateien wird von den Datenbankkonfigurationsparametern **LOGPRIMARY** und **LOGSECOND** definiert und die Größe der Protokolldateien vom Datenbankkonfigurationsparameter **LOGFILSIZ**. Eine Transaktion darf keinen größeren Protokollspeicherbereich als **LOGFILSZ** * (**LOGPRIMARY** + **LOGSECOND**) * 4096 KB belegen.

Der Befehl `DB2 GET DATABASE CONFIGURATION` liefert unter anderem Informationen zur Größe der Protokolldateien
und zur Anzahl der primären und sekundären Protokolldateien.

Möglicherweise müssen Sie den
DB2-Protokollspeicherbereich ausgehend von der größten implementierten MobileFirst-Anwendung vergrößern.

Erhöhen Sie mit dem Befehl `DB2 update db cfg` den Wert des Parameters
**LOGSECOND**.Speicherbereich wird nicht bei Aktivierung der Datenbank, sondern bei Bedarf zugeordnet.

### Nahtloses Failover mit DB2 HADR für MobileFirst-Server- und Application-Center-Datenquellen konfigurieren
{: #configuring-db2-hadr-seamless-failover-for-mobilefirst-server-and-application-center-data-sources }
Sie müssen das Feature für nahtloses Failover in WebSphere Application Server
Liberty Profile und WebSphere Application
Server aktivieren. Mit diesem Feature können Sie eine Ausnahme verwalten, wenn eine Datenbank ausfällt und vom
DB2-JDBC-Treiber umgeleitet wird.

> **Hinweis:** Das Failover mit DB2 HADR wird nicht für Apache Tomcat unterstützt. 

Wenn Sie DB2 HADR verwenden und der
DB2-JDBC-Treiber nach Feststellung eines Datenbankausfalls eine Clientumleitung durchführt,
löst der Treiber bei dem ersten Versuch, eine vorhandene Verbindung zu nutzen, die Ausnahme
**com.ibm.db2.jcc.am.ClientRerouteException** mit **ERRORCODE=-4498** und **SQLSTATE=08506** aus. Bevor die Anwendung diese Ausnahme empfängt, ordnet WebSphere Application Server
sie der Ausnahme **com.ibm.websphere.ce.cm.StaleConnectionException** zu.

Die Anwendung müsste also die Ausnahme abfangen und die Transaktion erneut ausführen. Die {{ site.data.keys.product_adj }}-Laufzeitumgebung und die
Application-Center-Laufzeitumgebung können die Ausnahme nicht verwalten, greifen jedoch auf ein Feature mit der Bezeichnung "nahtloses Failover" zurück. Zum Aktivieren
dieses Features müssen Sie die JDBC-Eigenschaft
**enableSeamlessFailover** auf "1" setzen.

#### Konfiguration von WebSphere Application Server Liberty Profile
{: #websphere-application-server-liberty-profile-configuration }
Sie müssen die Datei **server.xml** bearbeiten und die Eigenschaft
**enableSeamlessFailover** zum Element
**properties.db2.jcc** der {{ site.data.keys.product_adj }}- und Application-Center-Datenquellen hinzufügen. Beispiel: 

```xml
<dataSource jndiName="jdbc/WorklightAdminDS" transactional="false">
  <jdbcDriver libraryRef="DB2Lib"/>
  <properties.db2.jcc databaseName="WLADMIN"  currentSchema="WLADMSC"
                      serverName="db2server" portNumber="50000"
                      enableSeamlessFailover= "1"
                      user="worklight" password="worklight"/>
</dataSource>
```

#### Konfiguration von WebSphere Application Server
{: #websphere-application-server-configuration }
Führen Sie in der Administrationskonsole von WebSphere Application Server für
jede {{ site.data.keys.product_adj }}- und
Application-Center-Datenquelle die folgenden Schritte aus:

1. Navigieren Sie zu **Ressourcen → JDBC → Datenquellen → Datenquellenname**.
2. Wählen Sie **Neu** aus und fügen Sie die folgende angepasste Eigenschaft hinzu bzw. aktualisieren Sie den Wert, wenn es die Eigenschaft bereits gibt: `enableSeamlessFailover : 1`
3. Klicken Sie auf **Anwenden**.
4. Speichern Sie Ihre Konfiguration.

Weitere Informationen zum Konfigurieren einer Verbindung zu einer DB2-HADR-Datenbank finden Sie unter
https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/tdat_db2_hadr.html?cp=SSAW57_8.5.5%2F3-3-6-3-3-0-7-3&lang=de">Verbindung für eine HADR-aktivierte DB2-Datenbank konfigurieren.

### Behandlung von veralteten Verbindungen
{: #handling-stale-connections }
Konfigurieren Sie Ihren Anwendungsserver so, dass Probleme mit der Überschreibung von Datenbankzeitlimits
vermieden werden. 

Der Datenbankverbindungscode des Java-Anwendungsserverprofils
generiert eine Ausnahme **StaleConnectionException**, wenn ein
JDBC-Treiber einen nicht behebbaren Fehler für eine Verbindungsanforderung oder Operation zurückgibt. **StaleConnectionException** wird ausgelöst, wenn
der Datenbankanbieter eine Ausnahme
absetzt, um anzuzeigen, dass eine zurzeit im Verbindungspool enthaltene Verbindung nicht mehr gültig ist. Zu dieser Ausnahme kann es aus vielen Gründen kommen. Am häufigsten
tritt die Ausnahme
**StaleConnectionException** ein, wenn beim Abrufen von Verbindungen aus dem Datenbankverbindungspool festgestellt wird, dass das Zeitlimit für eine
Verbindung überschritten ist oder dass eine länger ungenutzte Verbindung gelöscht wurde. 

Sie können Ihren Anwendungsserver so konfigurieren, dass diese Ausnahme vermieden
wird. 

#### Apache-Tomcat-Konfiguration
{: #apache-tomcat-configuration }
**MySQL**  
Die MySQL-Datenbank schließt ihre Verbindungen, wenn für eine Verbindung ein bestimmter Zeitraum ohne Aktivität abgelaufen ist. Dieses Zeitlimit wird mit der Systemvariablen **wait_timeout** definiert.
Der Standardwert ist 28000 Sekunden (8 Stunden). 

Wenn eine Anwendung versucht, eine Verbindung zur Datenbank herzustellen,
nachdem MySQL die Verbindung geschlossen hat, wird
die folgende Ausnahme generiert: 

```xml
com.mysql.jdbc.exceptions.jdbc4.MySQLNonTransientConnectionException: No operations allowed after statement closed.
```

Bearbeiten Sie die Dateien **server.xml** und **context.xml** und fügen Sie für jedes `<Resource>`-Element die folgenden Eigenschaften hinzu:

* **testOnBorrow="true"**
* **validationQuery="select 1"**

Beispiel: 

```xml
<Resource name="jdbc/AppCenterDS"
  type="javax.sql.DataSource"
  driverClassName="com.mysql.jdbc.Driver"
  ...
  testOnBorrow="true"
  validationQuery="select 1"
/>
```

#### Konfiguration von WebSphere Application Server Liberty Profile
{: #websphere-application-server-liberty-profile-configuration-1 }
Bearbeiten Sie die Datei **server.xml** und fügen Sie für jedes `<dataSource>`-Element (Laufzeit- und Application-Center-Datenbank) ein Element `<connectionManager>` mit der Eigenschaft agedTimeout hinzu:

```xml
<connectionManager agedTimeout="Zeitlimitwert"/>
```

Der Zeitlimitwert richtet sich im Wesentlichen nach der Anzahl gleichzeitig geöffneter Verbindungen, aber auch nach der
Mindestanzahl und der maximalen Anzahl von Verbindungen im Pool. Sie müssen die verschiedenen
**connectionManager**-Attribute also optimieren und die am besten geeigneten Werte finden. Weitere Informationen
zum Element **connectionManager** finden Sie unter
[Liberty: Configuration elements in the **server.xml** file](https://www.ibm.com/support/knowledgecenter/SSD28V_8.5.5/com.ibm.websphere.wlp.core.doc/autodita/rwlp_metatype_core.html).

> **Hinweis:** MySQL
in Kombination mit WebSphere Application Server Liberty
Profile oder WebSphere Application Server Full Profile ist keine unterstützte Konfiguration. Weitere Informationen finden Sie unter [WebSphere Application
Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Sie können IBM DB2 oder
eine andere von WebSphere Application Server unterstützte Datenbank
verwenden, um die Vorteile
einer Konfiguration zu nutzen, die vollständig vom IBM Support unterstützt wird.

### Veraltete Daten nach dem Erstellen oder Löschen von Apps in der {{ site.data.keys.mf_console }}
{: #stale-data-after-creating-or-deleting-apps-from-mobilefirst-operations-console }
Wenn Sie in einem Tomcat 8 Application Server eine MySQL-Datenbank verwenden,
wird für einige Serviceaufrufe der {{ site.data.keys.mf_console }} ein Fehler
404 zurückgegeben. 

Wenn Sie in einem Tomcat 8 Application Server mit einer MySQL-Datenbank arbeiten und in
der {{ site.data.keys.mf_console }} eine App löschen oder eine neue App hinzufügen, sehen Sie nach mehrfacher Aktualisierung der
Konsolenanzeige möglicherweise veraltete Daten. Benutzer könnten beispielsweise eine bereits gelöschte App in der Liste sehen. 

Sie können dieses Problem umgehen, indem Sie die Isolationsstufe
in der Datenquelle oder im Datenbankmanagementsystem auf **READ_COMMITTED** setzen. 

Die Bedeutung von **READ_COMMITTED** ist in der [MySQL-Dokumentation](http://www.ibm.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html?view=kc)
unter [http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html](http://dev.mysql.com/doc/refman/5.7/en/innodb-transaction-isolation-levels.html) erläutert.

* Wenn Sie die Isolationsstufe in der Datenquelle auf **READ_COMMITTED** setzen möchten,
müssen Sie die Tomcat-Konfigurationsdatei **server.xml** modifizieren.
Fügen Sie im Abschnitt **<Resource name="jdbc/mfpAdminDS" .../>** das Attribut **defaultTransactionIsolation="READ_COMMITTED"** hinzu. 
* Wenn Sie die Isolationsstufe im Datenbankmanagementsystem global auf **READ_COMMITTED** setzen möchten,
lesen Sie sich die Seite [SET TRANSACTION Syntax](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html) in der
MySQL-Dokumentation unter [http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html](http://dev.mysql.com/doc/refman/5.7/en/set-transaction.html) durch.

#### Konfiguration von WebSphere Application Server Full Profile
{: #websphere-application-server-full-profile-configuration }
**DB2 oder Oracle**  
Wenn Sie Probleme mit veralteten Verbindungen auf ein Minimum reduzieren möchten, überprüfen Sie in der
Administrationskonsole von WebSphere Application Server die Verbindungspoolkonfiguration für jede
Datenquelle. 

1. Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an. 
2. Wählen Sie **Ressourcen → JDBC-Provider → Datenbank-JDBC-Provider → Datenquellen → Ihre_Datenquelle → Eigenschaften des Verbindungspools** aus.
3. Setzen Sie **Mindestanzahl von Verbindungen** auf den Wert 0.
4. Setzen Sie das **Bereinigungsintervall** auf einen Wert, der kleiner als der Wert
für das **Zeitlimit für nicht verwendete Verbindungen** ist. 
5. Stellen Sie sicher, dass die Eigenschaft **Löschrichtlinie** auf
(die Standardeinstellung) **Gesamter Pool** gesetzt ist. 

Weitere Informationen finden Sie unter
[Connection pool settings](https://www.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/udat_conpoolset.html).

**MySQL**  

1. Melden Sie sich bei der Administrationskonsole von WebSphere Application Server an. 
2. Wählen Sie **Ressourcen → JDBC → Datenquellen** aus.
3. Gehen Sie für jede MySQL-Datenquelle wie folgt vor:
    * Klicken Sie auf die Datenquelle.
    * Wählen Sie unter
**Weitere Eigenschaften** die Option **Eigenschaften des Verbindungspools** aus.
    * Ändern Sie den Wert der Eigenschaft
**Zeitlimit für veraltete Verbindungen**. Der Wert muss kleiner sein als der Wert für die
MySQL-Systemvariable **wait_timeout**, damit die Verbindungen bereinigt werden,
bevor sie von MySQL geschlossen werden.

    * Klicken Sie auf **OK**. 

> **Hinweis:** MySQL
in Kombination mit WebSphere Application Server Liberty
Profile oder WebSphere Application Server Full Profile ist keine unterstützte Konfiguration. Weitere Informationen finden Sie unter [WebSphere Application
Server Support Statement](http://www.ibm.com/support/docview.wss?uid=swg27004311). Sie können IBM DB2 oder
eine andere von WebSphere Application Server unterstützte Datenbank
verwenden, um die Vorteile
einer Konfiguration zu nutzen, die vollständig vom IBM Support unterstützt wird.

## Protokollierungs- und Überwachungsmechanismen konfigurieren
{: #configuring-logging-and-monitoring-mechanisms }
Die {{ site.data.keys.product }} schreibt Fehler, Warnungen und Informationsnachrichten in eine
Protokolldatei. Der zugrunde liegende Protokollierungsmechanismus ist je nach Anwendungsserver verschieden.

### {{ site.data.keys.mf_server }}
{: #mobilefirst-server }
Die {{ site.data.keys.product }} (oder kurz {{ site.data.keys.mf_server }}) verwendet das Standardpaket java.util.logging. Die gesamte {{ site.data.keys.product_adj }}-Protokollierung
erfolgt standardmäßig in den Protokolldateien des Anwendungsservers. Sie können die Protokollierung von {{ site.data.keys.mf_server }} mit
den in jedem Anwendungsserver verfügbaren Standardtools steuern. Wenn Sie beispielsweise in WebSphere Application Server Liberty die Traceprotokollierung aktivieren möchten, fügen Sie
zur Datei
server.xml ein Element "trace" hinzu. Wenn Sie die Traceprotokollierung in
WebSphere Application Server
aktivieren möchten,
aktivieren Sie in der Protokollierungsanzeige der Konsole
den Trace für {{ site.data.keys.product_adj }}-Protokolle. 

Die Namen aller
{{ site.data.keys.product_adj }}-Protokolle
beginnen mit **com.ibm.mfp**.   
Die Namen der
Application-Center-Protokolle beginnen mit **com.ibm.puremeap**. 

Weitere Informationen zu den Protokollierungsmodellen der einzelnen Anwendungsserver und zur Position der Protokolldateien finden Sie in der
Dokumentation zum jeweiligen Anwendungsserver. Vergleichen Sie dazu die Angaben in der folgenden Tabelle.

| Anwendungsserver | Position der Dokumentation |
| -------------------|---------------------------|
| Apache Tomcat	     | [http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)](http://tomcat.apache.org/tomcat-7.0-doc/logging.html#Using_java.util.logging_(default)) |
| WebSphere Application Server Version 8.5 Full Profile | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.base.doc/ae/ttrb_trcover.html) |
| WebSphere Application Server Version 8.5 Liberty Profile | 	[http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0](http://ibm.biz/knowctr#SSEQTP_8.5.5/com.ibm.websphere.wlp.doc/ae/rwlp_logging.html?cp=SSEQTP_8.5.5%2F1-16-0-0) |

### Zuordnung der Protokollstufen
{: #log-level-mappings }
{{ site.data.keys.mf_server }} verwendet
die API **java.util.logging**. Die Zuordnung der Protokollierungsstufen sieht wie folgt aus:

* WL.Logger.debug: FINE
* WL.Logger.info: INFO
* WL.Logger.warn: WARNING
* WL.Logger.error: SEVERE

### Überwachungstools für Protokolle
{: #log-monitoring-tools }
Für Apache Tomcat
können Sie [IBM Operations Analytics - Log Analysis](http://www.ibm.com/software/products/en/ibm-operations-analytics---log-analysis) oder andere Überwachungstools für Protokolldateien nach Industrienorm verwenden,
um Protokolle zu überwachen und Fehler und Warnungen hervorzuheben. 

Verwenden Sie für WebSphere Application Server
die Protokollanzeigefunktionen, die um IBM Knowledge Center beschrieben sind. Die URLs sind auf dieser Seite in der Tabelle im MobileFirst-Server-Abschnitt
aufgelistet. 

### Back-End-Konnektivität
{: #back-end-connectivity }
Wenn Sie den Trace für die Überwachung der Back-End-Konnektivität aktivieren möchten, lesen Sie
die Dokumentation zu Ihrer Anwendungsserverplattform auf dieser Seite in der Tabelle
im Abschnitt {{ site.data.keys.mf_server }}. Verwenden Sie das Paket
**com.ibm.mfp.server.js.adapter** und setzen Sie die Protokollstufe
auf **FINEST**.

### Prüfprotokoll für Verwaltungsoperationen
{: #audit-log-for-administration-operations }
Die {{ site.data.keys.mf_console }} speichert
ein Prüfprotokoll für Anmeldung, Abmeldung und alle Verwaltungsoperationen, z. B. die Implementierung von Apps oder Adaptern oder das Sperren von Apps. Sie können das Prüfprotokoll inaktivieren, indem Sie
die JNDI-Eigenschaft **mfp.admin.audit** der Webanwendung für den
{{ site.data.keys.product_adj }}-Verwaltungsservice
(**mfp-admin-service.war**) auf "false" setzen. 

Wenn das Prüfprotokoll aktiviert ist, können Sie es von der
{{ site.data.keys.mf_console }} herunterladen. Klicken Sie dazu
in der Fußzeile der Seite auf den Link **Prüfprotokoll**. 

### Probleme bei der Anmeldung und der Authentifizierung
{: #login-and-authentication-issues }
Aktivieren Sie zur Diagnose von Anmelde- und Authentifizierungsproblemen
das Paket
**com.ibm.mfp.server.security** für Traces und setzen Sie die Protokollstufe auf
**FINEST**.

## Mehrere Laufzeiten konfigurieren
{: #configuring-multiple-runtimes }
Sie können {{ site.data.keys.mf_server }} mit mehreren Laufzeiten konfigurieren und in der {{ site.data.keys.mf_console }} eine visuelle Abgrenzung der Anwendungstypen erstellen. 

> **Hinweis:** Eine Mobile-Foundation-Server-Instanz, die mit dem Mobile-Foundation-Bluemix-Service erstellt wurde, bietet keine Unterstützung für mehrere Laufzeiten. Im Bluemix-Service müssen Sie stattdessen mehrere Serviceinstanzen erstellen.

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to-1 }
* [Mehrere Laufzeiten in WebSphere Liberty Profile konfigurieren](#configuring-multiple-runtimes-in-websphere-liberty-profile)
* [In verschiedenen Laufzeiten Anwendungen registrieren und Adapter implementieren](#registering-applications-and-deploying-adapters-to-different-runtimes)
* [Laufzeitkonfigurationen exportieren und importieren](#exporting-and-importing-runtime-configurations)

### Mehrere Laufzeiten in WebSphere Liberty Profile konfigurieren
{: #configuring-multiple-runtimes-in-websphere-liberty-profile }

1. Öffnen Sie die Datei **server.xml** des Anwendungsservers. Normalerweise befindet sich die Datei
im Ordner **[Anwendungsserver]/usr/servers/Servername/**. Wenn Sie beispielsweise das
{{ site.data.keys.mf_dev_kit }} verwenden, finden Sie die Datei unter **[Installationsordner]/mfp-server/usrs/servers/mfp/server.xml**.

2. Fügen Sie ein zweites Element `application` hinzu: 

   ```xml
   <application id="second-runtime" name="second-runtime" location="mfp-server.war" type="war">
        <classloader delegation="parentLast">
            </classloader>
   </application>
   ```

3. Fügen Sie eine zweite Gruppe von JNDI-Einträgen hinzu: 

   ```xml
   <jndiEntry jndiName="second-runtime/mfp.analytics.url" value='"http://localhost:9080/analytics-service/rest"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.console.url" value='"http://localhost:9080/analytics/console"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.username" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.analytics.password" value='"admin"'/>
   <jndiEntry jndiName="second-runtime/mfp.authorization.server" value='"embedded"'/>
   ```

4. Fügen Sie ein zweites Element `dataSource` hinzu: 

   ```xml
   <dataSource jndiName="second-runtime/jdbc/mfpDS" transactional="false">
        <jdbcDriver libraryRef="DerbyLib"/>
        <properties.derby.embedded databaseName="${wlp.install.dir}/databases/second-runtime" user='"MFPDATA"'/>
   </dataSource>
   ```

    > **Hinweis:**
    >
    > * Stellen Sie sicher, dass `dataSource` auf ein anderes Datenbankschema zeigt. 
    > * Vergewissern Sie sich, dass für die neue Laufzeit eine [andere Datenbankinstanz](../databases) erstellt wurde. 
    > * Fügen Sie in der Entwicklungsumgebung zum untergeordneten Element `properties.derby.embedded` den Eintrag `createDatabase="create"` hinzu. 

5. Starten Sie den Anwendungsserver neu.

### In verschiedenen Laufzeiten Anwendungen registrieren und Adapter implementieren
{: #registering-applications-and-deploying-adapters-to-different-runtimes }
Wenn ein {{ site.data.keys.mf_server }} mit mehreren Laufzeiten konfiguriert ist, verläuft die Registrierung von Anwendungen und die Implementierung von Adaptern etwas anders. 

* [Registrierung und Implementierung über die {{ site.data.keys.mf_console }}](#registering-and-deploying-from-the-mobilefirst-operations-console)
* [Registrierung und Implementierung über die Befehlszeile](#registering-and-deploying-from-the-command-line)

#### Registrierung und Implementierung über die {{ site.data.keys.mf_console }}
{: #registering-and-deploying-from-the-mobilefirst-operations-console }
Wenn Sie diese Aktionen in der {{ site.data.keys.mf_console }} ausführen, müssen Sie jetzt die Ziellaufzeit für die Registrierung oder Implementierung auswählen. 

<img class="gifplayer" alt="Mehrere Laufzeiten in der {{ site.data.keys.mf_console }}" src="register-and-deploy-to-multiple-runtimes.png"/>

#### Registrierung und Implementierung über die Befehlszeile
{: #registering-and-deploying-from-the-command-line }
Wenn Sie diese Aktionen mit dem Befehlszeilentool (**mfpdev**) ausführen, müssen Sie jetzt den Namen der Ziellaufzeit für die Registrierung oder Implementierung hinzufügen. 

Registrierung einer Anwendung: `mfpdev app register <Servername> <Laufzeitname>`.  

```bash
mfpdev app register local second-runtime
```

Implementierung eines Adapters: `mfpdev adapter deploy <Servername> <Laufzeitname>`.  

```bash
mfpdev adapter deploy local second-runtime
```

* In der {{ site.data.keys.mf_cli }} ist **local** der Name der Standardserverdefinition. Ersetzen Sie *local* durch den Namen einer Serverdefinition, die als Ziel für die Registrierung oder Implementierung verwendet werden soll. 
* **Laufzeitname** ist der Name der Ziellaufzeit für die Registrierung oder Implementierung. 

> Weitere Informationen können Sie mit den folgenden help-Befehlen der CLI abrufen: 
>
> * `mfpdev help server add`
> * `mfpdev help app register`
> * `mfpdev help adapter deploy`

## Laufzeitkonfigurationen exportieren und importieren
{: #exporting-and-importing-runtime-configurations }
Mit den REST-APIs des MobileFirst-Server-**Verwaltungsservice** können Sie eine Laufzeitkonfiguration exportieren und in einen anderen
{{ site.data.keys.mf_server }} importieren. 

Sie können beispielsweise eine Laufzeitkonfiguration in einer Entwicklungsumgebung definieren, dann die Konfiguration exportieren und die Konfiguration schließlich
für ein Schnell-Setup in eine Testumgebung importieren.
In der Testumgebung können Sie die Definition der Konfiguration an die Umgebungsanforderungen anpassen. 

> In den [API-Referenzinformationen](http://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/c_restapi_oview.html) erfahren Sie, welche REST-APIs zur Verfügung stehen.

## Lizenzüberwachung konfigurieren
{: #configuring-license-tracking }
Die Lizenzüberwachung ist standardmäßig aktiviert. In den folgenden Abschnitten erfahren Sie, wie Sie die Lizenzüberwachung
konfigurieren können. Weitere Informationen zur Lizenzüberwachung
finden Sie unter
[Lizenzüberwachung](../../../administering-apps/license-tracking).

* [Lizenzüberwachung für Clientgeräte und adressierbare Geräte konfigurieren](#configuring-license-tracking-for-client-device-and-addressable-device)
* [Protokolldateien von IBM License Metric Tool konfigurieren](#configuring-ibm-license-metric-tool-log-files)

### Lizenzüberwachung für Clientgeräte und adressierbare Geräte konfigurieren
{: #configuring-license-tracking-for-client-device-and-addressable-device }
Die Lizenzüberwachung für Clientgeräte und adressierbare Geräte ist standardmäßig aktiviert. Die Lizenzberichte sind in der
{{ site.data.keys.mf_console }} verfügbar.
Sie können die folgenden JNDI-Eigenschaften angeben, um die Standardeinstellungen für die Lizenzüberwachung zu ändern. 

> **Hinweis:** Wenn in Ihrem Vertrag die Tokenlizenzierung vereinbart ist, lesen Sie auch die Informationen unter [Installation und Konfiguration für Tokenlizenzierung](../token-licensing). Sie können die folgenden JNDI-Eigenschaften angeben, um die Standardeinstellungen für die Lizenzüberwachung zu ändern. 

**mfp.device.decommission.when**  
Anzahl von Tagen der Inaktivität, nach denen ein Gerät mit der Aufgabe für Gerätestilllegung stillgelegt wird. Für Lizenzberichte werden stillgelegte Geräte nicht als aktive
Geräte gezählt. Der Standardwert für diese Eigenschaft liegt bei 90 Tagen. Legen Sie keinen Wert unter 30 Tagen fest, wenn Ihre Software auf der Basis von
Clientgeräten oder
adressierbaren Geräten lizenziert wird. Andernfalls sind die Lizenzberichte unter Umständen nicht ausreichend, um die Einhaltung der Lizenzvereinbarung
nachzuweisen. 

**mfp.device.archiveDecommissioned.when**  
Ein Wert, der in Tagen definiert, wann stillgelegte Geräte bei Ausführung der Stilllegungsaufgabe in eine
Archivdatei aufgenommen werden. Die archivierten Geräte werden
in eine Datei im IBM MobileFirst-Server-Verzeichnis **home\devices_archive** geschrieben.
Der Name der Datei
enthält die Zeitmarke für den Erstellungszeitpunkt der Archivdatei. Der Standardwert liegt bei 90 Tagen.

**mfp.device.decommissionProcessingInterval**  
Definiert, wie häufig eine Stilllegung durchgeführt wird (Intervall in Sekunden). Standardwert: 86400 (ein Tag). Bei der
Stilllegung werden folgende Aktionen ausgeführt:

* Inaktive Geräte werden ausgehend von der Einstellung der Eigenschaft **mfp.device.decommission.when** stillgelegt.
* Ältere stillgelegte Geräte können ausgehend von der Einstellung der Eigenschaft **mfp.device.archiveDecommissioned.when** archiviert werden.
* Der Lizenzüberwachungsbericht wird generiert.

**mfp.licenseTracking.enabled**  
Mit dem Wert dieser Eigenschaft wird die Lizenzüberwachung in
der {{ site.data.keys.product }} aktiviert oder inaktiviert. Die Lizenzüberwachung
ist standardmäßig
aktiviert. Aus Leistungsgründen können Sie dieses Flag inaktivieren, wenn
die {{ site.data.keys.product }}
weder auf der Basis von Clientgeräten noch auf der Basis von adressierbaren
Geräten lizienziert wird.
Bei inaktivierter Geräteüberwachung sind
auch die Lizenzberichte inaktiviert und es werden keine Lizenzmetriken generiert. In dem Fall weden nur
Datensätze von IBM License Metric Tool für die Anwendungszählung generiert. 

Weitere Informationen zur Angabe von JNDI-Eigenschaften
finden Sie in der [Liste der JNDI-Eigenschaften für die {{ site.data.keys.product_adj }}-Laufzeit](#list-of-jndi-properties-for-mobilefirst-runtime).

### Protokolldateien von IBM License Metric Tool konfigurieren
{: #configuring-ibm-license-metric-tool-log-files }
Die {{ site.data.keys.product }}
generiert SLMT-Dateien (IBM Software License Metric Tag). Versionen des IBM License Metric Tool, die
SLMT unterstützen, können Berichte zum Lizenzbedarf generieren. Lesen Sie die folgenden Informationen, damit Sie wissen, wie die
Position und die maximale Größe der generierten Dateien konfiguriert werden. 

SLMT-Dateien (IBM Software License Metric Tag) sind standardmäßig in folgenden Verzeichnissen
enthalten:

* Windows: **%ProgramFiles%\ibm\common\slm**
* UNIX und UNIX-ähnliche Betriebssysteme: **/var/ibm/common/slm**

Wenn die Verzeichnisse schreibgeschützt sind, werden die
Dateien im Protokollverzeichnis des Anwendungsservers erstellt,
in dem die {{ site.data.keys.product_adj }}-Laufzeitumgebung ausgeführt wird.

Sie können die Position und die Verwaltung der Dateien mit folgenden Eigenschaften konfigurieren:             

* **license.metric.logger.output.dir**: Position der SLMT-Dateien
* **license.metric.logger.file.size**: Maximale Größe einer SLMT-Datei, bei deren Erreichung eine Rotation erfolgt. Die Standardgröße liegt bei 1 MB.
* **license.metric.logger.file.number**: Maximale Anzahl der SLMT-Archivdateien bei aktiver Rotation. Die Standardanzahl ist 10.

Wenn Sie die Standardwerte
ändern möchten, müssen Sie eine Java-Eigenschaftendatei im Format **Schlüssel=Wert** erstellen und mit der JVM-Eigenschaft **license_metric_logger_configuration** den Pfad zu den Eigenschaften angeben.

Weitere Informationen zu
Berichten des IBM License Metric Tool
finden Sie unter [Integration des
IBM License Metric Tool](../../../administering-apps/license-tracking/#integration-with-ibm-license-metric-tool).

## SSL-Konfiguration von WebSphere Application Server und HTTP-Adapter
{: #websphere-application-server-ssl-configuration-and-http-adapters }
Sie können mit einer Einstellung dafür sorgen, dass HTTP-Adapter von der
WebSphere-SSL-Konfiguration profitieren. 

Standardmäßig machen HTTP-Adapter keinen Gebrauch von
WebSphere-SSL mit der Verkettung des JRE-Truststores
und des IBM MobileFirst-Platform-Server-Keystores (siehe Beschreibung unter
[Keystore von {{ site.data.keys.mf_server }} konfigurieren](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore)).
Lesen Sie auch die Informationen unter
[SSL zwischen Adaptern und Back-End-Servern mit selbst signierten Zertifikaten konfigurieren](../../../administering-apps/deployment/#configuring-ssl-between-adapters-and-back-end-servers-by-using-self-signed-certificates).

Wenn HTTP-Adapter in der Lage sein sollen, die
WebSphere-SSL-Konfiguration zu nutzen, müssen Sie die JNDI-Eigenschaft
**ssl.websphere.config** auf true setzen.
Diese Einstellung hat die folgenden Auswirkungen in der hier genannten Reihenfolge: 

1. In WebSphere ausgeführte Adapter verwenden
den WebSphere-Keystore und nicht den Keystore von
{{ site.data.keys.mf_server }}. 
2. Wenn die Eigenschaft **ssl.websphere.alias** gesetzt ist, verwendet der Adapter die
SSL-Konfiguration, die dem mit dieser Eigenschaft angegebenen Alias zugeordnet ist. 
