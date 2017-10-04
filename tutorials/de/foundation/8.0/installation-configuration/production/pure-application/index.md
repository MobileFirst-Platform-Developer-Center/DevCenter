---
layout: tutorial
title: MobileFirst Server in IBM PureApplication System implementieren
breadcrumb_title: Pure Application System installieren
weight: 10
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} bietet die Möglichkeit,
{{ site.data.keys.mf_server }} und
{{ site.data.keys.product_adj }}-Anwendungen in
IBM PureApplication System
und
IBM PureApplication Service
on SoftLayer zu implementieren und zu verwalten.

Die Verwendung der {{ site.data.keys.product }} in
Kombination mit IBM
PureApplication System
und
IBM PureApplication Service on SoftLayer
bietet Entwicklern und Administratoren eine einfache und intuitive Umgebung, in der sie mobile Anwendungen entwickeln, testen und in der Cloud implementieren können.
Diese Version von {{ site.data.keys.mf_system_pattern_full }}
bietet MobileFirst-Foundation-Laufzeitunterstützung
und -Artefaktunterstützung für die PureApplication-Technologien für Muster für virtuelle Systeme
der neuesten Versionen von
IBM
PureApplication System
und IBM
PureApplication Service on SoftLayer. In früheren Versionen von IBM
PureApplication System wurden klassische Muster für virtuelle Systeme unterstützt. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [{{ site.data.keys.mf_system_pattern }} installieren](#installing-mobilefirst-system-pattern)
* [Voraussetzungen für die Tokenlizenzierung für {{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern)
* [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
* [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server)
* [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
* [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server)
* [{{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)
* [{{ site.data.keys.mf_app_center }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-application-center-on-a-single-node-websphere-application-server-liberty-profile-server)
* [{{ site.data.keys.mf_app_center }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-application-center-on-a-single-node-websphere-application-server-full-profile-server)
* [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einem externen LDAP-Repository konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)
* [Externe Datenbank mit {{ site.data.keys.mf_system_pattern }} konfigurieren](#configuring-an-external-database-with-a-mobilefirst-system-pattern)
* [{{ site.data.keys.mf_analytics }} implementieren und konfigurieren](#deploying-and-configuring-mobilefirst-analytics)
* [Vordefinierte Schablonen für {{ site.data.keys.mf_system_pattern }}](#predefined-templates-for-mobilefirst-system-pattern)
* [Scriptpakete für {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server)
* [Upgrade für {{ site.data.keys.mf_system_pattern }}](#upgrading-mobilefirst-system-pattern)

### Wichtige Vorteile
{: #key-benefits }
{{ site.data.keys.mf_system_pattern }} bietet die folgenden Vorteile:

* Mit vordefinierten Schablonen können Sie auf einfachem Wege Muster für die typischen
MobileFirst-Server-Implementierungstechnologien
erstellen. Beispiele für Topologien:   
    * Einzelknoten mit IBM WebSphere Application Server Liberty Profile
    * Mehrere Knoten mit IBM WebSphere Application Server Liberty Profile
    * Einzelknoten mit IBM WebSphere Application Server Full Profile
    * Mehrere Knoten mit IBM WebSphere Application Server Full Profile
    * Server-Cluster mit WebSphere Application Server Network Deployment
    * Application-Center-Implementierungstopologien wie die folgenden: 
        * Einzelknoten mit IBM WebSphere Application Server Liberty Profile
        * Einzelknoten mit IBM WebSphere Application Server Full Profile
* Scriptpakete fungieren als logische Bausteine für die Erstellung erweiterter Implementierungstopologien, z. B. für die Automation der Einbeziehung eines
Analyseservers in ein Muster und flexible Implementierungsoptionen für virtuelle Maschinen für Datenbanken. Über die Einbeziehung von
WebSphere-Application-Server- und
DB2-Mustertypen sind
WebSphere-Application-Server- und
DB2-Scriptpakete verfügbar.
* Mit optionalen JNDI-Eigenschaften im Scriptpaket für Laufzeitimplementierung kann die Implementierungstopologie
differenziert optimiert werden. Darüber hinaus bieten mit
IBM WebSphere Application Server Full
Profile erstellte Implementierungstopologien jetzt Unterstützung für
den Zugriff auf die Administrationskonsole von
WebSphere Application Server, sodass eine vollständige Kontrolle der Konfiguration des
Anwendungsservers möglich ist. 

### Wichtige Einschränkungen
{: #important-restrictions }
Je nach verwendeter Musterschablone gibt es Komponentenattribute, die Sie nicht ändern dürfen. Wenn Sie eines dieser Komponentenattribute ändern, schlägt die Implementierung von Mustern fehl, die auf folgenden
Schablonen basieren. 

#### {{ site.data.keys.product }} (Application Center Liberty Single Node)
{: #mobilefirst-foundation-application-center-liberty-single-node }
Ändern Sie für den Liberty-Profile-Server nicht die Werte der folgenden Attribute:


* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Wählen Sie unter "Install an IBM Java SDK" nur Java SDK
V7.0 oder Java SDK V7.1 aus. 
* Wählen Sie "Install Additional Features" aus und
"IBM WebSphere eXtreme Scale" ab.

#### {{ site.data.keys.product }} (Application Center WebSphere Application Server Single Node)
{: #mobilefirst-foundation-application-center-websphere-application-server-single-node }
Ändern Sie für den Liberty-Profile-Server nicht die Werte der folgenden Attribute:


* WebSphere product Installation directory
* Configuration data location
* Cell name
* Node name
* Profile name
* Wählen Sie unter "Install an IBM Java SDK" nur Java SDK
V7.0 oder Java SDK V7.1 aus. 
* Wählen Sie "Install Additional Features" aus und
"IBM WebSphere eXtreme Scale" ab.

#### {{ site.data.keys.product }} (Liberty Single Node)
{: #mobilefirst-foundation-liberty-single-node }
Ändern Sie für den Liberty-Profile-Server nicht die Werte der folgenden Attribute:


* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Wählen Sie unter "Install an IBM Java SDK" nur Java SDK
V7.0 oder Java SDK V7.1 aus. 
* Wählen Sie "Install Additional Features" aus und
"IBM WebSphere eXtreme Scale" ab.

#### {{ site.data.keys.product }} (Liberty Server Farm)
{: #mobilefirst-foundation-liberty-server-farm }
Ändern Sie für den Liberty-Profile-Server nicht die Werte der folgenden Attribute:


* WebSphere product Installation directory
* Configuration data location
* Liberty profile server name
* Wählen Sie unter "Install an IBM Java SDK" nur Java SDK
V7.0 oder Java SDK V7.1 aus. 
* Wählen Sie "Install Additional Features" aus und
"IBM WebSphere eXtreme Scale" ab.

#### Schablone '{{ site.data.keys.product }} (WebSphere Application Server Single Node)'
{: #mobilefirst-foundation-websphere-application-server-single-node-template }
Für die Komponente **Standalone Server** des Knotens "MobileFirst
Platform Server" dürfen Sie die Werte der folgenden Attribute nicht freigeben oder ändern: 

* Cell name
* Node name
* Profile name
* Wenn Sie eines dieser Attribute ändern, schlägt die Musterimplementierung fehl. 

#### Schablone '{{ site.data.keys.product }} (WebSphere Application Server Server Farm)'
{: #mobilefirst-foundation-websphere-application-server-server-farm-template }
Für die Komponente **Standalone Server** des Knotens "MobileFirst
Platform Server" dürfen Sie die Werte der folgenden Attribute nicht freigeben oder ändern: 

* Cell name
* Node name
* Profile name
* Wenn Sie eines dieser Attribute ändern, schlägt die Musterimplementierung fehl. 

#### Schablone '{{ site.data.keys.product }} (WebSphere Application Server Network Deployment)'
{: #mobilefirst-foundation-websphere-application-server-network-deployment-template }
Für die Komponente **Deployment Manager** des Knotens **DmgrNode** oder die Komponente **Custom Nodes**
des Knotens **CustomNode** dürfen Sie die Werte der folgenden Attribute nicht freigeben oder ändern: 

* Cell name
* Node name
* Profile name

Wenn Sie eines dieser Attribute ändern, schlägt die Musterimplementierung fehl. 

### Einschränkungen
{: #limitations }
Folgende Einschränkungen gelten:

* Für Server-Farmen mit WebSphere Application Server Liberty Profile
und WebSphere Application Server Full
Profile wird keine dynamische Skalierung unterstützt. Im Muster kann die Anzahl der Server-Farmknoten durch das Definieren der Skalierungsrichtlinie angegeben werden. Diese Anzahl
kann jedoch nicht in der Laufzeit geändert werden.
* Die bis Version 7.0 unterstützte {{ site.data.keys.v63_to_80prerebrand_product_full }} System Pattern Extension
für {{ site.data.keys.mf_studio }} und die bis Version 7.0 unterstützte
Ant-Befehlszeilenschnittstelle stehen für die aktuelle
Version von
{{ site.data.keys.mf_system_pattern }} nicht zur Verfügung.
* {{ site.data.keys.mf_system_pattern }} hängt von
WebSphere Application Server Patterns ab, für das eigene Einschränkungen gelten. Weitere Informationen
finden Sie unter
[Restrictions
for WebSphere Application Server Patterns](http://ibm.biz/knowctr#SSAJ7T_1.0.0/com.ibm.websphere.waspatt20base.doc/ae/rins_patternsB_restrictions.html). 
* Aufgrund von Beschränkungen bei der Deinstallation von Mustern für virtuelle Systeme müssen Sie die Scriptpakete manuell löschen, nachdem Sie
den Mustertyp gelöscht haben. Navigieren Sie in IBM
PureApplication System
zu **Katalog → Scriptpakete**, um die Scriptpakete zu löschen, die im Abschnitt
**Komponenten** aufgelistet sind. 
* Die Musterschablone "MobileFirst (WebSphere Application Server Network Deployment)" bietet keine Unterstützung für die Tokenlizenzierung. Wenn Sie dieses Muster verwenden möchten, müsen Sie mit
zeitlich unbegrenzten Lizenzen arbeiten. Alle anderen Muster unterstützen die Tokenlizenzierung. 

### Zusammensetzung
{: #composition }
{{ site.data.keys.mf_system_pattern }} setzt
sich aus folgenden Mustern zusammen:

* IBM WebSphere Application Server Network Deployment Patterns 2.2.0.0
* [PureApplication Service] WebSphere-8558-for-Mobile-IM-Repository als Voraussetzung
für das Funktionieren von WebSphere Application Server Network Deployment Patterns. Lassen Sie sich vom Administrator für
IBM PureApplication System
bestätigen, dass das WebSphere-8559-IM-Repository
installiert ist. 
* IBM
DB2 mit BLU
Acceleration Pattern 1.2.4.0
* {{ site.data.keys.mf_system_pattern }}.

### Komponenten
{: #components }
Neben den von IBM WebSphere Application
Server Patterns
und IBM DB2 mit BLU Acceleration Pattern
bereitgestellten Komponenten stellt {{ site.data.keys.mf_system_pattern }} die folgenden
Scriptpakete zur Verfügung: 

* MFP Administration DB
* MFP Runtime DB
* MFP Server Prerequisite
* MFP Server Administration
* MFP Server Runtime Deployment
* MFP Server Application Adapter Deployment
* MFP IHS Configuration
* MFP Analytics
* MFP Open Firewall Ports for WAS
* MFP WAS SDK Level
* MFP Server Application Center

### Kompatibilität von in verschiedenen Produktversionen erstellten Mustertypen und Artefakten
{: #compatibility-between-pattern-types-and-artifacts-created-with-different-product-versions }
Wenn Sie Ihre Anwendungen in MobileFirst Studio bis Version 6.3.0
entwickeln, können Sie die zugehörigen Laufzeit-, Anwendungs- und Adapterartefakte
in Muster hochladen, die
der {{ site.data.keys.v63_to_80prerebrand_product_full }} ab Version 7.0.0
zugeordnet sind. 

Der {{ site.data.keys.v63_to_80prerebrand_product_full }} bis Version 6.3.0
zugeordnete Mustertypen sind nicht mit Laufzeit-, Anwendungs- und Adapterartefakten kompatibel,
die mit
MobileFirst Studio ab Version 7.0.0 erstellt wurden. 

Bis
Version 6.0.0 ist die Kompatibilität nur gegeben, wenn Server, **.war**-Datei, Anwendungsdateien (**.wlapp**) und Adapter denselben Versionsstand
haben. 

## {{ site.data.keys.mf_system_pattern }} installieren
{: #installing-mobilefirst-system-pattern }
Sie müssen die Datei **{{ site.data.keys.mf_system_pattern_file }}** extrahieren, bevor Sie mit dieses Prozedur beginnen.

1. Melden Sie sich bei IBM PureApplication System
mit einem Account an, der berechtigt ist, neue Mustertypen zu erstellen.
2. Navigieren Sie zu **Katalog → Mustertypen**.
3. Laden Sie die **.tgz** mit {{ site.data.keys.mf_system_pattern }} wie folgt hoch: 
    * Klicken Sie in der Symbolleiste auf das Pluszeichen (**+**). Das Fenster "Mustertyp installieren" wird geöffnet.
    * Klicken Sie auf der Registerkarte "Lokal" auf **Durchsuchen**,
wählen Sie die **.tgz**-Datei mit {{ site.data.keys.mf_system_pattern }}
aus und warten Sie, bis der Uploadprozess beendet ist. Der Mustertyp wird in der Liste angezeigt und ist als nicht aktiviert gekennzeichnet.
4. Klicken Sie in der Liste der Mustertypen auf den hochgeladenen Mustertyp.Details des Mustertyps werden angezeigt.
5. Klicken Sie in der Zeile "Lizenzvereinbarung" auf **Lizenz**. Das Lizenzfenster mit den Bedingungen der Lizenzvereinbarung wird angezeigt.
6. Klicken Sie zum Akzeptieren der Lizenz auf **Akzeptieren**. In den Details für den Mustertyp wird jetzt angezeigt, dass die Lizenz akzeptiert wurde.
7. Klicken Sie in der Statuszeile auf **Aktivieren**. Der Mustertyp wird jetzt als aktiviert aufgeführt.
8. Obligatorisch für PureApplication Service:
Wenn der Mustertyp erfolgreich aktiviert ist, navigieren Sie zu
**Katalog → Scriptpakete** und wählen Sie Scriptpakete aus, deren Namen
ähnlich wie "MFP \*\*\*" lauten. Akzeptieren Sie rechts auf der Detailseite im Feld
**Lizenzvereinbarung** die Lizenz. Wiederholen Sie diese Schritte für alle elf Scriptpakete, die im Abschnitt
"Komponenten" aufgelistet sind.

## Voraussetzungen für die Tokenlizenzierung für {{ site.data.keys.mf_system_pattern }}
{: #token-licensing-requirements-for-mobilefirst-system-pattern }
Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden,
muss IBM  Rational License Key Server installiert
und mit Ihren Lizenzen konfiguriert werden,
bevor Sie {{ site.data.keys.mf_system_pattern_full }} implementieren. 

> **Wichtiger Hinweis:** Die Musterschablone "{{ site.data.keys.product }} (WAS ND)" bietet keine Unterstützung für die Tokenlizenzierung. Wenn Sie Muster implementieren, die auf der Musterschablone
"{{ site.data.keys.product }}
(WAS
ND)" basieren, müssen Sie zeitlich unbegrenzte Lizenzen verwenden. Alle anderen Musterschablonen unterstützen die Tokenlizenzierung. Ihr IBM Rational License Key Server muss bezogen auf Ihr
PureApplication
System ein externer Server sein. {{ site.data.keys.system_pattern }} bietet keine Unterstützung für
den gemeinsam genutzten PureApplication-System-Service für IBM Rational License Key Server.

Sie müssen die folgenden Angaben zu Ihrem Rational License Key Server kennen, damit Sie die License-Key-Server-Informationen
zu Ihren Musterattributen hinzufügen können: 

* Vollständig qualifizierter Hostnamen oder IP-Adresse Ihres Rational License Key Server
* Port des Lizenzmanagerdämons (**lmgrd**)
* Port von Vendor Daemon (**ibmratl**)

Wenn es zwischen Ihrem Rational License Key Server und Ihrem
PureApplication System eine Firewall gibt, müssen Sie sicherstellen, dass beide Dämonports in Ihrer Firewall geöffnet sind. Die Implementierung von {{ site.data.keys.system_pattern }} schlägt fehl,
wenn keine Verbindung zum License Key Server hergestellt werden kann oder nicht genug Token verfügbar sind. 

Einzelheiten zur Installation und Konfiguration von Rational License Key Server finden Sie
auf der [Startseite des IBM Support
zur Rational-Lizenzierung](http://www.ibm.com/software/rational/support/licensing/).

## {{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren
{: #deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server }
Für die Implementierung
von {{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit
WebSphere Application Server Liberty
Profile verwenden Sie eine vordefinierte Schablone.

Im Rahmen dieses Prozesses werden Sie bestimmte
Artefakte in das IBM
PureApplication System
hochladen, z. B. die erforderliche Anwendung oder den erforderlichen Adapter. Stellen Sie vor Beginn sicher, dass die Artefakte zum Hochladen verfügbar sind.

**Voraussetzungen für die Tokenlizenzierung:** Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten, lesen Sie zunächst die Voraussetzungen unter [Voraussetzungen für die Tokenlizenzierung für die Tokenlizenzierung für
{{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) durch. Die Implementierung dieses Musters schlägt fehl,
wenn keine Verbindung zum License Key Server hergestellt werden kann oder nicht genug Token verfügbar sind. 

Einige Parameter von Scriptpaketen der Schablone sind mit den empfohlenen Werten konfiguriert und werden in diesem Abschnitt
nicht erwähnt. Weitere Informationen zu allen Parametern der Scriptpakete zum Zwecke der Optimierung finden Sie unter
[Scriptpakete für {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server). 

Weitere Informationen zur Zusammensetzung und zu den Konfigurationsoptionen der hier verwendeten vordefinierten Schablone
finden Sie unter
[Schablone '{{ site.data.keys.product }} (Liberty Single Node)'](#mobilefirst-foundation-liberty-single-node-template). 

1. Erstellen Sie mit der vordefinierten Schablone ein Muster.
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. Die Seite "Muster für virtuelle Systeme" wird geöffnet.
    * Klicken Sie auf der Seite **Muster für virtuelle Systeme** auf **Neue
erstellen**. Wählen Sie dann im Popup-Fenster in der Liste der vordefinierten Schablonen
**MobileFirst
Platform (Liberty Single Node)** aus. Wenn der Name aufgrund seiner Länge nur teilweise sichtbar ist, können Sie sich vergewissern, dass Sie die richtige Schablone ausgewählt haben,
indem Sie sich die Beschreibung auf der Registerkarte
**Weitere
Informationen** ansehen. 
    * Geben Sie im Feld **Name** einen Namen für das Muster an.
    * Geben Sie im Feld **Version** die Versionsnummer des Musters an.
    * Klicken Sie auf **Erstellung starten**.
2. Obligatorisch für AIX: Auf IBM
PureApplication System
Power muss der Knoten "MobileFirst-Platform-Datenbank"
die AIX-spezifische Add-on-Komponente
"Default AIX Add Disk" anstelle der Komponente
"Default Add Disk" in der Schablone verwenden, damit das
jfs2-Dateisystem unterstützt wird. 
    * Wählen Sie im Erstellungsprogramm für Muster den Knoten
**MobileFirst-Platform-Datenbank**
aus. 
    * Klicken Sie auf die Schaltfläche **Komponenten-Add-on hinzufügen**.
(Die Schaltfläche wird über dem Komponentenfeld angezeigt, wenn Sie den Cursor auf den Knoten
**MobileFirst-Platform-Datenbank** bewegen.) 
    * Wählen Sie in der Liste **Add-ons hinzufügen**
den Eintrag **Default
AIX Add
Disk** aus.
Die Komponente wird als unterste Komponente des Knotens
"MobileFirst-Platform-Datenbank" hinzugefügt. 
    * Wählen Sie die Komponente **Default AIX Add
Disk** aus und geben Sie die folgenden Attribute an:
        * **DISK_SIZE_GB:** Speicherkapazität (in GB), die für den Datenbankserver hinzugefügt werden soll. Beispielwert: **10**.
        * **FILESYSTEM_TYPE:** Unterstütztes Dateisystem in AIX. Standardwert: **jfs2**. 
        * **MOUNT_POINT:** Gleichen Sie dieses Attribut an das Attribut **Mount
point for instance owner** der Komponente
"Database Server" des Knotens
"MobileFirst Platform DB" an. Beispielwert: **/dbinst**.
        * **VOLUME_GROUP:** Beispielwert: **group1**. Fragen Sie Ihren Administrator für IBM
PureApplication System
nach dem richtigen Wert. 
    * Wählen Sie auf dem Knoten "MobileFirst-Platform-Datenbank" die Komponente
**Default Add
Disk** aus und klicken Sie auf das Papierkorbsymbol,
um sie zu löschen. 
    * Speichern Sie das Muster.
3. Optional: Konfigurieren Sie die MobileFirst-Server-Verwaltung. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Administratorberechtigung für
{{ site.data.keys.mf_server }} später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Gehen Sie wie folgt vor, wenn Sie die Berechtigungsnachweise jetzt angeben möchten: 

    > **Hinweis:** Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren möchten, müssen Sie LDAP-Informationen
angeben (siehe
[{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Administration**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben den Feldern **admin_user**
und
**admin_password** auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene zu löschen. 
    * Geben Sie in den Feldern
**admin_user** und
**admin\_password** den Benutzernamen und das Kennwort des Benutzers mit Administratorberechtigung an.
    * Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten,
machen Sie in den folgenden Feldern Angaben. Lassen Sie diese Felder leer, wenn Sie keine Tokenlizenzierung anwenden. 

    **ACTIVATE\_TOKEN\_LICENSE**: Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden
möchten.  
    **LICENSE\_SERVER\_HOSTNAME**: Geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres
Rational License Key Server ein.  
    **LMGRD\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (**lmrgd**) auf eingehende Verbindungen wartet. Der Standardport des
Lizenzmanagerdämons ist 27000.  
    **IBMRATL\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (**ibmratl**) auf eingehende Verbindungen wartet. Der Standardport des
Vendor Daemon ist 27001.   

    Während der Musterimplementierung wird ein Standardverwaltungskonto
für {{ site.data.keys.mf_server }} erstellt.

4. Konfigurieren Sie die Implementierung der MobileFirst-Server-Laufzeit. Sie können diesen Schritt auslassen, wenn Sie den Namen des Kontextstammverzeichnisses für die Laufzeit
später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Gehen Sie wie folgt vor, wenn Sie den Namen des Kontextstammverzeichnisses jetzt angeben möchten: 
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Runtime Deployment**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben dem Feld
**runtime\_contextRoot** auf die Schaltfläche **Löschen**, um die Parametereinstellung auf Musterebene zu löschen. 
    * Geben Sie im Feld
**runtime\_contextRoot** den Namen des Laufzeitkontextstammverzeichnisses
an.
Beachten Sie, dass der Name des Kontextstammverzeichnisses mit einem
Schrägstrich (/) beginnen muss, z. B. `/HelloWorld`.

5. Laden Sie wie folgt die Anwendungs- und Adapterartefakte hoch: 

    > **Wichtiger Hinweis:** Wenn Sie den Zielpfad für Anwendungen und Adapter angeben, müssen Sie sicherstellen, dass sich alle Anwendungen
und Adapter in demselben Verzeichnis befinden. Wenn ein Zielpfad beispielsweise **/opt/tmp/deploy/HelloWorld-common.json** lautet,
müssen alle anderen Zielpfade
`/opt/tmp/deploy/*` lauten.    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente **MFP
Server Application** oder **MFP Server Adapter**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie für das Feld **Zusätzliche
Datei** auf
die
Schaltfläche **Durchsuchen**, um das Anwendungs- oder Adapterartefakt zu finden und hochzuladen. 
    * Geben Sie im Feld **Zielpfad**
den vollständigen Pfad für das Speichern des Artefakts
(einschließlich des Dateinamens) an, z. B.
**/opt/tmp/deploy/HelloWorld-common.json**.
    * Wenn im Muster keine Anwendung oder kein Adapter implementiert werden soll, entfernen Sie die betreffende Komponente, indem Sie
auf die Schaltfläche
**X** klicken. Wenn Sie eine leere
{{ site.data.keys.mf_console }} ohne installierte App oder installierten Adapter implementieren
möchten, entfernen Sie die Komponente
"MFP Server Application Adapter Deployment", indem Sie auf die Schaltfläche
X klicken. 

6. Optional: Fügen Sie weitere Anwendungs- oder Adapterartefakte zur Implementierung hinzu. 
    * Blenden Sie in der Symbolleiste für **Assets** die Anzeige
für
**Softwarekomponenten** ein.
Ziehen Sie dann mit der Maus eine Komponente
**Additional File** auf den Knoten
"MobileFirst Platform Server" im Erstellungsbereich. Benennen Sie die Komponente
in **{{ site.data.keys.product_adj }} App\_X** oder **{{ site.data.keys.product_adj }} Adatper\_X** um. (Hier steht
das
**X** für eine eindeutige Zahl zur Unterscheidung.) 
    * Bewegen Sie den Cursor auf die neu hinzugefügte App- oder Adapterkomponente.
Klicken Sie dann auf die Schaltfläche
**Nach oben** bzw. **Nach unten**, um die Position in der Reihenfolge der Knotenkomponenten
anzupassen. Stellen Sie sicher, dass sich die Komponente hinter der Komponente "MFP Runtime Deployment", aber vor der
Komponente "MFP Server Application Adapter Deployment" befindet. 
    * Klicken Sie auf die neu hinzugefügte Anwendungs- oder Adapterkomponente. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt. Laden Sie das Anwendungs-
oder Adapterartefakt hoch und geben Sie den Zielpfad an. Beziehen Sie sich dabei auf die Teilschritte von Schritt 6. 
    * Wiederholen Sie Schritt 7, um weitere Anwendungen und Adapter zur Implementierung hinzuzufügen. 

7. Optional: Konfigurieren Sie die Anwendungs- und Adapterimplementierung in
{{ site.data.keys.mf_server }}. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Implementierungsberechtigung später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Falls Sie in Schritt 3 die Berechtigungsnachweise für den Standardbenutzer mit Administratorberechtigung angegeben haben, können Sie jetzt
den Implementierer angeben, dessen Berechtigungsnachweise an die des Benutzers mit Administratorberechtigung angeglichen werden müssen. 
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" die Komponente **MFP
Server Application Adapter Deployment** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Suchen Sie die Parameter **deployer_user** und **deployer_password**
und klicken Sie daneben jeweils
auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene
zu löschen. 
    * Geben Sie in den Feldern
**deployer\_user** und **deployer\_password**
den Benutzernamen und das Kennwort an. 

8. Konfigurieren und starten Sie wie folgt die Musterimplementierung:
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. 
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld
**Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus. 
    * Klicken Sie in der Symbolleiste über dem Bereich mit den ausführlichen Informationen zum Muster
auf die Schaltfläche Implementieren. 
    * Wählen Sie im Fenster "Muster implementieren" im Bereich "Konfigurieren" in der
Liste **Umgebungsprofil** das richtige Umgebungsprofil aus und geben Sie weitere Umgebungsparameter für
IBM PureApplication System
an. Die richtigen Angaben erfahren Sie von Ihrem Administrator für
IBM PureApplication System. 
    * Klicken Sie in der mittleren Spalte auf **Musterattribute**,
um Attribute wie Benutzernamen und Kennwörter anzuzeigen.

        Machen Sie in den bereitgestellten Feldern die folgenden Angaben:

        > **Hinweis:** Ändern Sie die Standardwerte der Parameter auf Musterebene nach Bedarf, auch wenn ein externer LDAP-Server konfiguriert ist. Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren, müssen Sie zusätzliche LDAP-Informationen angeben (siehe [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
        
        **admin\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Erstellen Sie ein Standardadministratorkonto für {{ site.data.keys.mf_server }}. Standardwert: demo.
        
        **admin\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Er gibt das Kennwort für das Standardadministratorkonto an. Standardwert: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden möchten. Lassen Sie dieses Feld leer, wenn Sie zeitlich unbegrenzte Lizenzen verwenden.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres Rational License Key Server ein. Lassen Sie dieses Feld andernfalls leer.
        
        **LMGRD\_PORT**   
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (lmrgd) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Lizenzmanagerdämons ist 27000.

        **IBMRATL\_PORT**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (ibmratl) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Vendor Daemon ist 27001.

        **runtime\_contextRoot**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 5 konfiguriert wurde. Er gibt den Namen des Kontextstammverzeichnisses für die MobileFirst-Server-Laufzeit an. Der Name muss mit "/" beginnen.
        
        **deployer\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Wenn kein externer LDAP-Server konfiguriert ist, müssen Sie den Wert eingeben, den Sie beim Erstellen des Standardbenutzers mit Administratorberechtigung für den Verwaltungsservice angegeben haben, weil in diesem Fall nur der für die App- und Adapterimplementierung autorisierte Benutzer der Standardbenutzer mit Administratorberechtigung ist.
        
        **deployer\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt das Kennwort des Benutzers mit Implementierungsberechtigung an.
        
        **MFP VMs Password (root)**  
        Rootkennwort für die Knoten "{{ site.data.keys.mf_server }}" und "{{ site.data.keys.product }} DB". Standardwert: passw0rd.
        
        **MFP DB Password (Instance owner)**  
        Kennwort des Instanzeigners für den Knoten "MobileFirst Platform DB". Standardwert: **passw0rd**.    
    * Klicken Sie auf **Schnellimplementierung**, um Ihre Musterimplementierung zu starten. Nach einigen Sekunden wird eine Nachricht angezeigt, aus der hervorgeht, dass mit dem Start des Musters begonnen wurde. Sie können auf die URL in der Nachricht klicken, um den Status Ihrer Musterimplementierung zu verfolgen, oder zu **Muster → Instanzen eines virtuellen Systems** navigieren, um die Seite "Instanzen eines virtuellen Systems" zu öffnen und dort nach Ihrem Muster zu suchen.

    Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung
verwenden, kann Ihre Musterimplementierung fehlschlagen, wenn nicht genug Lizenztoken verfügbar sind oder die
IP-Adresse und die Portnummer des License Key Server falsch eingegeben wurden. 

9. Greifen Sie wie folgt auf die {{ site.data.keys.mf_console }} zu:
    * Klicken Sie auf **Muster → Instanzen eines virtuellen Systems**, um die Seite Instanzen eines virtuellen Systems zu öffnen und dort nach Ihrem Muster zu suchen. Stellen Sie sicher, dass der Status "Aktiv" lautet.
    * Wählen Sie den Musternamen aus und erweitern Sie im Bereich mit den Details der ausgewählten Instanz die Anzeige für die Option **Perspektive virtueller Maschine**.
    * Suchen Sie die virtuelle Maschine für {{ site.data.keys.mf_server }}, die einen Namen wie **MobileFirst\_Platform\_Server.*** hat, und notieren Sie die öffentliche IP-Adresse der Maschine. Sie benötigen diese Angabe im folgenden Schritt.
    * Öffnen Sie im Browser die {{ site.data.keys.mf_console }}, indem Sie die URL der Konsole in einem der folgenden Formate angeben:
        * `http://{öffentliche IP-Adresse der VM für MFP Server}:9080/mfpconsole`
        * `https://{öffentliche IP-Adresse der VM für MFP Server}:9443/mfpconsole`
    * Melden Sie sich bei der Konsole als Benutzer mit Administratorberechtigung mit dem entsprechenden Kennwort (angegeben in Schritt 3 oder 9) an.

## {{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren
{: #deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server }
Für die Implementierung
von {{ site.data.keys.mf_server }} auf mehreren Serverknoten mit
WebSphere Application Server Liberty
Profile verwenden Sie eine vordefinierte Schablone.

Im Rahmen dieses Prozesses werden Sie bestimmte
Artefakte in das IBM
PureApplication System
hochladen, z. B. die erforderliche Anwendung oder den erforderlichen Adapter. Stellen Sie vor Beginn sicher, dass die Artefakte zum Hochladen verfügbar sind.

**Voraussetzungen für die Tokenlizenzierung:** Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten, lesen Sie zunächst die Voraussetzungen unter [Voraussetzungen für die Tokenlizenzierung für die Tokenlizenzierung für
{{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) durch. Die Implementierung dieses Musters schlägt fehl,
wenn keine Verbindung zum License Key Server hergestellt werden kann oder nicht genug Token verfügbar sind. 

Einige Parameter von Scriptpaketen der Schablone sind mit den empfohlenen Werten konfiguriert und werden in diesem Abschnitt
nicht erwähnt. Weitere Informationen zu allen Parametern der Scriptpakete zum Zwecke der Optimierung finden Sie unter
[Scriptpakete für {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server). 

Weitere Informationen zur Zusammensetzung und zu den Konfigurationsoptionen der hier verwendeten vordefinierten Schablone
finden Sie unter
[Schablone '{{ site.data.keys.product }} (Liberty Server Farm)'](#mobilefirst-foundation-liberty-server-farm-template). 

1. Erstellen Sie mit der vordefinierten Schablone ein Muster.
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. Die Seite **Muster für virtuelle Systeme** wird geöffnet. 
    * Klicken Sie auf der Seite **Muster für virtuelle Systeme** auf **Neue
erstellen**. Wählen Sie dann im Popup-Fenster in der Liste der vordefinierten Schablonen
**MobileFirst
Platform (Liberty Server Farm)** aus. Wenn der Name aufgrund seiner Länge nur teilweise sichtbar ist, können Sie sich vergewissern, dass Sie die richtige Schablone ausgewählt haben,
indem Sie sich die Beschreibung auf der Registerkarte
**Weitere
Informationen** ansehen. 
    * Geben Sie im Feld **Name** einen Namen für das Muster an.
    * Geben Sie im Feld **Version** die Versionsnummer des Musters an.
    * Klicken Sie auf **Erstellung starten**.
2. Obligatorisch für AIX: Auf IBM
PureApplication System
Power muss der Knoten "MobileFirst-Platform-Datenbank"
die AIX-spezifische Add-on-Komponente
"Default AIX Add Disk" anstelle der Komponente
"Default Add Disk" in der Schablone verwenden, damit das
**jfs2**-Dateisystem unterstützt wird. 
    * Wählen Sie im Erstellungsprogramm für Muster den Knoten
**MobileFirst-Platform-Datenbank**
aus. 
    * Klicken Sie auf die Schaltfläche **Komponenten-Add-on hinzufügen**.
(Die Schaltfläche wird über dem Komponentenfeld angezeigt, wenn Sie den Cursor auf den Knoten
**MobileFirst-Platform-Datenbank** bewegen.) 
    * Wählen Sie in der Liste **Add-ons hinzufügen**
den Eintrag **Default
AIX Add
Disk** aus.
Die Komponente wird als unterste Komponente des Knotens
"MobileFirst-Platform-Datenbank" hinzugefügt. 
    * Wählen Sie die Komponente **Default AIX Add
Disk** aus und geben Sie die folgenden Attribute an:
        * **DISK_SIZE_GB:** Speicherkapazität (in GB), die für den Datenbankserver hinzugefügt werden soll. Beispielwert: **10**.
        * **FILESYSTEM_TYPE:** Unterstütztes Dateisystem in AIX. Standardwert: **jfs2**. 
        * **MOUNT_POINT:** Gleichen Sie dieses Attribut an das Attribut **Mount
point for instance owner** der Komponente
"Database Server" des Knotens
"MobileFirst Platform DB" an. Beispielwert: **/dbinst**.
        * **VOLUME_GROUP:** Beispielwert: **group1**. Fragen Sie Ihren Administrator für IBM
PureApplication System
nach dem richtigen Wert. 
    * Wählen Sie auf dem Knoten "MobileFirst-Platform-Datenbank" die Komponente
**Default Add
Disk** aus und klicken Sie auf das Papierkorbsymbol,
um sie zu löschen. 
    * Speichern Sie das Muster.
3. Optional: Konfigurieren Sie die MobileFirst-Server-Verwaltung. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Administratorberechtigung für
{{ site.data.keys.mf_server }} später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Gehen Sie wie folgt vor, wenn Sie die Berechtigungsnachweise jetzt angeben möchten: 

    > **Hinweis:** Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren möchten, müssen Sie LDAP-Informationen
angeben (siehe
[{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Administration**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben den Feldern **admin_user**
und
**admin_password** auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene zu löschen. 
    * Geben Sie in den Feldern
**admin_user** und
**admin\_password** den Benutzernamen und das Kennwort des Benutzers mit Administratorberechtigung an.
    * Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten,
machen Sie in den folgenden Feldern Angaben. Lassen Sie diese Felder leer, wenn Sie keine Tokenlizenzierung anwenden. 

    **ACTIVATE\_TOKEN\_LICENSE**: Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden
möchten.  
    **LICENSE\_SERVER\_HOSTNAME**: Geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres
Rational License Key Server ein.  
    **LMGRD\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (**lmrgd**) auf eingehende Verbindungen wartet. Der Standardport des
Lizenzmanagerdämons ist 27000.  
    **IBMRATL\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (**ibmratl**) auf eingehende Verbindungen wartet. Der Standardport des
Vendor Daemon ist 27001.   

    Während der Musterimplementierung wird ein Standardverwaltungskonto
für {{ site.data.keys.mf_server }} erstellt.
    
4. Konfigurieren Sie die Implementierung der MobileFirst-Server-Laufzeit. Sie können diesen Schritt auslassen, wenn Sie den Namen des Kontextstammverzeichnisses für die Laufzeit
später
in Schritt 10 beim Konfigurieren der Musterimplementierung angeben möchten. Wenn Sie den Namen des Kontextstammverzeichnisses jetzt angeben möchten, führen Sie
die folgenden Schritte aus: 
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Runtime Deployment**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben dem Feld
**runtime\_contextRoot** auf die Schaltfläche **Löschen**, um die Parametereinstellung auf Musterebene zu löschen. 
    * Geben Sie im Feld
**runtime\_contextRoot** den Namen des Laufzeitkontextstammverzeichnisses
an.
Beachten Sie, dass der Name des Kontextstammverzeichnisses mit einem
Schrägstrich (/) beginnen muss, z. B. `/HelloWorld`.

5. Laden Sie wie folgt die Anwendungs- und Adapterartefakte hoch: 

    > **Wichtiger Hinweis:** Wenn Sie den Zielpfad für Anwendungen und Adapter angeben, müssen Sie sicherstellen, dass sich alle Anwendungen
und Adapter in demselben Verzeichnis befinden. Wenn ein Zielpfad beispielsweise **/opt/tmp/deploy/HelloWorld-common.json** lautet,
müssen alle anderen Zielpfade
`/opt/tmp/deploy/*` lauten.    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente **MFP
Server Application** oder **MFP Server Adapter**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie für das Feld **Zusätzliche
Datei** auf
die
Schaltfläche **Durchsuchen**, um das Anwendungs- oder Adapterartefakt zu finden und hochzuladen. 
    * Geben Sie im Feld **Zielpfad**
den vollständigen Pfad für das Speichern des Artefakts
(einschließlich des Dateinamens) an, z. B.
**/opt/tmp/deploy/HelloWorld-common.json**.
    * Wenn im Muster keine Anwendung oder kein Adapter implementiert werden soll, entfernen Sie die betreffende Komponente, indem Sie
auf die Schaltfläche
**X** klicken. Wenn Sie eine leere
{{ site.data.keys.mf_console }} ohne installierte App oder installierten Adapter implementieren
möchten, entfernen Sie die Komponente
"MFP Server Application Adapter Deployment", indem Sie auf die Schaltfläche
X klicken.  

6. Optional: Fügen Sie weitere Anwendungs- oder Adapterartefakte zur Implementierung hinzu. 
    * Blenden Sie in der Symbolleiste für **Assets** die Anzeige
für
**Softwarekomponenten** ein.
Ziehen Sie dann mit der Maus eine Komponente
**Additional File** auf den Knoten
"MobileFirst Platform Server" im Erstellungsbereich. Benennen Sie die Komponente
in **{{ site.data.keys.product_adj }} App\_X** oder **{{ site.data.keys.product_adj }} Adatper\_X** um. (Hier steht
das
**X** für eine eindeutige Zahl zur Unterscheidung.) 
    * Bewegen Sie den Cursor auf die neu hinzugefügte App- oder Adapterkomponente.
Klicken Sie dann auf die Schaltfläche
**Nach oben** bzw. **Nach unten**, um die Position in der Reihenfolge der Knotenkomponenten
anzupassen. Stellen Sie sicher, dass sich die Komponente hinter der Komponente "MFP Runtime Deployment", aber vor der
Komponente "MFP Server Application Adapter Deployment" befindet. 
    * Klicken Sie auf die neu hinzugefügte Anwendungs- oder Adapterkomponente. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt. Laden Sie das Anwendungs-
oder Adapterartefakt hoch und geben Sie den Zielpfad an. Beziehen Sie sich dabei auf die Teilschritte von Schritt 6. 
    * Wiederholen Sie Schritt 7, um weitere Anwendungen und Adapter zur Implementierung hinzuzufügen. 

7. Optional: Konfigurieren Sie die Anwendungs- und Adapterimplementierung in
{{ site.data.keys.mf_server }}. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Implementierungsberechtigung später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Falls Sie in Schritt 3 die Berechtigungsnachweise für den Standardbenutzer mit Administratorberechtigung angegeben haben, können Sie jetzt
den Implementierer angeben, dessen Berechtigungsnachweise an die des Benutzers mit Administratorberechtigung angeglichen werden müssen. 
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" die Komponente **MFP
Server Application Adapter Deployment** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Suchen Sie die Parameter **deployer_user** und **deployer_password**
und klicken Sie daneben jeweils
auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene
zu löschen. 
    * Geben Sie in den Feldern
**deployer\_user** und **deployer\_password**
den Benutzernamen und das Kennwort an. 

8. Konfigurieren Sie wie folgt die Basisskalierungsrichtlinie:
    * Wählen Sie auf dem Knoten MobileFirst Platform Server die Komponente **Base Scaling Policy** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Geben Sie im Feld **Anzahl der Instanzen** die Anzahl der Serverknoten an, die während der Musterimplementierung instanziiert werden sollen. Der Standardwert der vordefinierten Schablone lautet 2. Da die dynamische Skalierung in diesem Release nicht unterstützt wird, geben Sie in den übrigen Attributfeldern keine Werte an.

9. Konfigurieren und starten Sie wie folgt die Musterimplementierung:
    * Klicken Sie im Dashboard von IBM PureApplication System auf **Muster → Muster für virtuelle Systeme**.
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld **Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus.
    * Klicken Sie in der Symbolleiste über dem Bereich mit den ausführlichen Informationen zum Muster auf die Schaltfläche Implementieren.
    * Wählen Sie im Fenster "Muster implementieren" im Bereich "Konfigurieren" in der Liste **Umgebungsprofil** das richtige Umgebungsprofil aus und geben Sie weitere Umgebungsparameter für IBM PureApplication System an. Die richtigen Angaben erfahren Sie von Ihrem Administrator für IBM PureApplication System.
    * Klicken Sie in der mittleren Spalte auf **Musterattribute**, um Attribute wie Benutzernamen und Kennwörter anzuzeigen.

        Machen Sie in den bereitgestellten Feldern die folgenden Angaben:

        > **Hinweis:** Ändern Sie die Standardwerte der Parameter auf Musterebene nach Bedarf, auch wenn ein externer LDAP-Server konfiguriert ist. Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren, müssen Sie zusätzliche LDAP-Informationen angeben (siehe [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
        
        **admin\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Erstellen Sie ein Standardadministratorkonto für {{ site.data.keys.mf_server }}. Standardwert: demo.
        
        **admin\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Er gibt das Kennwort für das Standardadministratorkonto an. Standardwert: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden möchten. Lassen Sie dieses Feld leer, wenn Sie zeitlich unbegrenzte Lizenzen verwenden.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres Rational License Key Server ein. Lassen Sie dieses Feld andernfalls leer.
        
        **LMGRD\_PORT**   
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (lmrgd) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Lizenzmanagerdämons ist 27000.

        **IBMRATL\_PORT**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (ibmratl) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Vendor Daemon ist 27001.

        **runtime\_contextRoot**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 5 konfiguriert wurde. Er gibt den Namen des Kontextstammverzeichnisses für die MobileFirst-Server-Laufzeit an. Der Name muss mit "/" beginnen.
        
        **deployer\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt den Benutzernamen für das Konto mit Implementierungsberechtigung an. Wenn kein externer LDAP-Server konfiguriert ist, müssen Sie den Wert eingeben, den Sie beim Erstellen des Standardbenutzers mit Administratorberechtigung für den Verwaltungsservice angegeben haben, weil in diesem Fall nur der für die App- und Adapterimplementierung autorisierte Benutzer der Standardbenutzer mit Administratorberechtigung ist.
        
        **deployer\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt das Kennwort des Benutzers mit Implementierungsberechtigung an.
        
        **MFP VMs Password (root)**  
        Rootkennwort für die Knoten "{{ site.data.keys.mf_server }}" und "{{ site.data.keys.product }} DB". Standardwert: passw0rd.
        
        **MFP DB Password (Instance owner)**  
        Kennwort des Instanzeigners für den Knoten "MobileFirst Platform DB". Standardwert: **passw0rd**.    
    * Klicken Sie auf **Schnellimplementierung**, um Ihre Musterimplementierung zu starten. Nach einigen Sekunden wird eine Nachricht angezeigt, aus der hervorgeht, dass mit dem Start des Musters begonnen wurde. Sie können auf die URL in der Nachricht klicken, um den Status Ihrer Musterimplementierung zu verfolgen, oder zu **Muster → Instanzen eines virtuellen Systems** navigieren, um die Seite "Instanzen eines virtuellen Systems" zu öffnen und dort nach Ihrem Muster zu suchen.

    Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, kann Ihre Musterimplementierung fehlschlagen, wenn nicht genug Lizenztoken verfügbar sind oder die IP-Adresse und die Portnummer des License Key Server falsch eingegeben wurden.
    
10. Greifen Sie wie folgt auf die {{ site.data.keys.mf_console }} zu:
    * Klicken Sie auf **Muster → Instanzen eines virtuellen Systems**, um die Seite Instanzen eines virtuellen Systems zu öffnen und dort nach Ihrem Muster zu suchen. Stellen Sie sicher, dass der Status "Aktiv" lautet.
    * Wählen Sie den Musternamen aus und erweitern Sie im Bereich mit den Details der ausgewählten Instanz die Anzeige für die Option **Perspektive virtueller Maschine**.
    * Finden Sie die virtuelle Maschine mit IHS, die einen ähnlichen Namen wie **IHS\_Server.***hat, und notieren Sie die öffentliche IP-Adresse der Maschine. Sie benötigen diese Angabe im nächsten Schritt.
    * Öffnen Sie im Browser die {{ site.data.keys.mf_console }}, indem Sie die URL der Konsole in einem der folgenden Formate angeben:
        * `http://{öffentliche IP-Adresse der VM für IHS}/mfpconsole`
        * `https://{öffentliche IP-Adresse der VM für IHS}/mfpconsole`
    * Melden Sie sich bei der Konsole als Benutzer mit Administratorberechtigung mit der entsprechenden Benutzer-ID und dem entsprechenden Kennwort (angegeben in Schritt 3 oder 10) an.

## {{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren
{: #deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server }
Für die Implementierung
von {{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit
WebSphere Application Server Full Profile
verwenden Sie eine vordefinierte Schablone. 

Im Rahmen dieses Prozesses werden Sie bestimmte
Artefakte in das IBM
PureApplication System
hochladen, z. B. die erforderliche Anwendung oder den erforderlichen Adapter. Stellen Sie vor Beginn sicher, dass die Artefakte zum Hochladen verfügbar sind.

**Voraussetzungen für die Tokenlizenzierung:** Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten, lesen Sie zunächst die Voraussetzungen unter [Voraussetzungen für die Tokenlizenzierung für die Tokenlizenzierung für
{{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) durch. Die Implementierung dieses Musters schlägt fehl,
wenn keine Verbindung zum License Key Server hergestellt werden kann oder nicht genug Token verfügbar sind. 

Einige Parameter von Scriptpaketen der Schablone sind mit den empfohlenen Werten konfiguriert und werden in diesem Abschnitt
nicht erwähnt. Weitere Informationen zu allen Parametern der Scriptpakete zum Zwecke der Optimierung finden Sie unter
[Scriptpakete für {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server). 

Weitere Informationen zur Zusammensetzung und zu den Konfigurationsoptionen der hier verwendeten vordefinierten Schablone
finden Sie unter
[Schablone '{{ site.data.keys.product }} (WAS Single Node)'](#mobilefirst-foundation-was-single-node-template). 

1. Erstellen Sie mit der vordefinierten Schablone ein Muster.
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. Die Seite **Muster für virtuelle Systeme** wird geöffnet. 
    * Klicken Sie auf der Seite **Muster für virtuelle Systeme** auf **Neue
erstellen**. Wählen Sie dann im Popup-Fenster in der Liste der vordefinierten Schablonen
**MobileFirst
Platform (WAS Single Node)** aus. Wenn der Name aufgrund seiner Länge nur teilweise sichtbar ist, können Sie sich vergewissern, dass Sie die richtige Schablone ausgewählt haben,
indem Sie sich die Beschreibung auf der Registerkarte
**Weitere
Informationen** ansehen. 
    * Geben Sie im Feld **Name** einen Namen für das Muster an.
    * Geben Sie im Feld **Version** die Versionsnummer des Musters an.
    * Klicken Sie auf **Erstellung starten**.
2. Obligatorisch für AIX: Auf IBM
PureApplication System
Power muss der Knoten "MobileFirst-Platform-Datenbank"
die AIX-spezifische Add-on-Komponente
"Default AIX Add Disk" anstelle der Komponente
"Default Add Disk" in der Schablone verwenden, damit das
**jfs2**-Dateisystem unterstützt wird. 
    * Wählen Sie im Erstellungsprogramm für Muster den Knoten
**MobileFirst-Platform-Datenbank**
aus. 
    * Klicken Sie auf die Schaltfläche **Komponenten-Add-on hinzufügen**.
(Die Schaltfläche wird über dem Komponentenfeld angezeigt, wenn Sie den Cursor auf den Knoten
**MobileFirst-Platform-Datenbank** bewegen.) 
    * Wählen Sie in der Liste **Add-ons hinzufügen**
den Eintrag **Default
AIX Add
Disk** aus.
Die Komponente wird als unterste Komponente des Knotens
"MobileFirst-Platform-Datenbank" hinzugefügt. 
    * Wählen Sie die Komponente **Default AIX Add
Disk** aus und geben Sie die folgenden Attribute an:
        * **DISK_SIZE_GB:** Speicherkapazität (in GB), die für den Datenbankserver hinzugefügt werden soll. Beispielwert: **10**.
        * **FILESYSTEM_TYPE:** Unterstütztes Dateisystem in AIX. Standardwert: **jfs2**. 
        * **MOUNT_POINT:** Gleichen Sie dieses Attribut an das Attribut **Mount
point for instance owner** der Komponente
"Database Server" des Knotens
"MobileFirst Platform DB" an. Beispielwert: **/dbinst**.
        * **VOLUME_GROUP:** Beispielwert: **group1**. Fragen Sie Ihren Administrator für IBM
PureApplication System
nach dem richtigen Wert. 
    * Wählen Sie auf dem Knoten "MobileFirst-Platform-Datenbank" die Komponente
**Default Add
Disk** aus und klicken Sie auf das Papierkorbsymbol,
um sie zu löschen. 
    * Speichern Sie das Muster.
3. Optional: Konfigurieren Sie die MobileFirst-Server-Verwaltung. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Administratorberechtigung für
{{ site.data.keys.mf_server }} später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Gehen Sie wie folgt vor, wenn Sie die Berechtigungsnachweise jetzt angeben möchten: 

    > **Hinweis:** Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren möchten, müssen Sie LDAP-Informationen
angeben (siehe
[{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Administration**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben den Feldern **admin_user**
und
**admin_password** auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene zu löschen. 
    * Geben Sie in den Feldern
**admin_user** und
**admin\_password** den Benutzernamen und das Kennwort des Benutzers mit Administratorberechtigung an.
    * Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten,
machen Sie in den folgenden Feldern Angaben. Lassen Sie diese Felder leer, wenn Sie keine Tokenlizenzierung anwenden. 

    **ACTIVATE\_TOKEN\_LICENSE**: Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden
möchten.  
    **LICENSE\_SERVER\_HOSTNAME**: Geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres
Rational License Key Server ein.  
    **LMGRD\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (**lmrgd**) auf eingehende Verbindungen wartet. Der Standardport des
Lizenzmanagerdämons ist 27000.  
    **IBMRATL\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (**ibmratl**) auf eingehende Verbindungen wartet. Der Standardport des
Vendor Daemon ist 27001.   

    Während der Musterimplementierung wird ein Standardverwaltungskonto
für {{ site.data.keys.mf_server }} erstellt.

4. Konfigurieren Sie die Implementierung der MobileFirst-Server-Laufzeit. Sie können diesen Schritt auslassen, wenn Sie den Namen des Kontextstammverzeichnisses für die Laufzeit
später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Gehen Sie wie folgt vor, wenn Sie den Namen des Kontextstammverzeichnisses jetzt angeben möchten: 
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Runtime Deployment**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben dem Feld
**runtime\_contextRoot** auf die Schaltfläche **Löschen**, um die Parametereinstellung auf Musterebene zu löschen. 
    * Geben Sie im Feld
**runtime\_contextRoot** den Namen des Laufzeitkontextstammverzeichnisses
an.
Beachten Sie, dass der Name des Kontextstammverzeichnisses mit einem
Schrägstrich (/) beginnen muss, z. B. `/HelloWorld`.

5. Laden Sie wie folgt die Anwendungs- und Adapterartefakte hoch: 

    > **Wichtiger Hinweis:** Wenn Sie den Zielpfad für Anwendungen und Adapter angeben, müssen Sie sicherstellen, dass sich alle Anwendungen
und Adapter in demselben Verzeichnis befinden. Wenn ein Zielpfad beispielsweise **/opt/tmp/deploy/HelloWorld-common.json** lautet,
müssen alle anderen Zielpfade
`/opt/tmp/deploy/*` lauten.    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente **MFP
Server Application** oder **MFP Server Adapter**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie für das Feld **Zusätzliche
Datei** auf
die
Schaltfläche **Durchsuchen**, um das Anwendungs- oder Adapterartefakt zu finden und hochzuladen. 
    * Geben Sie im Feld **Zielpfad**
den vollständigen Pfad für das Speichern des Artefakts
(einschließlich des Dateinamens) an, z. B.
**/opt/tmp/deploy/HelloWorld-common.json**.
    * Wenn im Muster keine Anwendung oder kein Adapter implementiert werden soll, entfernen Sie die betreffende Komponente, indem Sie
auf die Schaltfläche
**X** klicken. Wenn Sie eine leere
{{ site.data.keys.mf_console }} ohne installierte App oder installierten Adapter implementieren
möchten, entfernen Sie die Komponente
"MFP Server Application Adapter Deployment", indem Sie auf die Schaltfläche
X klicken.  

6. Optional: Fügen Sie weitere Anwendungs- oder Adapterartefakte zur Implementierung hinzu. 
    * Blenden Sie in der Symbolleiste für **Assets** die Anzeige
für
**Softwarekomponenten** ein.
Ziehen Sie dann mit der Maus eine Komponente
**Additional File** auf den Knoten
"MobileFirst Platform Server" im Erstellungsbereich. Benennen Sie die Komponente
in **{{ site.data.keys.product_adj }} App\_X** oder **{{ site.data.keys.product_adj }} Adatper\_X** um. (Hier steht
das
**X** für eine eindeutige Zahl zur Unterscheidung.) 
    * Bewegen Sie den Cursor auf die neu hinzugefügte App- oder Adapterkomponente.
Klicken Sie dann auf die Schaltfläche
**Nach oben** bzw. **Nach unten**, um die Position in der Reihenfolge der Knotenkomponenten
anzupassen. Stellen Sie sicher, dass sich die Komponente hinter der Komponente "MFP Runtime Deployment", aber vor der
Komponente "MFP Server Application Adapter Deployment" befindet. 
    * Klicken Sie auf die neu hinzugefügte Anwendungs- oder Adapterkomponente. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt. Laden Sie das Anwendungs-
oder Adapterartefakt hoch und geben Sie den Zielpfad an. Beziehen Sie sich dabei auf die Teilschritte von Schritt 6. 
    * Wiederholen Sie Schritt 7, um weitere Anwendungen und Adapter zur Implementierung hinzuzufügen. 

7. Optional: Konfigurieren Sie die Anwendungs- und Adapterimplementierung in
{{ site.data.keys.mf_server }}. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Implementierungsberechtigung später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Falls Sie in Schritt 3 die Berechtigungsnachweise für den Standardbenutzer mit Administratorberechtigung angegeben haben, können Sie jetzt
den Implementierer angeben, dessen Berechtigungsnachweise an die des Benutzers mit Administratorberechtigung angeglichen werden müssen. 
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" die Komponente **MFP
Server Application Adapter Deployment** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Suchen Sie die Parameter **deployer_user** und **deployer_password**
und klicken Sie daneben jeweils
auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene
zu löschen. 
    * Geben Sie in den Feldern
**deployer\_user** und **deployer\_password**
den Benutzernamen und das Kennwort an. 

8. Konfigurieren Sie wie folgt die Basisskalierungsrichtlinie:
    * Klicken Sie im Dashboard von IBM PureApplication System auf **Muster → Muster für virtuelle Systeme**.
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld **Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus.
    * Klicken Sie in der Symbolleiste über dem Bereich mit den ausführlichen Informationen zum Muster auf die Schaltfläche **Implementieren**.
    * Wählen Sie im Fenster **Muster implementieren** im Bereich **Konfigurieren** das richtige **Umgebungsprofil** und weitere Umgebungsparameter für IBM PureApplication System aus. Kontaktieren Sie dazu Ihren Administrator für IBM PureApplication System.
    * Klicken Sie in der mittleren Spalte auf **Musterattribute**, um Attribute wie Benutzernamen und Kennwörter festzulegen.

        Machen Sie in den bereitgestellten Feldern die folgenden Angaben:
        
        > **Hinweis:** Ändern Sie die Standardwerte der Parameter auf Musterebene nach Bedarf, auch wenn ein externer LDAP-Server konfiguriert ist. Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren, müssen Sie zusätzliche LDAP-Informationen angeben (siehe [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).

        **Name des WebSphere-Benutzers mit Administratorberechtigung**  
        Benutzer-ID des Benutzers mit Administratorberechtigung für die Anmeldung bei der WebSphere-Administrationskonsole. Standardwert: virtuser.

        **WebSphere-Verwaltungskennwort**  
        Kennwort des Benutzers mit Administratorberechtigung für die Anmeldung bei der WebSphere-Administrationskonsole. Standardwert: passw0rd.
        
        **admin\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Erstellen Sie ein Standardadministratorkonto für {{ site.data.keys.mf_server }}. Standardwert: demo.
        
        **admin\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Er gibt das Kennwort für das Standardadministratorkonto an. Standardwert: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden möchten. Lassen Sie dieses Feld leer, wenn Sie zeitlich unbegrenzte Lizenzen verwenden.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres Rational License Key Server ein. Lassen Sie dieses Feld andernfalls leer.
        
        **LMGRD\_PORT**   
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (lmrgd) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Lizenzmanagerdämons ist 27000.

        **IBMRATL\_PORT**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (ibmratl) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Vendor Daemon ist 27001.

        **runtime\_contextRoot**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 5 konfiguriert wurde. Er gibt den Namen des Kontextstammverzeichnisses für die MobileFirst-Server-Laufzeit an. Der Name muss mit "/" beginnen.
        
        **deployer\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt den Benutzernamen für das Konto mit Implementierungsberechtigung an. Wenn kein externer LDAP-Server konfiguriert ist, müssen Sie den Wert eingeben, den Sie beim Erstellen des Standardbenutzers mit Administratorberechtigung für den Verwaltungsservice angegeben haben, weil in diesem Fall nur der für die App- und Adapterimplementierung autorisierte Benutzer der Standardbenutzer mit Administratorberechtigung ist.
        
        **deployer\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt das Kennwort des Benutzers mit Implementierungsberechtigung an.
        
        **MFP VMs Password (root)**  
        Rootkennwort für die Knoten "{{ site.data.keys.mf_server }}" und "{{ site.data.keys.product }} DB". Standardwert: passw0rd.
        
        **MFP DB Password (Instance owner)**  
        Kennwort des Instanzeigners für den Knoten "MobileFirst Platform DB". Standardwert: **passw0rd**.

        **Wichtige Einschränkung:**  
        Wenn Sie diese Attribute festlegen, ändern Sie nicht die folgenden Attribute im Abschnitt "{{ site.data.keys.mf_server }}":
        
        * Cell name
        * Node name
        * Profile name

        Wenn Sie eines dieser Attribute ändern, schlägt Ihre Musterimplementierung fehl.
    * Klicken Sie auf **Schnellimplementierung**, um Ihre Musterimplementierung zu starten. Nach einigen Sekunden wird eine Nachricht angezeigt, aus der hervorgeht, dass mit dem Start des Musters begonnen wurde. Sie können auf die URL in der Nachricht klicken, um den Status Ihrer Musterimplementierung zu verfolgen, oder zu **Muster → Instanzen eines virtuellen Systems** navigieren, um die Seite **Instanzen eines virtuellen Systems** zu öffnen und dort nach Ihrem Muster zu suchen.

9. Greifen Sie wie folgt auf die {{ site.data.keys.mf_console }} zu:
    * Klicken Sie auf **Muster → Instanzen eines virtuellen Systems**, um die Seite Instanzen eines virtuellen Systems zu öffnen und dort nach Ihrem Muster zu suchen. Stellen Sie sicher, dass der Status "Aktiv" lautet.
    * Wählen Sie den Musternamen aus und erweitern Sie im Bereich mit den Details der ausgewählten Instanz die Anzeige für die Option **Perspektive virtueller Maschine**.
    * Suchen Sie die virtuelle Maschine für {{ site.data.keys.mf_server }}, die einen Namen wie **MobileFirst\_Platform\_Server.*** hat, und notieren Sie die öffentliche IP-Adresse der Maschine. Sie benötigen diese Angabe im folgenden Schritt.
    * Öffnen Sie im Browser die {{ site.data.keys.mf_console }}, indem Sie die URL der Konsole in einem der folgenden Formate angeben:
        * `http://{öffentliche IP-Adresse der VM für MFP Server}:9080/mfpconsole`
        * `https://{öffentliche IP-Adresse der VM für MFP Server}:9443/mfpconsole`
    * Melden Sie sich bei der Konsole als Benutzer mit Administratorberechtigung mit dem entsprechenden Kennwort (angegeben in Schritt 3 oder 9) an.

## {{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren
{: #deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server }
Für die Implementierung
von {{ site.data.keys.mf_server }} auf mehreren Serverknoten mit
WebSphere Application Server Full
Profile verwenden Sie eine vordefinierte Schablone.

Im Rahmen dieses Prozesses werden Sie bestimmte
Artefakte in das IBM
PureApplication System
hochladen, z. B. die erforderliche Anwendung oder den erforderlichen Adapter. Stellen Sie vor Beginn sicher, dass die Artefakte zum Hochladen verfügbar sind.

**Voraussetzungen für die Tokenlizenzierung:** Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten, lesen Sie zunächst die Voraussetzungen unter [Voraussetzungen für die Tokenlizenzierung für die Tokenlizenzierung für
{{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) durch. Die Implementierung dieses Musters schlägt fehl,
wenn keine Verbindung zum License Key Server hergestellt werden kann oder nicht genug Token verfügbar sind. 

Einige Parameter von Scriptpaketen der Schablone sind mit den empfohlenen Werten konfiguriert und werden in diesem Abschnitt
nicht erwähnt. Weitere Informationen zu allen Parametern der Scriptpakete zum Zwecke der Optimierung finden Sie unter
[Scriptpakete für {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server). 

Weitere Informationen zur Zusammensetzung und zu den Konfigurationsoptionen der hier verwendeten vordefinierten Schablone
finden Sie unter
[Schablone '{{ site.data.keys.product }} (WAS Server Farm)'](#mobilefirst-foundation-was-server-farm-template). 

1. Erstellen Sie mit der vordefinierten Schablone ein Muster.
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. Die Seite "Muster für virtuelle Systeme" wird geöffnet.
    * Klicken Sie auf der Seite **Muster für virtuelle Systeme** auf **Neue
erstellen**. Wählen Sie dann im Popup-Fenster in der Liste der vordefinierten Schablonen
**MobileFirst
Platform (WAS Server Farm)** aus. Wenn der Name aufgrund seiner Länge nur teilweise sichtbar ist, können Sie sich vergewissern, dass Sie die richtige Schablone ausgewählt haben,
indem Sie sich die Beschreibung auf der Registerkarte
**Weitere
Informationen** ansehen. 
    * Geben Sie im Feld **Name** einen Namen für das Muster an.
    * Geben Sie im Feld **Version** die Versionsnummer des Musters an.
    * Klicken Sie auf **Erstellung starten**.
2. Obligatorisch für AIX: Auf IBM
PureApplication System
Power muss der Knoten "MobileFirst-Platform-Datenbank"
die AIX-spezifische Add-on-Komponente
"Default AIX Add Disk" anstelle der Komponente
"Default Add Disk" in der Schablone verwenden, damit das
jfs2-Dateisystem unterstützt wird. 
    * Wählen Sie im Erstellungsprogramm für Muster den Knoten
**MobileFirst-Platform-Datenbank**
aus. 
    * Klicken Sie auf die Schaltfläche **Komponenten-Add-on hinzufügen**.
(Die Schaltfläche wird über dem Komponentenfeld angezeigt, wenn Sie den Cursor auf den Knoten
**MobileFirst-Platform-Datenbank** bewegen.) 
    * Wählen Sie in der Liste **Add-ons hinzufügen**
den Eintrag **Default
AIX Add
Disk** aus.
Die Komponente wird als unterste Komponente des Knotens
"MobileFirst-Platform-Datenbank" hinzugefügt. 
    * Wählen Sie die Komponente **Default AIX Add
Disk** aus und geben Sie die folgenden Attribute an:
        * **DISK_SIZE_GB:** Speicherkapazität (in GB), die für den Datenbankserver hinzugefügt werden soll. Beispielwert: **10**.
        * **FILESYSTEM_TYPE:** Unterstütztes Dateisystem in AIX. Standardwert: **jfs2**. 
        * **MOUNT_POINT:** Gleichen Sie dieses Attribut an das Attribut **Mount
point for instance owner** der Komponente
"Database Server" des Knotens
"MobileFirst Platform DB" an. Beispielwert: **/dbinst**.
        * **VOLUME_GROUP:** Beispielwert: **group1**. Fragen Sie Ihren Administrator für IBM
PureApplication System
nach dem richtigen Wert. 
    * Wählen Sie auf dem Knoten "MobileFirst-Platform-Datenbank" die Komponente
**Default Add
Disk** aus und klicken Sie auf das Papierkorbsymbol,
um sie zu löschen. 
    * Speichern Sie das Muster.
3. Optional: Konfigurieren Sie die MobileFirst-Server-Verwaltung. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Administratorberechtigung für
{{ site.data.keys.mf_server }} später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Gehen Sie wie folgt vor, wenn Sie die Berechtigungsnachweise jetzt angeben möchten: 

    > **Hinweis:** Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren möchten, müssen Sie LDAP-Informationen
angeben (siehe
[{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Administration**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben den Feldern **admin_user**
und
**admin_password** auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene zu löschen. 
    * Geben Sie in den Feldern
**admin_user** und
**admin\_password** den Benutzernamen und das Kennwort des Benutzers mit Administratorberechtigung an.
    * Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten,
machen Sie in den folgenden Feldern Angaben. Lassen Sie diese Felder leer, wenn Sie keine Tokenlizenzierung anwenden. 

    **ACTIVATE\_TOKEN\_LICENSE**: Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden
möchten.  
    **LICENSE\_SERVER\_HOSTNAME**: Geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres
Rational License Key Server ein.  
    **LMGRD\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (**lmrgd**) auf eingehende Verbindungen wartet. Der Standardport des
Lizenzmanagerdämons ist 27000.  
    **IBMRATL\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (**ibmratl**) auf eingehende Verbindungen wartet. Der Standardport des
Vendor Daemon ist 27001.   

    Während der Musterimplementierung wird ein Standardverwaltungskonto
für {{ site.data.keys.mf_server }} erstellt.

4. Konfigurieren Sie die Implementierung der MobileFirst-Server-Laufzeit. Sie können diesen Schritt auslassen, wenn Sie den Namen des Kontextstammverzeichnisses für die Laufzeit
später
in Schritt 10 beim Konfigurieren der Musterimplementierung angeben möchten. Wenn Sie den Namen des Kontextstammverzeichnisses jetzt angeben möchten, führen Sie
die folgenden Schritte aus: 
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Runtime Deployment**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben dem Feld
**runtime\_contextRoot** auf die Schaltfläche **Löschen**, um die Parametereinstellung auf Musterebene zu löschen. 
    * Geben Sie im Feld
**runtime\_contextRoot** den Namen des Laufzeitkontextstammverzeichnisses
an.
Beachten Sie, dass der Name des Kontextstammverzeichnisses mit einem
Schrägstrich (/) beginnen muss, z. B. `/HelloWorld`.

5. Laden Sie wie folgt die Anwendungs- und Adapterartefakte hoch: 

    > **Wichtiger Hinweis:** Wenn Sie den Zielpfad für Anwendungen und Adapter angeben, müssen Sie sicherstellen, dass sich alle Anwendungen
und Adapter in demselben Verzeichnis befinden. Wenn ein Zielpfad beispielsweise **/opt/tmp/deploy/HelloWorld-common.json** lautet,
müssen alle anderen Zielpfade
`/opt/tmp/deploy/*` lauten.    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente **MFP
Server Application** oder **MFP Server Adapter**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie für das Feld **Zusätzliche
Datei** auf
die
Schaltfläche **Durchsuchen**, um das Anwendungs- oder Adapterartefakt zu finden und hochzuladen. 
    * Geben Sie im Feld **Zielpfad**
den vollständigen Pfad für das Speichern des Artefakts
(einschließlich des Dateinamens) an, z. B.
**/opt/tmp/deploy/HelloWorld-common.json**.
    * Wenn im Muster keine Anwendung oder kein Adapter implementiert werden soll, entfernen Sie die betreffende Komponente, indem Sie
auf die Schaltfläche
**X** klicken. Wenn Sie eine leere
{{ site.data.keys.mf_console }} ohne installierte App oder installierten Adapter implementieren
möchten, entfernen Sie die Komponente
"MFP Server Application Adapter Deployment", indem Sie auf die Schaltfläche
X klicken. 

6. Optional: Fügen Sie weitere Anwendungs- oder Adapterartefakte zur Implementierung hinzu. 
    * Blenden Sie in der Symbolleiste für **Assets** die Anzeige
für
**Softwarekomponenten** ein.
Ziehen Sie dann mit der Maus eine Komponente
**Additional File** auf den Knoten
"MobileFirst Platform Server" im Erstellungsbereich. Benennen Sie die Komponente
in **{{ site.data.keys.product_adj }} App\_X** oder **{{ site.data.keys.product_adj }} Adatper\_X** um. (Hier steht
das
**X** für eine eindeutige Zahl zur Unterscheidung.) 
    * Bewegen Sie den Cursor auf die neu hinzugefügte App- oder Adapterkomponente.
Klicken Sie dann auf die Schaltfläche
**Nach oben** bzw. **Nach unten**, um die Position in der Reihenfolge der Knotenkomponenten
anzupassen. Stellen Sie sicher, dass sich die Komponente hinter der Komponente "MFP Runtime Deployment", aber vor der
Komponente "MFP Server Application Adapter Deployment" befindet. 
    * Klicken Sie auf die neu hinzugefügte Anwendungs- oder Adapterkomponente. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt. Laden Sie das Anwendungs-
oder Adapterartefakt hoch und geben Sie den Zielpfad an. Beziehen Sie sich dabei auf die Teilschritte von Schritt 6. 
    * Wiederholen Sie Schritt 7, um weitere Anwendungen und Adapter zur Implementierung hinzuzufügen. 

7. Optional: Konfigurieren Sie die Anwendungs- und Adapterimplementierung in
{{ site.data.keys.mf_server }}. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Implementierungsberechtigung
später
in Schritt 10 beim Konfigurieren der Musterimplementierung angeben möchten. Falls Sie in Schritt 3 die Berechtigungsnachweise für den Standardbenutzer mit Administratorberechtigung angegeben haben, können Sie jetzt
den Implementierer angeben, dessen Berechtigungsnachweise an die des Benutzers mit Administratorberechtigung angeglichen werden müssen. 
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" die Komponente **MFP
Server Application Adapter Deployment** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Suchen Sie die Parameter **deployer_user** und **deployer_password**
und klicken Sie daneben jeweils
auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene
zu löschen. 
    * Geben Sie in den Feldern
**deployer\_user** und **deployer\_password**
den Benutzernamen und das Kennwort an. 

8. Konfigurieren Sie wie folgt die Basisskalierungsrichtlinie:
    * Wählen Sie auf dem Knoten **{{ site.data.keys.mf_server }}** die Komponente **Base Scaling Policy** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Geben Sie im Feld **Anzahl der Instanzen** die Anzahl der Serverknoten an, die während der Musterimplementierung instanziiert werden sollen. Der Standardwert der vordefinierten Schablone lautet 2. Da die dynamische Skalierung in diesem Release nicht unterstützt wird, geben Sie in den übrigen Attributfeldern keine Werte an.

9. Konfigurieren und starten Sie wie folgt die Musterimplementierung:
    * Klicken Sie im Dashboard von IBM PureApplication System auf **Muster → Muster für virtuelle Systeme**.
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld **Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus.
    * Klicken Sie in der Symbolleiste über dem Bereich mit den ausführlichen Informationen zum Muster auf die Schaltfläche Implementieren.
    * Wählen Sie im Fenster "Muster implementieren" im Bereich "Konfigurieren" in der Liste **Umgebungsprofil** das richtige Umgebungsprofil aus und geben Sie weitere Umgebungsparameter für IBM PureApplication System an. Die richtigen Angaben erfahren Sie von Ihrem Administrator für IBM PureApplication System.
    * Klicken Sie in der mittleren Spalte auf **Musterattribute**, um Attribute wie Benutzernamen und Kennwörter anzuzeigen.

        Machen Sie in den bereitgestellten Feldern die folgenden Angaben:

        > **Hinweis:** Ändern Sie die Standardwerte der Parameter auf Musterebene nach Bedarf, auch wenn ein externer
LDAP-Server konfiguriert ist. Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren, müssen Sie zusätzliche LDAP-Informationen
angeben (siehe
[{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).        
        **runtime_contextRoot_list**  
Namen der Kontextstammverzeichnisse der
MobileFirst-Server-Laufzeiten, falls es mehrere Laufzeiten gibt. Trennen Sie die einzelnen Laufzeitkontextstammverzeichnisse jeweils
durch ein Semikolon (;), z. B. **HelloMobileFirst;HelloWorld**. 

        **Wichtiger Hinweis:** Der Parameter **runtime_contextRoot_list** muss an das Kontextstammverzeichnis angeglichen werden, das auf dem Knoten "MFP-Server-Laufzeitimplementierung" angegeben ist. Andernfalls kann IHS Anforderungen, die das Laufzeitkontextstammverzeichnis enthalten, nicht weiterleiten.
        
        **Name des WebSphere-Benutzers mit Administratorberechtigung**  
        Benutzer-ID des Benutzers mit Administratorberechtigung für die Anmeldung bei der WebSphere-Administrationskonsole. Standardwert: virtuser.
        
        **WebSphere-Verwaltungskennwort**  
        Kennwort des Benutzers mit Administratorberechtigung für die Anmeldung bei der WebSphere-Administrationskonsole. Standardwert: passw0rd.

        **admin\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Erstellen Sie ein Standardadministratorkonto für {{ site.data.keys.mf_server }}. Standardwert: demo.
        
        **admin\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Er gibt das Kennwort für das Standardadministratorkonto an. Standardwert: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden möchten. Lassen Sie dieses Feld leer, wenn Sie zeitlich unbegrenzte Lizenzen verwenden.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres Rational License Key Server ein. Lassen Sie dieses Feld andernfalls leer.
        
        **LMGRD\_PORT**   
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (lmrgd) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Lizenzmanagerdämons ist 27000.

        **IBMRATL\_PORT**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (ibmratl) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Vendor Daemon ist 27001.

        **runtime\_contextRoot**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 5 konfiguriert wurde. Er gibt den Namen des Kontextstammverzeichnisses für die MobileFirst-Server-Laufzeit an. Der Name muss mit "/" beginnen.
        
        **deployer\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt den Benutzernamen für das Konto mit Implementierungsberechtigung an. Wenn kein externer LDAP-Server konfiguriert ist, müssen Sie den Wert eingeben, den Sie beim Erstellen des Standardbenutzers mit Administratorberechtigung für den Verwaltungsservice angegeben haben, weil in diesem Fall nur der für die App- und Adapterimplementierung autorisierte Benutzer der Standardbenutzer mit Administratorberechtigung ist.
        
        **deployer\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt das Kennwort des Benutzers mit Implementierungsberechtigung an.
        
        **MFP VMs Password (root)**  
        Rootkennwort für die Knoten "{{ site.data.keys.mf_server }}" und "{{ site.data.keys.product }} DB". Standardwert: passw0rd.
        
        **MFP DB Password (Instance owner)**  
        Kennwort des Instanzeigners für den Knoten "MobileFirst Platform DB". Standardwert: **passw0rd**.    
    * Klicken Sie auf **Schnellimplementierung**, um Ihre Musterimplementierung zu starten. Nach einigen Sekunden wird eine Nachricht angezeigt, aus der hervorgeht, dass mit dem Start des Musters begonnen wurde. Sie können auf die URL in der Nachricht klicken, um den Status Ihrer Musterimplementierung zu verfolgen, oder zu **Muster → Instanzen eines virtuellen Systems** navigieren, um die Seite "Instanzen eines virtuellen Systems" zu öffnen und dort nach Ihrem Muster zu suchen.

    Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung
verwenden, kann Ihre Musterimplementierung fehlschlagen, wenn nicht genug Lizenztoken verfügbar sind oder die
IP-Adresse und die Portnummer des License Key Server falsch eingegeben wurden. 
    
10. Greifen Sie wie folgt auf die {{ site.data.keys.mf_console }} zu:
    * Klicken Sie auf **Muster → Instanzen eines virtuellen Systems**, um die Seite Instanzen eines virtuellen Systems zu öffnen und dort nach Ihrem Muster zu suchen. Stellen Sie sicher, dass der Status "Aktiv" lautet.
    * Wählen Sie den Musternamen aus und erweitern Sie im Bereich mit den Details der ausgewählten Instanz die Anzeige für die Option **Perspektive virtueller Maschine**.
    * Finden Sie die virtuelle Maschine mit IHS, die einen ähnlichen Namen wie **IHS\_Server.***hat, und notieren Sie die öffentliche IP-Adresse der Maschine. Sie benötigen diese Angabe im nächsten Schritt.
    * Öffnen Sie im Browser die {{ site.data.keys.mf_console }}, indem Sie die URL der Konsole in einem der folgenden Formate angeben:
        * `http://{öffentliche IP-Adresse der VM für IHS}/mfpconsole`
        * `https://{öffentliche IP-Adresse der VM für IHS}/mfpconsole`
    * Melden Sie sich bei der Konsole als Benutzer mit Administratorberechtigung mit der entsprechenden Benutzer-ID und dem entsprechenden Kennwort (angegeben in Schritt 3 oder 10) an.

## {{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren
{: #deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers }
Für die Implementierung von {{ site.data.keys.mf_server }} in einem Server-Cluster mit WebSphere  Application Server Network Deployment verwenden Sie eine vordefinierte Schablone. Diese System-Pattern-Schablone bietet keine Unterstützung für die
Tokenlizenzierung. 

Im Rahmen dieses Prozesses werden Sie bestimmte
Artefakte in das IBM
PureApplication System
hochladen, z. B. die erforderliche Anwendung oder den erforderlichen Adapter. Stellen Sie vor Beginn sicher, dass die Artefakte zum Hochladen verfügbar sind.

Wenn Sie den gemeinsam genutzten Service System Monitoring für
WebSphere Application Server
verwenden, besteht die Möglichkeit, dass
die MobileFirst-Foundation-Laufzeitumgebung bei Implementierung des Musters
nicht ordnungsgemäß gestartet wird. Stoppen Sie nach Möglichkeit den gemeinsam genutzten Service, bevor Sie diese Prozedur fortsetzen. Falls Sie den gemeinsam genutzten Service
nicht stoppen können, müssen Sie unter Umständen
die MobileFirst-Foundation-Laufzeit
in der Administrationskonsole von WebSphere Application Server
neu starten, um das Problem zu lösen. Weitere Informationen
finden Sie unter [Einschränkung für die Synchronisation der
MobileFirst-Foundation-Laufzeit mit WebSphere Application Server Network Deployment](#mobilefirst-foundation-runtime-synchronization-limitation-with-websphere-application-server-network-deployment). 

**Wichtige Einschränkung bei Verwendung der Tokenlizenzierung:** Diese Musterschablone bietet keine Unterstützung für die
Tokenlizenzierung. Wenn Sie Muster implementieren, die auf der Musterschablone
"{{ site.data.keys.product }}
(WAS
ND)" basieren, müssen Sie zeitlich unbegrenzte Lizenzen verwenden. 

Einige Parameter von Scriptpaketen der Schablone sind mit empfohlenen Werten konfiguriert und werden in diesem Abschnitt
nicht erwähnt. Weitere Informationen zu allen Parametern der Scriptpakete zum Zwecke der Optimierung finden Sie unter
[Scriptpakete für {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server). 

Weitere Informationen zur Zusammensetzung und zu den Konfigurationsoptionen der hier verwendeten vordefinierten Schablone
finden Sie unter
[Schablone '{{ site.data.keys.product }} (WAS ND)'](#mobilefirst-foundation-was-nd-template). 

1. Erstellen Sie mit der vordefinierten Schablone ein Muster.
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. Die Seite "Muster für virtuelle Systeme" wird geöffnet.
    * Klicken Sie auf der Seite **Muster für virtuelle Systeme** auf **Neue
erstellen**. Wählen Sie dann im Popup-Fenster in der Liste der vordefinierten Schablonen
**MobileFirst
Platform (WAS ND)** aus. Wenn der Name aufgrund seiner Länge nur teilweise sichtbar ist, können Sie sich vergewissern, dass Sie die richtige Schablone ausgewählt haben,
indem Sie sich die Beschreibung auf der Registerkarte
**Weitere
Informationen** ansehen. 
    * Geben Sie im Feld **Name** einen Namen für das Muster an.
    * Geben Sie im Feld **Version** die Versionsnummer des Musters an.
    * Klicken Sie auf **Erstellung starten**.
2. Obligatorisch für AIX: Auf IBM
PureApplication System
Power muss der Knoten "MobileFirst-Platform-Datenbank"
die AIX-spezifische Add-on-Komponente
"Default AIX Add Disk" anstelle der Komponente
"Default Add Disk" in der Schablone verwenden, damit das
jfs2-Dateisystem unterstützt wird. 
    * Wählen Sie im Erstellungsprogramm für Muster den Knoten
**MobileFirst-Platform-Datenbank**
aus. 
    * Klicken Sie auf die Schaltfläche **Komponenten-Add-on hinzufügen**.
(Die Schaltfläche wird über dem Komponentenfeld angezeigt, wenn Sie den Cursor auf den Knoten
**MobileFirst-Platform-Datenbank** bewegen.) 
    * Wählen Sie in der Liste **Add-ons hinzufügen**
den Eintrag **Default
AIX Add
Disk** aus.
Die Komponente wird als unterste Komponente des Knotens
"MobileFirst-Platform-Datenbank" hinzugefügt. 
    * Wählen Sie die Komponente **Default AIX Add
Disk** aus und geben Sie die folgenden Attribute an:
        * **DISK_SIZE_GB:** Speicherkapazität (in GB), die für den Datenbankserver hinzugefügt werden soll. Beispielwert: **10**.
        * **FILESYSTEM_TYPE:** Unterstütztes Dateisystem in AIX. Standardwert: **jfs2**. 
        * **MOUNT_POINT:** Gleichen Sie dieses Attribut an das Attribut **Mount
point for instance owner** der Komponente
"Database Server" des Knotens
"MobileFirst Platform DB" an. Beispielwert: **/dbinst**.
        * **VOLUME_GROUP:** Beispielwert: **group1**. Fragen Sie Ihren Administrator für IBM
PureApplication System
nach dem richtigen Wert. 
    * Wählen Sie auf dem Knoten "MobileFirst-Platform-Datenbank" die Komponente
**Default Add
Disk** aus und klicken Sie auf das Papierkorbsymbol,
um sie zu löschen. 
    * Speichern Sie das Muster.
3. Optional: Konfigurieren Sie die MobileFirst-Server-Verwaltung. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Administratorberechtigung für
{{ site.data.keys.mf_server }} später
in Schritt 9 beim Konfigurieren der Musterimplementierung angeben möchten.
Gehen Sie wie folgt vor, wenn Sie die Berechtigungsnachweise jetzt angeben möchten: 

    > **Hinweis:** Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren möchten, müssen Sie LDAP-Informationen
angeben (siehe
[{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Administration**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben den Feldern **admin_user**
und
**admin_password** auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene zu löschen. 
    * Geben Sie in den Feldern
**admin_user** und
**admin\_password** den Benutzernamen und das Kennwort des Benutzers mit Administratorberechtigung an.
    * Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten,
machen Sie in den folgenden Feldern Angaben. Lassen Sie diese Felder leer, wenn Sie keine Tokenlizenzierung anwenden. 

    **ACTIVATE\_TOKEN\_LICENSE**: Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden
möchten.  
    **LICENSE\_SERVER\_HOSTNAME**: Geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres
Rational License Key Server ein.  
    **LMGRD\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (**lmrgd**) auf eingehende Verbindungen wartet. Der Standardport des
Lizenzmanagerdämons ist 27000.  
    **IBMRATL\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (**ibmratl**) auf eingehende Verbindungen wartet. Der Standardport des
Vendor Daemon ist 27001.   

    Während der Musterimplementierung wird ein Standardverwaltungskonto
für {{ site.data.keys.mf_server }} erstellt.

4. Konfigurieren Sie die Implementierung der MobileFirst-Server-Laufzeit. Sie können diesen Schritt auslassen, wenn Sie den Namen des Kontextstammverzeichnisses für die Laufzeit
später
in Schritt 10 beim Konfigurieren der Musterimplementierung angeben möchten. Wenn Sie den Namen des Kontextstammverzeichnisses jetzt angeben möchten, führen Sie
die folgenden Schritte aus: 
    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente
**MFP Server Runtime Deployment**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben dem Feld
**runtime\_contextRoot** auf die Schaltfläche **Löschen**, um die Parametereinstellung auf Musterebene zu löschen. 
    * Geben Sie im Feld
**runtime\_contextRoot** den Namen des Laufzeitkontextstammverzeichnisses
an.
Beachten Sie, dass der Name des Kontextstammverzeichnisses mit einem
Schrägstrich (/) beginnen muss, z. B. `/HelloWorld`.

5. Optional: Passen Sie die Anzahl der Anwendungsserverknoten
in Ihren Clustern mit WebSphere Application Server Network Deployment
an die {{ site.data.keys.product_adj }}-Verwaltungskomponente
und die MobileFirst-Foundation-Laufzeitumgebung an. 

    Sowohl die Verwaltungskomponente als auch die Laufzeitumgebung hat in ihrem jeweiligen Cluster zwei Anwendungsserverknoten. 
    * Klicken Sie auf dem Knoten DmgrNode auf die Komponente **MFP Server Administration**. Neben dem Erstellungsbereich werden die Eigenschaften der Komponente angezeigt.
    * Geben Sie im Feld **NUMBER\_OF\_CLUSTERMEMBERS** für Ihren Cluster mit
WebSphere Application Server Network Deployment
die gewünschte Anzahl Anwendungsserverknoten für
die {{ site.data.keys.product_adj }}-Verwaltungskomponente an. 
    * Klicken Sie auf dem Knoten DmgrNode auf die Komponente **MFP Server Runtime Deployment**. Neben dem Erstellungsbereich werden die Eigenschaften der Komponente angezeigt.
    * Geben Sie im Feld **NUMBER\_OF\_CLUSTERMEMBERS** für Ihren Cluster mit
WebSphere Application Server Network Deployment
die gewünschte Anzahl Anwendungsserverknoten für
die MobileFirst-Foundation-Laufzeitumgebung an. 
    * Klicken Sie auf dem Knoten CustomNode auf die Komponente **Base Scaling Policy**. 
    * Passen Sie den Wert für **Anzahl der Instanzen** an die Gesamtzahl der
Anwendungsserverknoten an, die Sie für die einzelnen Komponenten im Feld
**NUMBER\_OF\_CLUSTERMEMBERS**
angegeben haben. Der Mindestwert für **Anzahl der Instanzen** ist die Gesamtzahl der Serverknoten für die
{{ site.data.keys.product_adj }}-Verwaltungskomponente
und die {{ site.data.keys.product }}-Laufzeitumgebungen. 

    Für die Standardtopologie mit zwei Knoten für die Verwaltungskomponente und zwei Knoten für die
Laufzeitumgebung liegt der Standardwert für **Anzahl der Instanzen** beispielsweise
bei
4. Wenn Sie den Wert
von **NUMBER\_OF\_CLUSTERMEMBERS** für die Verwaltungskomponente
in
3 ändern und für die
Laufzeitumgebung in 5, ist der Mindestwert für die
Anzahl der Instanzen 8.

6. Laden Sie wie folgt die Anwendungs- und Adapterartefakte hoch: 

    > **Wichtiger Hinweis:** Wenn Sie den Zielpfad für Anwendungen und Adapter angeben, müssen Sie sicherstellen, dass sich alle Anwendungen
und Adapter in demselben Verzeichnis befinden. Wenn ein Zielpfad beispielsweise **/opt/tmp/deploy/HelloWorld-common.json** lautet,
müssen alle anderen Zielpfade
`/opt/tmp/deploy/*` lauten.    * Klicken Sie auf dem Knoten "MobileFirst Platform Server" auf die Komponente **MFP
Server Application** oder **MFP Server Adapter**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie für das Feld **Zusätzliche
Datei** auf
die
Schaltfläche **Durchsuchen**, um das Anwendungs- oder Adapterartefakt zu finden und hochzuladen. 
    * Geben Sie im Feld **Zielpfad**
den vollständigen Pfad für das Speichern des Artefakts
(einschließlich des Dateinamens) an, z. B.
**/opt/tmp/deploy/HelloWorld-common.json**.
    * Wenn im Muster keine Anwendung oder kein Adapter implementiert werden soll, entfernen Sie die betreffende Komponente, indem Sie
auf die Schaltfläche
**X** klicken. Wenn Sie eine leere
{{ site.data.keys.mf_console }} ohne installierte App oder installierten Adapter implementieren
möchten, entfernen Sie die Komponente
"MFP Server Application Adapter Deployment", indem Sie auf die Schaltfläche
X klicken. 

7. Optional: Fügen Sie weitere Anwendungs- oder Adapterartefakte zur Implementierung hinzu. 
    * Blenden Sie in der Symbolleiste für **Komponenten** die Anzeige
für
**Softwarekomponenten** ein.
Ziehen Sie dann mit der Maus eine Komponente
**Additional File** auf den Knoten
"MobileFirst Platform Server" im Erstellungsbereich. Benennen Sie die Komponente
in **{{ site.data.keys.product_adj }} App\_X** oder **{{ site.data.keys.product_adj }} Adatper\_X** um. (Hier steht
das
**X** für eine eindeutige Zahl zur Unterscheidung.) 
    * Bewegen Sie den Cursor auf die neu hinzugefügte App- oder Adapterkomponente.
Klicken Sie dann auf die Schaltfläche
**Nach oben** bzw. **Nach unten**, um die Position in der Reihenfolge der Knotenkomponenten
anzupassen. Stellen Sie sicher, dass sich die Komponente hinter der Komponente "MFP Runtime Deployment", aber vor der
Komponente "MFP Server Application Adapter Deployment" befindet. 
    * Klicken Sie auf die neu hinzugefügte Anwendungs- oder Adapterkomponente. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt. Laden Sie das Anwendungs-
oder Adapterartefakt hoch und geben Sie den Zielpfad an. Beziehen Sie sich dabei auf die Teilschritte von Schritt 6. 
    * Klicken Sie für das Feld **Zusätzliche
Datei** auf
die
Schaltfläche **Durchsuchen**, um das Anwendungs- oder Adapterartefakt zu finden und hochzuladen. 
    * Geben Sie im Feld **Zielpfad**
den vollständigen Pfad für das Speichern des Artefakts, einschließlich des Dateinamens, an. Beispiel: **/opt/tmp/deploy/HelloWorld-common.wlapp**

    Wiederholen Sie diesen Schritt, um weitere Anwendungen und Adapter zur Implementierung hinzuzufügen. 

8. Optional: Konfigurieren Sie die Anwendungs- und Adapterimplementierung in
{{ site.data.keys.mf_server }}. Sie können diesen Schritt auslassen, wenn Sie die Berechtigungsnachweise des Benutzers mit Implementierungsberechtigung
später
in Schritt 10 beim Konfigurieren der Musterimplementierung angeben möchten. Falls Sie in Schritt 3 die Berechtigungsnachweise für den Standardbenutzer mit Administratorberechtigung angegeben haben, können Sie jetzt
den Implementierer angeben, dessen Berechtigungsnachweise an die des Benutzers mit Administratorberechtigung angeglichen werden müssen. 
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" die Komponente **MFP
Server Application Adapter Deployment** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Suchen Sie die Parameter **deployer_user** und **deployer_password**
und klicken Sie daneben jeweils
auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene
zu löschen. 
    * Geben Sie in den Feldern
**deployer\_user** und **deployer\_password**
den Benutzernamen und das Kennwort an. 

9. Konfigurieren Sie wie folgt die Basisskalierungsrichtlinie:
    * Klicken Sie im Dashboard von IBM PureApplication System auf **Muster → Muster für virtuelle Systeme**.
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld **Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus.
    * Klicken Sie in der Symbolleiste über dem Bereich mit den ausführlichen Informationen zum Muster auf die Schaltfläche **Implementieren**.
    * Wählen Sie im Fenster **Muster implementieren** im Bereich **Konfigurieren** das richtige **Umgebungsprofil** und weitere Umgebungsparameter für IBM PureApplication System aus. Kontaktieren Sie dazu Ihren Administrator für IBM PureApplication System.
    * Klicken Sie in der mittleren Spalte auf **Musterattribute**, um Attribute wie Benutzernamen und Kennwörter festzulegen.

        Machen Sie in den bereitgestellten Feldern die folgenden Angaben:
        
        > **Hinweis:** Ändern Sie die Standardwerte der Parameter auf Musterebene nach Bedarf, auch wenn ein externer LDAP-Server konfiguriert ist. Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren, müssen Sie zusätzliche LDAP-Informationen angeben (siehe [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).

        **Name des WebSphere-Benutzers mit Administratorberechtigung**  
        Benutzer-ID des Benutzers mit Administratorberechtigung für die Anmeldung bei der WebSphere-Administrationskonsole. Standardwert: virtuser.

        **WebSphere-Verwaltungskennwort**  
        Kennwort des Benutzers mit Administratorberechtigung für die Anmeldung bei der WebSphere-Administrationskonsole. Standardwert: passw0rd.
        
        **admin\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Erstellen Sie ein Standardadministratorkonto für {{ site.data.keys.mf_server }}. Standardwert: demo.
        
        **admin\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Er gibt das Kennwort für das Standardadministratorkonto an. Standardwert: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden möchten. Lassen Sie dieses Feld leer, wenn Sie zeitlich unbegrenzte Lizenzen verwenden.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres Rational License Key Server ein. Lassen Sie dieses Feld andernfalls leer.
        
        **LMGRD\_PORT**   
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (lmrgd) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Lizenzmanagerdämons ist 27000.

        **IBMRATL\_PORT**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (ibmratl) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Vendor Daemon ist 27001.

        **runtime\_contextRoot**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 5 konfiguriert wurde. Er gibt den Namen des Kontextstammverzeichnisses für die MobileFirst-Server-Laufzeit an. Der Name muss mit "/" beginnen.
        
        **deployer\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt den Benutzernamen für das Konto mit Implementierungsberechtigung an. Wenn kein externer LDAP-Server konfiguriert ist, müssen Sie den Wert eingeben, den Sie beim Erstellen des Standardbenutzers mit Administratorberechtigung für den Verwaltungsservice angegeben haben, weil in diesem Fall nur der für die App- und Adapterimplementierung autorisierte Benutzer der Standardbenutzer mit Administratorberechtigung ist.
        
        **deployer\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt das Kennwort des Benutzers mit Implementierungsberechtigung an.
        
        **MFP VMs Password (root)**  
        Rootkennwort für die Knoten "{{ site.data.keys.mf_server }}" und "{{ site.data.keys.product }} DB". Standardwert: passw0rd.
        
        **MFP VMs Password(virtuser)**  
        Kennwort des Benutzers virtuser für die Knoten DmgrNode, CustomNode, IHSNode und "{{ site.data.keys.product }} DB". Standardwert: passw0rd.
        
        **Open Firewall Ports for WAS**  
Die auf den CustomNode-VM-Knoten implementierten WebSphere-Application-Server-Knoten
benötigen offene Firewallports, damit sie eine Verbindung zum Datenbankserver und (bei entsprechender Konfiguration) zum
LDAP-Server herstellen können. Wenn Sie mehrere Portnummern angeben müssen, trennen Sie sie jeweils durch ein
Semikolon (;), z. B.
50000;636. Der Standardwert ist 50000 (Standardport für
DB2 Server).

        **Wichtige Einschränkung:**  
        Wenn Sie diese Attribute festlegen, ändern Sie nicht die folgenden Attribute im Abschnitt "{{ site.data.keys.mf_server }}":
        
        * Cell name
        * Node name
        * Profile name

        Wenn Sie eines dieser Attribute ändern, schlägt Ihre Musterimplementierung fehl.
    * Klicken Sie auf **Schnellimplementierung**, um Ihre Musterimplementierung zu starten. Nach einigen Sekunden wird eine Nachricht angezeigt, aus der hervorgeht, dass mit dem Start des Musters begonnen wurde. Sie können auf die URL in der Nachricht klicken, um den Status Ihrer Musterimplementierung zu verfolgen, oder zu **Muster → Instanzen eines virtuellen Systems** navigieren, um die Seite **Instanzen eines virtuellen Systems** zu öffnen und dort nach Ihrem Muster zu suchen.

10. Greifen Sie wie folgt auf die {{ site.data.keys.mf_console }} zu:
    * Klicken Sie auf **Muster → Instanzen eines virtuellen Systems**, um die Seite Instanzen eines virtuellen Systems zu öffnen und dort nach Ihrem Muster zu suchen. Stellen Sie sicher, dass der Status "Aktiv" lautet.
    * Wählen Sie den Musternamen aus und erweitern Sie im Bereich mit den Details der ausgewählten Instanz die Anzeige für die Option **Perspektive virtueller Maschine**.
    * Suchen Sie die virtuelle Maschine für {{ site.data.keys.mf_server }}, die einen Namen wie **MobileFirst\_Platform\_Server.*** hat, und notieren Sie die öffentliche IP-Adresse der Maschine. Sie benötigen diese Angabe im folgenden Schritt.
    * Öffnen Sie im Browser die {{ site.data.keys.mf_console }}, indem Sie die URL der Konsole in einem der folgenden Formate angeben:
        * `http://{öffentliche IP-Adresse der VM für MFP Server}:9080/mfpconsole`
        * `https://{öffentliche IP-Adresse der VM für MFP Server}:9443/mfpconsole`
    * Melden Sie sich bei der Konsole als Benutzer mit Administratorberechtigung mit dem entsprechenden Kennwort (angegeben in Schritt 3 oder 9) an.

    Wenn die
MobileFirst-Foundation-Laufzeiten nicht in der
Konsole angezeigt werden,
starten Sie den MobileFirst-Foundation-Laufzeitknoten
erneut in der Administrationskonsole von WebSphere Application Server. Anweisungen für das erneute
Starten des Laufzeitknotens in der Administrationskonsole finden Sie unter
[MobileFirst-Foundation-Laufzeit in der Administrationskonsole von WebSphere Application Server neu starten](#restarting-the-mobilefirst-foundation-runtime-from-the-websphere-application-server-administrative-console). 

### Einschränkung für die Synchronisation der MobileFirst-Foundation-Laufzeit mit WebSphere Application Server Network Deployment
{: #mobilefirst-foundation-runtime-synchronization-limitation-with-websphere-application-server-network-deployment }
Wenn Sie ein auf der Schablone "{{ site.data.keys.product }} (WAS ND)" basierendes PureApplication-Muster
mplementieren und den gemeinsam genutzten Service System Monitoring für
WebSphere Application Server
verwenden, besteht die Möglichkeit, dass
die MobileFirst-Foundation-Laufzeitumgebung bei Implementierung des Musters
nicht ordnungsgemäß gestartet wird. 

Ein auf der Schablone "{{ site.data.keys.product }} (WAS ND)" basierendes PureApplication-Muster für virtuelle Systeme
implementiert den  {{ site.data.keys.product_adj }}-Verwaltungsservice
und die MobileFirst-Foundation-Laufzeit in unterschiedlichen Clustern mit
WebSphere Application Server Network Deployment. Die
MobileFirst-Foundation-Laufzeit funktioniert nur ordnungsgemäß, wenn sie nach dem
{{ site.data.keys.product_adj }}-Verwaltungsservice
gestartet wird. Wird die MobileFirst-Foundation-Laufzeit zuerst gestartet, kann der Laufzeitservice den
{{ site.data.keys.product_adj }}-Verwaltungsservice nicht finden. Dies führt zu Fehlern im Laufzeitservice. 

Wenn die Implementierung eines
PureApplication-Musters fast abgeschlossen ist,
startet der gemeinsam genutzte Service System Monitoring für
WebSphere Application Server
alle mit dem Muster implementierten WebSphere-Application-Server-Knoten neu. Der Neustart der Knoten erfolgt in zufälliger Reihenfolge, sodass die Knoten mit
der
MobileFirst-Foundation-Laufzeit vor den Knoten mit dem
{{ site.data.keys.product_adj }}-Verwaltungsservice gestartet werden könnten. 

Sie müssen vor der Implementierung des Musters den gemeinsam genutzten Service
"System Monitoring für WebSphere Application Server"
stoppen. Falls Sie den gemeinsam genutzten Service
nicht stoppen können, müssen Sie unter Umständen
die MobileFirst-Foundation-Laufzeit
in der Administrationskonsole von WebSphere Application Server
neu starten, um das Problem zu lösen. 

### MobileFirst-Foundation-Laufzeit in der Administrationskonsole von WebSphere Application Server-Administrationskonsole neu starten
{: #restarting-the-mobilefirst-foundation-runtime-from-the-websphere-application-server-administrative-console }
Wenn Ihre
{{ site.data.keys.mf_console }} nach der Implementierung eines auf der Schablone "{{ site.data.keys.product }} (WAS ND)" basierenden
PureApplication-System-Musters leer ist, kann ein Neustart der
MobileFirst-Foundation-Laufzeit in der Administrationskonsole von
WebSphere Application Server
erforderlich sein. 

Diese Prozedur ist nur anwendbar, wenn Sie auf der Schablone "{{ site.data.keys.product }} (WAS ND)" basierende PureApplication-Muster
implementieren und den gemeinsam genutzten Service System Monitoring für
WebSphere Application Server
verwenden. Wenn Sie diesen gemeinsam genutzten Service nicht verwenden oder ein auf einer anderen Schablone basierendes Muster implementieren, gilt diese Prozedur nicht für Sie. 

Sie müssen Ihr Muster implementieren, bevor
Sie diese Prozedur ausführen. 

Die Knoten mit dem
{{ site.data.keys.product_adj }}-Verwaltungsservice
müssen vor den MobileFirst-Foundation-Laufzeitknoten gestartet werden, damit sie ordnungsgemäß funktionieren. Wenn bei Implementierung eines Musters
der gemeinsam genutzte Service System Monitoring für WebSphere Application Server
aktiv ist, startet dieser Service alle mit dem Muster implementierten WebSphere-Application-Server-Knoten neu. Da der Neustart der Knoten in zufälliger Reihenfolge erfolgt, können die Knoten mit
der
MobileFirst-Foundation-Laufzeit vor den Knoten mit dem
{{ site.data.keys.product_adj }}-Verwaltungsservice gestartet werden. 

1. Vergewissern Sie sich, dass der gemeinsam genutzte Service
System Monitoring für WebSphere Application Server
implementiert und aktiv ist. 
    * Klicken Sie im Dashboard von PureApplication System
auf Muster und dann unter Musterinstanzen auf
Gemeinsam genutzte Services.

        > **Wichtiger Hinweis:** "Gemeinsam genutzte Services" erscheint zweimal im Menü
**Muster**. Achten Sie darauf, dass Sie unter **Musterinstanzen** und nicht unter
"Muster" auf **Gemeinsam genutzte Services** klicken.
    * Suchen Sie auf der Seite **Gemeinsam genutzte Serviceinstanzen** nach einem Namen der mit
**System Monitoring for WebSphere Application Server** beginnt. Klicken Sie auf den Namen, um den zugehörigen Eintrag einzublenden. 
    
        Wenn Sie keinen Eintrag für **System Monitoring for WebSphere Application Server** sehen
ist der gemeinsam genutzte Service
System Monitoring für WebSphere Application Server nicht implementiert. Fahren Sie in dem Fall nicht mit dieser
Prozedur fort. 
    * Überprüfen Sie für den Service die Spalte **Status**. 
    
        Wenn unter **Status** die Angabe
`Gestoppt` erscheint, ist der gemeinsam genutzte Service
System Monitoring für WebSphere Application Server gestoppt. Sie müssen in dem Fall nicht mit dieser
Prozedur fortfahren.   
Wenn unter **Status** die Angabe
`Gestartet` zu sehen ist, ist der gemeinsam genutzte Service
System Monitoring für WebSphere Application Server aktiv. Fahren Sie mit der hier beschriebenen Prozedur fort. 

2. Vergewissern Sie sich, dass Ihr Muster aktiv ist.
Greifen Sie im Dashboard von
PureApplication System auf die
{{ site.data.keys.mf_console }} zu. 

    Anweisungen für den Zugriff auf die
{{ site.data.keys.mf_console }} über das Dashboard von
PureApplication System
finden Sie in Schritt 10
unter [{{ site.data.keys.mf_server }} auf Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers). 
    
3. Wenn die Konsole leer erscheint oder die
MobileFirst-Foundation-Laufzeiten nicht
anzeigt,
starten Sie den MobileFirst-Foundation-Laufzeitknoten
erneut in der Administrationskonsole von WebSphere Application Server. 
    * Klicken Sie im Dashboard von **PureApplication System**
auf
**Muster → Instanzen des virtuellen Systems**.
    * Suchen Sie auf der Seite **Instanzen des virtuellen Systems** Ihre Musterinstanz und vergewissern Sie sich, dass die Instanz aktiv ist. Wenn sie nicht aktiv ist, starten Sie sie. 
    * Klicken Sie in der Detailanzeige auf den Namen Ihrer Musterinstanz und suchen Sie den Abschnitt
**Perspektive virtueller Maschine**. 
    * Suchen Sie im Abschnitt **Perspektive virtueller Maschine** die VM, deren Name mit
**DmgrNode** beginnt. Notieren Sie sich die öffentliche Adresse dieser VM. 
    * Öffnen Sie die Administrationskonsole von WebSphere Application Server mit folgender URL: 
    
        ```bash
        https://{öffentliche IP-Adresse der VM für DmgrNode Server}:9043/ibm/console
        ```
    
        Verwenden Sie die Benutzer-ID und das Kennwort,
die Sie bei der Implementierung des Musters für die Administrationskonsole
von WebSphere Application Server angegeben haben. 
    * Erweitern Sie in der Administrationskonsole von WebSphere Application Server
die Anzeige für
**Anewndungen** und klicken Sie auf **Alle Anwendungen**. 
    * Starten Sie die MobileFirst-Foundation-Laufzeit neu. 
        * Wählen Sie in der Liste der Anwendungen die Anwendung aus, deren Name mit
IBM\_Worklight\_project\_runtime\_MFP beginnt.
        * Wählen Sie in der Spalte **Aktion** den Eintrag **Stoppen** aus.
        * Klicken Sie auf **Aktion übergeben**.
        * Warten Sie, bis in der Spalte **Status** der Anwendungsstatus mit dem Symbol für "Gestoppt" angezeigt wird. 
        * Wählen Sie in der Spalte **Aktion** den Eintrag **Starten** aus.
        * Klicken Sie auf **Aktion übergeben**.

        Wiederholen Sie diesen Schritt für jede MobileFirst-Foundation-Laufzeitanwendung in der Liste. 

4. Greifen Sie erneut auf die
{{ site.data.keys.mf_console }} zu und vergewissern Sie sich,
dass Ihre MobileFirst-Foundation-Laufzeiten sichtbar sind. 

## {{ site.data.keys.mf_app_center }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren
{: #deploying-mobilefirst-application-center-on-a-single-node-websphere-application-server-liberty-profile-server }
Für die Implementierung
von {{ site.data.keys.mf_app_center }} auf einem einzelnen Serverknoten mit
WebSphere Application Server Liberty
Profile verwenden Sie eine vordefinierte Schablone.

Im Rahmen dieses Prozesses werden Sie bestimmte
Artefakte in das IBM
PureApplication System
hochladen, z. B. die erforderliche Anwendung oder den erforderlichen Adapter. Stellen Sie vor Beginn sicher, dass die Artefakte zum Hochladen verfügbar sind.

**Voraussetzungen für die Tokenlizenzierung:** Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten, lesen Sie zunächst die Voraussetzungen unter [Voraussetzungen für die Tokenlizenzierung für die Tokenlizenzierung für
{{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) durch. Die Implementierung dieses Musters schlägt fehl,
wenn keine Verbindung zum License Key Server hergestellt werden kann oder nicht genug Token verfügbar sind. 

Einige Parameter von Scriptpaketen der Schablone sind mit den empfohlenen Werten konfiguriert und werden hier
nicht erwähnt. Weitere Informationen zu allen Parametern der Scriptpakete zum Zwecke der Optimierung finden Sie unter
[Scriptpakete für {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server). 

Weitere Informationen zur Zusammensetzung und zu den Konfigurationsoptionen der hier verwendeten vordefinierten Schablone
finden Sie unter
[Schablone '{{ site.data.keys.mf_app_center }} (Liberty Single Node)'](#mobilefirst-application-center-liberty-single-node-template). 

1. Erstellen Sie mit der vordefinierten Schablone ein Muster.
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. Die Seite "Muster für virtuelle Systeme" wird geöffnet.
    * Klicken Sie auf der Seite **Muster für virtuelle Systeme** auf **Neue
erstellen**. Wählen Sie dann im Popup-Fenster in der Liste der vordefinierten Schablonen
**MobileFirst
Platform (AppCenter Liberty Single Node)** aus. Wenn der Name aufgrund seiner Länge nur teilweise sichtbar ist, können Sie sich vergewissern, dass Sie die richtige Schablone ausgewählt haben,
indem Sie sich die Beschreibung auf der Registerkarte
**Weitere
Informationen** ansehen. 
    * Geben Sie im Feld **Name** einen Namen für das Muster an.
    * Geben Sie im Feld **Version** die Versionsnummer des Musters an.
    * Klicken Sie auf **Erstellung starten**.
2. Obligatorisch für AIX: Auf IBM
PureApplication System
Power muss der Knoten "MobileFirst-Platform-Datenbank"
die AIX-spezifische Add-on-Komponente
"Default AIX Add Disk" anstelle der Komponente
"Default Add Disk" in der Schablone verwenden, damit das
jfs2-Dateisystem unterstützt wird. 
    * Wählen Sie im Erstellungsprogramm für Muster den Knoten
**MobileFirst-Platform-Datenbank**
aus. 
    * Klicken Sie auf die Schaltfläche **Komponenten-Add-on hinzufügen**.
(Die Schaltfläche wird über dem Komponentenfeld angezeigt, wenn Sie den Cursor auf den Knoten
**MobileFirst-Platform-Datenbank** bewegen.) 
    * Wählen Sie in der Liste **Add-ons hinzufügen**
den Eintrag **Default
AIX Add
Disk** aus.
Die Komponente wird als unterste Komponente des Knotens
"MobileFirst-Platform-Datenbank" hinzugefügt. 
    * Wählen Sie die Komponente **Default AIX Add
Disk** aus und geben Sie die folgenden Attribute an:
        * **DISK_SIZE_GB:** Speicherkapazität (in GB), die für den Datenbankserver hinzugefügt werden soll. Beispielwert: **10**.
        * **FILESYSTEM_TYPE:** Unterstütztes Dateisystem in AIX. Standardwert: **jfs2**. 
        * **MOUNT_POINT:** Gleichen Sie dieses Attribut an das Attribut **Mount
point for instance owner** der Komponente
"Database Server" des Knotens
"MobileFirst Platform DB" an. Beispielwert: **/dbinst**.
        * **VOLUME_GROUP:** Beispielwert: **group1**. Fragen Sie Ihren Administrator für IBM
PureApplication System
nach dem richtigen Wert. 
    * Wählen Sie auf dem Knoten "MFP AppCenter DB" die Komponente
**Default Add
Disk** aus und klicken Sie auf das Papierkorbsymbol,
um sie zu löschen. 
    * Speichern Sie das Muster.
3. Optional: Konfigurieren Sie **MFP
Server Application Center** auf dem Knoten **MFP AppCenter Server**. 
    
    > **Hinweis:** Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren möchten, müssen Sie LDAP-Informationen
angeben (siehe
[{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
    * Klicken Sie auf dem Knoten **MFP AppCenter Server** auf die Komponente **MFP Server Application Center**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben den Feldern **admin_user**
und
**admin_password** auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene zu löschen. 
    * Geben Sie in den Feldern
**admin_user** und
**admin_password** den Benutzernamen und das Kennwort des Benutzers mit Administratorberechtigung an.
    * Klicken Sie neben den Feldern **db_user**
und
**db_password** auf die Schaltfläche
**Löschen**, um die Parametereinstellungen auf Musterebene zu löschen. 
    * Geben Sie in den Feldern
**db_user** und
**db_password** den Namen und das Kennwort des Datenbankbenutzers an. 
    * Geben Sie in den Feldern **db_name**, **db_instance**,
**db_ip** und **db_port** den Benutzernamen und das Kennwort des Datenbankbenutzers, den Instanznamen, die IP-Adresse und die
Portnummer an. 

    Während der Musterimplementierung wird ein Standardverwaltungskonto
für {{ site.data.keys.mf_server }} erstellt.

4. Konfigurieren und starten Sie wie folgt die Musterimplementierung:
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. 
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld
**Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus. 
    * Klicken Sie in der Symbolleiste über dem Bereich mit den ausführlichen Informationen zum Muster
auf die Schaltfläche **Implementieren**. 
    * Wählen Sie im Fenster **Muster implementieren** im Bereich **Konfigurieren** in der
Liste **Umgebungsprofil** das richtige Umgebungsprofil aus und geben Sie weitere Umgebungsparameter für
IBM PureApplication System
an. Die richtigen Angaben erfahren Sie von Ihrem Administrator für
IBM PureApplication System. 
    * Klicken Sie in der mittleren Spalte auf Musterattribute,
um Attribute wie Benutzernamen und Kennwörter anzuzeigen.

    Machen Sie in den bereitgestellten Feldern die folgenden Angaben:

    > **Hinweis:** Ändern Sie die Standardwerte der Parameter auf Musterebene nach Bedarf, auch wenn ein externer LDAP-Server konfiguriert ist. Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren, müssen Sie zusätzliche LDAP-Informationen angeben (siehe [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
    
    **admin\_user**  
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Erstellen Sie ein Standardadministratorkonto für {{ site.data.keys.mf_server }}. Standardwert: demo.
    
    **admin\_password**  
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Er gibt das Kennwort für das Standardadministratorkonto an. Standardwert: demo.
    
    **ACTIVATE\_TOKEN\_LICENSE**  
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden möchten. Lassen Sie dieses Feld leer, wenn Sie zeitlich unbegrenzte Lizenzen verwenden.
    
    **LICENSE\_SERVER\_HOSTNAME**  
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres Rational License Key Server ein. Lassen Sie dieses Feld andernfalls leer.
    
    **LMGRD\_PORT**   
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (lmrgd) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Lizenzmanagerdämons ist 27000.

    **IBMRATL\_PORT**  
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (ibmratl) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Vendor Daemon ist 27001.

    **runtime\_contextRoot**  
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 5 konfiguriert wurde. Er gibt den Namen des Kontextstammverzeichnisses für die MobileFirst-Server-Laufzeit an. Der Name muss mit "/" beginnen.
    
    **deployer\_user**  
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt den Benutzernamen für das Konto mit Implementierungsberechtigung an. Wenn kein externer LDAP-Server konfiguriert ist, müssen Sie den Wert eingeben, den Sie beim Erstellen des Standardbenutzers mit Administratorberechtigung für den Verwaltungsservice angegeben haben, weil in diesem Fall nur der für die App- und Adapterimplementierung autorisierte Benutzer der Standardbenutzer mit Administratorberechtigung ist.
    
    **deployer\_password**  
    Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt das Kennwort des Benutzers mit Implementierungsberechtigung an.
    
    **MFP VMs Password (root)**  
    Rootkennwort für die Knoten "{{ site.data.keys.mf_server }}" und "{{ site.data.keys.product }} DB". Standardwert: passw0rd.
    
    **MFP DB Password (Instance owner)**  
    Kennwort des Instanzeigners für den Knoten "MobileFirst Platform DB". Standardwert: **passw0rd**.    
* Klicken Sie auf **Schnellimplementierung**, um Ihre Musterimplementierung zu starten. Nach einigen Sekunden wird eine Nachricht angezeigt, aus der hervorgeht, dass mit dem Start des Musters begonnen wurde. Sie können auf die URL in der Nachricht klicken, um den Status Ihrer Musterimplementierung zu verfolgen, oder zu **Muster → Instanzen eines virtuellen Systems** navigieren, um die Seite "Instanzen eines virtuellen Systems" zu öffnen und dort nach Ihrem Muster zu suchen.

5. Gehen Sie für den Zugriff auf die {{ site.data.keys.mf_console }} wie folgt vor: 
    * Klicken Sie auf **Muster → Instanzen eines virtuellen Systems**, um die Seite **Instanzen eines virtuellen Systems** zu öffnen und dort nach Ihrem Muster zu suchen.
    * Wählen Sie Ihren Musternamen aus und erweitern Sie im Bereich mit den Details der ausgewählten Instanz die Anzeige für die "Perspektive virtueller Maschine".
    * Suchen Sie die virtuelle Maschine für {{ site.data.keys.mf_server }}, die einen Namen wie **MFP\_AppCenter\_Server.*** hat, und notieren Sie die öffentliche IP-Adresse der Maschine.
    * Öffnen Sie im Browser die {{ site.data.keys.mf_console }}, indem Sie die URL der Konsole in einem der folgenden Formate angeben:
        * `http://{öffentliche IP-Adresse der VM für MFP Server}:9080/appcenterconsole`
        * `https://{öffentliche IP-Adresse der VM für MFP Server}:9443/appcenterconsole`
    * Melden Sie sich bei der Konsole als Benutzer mit Administratorberechtigung mit dem entsprechenden Kennwort (angegeben in Schritt 3) an. 

## {{ site.data.keys.mf_app_center }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren
{: #deploying-mobilefirst-application-center-on-a-single-node-websphere-application-server-full-profile-server }
Für die Implementierung
des {{ site.data.keys.mf_app_center }} auf einem einzelnen Serverknoten mit
WebSphere Application Server Full Profile
verwenden Sie eine vordefinierte Schablone. 

Im Rahmen dieses Prozesses werden Sie bestimmte
Artefakte in das IBM
PureApplication System
hochladen, z. B. die erforderliche Anwendung oder den erforderlichen Adapter. Stellen Sie vor Beginn sicher, dass die Artefakte zum Hochladen verfügbar sind.

**Voraussetzungen für die Tokenlizenzierung:** Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten, lesen Sie zunächst die Voraussetzungen unter [Voraussetzungen für die Tokenlizenzierung für die Tokenlizenzierung für
{{ site.data.keys.mf_system_pattern }}](#token-licensing-requirements-for-mobilefirst-system-pattern) durch. Die Implementierung dieses Musters schlägt fehl,
wenn keine Verbindung zum License Key Server hergestellt werden kann oder nicht genug Token verfügbar sind. 

Einige Parameter von Scriptpaketen der Schablone sind mit den empfohlenen Werten konfiguriert und werden in diesem Abschnitt
nicht erwähnt. Weitere Informationen zu allen Parametern der Scriptpakete zum Zwecke der Optimierung finden Sie unter
[Scriptpakete für {{ site.data.keys.mf_server }}](#script-packages-for-mobilefirst-server). 

Weitere Informationen zur Zusammensetzung und zu den Konfigurationsoptionen der hier verwendeten vordefinierten Schablone
finden Sie unter
[Schablone '{{ site.data.keys.mf_app_center }} (WAS Single Node)'](#mobilefirst-application-center-was-single-node-template). 

1. Erstellen Sie mit der vordefinierten Schablone ein Muster.
    * Klicken Sie im Dashboard von **IBM PureApplication System** auf **Muster → Muster für virtuelle Systeme**. Die Seite "Muster für virtuelle Systeme" wird geöffnet.
    * Klicken Sie auf der Seite **Muster für virtuelle Systeme** auf **Neue
erstellen**. Wählen Sie dann im Popup-Fenster in der Liste der vordefinierten Schablonen
**MobileFirst
Platform (AppCenter Liberty Single Node)** aus. Wenn der Name aufgrund seiner Länge nur teilweise sichtbar ist, können Sie sich vergewissern, dass Sie die richtige Schablone ausgewählt haben,
indem Sie sich die Beschreibung auf der Registerkarte
Weitere
Informationen ansehen. 
    * Geben Sie im Feld **Name** einen Namen für das Muster an.
    * Geben Sie im Feld **Version** die Versionsnummer des Musters an.
    * Klicken Sie auf **Erstellung starten**.
2. Obligatorisch für AIX: Auf IBM
PureApplication System
Power muss der Knoten "MobileFirst-Platform-Datenbank"
die AIX-spezifische Add-on-Komponente
"Default AIX Add Disk" anstelle der Komponente
"Default Add Disk" in der Schablone verwenden, damit das
**jfs2**-Dateisystem unterstützt wird. 
    * Wählen Sie im Erstellungsprogramm für Muster den Knoten
**MFP AppCenter DB**
aus. 
    * Klicken Sie auf die Schaltfläche **Komponenten-Add-on hinzufügen**.
(Die Schaltfläche wird über dem Komponentenfeld angezeigt, wenn Sie den Cursor auf den Knoten **MFP AppCenter DB** bewegen.) 
    * Wählen Sie in der Liste Add-ons hinzufügen
den Eintrag **Default
AIX Add Disk** aus.
Die Komponente wird als unterste Komponente des Knotens
"MobileFirst-Platform-Datenbank" hinzugefügt. 
    * Wählen Sie die Komponente **Default AIX Add
Disk** aus und geben Sie die folgenden Attribute an:
        
        **DISK\_SIZE\_GB**  
        Speicherkapazität (in GB), die für den Datenbankserver hinzugefügt werden soll. Beispielwert: 10.

        **FILESYSTEM\_TYPE**  
Unterstütztes Dateisystem in AIX.
Standardwert: **jfs2**. 

        **MOUNT\_POINT**  
Gleichen Sie dieses Attribut an das Attribut **Mount
point for instance owner** der Komponente
"Database Server" des Knotens
"MobileFirst-Platform-Datenbank" an.
Beispielwert: /dbinst.

        **VOLUME\_GROUP**  
Beispielwert: **group1**. Fragen Sie Ihren Administrator für IBM
PureApplication System
nach dem richtigen Wert. 
    * Wählen Sie auf dem Knoten **MFP AppCenter DB** die Komponente
**Default Add
Disk** aus und klicken Sie auf das Papierkorbsymbol,
um sie zu löschen. 
    * Speichern Sie das Muster.

3. Optional: Konfigurieren Sie **MFP
Server Application Center** auf dem Knoten **MFP AppCenter Server**. 

    > **Hinweis:** Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren möchten, müssen Sie LDAP-Informationen
angeben (siehe
[{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
    * Klicken Sie auf dem Knoten **MFP AppCenter Server** auf die Komponente **MFP Server Administration**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Klicken Sie neben den Feldern **admin_user**
und
**admin_password** auf die Schaltfläche Löschen, um die Parametereinstellungen auf Musterebene zu löschen. 
    * Geben Sie in den Feldern
**admin_user** und
**admin\_password** den Benutzernamen und das Kennwort des Benutzers mit Administratorberechtigung an.
    * Wenn Sie für die
{{ site.data.keys.product }} die Tokenlizenzierung verwenden möchten,
machen Sie in den folgenden Feldern Angaben. Lassen Sie diese Felder leer, wenn Sie keine Tokenlizenzierung anwenden. 

    **ACTIVATE\_TOKEN\_LICENSE**: Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden
möchten.  
    **LICENSE\_SERVER\_HOSTNAME**: Geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres
Rational License Key Server ein.  
    **LMGRD\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (**lmrgd**) auf eingehende Verbindungen wartet. Der Standardport des
Lizenzmanagerdämons ist 27000.  
    **IBMRATL\_PORT**: Geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (**ibmratl**) auf eingehende Verbindungen wartet. Der Standardport des
Vendor Daemon ist 27001.   

    Während der Musterimplementierung wird ein Standardverwaltungskonto
für {{ site.data.keys.mf_server }} erstellt.

4. Konfigurieren und starten Sie wie folgt die Musterimplementierung:
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. 
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld
**Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus. 
    * Klicken Sie in der Symbolleiste über dem Bereich mit den ausführlichen Informationen zum Muster
auf die Schaltfläche Implementieren. 
    * Wählen Sie im Fenster "Muster implementieren" im Bereich "Konfigurieren" in der
Liste **Umgebungsprofil** das richtige Umgebungsprofil aus und geben Sie weitere Umgebungsparameter für
IBM PureApplication System
an. Die richtigen Angaben erfahren Sie von Ihrem Administrator für
IBM PureApplication System. 
    * Klicken Sie in der mittleren Spalte auf **Musterattribute**,
um Attribute wie Benutzernamen und Kennwörter anzuzeigen.

        Machen Sie in den bereitgestellten Feldern die folgenden Angaben:

        > **Hinweis:** Ändern Sie die Standardwerte der Parameter auf Musterebene nach Bedarf, auch wenn ein externer LDAP-Server konfiguriert ist. Wenn Sie für die Verwaltungssicherheit einen LDAP-Server konfigurieren, müssen Sie zusätzliche LDAP-Informationen angeben (siehe [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einer externen LDAP-Registry konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)).
        
        **admin\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Erstellen Sie ein Standardadministratorkonto für {{ site.data.keys.mf_server }}. Standardwert: demo.
        
        **admin\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Er gibt das Kennwort für das Standardadministratorkonto an. Standardwert: demo.
        
        **ACTIVATE\_TOKEN\_LICENSE**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wählen Sie dieses Feld aus, wenn Sie für Ihr Muster die Tokenlizenzierung verwenden möchten. Lassen Sie dieses Feld leer, wenn Sie zeitlich unbegrenzte Lizenzen verwenden.
        
        **LICENSE\_SERVER\_HOSTNAME**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie den vollständig qualifizierten Hostnamen oder die IP-Adresse Ihres Rational License Key Server ein. Lassen Sie dieses Feld andernfalls leer.
        
        **LMGRD\_PORT**   
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Lizenzmanagerdämon (lmrgd) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Lizenzmanagerdämons ist 27000.

        **IBMRATL\_PORT**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 3 konfiguriert wurde. Wenn Sie für die {{ site.data.keys.product }} die Tokenlizenzierung verwenden, geben Sie die Nummer des Ports ein, an dem der Vendor Daemon (ibmratl) auf eingehende Verbindungen wartet. Lassen Sie dieses Feld andernfalls leer. Der Standardport des Vendor Daemon ist 27001.

        **runtime\_contextRoot**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 5 konfiguriert wurde. Er gibt den Namen des Kontextstammverzeichnisses für die MobileFirst-Server-Laufzeit an. Der Name muss mit "/" beginnen.
        
        **deployer\_user**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt den Benutzernamen für das Konto mit Implementierungsberechtigung an. Wenn kein externer LDAP-Server konfiguriert ist, müssen Sie den Wert eingeben, den Sie beim Erstellen des Standardbenutzers mit Administratorberechtigung für den Verwaltungsservice angegeben haben, weil in diesem Fall nur der für die App- und Adapterimplementierung autorisierte Benutzer der Standardbenutzer mit Administratorberechtigung ist.
        
        **deployer\_password**  
        Dieser Parameter ist nicht sichtbar, wenn er bereits in Schritt 8 konfiguriert wurde. Er gibt das Kennwort des Benutzers mit Implementierungsberechtigung an.
        
        **MFP VMs Password (root)**  
        Rootkennwort für die Knoten "{{ site.data.keys.mf_server }}" und "{{ site.data.keys.product }} DB". Standardwert: passw0rd.
        
        **MFP DB Password (Instance owner)**  
        Kennwort des Instanzeigners für den Knoten "MobileFirst Platform DB". Standardwert: **passw0rd**.    
    * Klicken Sie auf **Schnellimplementierung**, um Ihre Musterimplementierung zu starten. Nach einigen Sekunden wird eine Nachricht angezeigt, aus der hervorgeht, dass mit dem Start des Musters begonnen wurde. Sie können auf die URL in der Nachricht klicken, um den Status Ihrer Musterimplementierung zu verfolgen, oder zu **Muster → Instanzen eines virtuellen Systems** navigieren, um die Seite "Instanzen eines virtuellen Systems" zu öffnen und dort nach Ihrem Muster zu suchen.

5. Gehen Sie für den Zugriff auf die {{ site.data.keys.mf_console }} wie folgt vor: 
    * Klicken Sie auf **Muster → Instanzen eines virtuellen Systems**, um die Seite Instanzen eines virtuellen Systems zu öffnen und dort nach Ihrem Muster zu suchen.
    * Wählen Sie Ihren Musternamen aus und erweitern Sie im Bereich mit den Details der ausgewählten Instanz die Anzeige für die "Perspektive virtueller Maschine".
    * Suchen Sie die virtuelle Maschine für {{ site.data.keys.mf_server }}, die einen Namen wie **MFP\_AppCenter\_Server.*** hat, und notieren Sie die öffentliche IP-Adresse der Maschine.
    * Öffnen Sie im Browser die {{ site.data.keys.mf_console }}, indem Sie die URL der Konsole in einem der folgenden Formate angeben:
        * `http://{öffentliche IP-Adresse der VM für MFP Server}:9080/appcenterconsole`
        * `https://{öffentliche IP-Adresse der VM für MFP Server}:9443/appcenterconsole`
    * Melden Sie sich bei der Konsole als Benutzer mit Administratorberechtigung mit dem entsprechenden Kennwort (angegeben in Schritt 3) an. 

## {{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einem externen LDAP-Repository konfigurieren
{: #configuring-mobilefirst-administration-security-with-an-external-ldap-repository }
Sie können die {{ site.data.keys.product_adj }}-Verwaltungssicherheit
konfigurieren, um eine Verbindung zu einem externen LDAP-Repository zu ermöglichen. Die Konfiguration für WebSphere Application Server Liberty Profile
und Full Profile ist dieselbe.

Im Rahmen dieser Prozedur werden die LDAP-Parameter für die Verbindung zum Server mit der externen Benutzerregistry
konfiguriert. Stellen Sie zu Beginn sicher, dass der LDAP-Server
arbeitet. Fordern Sie bei Ihrem LDAP-Administrator die erforderlichen Konfigurationsdaten an. 

**Wichtiger Hinweis:**  
Wenn die LDAP-Repository-Konfiguration aktiviert ist,
wird nicht automatisch ein Standardbenutzer für
die MobileFirst-Verwaltung erstellt.
Sie müssen stattdessen den Benutzernamen und das Kennwort des im LDAP-Repository gespeicherten Benutzers mit Administratorberechtigung angeben. Diese Angaben sind für
WebSphere Application Server Liberty Profile
und eine Server-Farm mit
WebSphere Application Server Full Profile erforderlich. 

Wenn die im Muster zu implementierende Laufzeit so konfiguriert ist, dass für die Anwendungsauthentifizierung LDAP verwendet wird,
stellen Sie sicher, dass der in der Laufzeit konfigurierte LDAP-Server der
für die MobileFirst-Verwaltung konfigurierte LDAP-Server ist. Ein anderer LDAP-Server wird nicht unterstützt. Protokoll und Port für die LDAP-Verbindung müssen auch identisch sein. Wenn beispielsweise
Verbindungen von der Laufzeit zum LDAP-Server für die Verwendung des SSL-Protokolls und des Ports 636 konfiguriert sind,
müssen Verbindungen von der
MobileFirst-Verwaltung zum LDAP-Server auch das SSL-Protokoll und den Port
636
verwenden. 

1. Erstellen Sie ein Muster mit einer benötigten Topologie. Weitere Informationen finden Sie in den folgenden Artikeln:
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server)
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server)
    * [{{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)
2. Obligatorisch für AIX: Auf IBM
PureApplication System
Power muss der Knoten "MobileFirst-Platform-Datenbank"
die AIX-spezifische Add-on-Komponente
"Default AIX Add Disk" anstelle der Komponente
"Default Add Disk" in der Schablone verwenden, damit das
jfs2-Dateisystem unterstützt wird. 
    * Wählen Sie im **Erstellungsprogramm für Muster** den Knoten
**MobileFirst-Platform-Datenbank**
aus. 
    * Klicken Sie auf die Schaltfläche **Komponenten-Add-on hinzufügen**.
(Die Schaltfläche wird über dem Komponentenfeld angezeigt, wenn Sie den Cursor auf den Knoten
**MobileFirst-Platform-Datenbank** bewegen.) 
    * Wählen Sie in der Liste **Add-ons hinzufügen**
den Eintrag **Default
AIX Add
Disk** aus.
Die Komponente wird als unterste Komponente des Knotens
"MobileFirst-Platform-Datenbank" hinzugefügt. 
    * Wählen Sie die Komponente **Default AIX Add
Disk** aus und geben Sie die folgenden Attribute an:

        **DISK\_SIZE\_GB**  
        Speicherkapazität (in GB), die für den Datenbankserver hinzugefügt werden soll. Beispielwert: 10.
        
        **FILESYSTEM\_TYPE**  
Unterstütztes Dateisystem in AIX.
Standardwert: jfs2. 
        
        **MOUNT\_POINT**  
Gleichen Sie dieses Attribut an das Attribut **Mount
point for instance owner** der Komponente
**Database Server** des Knotens **MobileFirst Platform DB** an.
Beispielwert: `/dbinst`.
        
        **VOLUME\_GROUP**  
Beispielwert: `group1`. Fragen Sie Ihren Administrator für IBM
PureApplication System
nach dem richtigen Wert. 
    * Wählen Sie auf dem Knoten "MobileFirst-Platform-Datenbank" die Komponente
Default Add
Disk aus und klicken Sie auf das Papierkorbsymbol,
um sie zu löschen. 
    * Speichern Sie das Muster.

3. Konfigurieren Sie die MobileFirst-Server-Verwaltung: 
    * Klicken Sie im Dashboard von IBM PureApplication System auf **Muster → Muster für virtuelle Systeme**. Die Seite "Muster für virtuelle Systeme" wird geöffnet.
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld
**Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus. Klicken Sie dann auf **Öffnen**, um die Seite **Erstellungsprogramm für Muster** zu öffnen.
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" (oder dem Knoten "DmgrNode", wenn Sie die Schablone "{{ site.data.keys.product }} (WAS ND)" verwenden)
die Komponente
MFP Server Administration aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Machen Sie in den bereitgestellten Feldern die folgenden Angaben zu LDAP:

    **admin_user**  
Benutzer-ID des Kontos mit Administratorberechtigung
für {{ site.data.keys.mf_server }}. Dieser Wert wird im LDAP-Repository gespeichert. Der Parameter ist nicht erforderlich, wenn {{ site.data.keys.mf_server }} auf einem Einzelknoten mit WebSphere Application Server Full Profile implementiert werden soll.
    
    **admin_password**  
Kennwort des Benutzers mit Administratorberechtigung. Dieser Wert wird im LDAP-Repository
gespeichert. Der Parameter ist nicht erforderlich, wenn {{ site.data.keys.mf_server }} auf einem Einzelknoten mit WebSphere Application Server Full Profile implementiert werden soll.
    
    **LDAP_TYPE**  
    LDAP-Servertyp Ihrer Benutzerregistry. Gültige Werte:  
    --- **None**  
    Die LDAP-Verbindung ist inaktiviert. Wenn dieser Wert festgelegt ist, werden alle anderen LDAP-Parameter nur als Platzhalter betrachtet.  
    --- **TivoliDirectoryServer**  
    Wählen Sie diesen Wert aus, wenn IBM Tivoli Directory Server als LDAP-Repository verwendet wird.  
    --- **ActiveDirectory**  
    Wählen Sie diesen Wert aus, wenn Microsoft Active Directory als LDAP-Repository verwendet wird.  
    Standardwert: None.
    
    **LDAP_IP**  
    IP-Adresse des LDAP-Servers
    
    **LDAP_SSL_PORT**  
    LDAP-Port für sichere Verbindungen
    
    **LDAP_PORT**  
    LDAP-Port für nicht gesicherte Verbindungen
    
    **BASE_DN**  
    Basis-DN
    
    **BIND_DN**  
    Bindungs-DN
    
    **BIND_PASSWORD**  
    Bindungs-DN-Kennwort
    
    **REQUIRE_SSL**  
    Wählen Sie true für eine sichere Verbindung zum LDAP-Server aus. Der Standardwert ist false.
    
    **USER_FILTER**  
    LDAP-Benutzerfilter, mit dem die vorhandene Benutzerregistry nach Benutzern durchsucht wird
    
    **GROUP_FILTER**  
    LDAP-Gruppenfilter, mit dem die vorhandene Benutzerregistry nach Gruppen durchsucht wird
    
    **LDAP\_REPOSITORY\_NAME**  
    Name des LDAP-Servers
    
    **CERT\_FILE\_PATH**  
    Zielpfad für das hochgeladene LDAP-Serverzertifikat
    
    **mfpadmin**  
    Verwaltungsrolle für {{ site.data.keys.mf_server }}. Gültige Werte:
    --- **None**  
    Kein Benutzer  
    --- **AllAuthenticatedUsers**  
    Authentifizierte Benutzer  
    --- **Everyone**  
    Alle Benutzer  
        
    Standardwert: None. Weitere Informationen zu Sicherheitsrollen finden Sie unter [Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren](../../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).
    
    **mfpdeployer**  
    Implementiererrolle für {{ site.data.keys.mf_server }}. Gültige Werte:
    --- **None**  
    Kein Benutzer  
    --- **AllAuthenticatedUsers**  
    Authentifizierte Benutzer  
    --- **Everyone**  
    Alle Benutzer
    
    Standardwert: None. Weitere Informationen zu Sicherheitsrollen finden Sie unter [Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren](../../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).
    
    **mfpmonitor**  
    Monitorrolle für {{ site.data.keys.mf_server }}. Gültige Werte:    
    --- **None**  
    Kein Benutzer  
    --- **AllAuthenticatedUsers**  
    Authentifizierte Benutzer     
    --- **Everyone**  
    Alle Benutzer
    
    Standardwert: None. Weitere Informationen zu Sicherheitsrollen finden Sie unter [Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren](../../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).
    
    **mfpoperator**  
    Operatorrolle für {{ site.data.keys.mf_server }}. Gültige Werte:
    --- **None**  
    Kein Benutzer  
    --- **AllAuthenticatedUsers**  
    Authentifizierte Benutzer  
    --- **Everyone**  
    Alle Benutzer

    Standardwert: None. Weitere Informationen zu Sicherheitsrollen finden Sie unter [Benutzerauthentifizierung für die MobileFirst-Server-Verwaltung konfigurieren](../../../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).

4. Optional: Konfigurieren Sie die LDAP-SSL-Verbindung. Dieser Schritt ist nur erforderlich, wenn Sie **REQUIRE_SSL** im vorherigen Schritt auf true gesetzt haben, um sichere Verbindungen zum LDAP-Server zu verwenden.
    * Blenden Sie in der Symbolleiste für **Assets** die Anzeige für **Softwarekomponenten** ein. Ziehen Sie dann mit der Maus eine Komponente **Additional File** auf den Knoten "MobileFirst Platform Server" im Erstellungsbereich. Benennen Sie die Komponente beispielsweise in "MobileFirst LDAP Cert" um.
    * Bewegen Sie den Cursor auf die neu hinzugefügte Komponente. Klicken Sie dann auf die Schaltfläche **Nach oben** bzw. **Nach unten**, um die Position der Komponente auf dem Knoten anzupassen. Sie muss sich zwischen der Komponente **MFP Server Prerequisite** und der Komponente **MFP Server Administration** befinden.
    * Klicken Sie auf die Komponente **MobileFirst LDAP Cert**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt. Klicken Sie für das Feld **Zusätzliche Datei** auf die Schaltfläche **Durchsuchen**, um das LDAP-Zertifizierungsartefakt zu finden und hochzuladen.
    * Geben Sie im Feld **Zielpfad** den vollständigen Pfad für das Speichern des Artefakts (einschließlich des Dateinamens) an, z. B. **/opt/tmp/tdscert.der**.
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" (oder dem Knoten "DmgrNode", wenn Sie die Schablone "{{ site.data.keys.product }} (WebSphere Application Server Network Deployment)" verwenden) die Komponente MFP Server Administration aus und klicken Sie neben dem Feld **CERT\_FILE\_PATH** auf die Schaltfläche **Referenz hinzufügen**. Klicken Sie im Popup-Fenster auf das Register **Parameter auf Komponentenebene**. Wählen Sie in der Liste Komponente die Komponente **MobileFirst LDAP Cert** aus. Wählen Sie in der Liste **Ausgabeattribut** den Eintrag **target\_path** aus. Klicken Sie auf die Schaltfläche **Hinzufügen**, um die Anzeige im Feld **Ausgabewert** zu aktualisieren. Klicken Sie dann auf **OK**.

5. Konfigurieren und starten Sie die Musterimplementierung. Auf der Seite "Muster implementieren" können Sie in der Liste "Knoten" Ihre LDAP-Konfigurationen anpassen. Klicken Sie dazu auf **MobileFirst Server** (oder **DmgrNode**, wenn Sie die Schablone "{{ site.data.keys.product }} (WAS ND)" verwenden) und erweitern Sie die Anzeige für **MFP Server Administration**. Weitere Informationen zur Musterimplementierung enthält der Schritt "Musterimplementierung konfigurieren und starten" in den folgenden Abschnitten. Lesen Sie den Abschnitt für die Topologie, die Sie beim Erstellen des Musters ausgewählt haben:
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server), Schritt 8
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server), Schritt 9
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server), Schritt 8
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server), Schritt 9
    * [{{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers), Schritt 9 und folgende

6. Greifen Sie auf die {{ site.data.keys.mf_console }} zu. Geben Sie den Namen und das Kennwort des Benutzers mit Administratorberechtigung an, um sich über Ihre LDAP-Konfiguration
bei der
{{ site.data.keys.mf_console }} anzumelden. Weitere Informationen enthält der Schritt "Zugriff auf die
{{ site.data.keys.mf_console }}" in den folgenden Abschnitten.
Lesen Sie den Abschnitt für die Topologie, die Sie beim Erstellen des Musters ausgewählt haben:

    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server), Schritt 9
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server), Schritt 10
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server), Schritt 9
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server), Schritt 10
    * [{{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers), Schritt 10 und folgende

## Externe Datenbank mit {{ site.data.keys.mf_system_pattern }} konfigurieren
{: #configuring-an-external-database-with-a-mobilefirst-system-pattern }
Sie können {{ site.data.keys.mf_system_pattern }}
so konfigurieren, dass eine Verbindung zu einer externen Datenbank hergestellt werden kann. IBM DB2 ist die einzige unterstützte externe
Datenbank. Die Konfiguration ist für alle unterstützten Muster einheitlich. 

**Vorbereitungen:**
Im Rahmen dieser Prozedur werden die Parameter der externen Datenbank für die Verbindung zur externen Datenbank konfiguriert. Führen Sie zu Beginn die folgenden Schritte aus:

* Konfigurieren Sie die externe Datenbankinstanz in Ihrer IBM DB2-Installation.
* Notieren Sie den Namen der Datenbankinstanz, den Namen des Datenbankbenutzers, das Datenbankkennwort, den Namen oder die IP-Adresse des Datenbankhosts und den Port der Datenbankinstanz.

1. Erstellen Sie ein Muster mit einer benötigten Topologie. Weitere Informationen enthalten die folgenden Artikel:
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server)
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server)
    * [{{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)

2. Wählen Sie **MobileFirst Platform DB** aus und klicken Sie auf **Remove component**.
3. Konfigurieren Sie die MobileFirst-Server-Verwaltung: 
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. Die Seite **Muster für virtuelle Systeme** wird geöffnet. 
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld
**Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus. Klicken Sie dann auf **Öffnen**, um die Seite **Erstellungsprogramm für Muster** zu öffnen.
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" (oder dem Knoten "DmgrNode", wenn Sie die Schablone "{{ site.data.keys.product }} (WAS ND)" verwenden)
die Komponente **MFP Server Administration** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Wählen Sie die Option **USE\_EXTERNAL\_DATABASE** aus und konfigurieren Sie die folgenden Parameter: 

        **db_instance**  
Name der externen Datenbankinstanz
        
        **db_user**  
Benutzername für die externe Datenbank
        
        **db_name**  
Name der externen Datenbank
        
        **db_password**  
Kennwort für die externe Datenbank 
        
        **db_ip**  
IP-Adresse der externen Datenbank
        
        **db_port**  
Portnummer der externen Datenbank 
        
        > **Hinweis:** Wenn Sie die Musterschablone "{{ site.data.keys.product }}
(WAS ND)" verwenden, müssen Sie für die Portnummer der externen Datenbank zusätzlich das Attribut **Open
firewall ports for WAS** konfigurieren.     * Wählen Sie auf dem Knoten "MobileFirst Platform Server" (oder dem Knoten "DmgrNode", wenn Sie die Schablone "{{ site.data.keys.product }} (WAS ND)" verwenden)
die Komponente **MFP Server Runtime Deployment** aus. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt.
    * Konfigurieren Sie unter **USE\_EXTERNAL\_DATABASE** die folgenden Parameter: 

        **rtdb_instance**  
Name der externen Datenbankinstanz
        
        **rtdb_user**  
Benutzername für die externe Laufzeitdatenbank
        
        **rtdb_name**  
Name der externen Laufzeitdatenbank, der erstellt wird
        
        **rtdb_password**
        Kennwort für die externe Laufzeitdatenbank 

## {{ site.data.keys.mf_analytics }} implementieren und konfigurieren
{: #deploying-and-configuring-mobilefirst-analytics }
Wenn Sie die Analysefeatures im Muster aktivieren möchten, können Sie
{{ site.data.keys.mf_analytics }} in
WebSphere Application Server Liberty Profile
und Full Profile implementieren und konfigurieren.

Vorbereitungen:  
Falls Sie für den Schutz der Analytics Console ein LDAP-Repository verwenden möchten, stellen Sie sicher, dass der LDAP-Server
arbeitet. Fordern Sie bei Ihrem LDAP-Administrator die erforderlichen Konfigurationsdaten an.

> **Wichtiger Hinweis:** Wenn die LDAP-Repository-Konfiguration in der Komponente "Analytics" aktiviert ist,
wird für {{ site.data.keys.mf_analytics }} kein Standardbenutzer mit Administratorberechtigung
erstellt.
Sie müssen stattdessen den Benutzernamen und das Kennwort des im LDAP-Repository gespeicherten Benutzers mit Administratorberechtigung angeben. Diese Werte sind zum Schutz
der Analytics Console erforderlich.

1. Erstellen Sie ein Muster mit der benötigten Topologie. Weitere Informationen finden Sie in den folgenden Artikeln:
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server)
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server)
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server)
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server)
    * [{{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers)

2. Fügen Sie {{ site.data.keys.mf_analytics }} hinzu und konfigurieren Sie {{ site.data.keys.mf_analytics }}. 
    * Klicken Sie im Dashboard von IBM
PureApplication
System auf **Muster → Muster für virtuelle Systeme**. Die Seite **Muster für virtuelle Systeme** wird geöffnet. 
    * Suchen Sie auf der Seite **Muster für virtuelle Systeme** über das Feld
**Suche** nach dem von Ihnen erstellten Muster und wählen Sie es aus. Klicken Sie dann auf **Öffnen**, um die Seite **Erstellungsprogramm für Muster** zu öffnen.
    * Erweitern Sie in der Assetliste die Anzeige für **Softwarekomponenten**.
Ziehen Sie dann mit der Maus die folgenden Komponenten
in den Erstellungsbereich und legen
Sie sie dort ab:

        **Liberty Profile Server**  
Wählen Sie diese Komponente aus, wenn Sie
{{ site.data.keys.mf_analytics }}
in WebSphere Application Server Liberty Profile implementieren möchten.
        
        **Standalone Server**  
Wählen Sie diese Komponente aus, wenn Sie
{{ site.data.keys.mf_analytics }}
in WebSphere Application Server Full Profile implementieren möchten.

        Ein neuer Knoten mit dem Namen
"OS Node" wird erstellt. Benennen Sie ihn in "{{ site.data.keys.mf_analytics }}" um. 
    * Nehmen Sie abhängig vom Typ des Anwendungsservers, in dem Sie "Analytics" implementieren möchten, die folgenden Konfigurationsänderungen vor:
        * Wenn Sie
{{ site.data.keys.mf_analytics }}
in WebSphere Application Server Liberty Profile implementieren,
klicken Sie auf dem Knoten "{{ site.data.keys.mf_analytics }}" auf **Liberty Profile Server**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt. Geben Sie im Feld
**Configuration data location**
den Pfad
**/opt/IBM/WebSphere/Liberty** ein. Geben Sie den Namen und das Kennwort des Benutzers mit Administratorberechtigung an. Verwenden Sie für die übrigen Parameter die Standardwerte.
        * Wenn Sie
{{ site.data.keys.mf_analytics }}
in WebSphere Application Server Full Profile implementieren,
klicken Sie auf dem Knoten "{{ site.data.keys.mf_analytics }}" auf **Standalone Server**. Neben dem Erstellungsbereich werden die Eigenschaften der ausgewählten Komponente angezeigt. Geben Sie im Feld
**Configuration data location**
den Pfad
**/opt/IBM/WebSphere/AppServer/Profiles** ein, ändern Sie den Profilnamen in **AppSrv01** und
geben Sie den Namen und das Kennwort des Benutzers mit Administratorberechtigung an. Verwenden Sie für die übrigen Parameter die Standardwerte.
    
        > **Wichtiger Hinweis:** Der WebSphere-Application-Server-Benutzer mit Administratorberechtigung
wird im Benutzerrepository von WebSphere Application Server erstellt. Wenn Sie LDAP für den Analytics-Server konfigurieren möchten,
vermeiden Sie Namenskonflikte mit dem Namen des WebSphere-Application-Server-Benutzers mit Administratorberechtigung. Wenn beispielsweise über die Konfiguration des LDAP-Servers
"Benutzer1" eingeführt wird, legen Sie
"Benutzer1" nicht als Namen des
WebSphere-Application-Server-Benutzers mit Administratorberechtigung fest.

    * Blenden Sie in der Komponentenliste die Anzeige
**Scripts** ein.
Ziehen Sie dann mit der Maus eine Komponente
**MFP Server Prerequisite** auf den Knoten
"{{ site.data.keys.mf_analytics }}" im Erstellungsbereich. 
    * Blenden Sie in der Komponentenliste die Anzeige
für
**Scripts** ein.
Ziehen Sie dann mit der Maus eine Komponente
**MFP Analytics** auf den Knoten
"{{ site.data.keys.mf_analytics }} " im Erstellungsbereich. Stellen Sie sicher, dass sich die
Komponente "MFP
Analytics" hinter der Komponente "Liberty Profile Server"
(oder der Komponente "Standalone Server") befindet.
    * Machen Sie in den bereitgestellten Feldern die folgenden Angaben für {{ site.data.keys.mf_analytics }}: 
        
        Die LDAP-Parameter sind identisch mit den Parametern der
Komponente "MFP Server Administration". Weitere Informationen finden Sie in Schritt 3
unter "MFP-Server-Verwaltung konfigurieren". 
        
        > **Wichtiger Hinweis:** Für die Konfiguration der LDAP-SSL-Verbindung in
{{ site.data.keys.mf_analytics }} müssen Sie in Schritt
4b unter [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einem externen LDAP-Repository konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository)
sicherstellen,
dass sich die mit der Maus auf den Knoten "{{ site.data.keys.mf_analytics }}" gezogene Komponente "{{ site.data.keys.product_adj }} LDAP Cert"
zwischen "Liberty Profile Server" (oder "Standalone Server") und dem Scriptpaket
"MFP Analytics" befindet.         
   #### WAS_ROOT
    * Wenn {{ site.data.keys.mf_analytics }} in
WebSphere Application Server Liberty Profile installiert wird, geben Sie
für "Analytics" das Installationsverzeichnis von Liberty Profile an. 
        * Klicken Sie neben dem Feld **WAS_ROOT** auf
die Schaltfläche
**Referenz hinzufügen**
und klicken Sie im Popup-Fenster auf
das Register
**Parameter auf Komponentenebene**. 
        * Wählen Sie für das Feld **Komponente** den Eintrag
**Liberty Profile Server** aus.
(Möglicherweise lautet
der Eintrag
**Liberty
Profile Server\_1**, wenn
{{ site.data.keys.mf_server }} auch in
WebSphere Application Server Liberty Profile implementiert ist.) 
        * Wählen Sie für das Feld **Ausgabeattribut**
den Eintrag **install_directory** aus. Klicken Sie auf die Schaltfläche
**Hinzufügen**, um die Anzeige im Feld
**Ausgabewert** zu aktualisieren. Klicken Sie dann auf
**OK**.
    * Wenn {{ site.data.keys.mf_analytics }} in
WebSphere Application Server Full Profile installiert wird, geben Sie
für "Analytics" das Installationsverzeichnis von WebSphere Application Server Full Profile an. 
        * Klicken Sie neben dem Feld **WAS_ROOT** auf
die Schaltfläche
**Referenz hinzufügen**
und klicken Sie im Popup-Fenster auf
das Register
**Parameter auf Komponentenebene**. 
        * Wählen Sie für das Feld **Komponente** den Eintrag
**Standalone Server** aus.
(Möglicherweise lautet
der Eintrag
**Standalone
Server\_1**, wenn
{{ site.data.keys.mf_server }} auch in
WebSphere Application Server Full Profile implementiert ist.) 
        * Wählen Sie für das Feld **Ausgabeattribut**
den Eintrag **install_directory** aus. Klicken Sie auf die Schaltfläche
**Hinzufügen**, um die Anzeige im Feld
**Ausgabewert** zu aktualisieren. Klicken Sie dann auf
**OK**.
        
   #### HEAP\_MIN\_SIZE
   
    Gilt nur für
WebSphere Application Server Full Profile.

    Der Umfang der generierten Analysedaten ist direkt
proportional zur dafür erforderlichen Speicherkapazität. Legen Sie den Wert so fest, dass für
WebSphere Application Server Full Profile
eine größere Mindestgröße des Heapspeichers möglich ist.
Stellen Sie sicher, dass die für die Komponente "Core OS" des
Knotens "{{ site.data.keys.mf_analytics }}" angegebene Speicherkapazität
über dem Wert von **HEAP\_MIN\_SIZE** liegt. Sie könnten den Wert auf den von
**HEAP\_MAX\_SIZE** setzen.
    
    Standardwert: 4096 MB.

   #### HEAP\_MAX\_SIZE
    Gilt nur für
WebSphere Application Server Full Profile.

    Der Umfang der generierten Analysedaten ist direkt
proportional zur dafür erforderlichen Speicherkapazität. Legen Sie den Wert so fest, dass für
WebSphere Application Server Full Profile
eine größere Maximalgröße des Heapspeichers möglich ist.
Stellen Sie sicher, dass die für die Komponente "Core OS" des
Knotens "{{ site.data.keys.mf_analytics }}" angegebene Speicherkapazität
über dem Wert von **HEAP\_MAX\_SIZE** liegt. Sie könnten den Wert auf den von
**HEAP\_MIN\_SIZE** setzen.

    Standardwert: 4096 MB.
    
   #### WAS\_admin\_user
    * Gilt nur für
WebSphere Application Server Full Profile.  
Dieser Parameter gibt die Benutzer-ID mit Administratorberechtigung von
WebSphere Application Server Full Profile
für den Analytics-Server an.
        * Klicken Sie neben dem Feld **WAS\_admin\_user** auf
die Schaltfläche
**Referenz hinzufügen**
und klicken Sie im Popup-Fenster auf
das Register
**Parameter auf Komponentenebene**. 
        * Wählen Sie für das Feld **Komponente** den Eintrag
**Standalone Server** aus.
(Möglicherweise lautet
der Eintrag
**Standalone
Server\_1**, wenn
{{ site.data.keys.mf_server }} auch in
WebSphere Application Server Full Profile implementiert ist.) 
        * Wählen Sie für das Feld **Ausgabeattribut**
den Eintrag **was\_admin** aus. Klicken Sie auf die Schaltfläche
**Hinzufügen**, um die Anzeige im Feld
**Ausgabewert** zu aktualisieren. Klicken Sie dann auf
**OK**.
    
    Für Liberty Profile
kann der Standardwert verwendet werden.
    
   #### WAS\_admin\_password
    Gilt nur für
WebSphere Application Server Full Profile.

    Dieser Parameter gibt die Benutzer-ID mit Administratorberechtigung von
WebSphere Application Server Full Profile
für den Analytics-Server an.
    * Klicken Sie neben dem Feld **WAS\_admin\_password** auf
die Schaltfläche
**Referenz hinzufügen**
und klicken Sie im Popup-Fenster auf
das Register
**Parameter auf Komponentenebene**. 
    * Wählen Sie für das Feld **Komponente** den Eintrag
**Standalone Server** aus.
(Möglicherweise lautet
der Eintrag
**Standalone
Server\_1**, wenn
{{ site.data.keys.mf_server }} auch in
WebSphere Application Server Full Profile implementiert ist.) 
    * Wählen Sie für das Feld **Ausgabeattribut**
den Eintrag **was\_admin\_password** aus. Klicken Sie auf die Schaltfläche
**Hinzufügen**, um die Anzeige im Feld
**Ausgabewert** zu aktualisieren. Klicken Sie dann auf
**OK**.
    
    Für Liberty Profile
kann der Standardwert verwendet werden.

   #### admin_user
    * Wenn kein LDAP-Repository aktiviert ist, erstellen Sie zum Schutz der {{ site.data.keys.mf_analytics_console }}
einen Standardbenutzer mit Administratorberechtigung.
    * Wenn ein LDAP-Repository aktiviert ist, geben Sie den Namen des Benutzers mit Administratorberechtigung
für {{ site.data.keys.mf_analytics }} an. Dieser Wert wird im LDAP-Repository
gespeichert.

   #### admin_password
    * Wenn kein LDAP-Repository aktiviert ist, geben Sie das Kennwort des Standardbenutzers mit Administratorberechtigung zum Schutz der {{ site.data.keys.mf_analytics_console }} an.
    * Wenn ein LDAP-Repository aktiviert ist, geben Sie das Kennwort des Benutzers mit Administratorberechtigung an. Dieser Wert wird im LDAP-Repository gespeichert.
    
    Optional: Aktivieren Sie das LDAP-Repository zum Schutz der {{ site.data.keys.mf_analytics_console }}. Die LDAP-Parameter in {{ site.data.keys.mf_analytics }} sind mit denen für die MobileFirst-Server-Verwaltung identisch. Weitere Informationen finden Sie im Abschnitt “MFP-Server-Verwaltung konfigurieren” (Schritt 3) unter [{{ site.data.keys.product_adj }}-Verwaltungssicherheit mit einem externen LDAP-Repository konfigurieren](#configuring-mobilefirst-administration-security-with-an-external-ldap-repository).

3. Konfigurieren Sie für die MobileFirst-Server-Laufzeitimplementierung eine Verbindung zu {{ site.data.keys.mf_analytics }}:
    * Wählen Sie auf dem Knoten "MobileFirst Platform Server" (oder dem Knoten "DmgrNode", wenn Sie die Schablone "{{ site.data.keys.product }} (WAS ND)" verwenden) die Komponente **MFP Server Runtime Deployment** aus.
    * Ziehen Sie mit der Maus eine Verbindung von der Komponente "MFP Server Runtime Deployment" zur Komponente "Liberty Profile Server" oder "Standalone Server" auf dem Knoten "{{ site.data.keys.mf_analytics }}", je nachdem, welchen Anwendungsservertyp Sie verwenden. Das Popup-Fenster "Datenabhängigkeiten konfigurieren" wird geöffnet.
    * Konfigurieren Sie wie folgt die Datenabhängigkeiten:
        * Löschen Sie im Fenster "Datenabhängigkeiten konfigurieren" alle empfohlenen Einträge für Datenabhängigkeiten, indem Sie neben jedem Eintrag auf die Schaltfläche **X** klicken.
        * Wählen Sie unter der Komponente **MFP Server Runtime Deployment** **analytics_ip** aus. Unter unter **Liberty Profile Server** oder **Standalone Server** müssen Sie **IP** auswählen.
        * Klicken Sie auf die Schaltfläche **Hinzufügen**, um die neue Datenabhängigkeit hinzuzufügen.
        * Klicken Sie auf **OK**, um Ihre Änderungen zu speichern.

            ![Link von der Komponente 'MFP Server Runtime' zum Liberty-Server hinzufügen](pureapp_analytics_link_1.jpg)
            
            Die Verbindung von der Komponente "MFP Server Runtime Deployment" zur Komponente "Liberty Profile Server" (oder "Standalone Server") ist hergestellt.
    * Ziehen Sie mit der Maus eine weitere Verbindung von der Komponente "MFP Server Runtime Deployment" zur Komponente "MFP Analytics" auf dem Knoten "{{ site.data.keys.mf_analytics }}". Das Popup-Fenster "Datenabhängigkeiten konfigurieren" wird geöffnet.
    * Konfigurieren Sie wie folgt die Datenabhängigkeiten:
        * Löschen Sie im Fenster "Datenabhängigkeiten konfigurieren" alle empfohlenen Einträge für Datenabhängigkeiten, indem Sie neben jedem Eintrag auf die Schaltfläche **X** klicken.
        * Wählen Sie unter der Komponente **MFP Server Runtime Deployment** **analytics\_admin\_user** und unter **MFP Analytics** **admin_user** aus.
        * Klicken Sie auf die Schaltfläche **Hinzufügen**, um die neue Datenabhängigkeit hinzuzufügen.
        * Wiederholen Sie den Prozess, um eine Datenabhängigkeit zwischen **analytics\_admin\_password** und **admin_password** zu konfigurieren.
        * Klicken Sie auf **OK**, um Ihre Änderungen zu speichern.
            
            ![Link von der Komponente 'MFP Server Runtime Deployment' zur Komponente 'MFP Analytics' hinzufügen](pureapp_analytics_link_2.jpg)
            
    Die folgende Abbildung zeigt ein Beispiel für einen Knoten "{{ site.data.keys.mf_analytics }}", der zu einem Muster "{{ site.data.keys.product }} (WAS ND)" hinzugefügt wurde.

    ![MobileFirst-Analytics-Knoten, der zu einem Muster '{{ site.data.keys.product }} WAS ND' hinzugefügt wurde](pureapp_analytics_node.jpg)

4. Konfigurieren und starten Sie die Musterimplementierung.

    Auf der Seite "Muster implementieren" können Sie Ihre Konfigurationseinstellungen für {{ site.data.keys.mf_analytics }} anpassen. Klicken Sie dazu unter der Knotenliste in der mittleren Spalte auf die Komponente {{ site.data.keys.mf_analytics }} und erweitern Sie die Anzeige für "MFP Analytics".

    Weitere Informationen zur Musterimplementierung enthält der Schritt "Musterimplementierung konfigurieren und starten" in den folgenden Abschnitten. Lesen Sie den Abschnitt für die Topologie, die Sie beim Erstellen des Musters ausgewählt haben:
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server), Schritt 8
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server), Schritt 9
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server), Schritt 8
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server), Schritt 9
    * [{{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers), Schritt 9 und folgende

5. Greifen Sie über die {{ site.data.keys.mf_console }} auf {{ site.data.keys.mf_analytics }} zu.

    Weitere Informationen enthält der Schritt "Zugriff auf die {{ site.data.keys.mf_console }}" in den folgenden Abschnitten. Lesen Sie den Abschnitt für die Topologie, die Sie beim Erstellen des Musters ausgewählt haben:
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-liberty-profile-server), Schritt 9
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Liberty Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-liberty-profile-server), Schritt 10
    * [{{ site.data.keys.mf_server }} auf einem einzelnen Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-single-node-websphere-application-server-full-profile-server), Schritt 9
    * [{{ site.data.keys.mf_server }} auf mehreren Serverknoten mit WebSphere Application Server Full Profile implementieren](#deploying-mobilefirst-server-on-a-multiple-node-websphere-application-server-full-profile-server), Schritt 10
    * [{{ site.data.keys.mf_server }} in Server-Clustern mit WebSphere Application Server Network Deployment implementieren](#deploying-mobilefirst-server-on-clusters-of-websphere-application-server-network-deployment-servers), Schritt 10 und folgende    
    
## Vordefinierte Schablonen für {{ site.data.keys.mf_system_pattern }}
{: #predefined-templates-for-mobilefirst-system-pattern }
In {{ site.data.keys.mf_system_pattern }} gibt es vordefinierte Schablonen, die Sie verwenden können, um Muster für die typischen Implementierungstopologien zu erstellen.  
Die nachstehend genannten Schablonen sind verfügbar. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to-1 }
* [Schablone '{{ site.data.keys.product }} (Liberty Single Node)'](#mobilefirst-foundation-liberty-single-node-template)
* [Schablone '{{ site.data.keys.product }} (Liberty Server Farm)'](#mobilefirst-foundation-liberty-server-farm-template)
* [Schablone '{{ site.data.keys.product }} (WAS Single Node)'](#mobilefirst-foundation-was-single-node-template)
* [Schablone '{{ site.data.keys.product }} (WAS Server Farm)'](#mobilefirst-foundation-was-server-farm-template)
* [Schablone '{{ site.data.keys.product }} (WAS ND)'](#mobilefirst-foundation-was-nd-template)
* [Schablone '{{ site.data.keys.mf_app_center }} (Liberty Single Node)'](#mobilefirst-application-center-liberty-single-node-template)
* [Schablone '{{ site.data.keys.mf_app_center }} (WAS Single Node)'](#mobilefirst-application-center-was-single-node-template)

### Schablone '{{ site.data.keys.product }} (Liberty Single Node)'
{: #mobilefirst-foundation-liberty-single-node-template }
Das folgende Diagramm zeigt den
Aufbau der Schablone "MobileFirst Platform (Liberty
Single Node)". 

![Schablone '{{ site.data.keys.product }} (Liberty Single Node)'](pureapp_templ_Lib_single_node.jpg)

Die Schablone "{{ site.data.keys.product }} (Liberty Single Node)" setzt sich aus folgenden Knoten und Komponenten zusammen: 

| Knoten| Komponenten| 
|------|------------|
| MobileFirst Platform Server| **Liberty Profile Server**<br/>Installation von WebSphere Application Server Liberty Profile<br/><br/>**MFP Server Prerequisite**<br/>Vorbedingungen für die Installation von {{ site.data.keys.mf_server }}, einschließlich SSL und Ant<br/><br/>**MFP Server Administration**<br/>Webanwendung für MobileFirst-Server-Verwaltung mit der {{ site.data.keys.mf_console }}<br/>**MFP Server Runtime Deployment**<br/>Konfiguration des Laufzeitkontextstammverzeichnisses<br/><br/>**MFP Server Application**<br/>{{ site.data.keys.product_adj }}-Anwendung, die zur Implementierung hinzugefügt werden soll<br/><br/>**MFP Server Adapter**<br/>Adapter, der zur Implementierung hinzugefügt werden soll<br/><br/>**MFP Server Application Adapter Deployment**<br/>Implementierung von Anwendungen und Adaptern in {{ site.data.keys.mf_server }}| 
| MobileFirst Platform DB| **Database Server**<br/>Installation des DB2-Datenbankservers<br/><br/>**MFP Administration DB**<br/>Installation des Schemas für die MobileFirst-Verwaltungsdatenbank<br/><br/>**MFP Runtime DB**<br/>Installation des Schemas für die {{ site.data.keys.product }}-Laufzeitdatenbank<br/><br/>**Default Add Disk**<br/>Konfiguration der Datenträgergröße| 

### Schablone '{{ site.data.keys.product }} (Liberty Server Farm)'
{: #mobilefirst-foundation-liberty-server-farm-template }
Das folgende Diagramm zeigt den Aufbau der Schablone "MobileFirst Platform (Liberty Server Farm)".

![Schablone '{{ site.data.keys.product }} (Liberty Server Farm)'](pureapp_templ_Lib_server_farm.jpg)

Die Schablone "{{ site.data.keys.product }} (Liberty Server Farm)" setzt sich aus folgenden Knoten und Komponenten zusammen: 

| Knoten| Komponenten| 
|------|------------|
| IHS| **IBM HTTP Server**<br/>Installation von IBM HTTP Server<br/><br/>**MFP IHS Configuration**<br/>Automatische Konfiguration von IBM HTTP Server| 
| MobileFirst Platform Server| **Liberty Profile Server**<br/>Installation von WebSphere Application Server Liberty Profile<br/><br/>**MFP Server Prerequisite**<br/>Vorbedingungen für die Installation von {{ site.data.keys.mf_server }}, einschließlich SSL und Ant<br/><br/>**MFP Server Administration**<br/>Webanwendung für MobileFirst-Server-Verwaltung mit der {{ site.data.keys.mf_console }}<br/><br/>**MFP Server Runtime Deployment**<br/>Konfiguration des Laufzeitkontextstammverzeichnisses<br/><br/>**MFP Server Application**<br/>{{ site.data.keys.product_adj }}-Anwendung, die zur Implementierung hinzugefügt werden soll<br/><br/>**MFP Server Adapter**<br/>Adapter, der zur Implementierung hinzugefügt werden soll<br/><br/>**MFP Server Application Adapter Deployment**<br/>Implementierung von Anwendungen und Adaptern in {{ site.data.keys.mf_server }}<br/><br/>**Base Scaling Policy**<br/>VM-Skalierungsrichtlinie mit der Anzahl virtueller Maschinen| 
| MobileFirst Platform DB| **Database Server**<br/>Installation des DB2-Datenbankservers<br/><br/>**MFP Administration DB**<br/>Installation des Schemas für die {{ site.data.keys.product_adj }}-Verwaltungsdatenbank<br/><br/>**MFP Runtime DB**<br/>Installation des Schemas für die {{ site.data.keys.product }}-Laufzeitdatenbank<br/><br/>**Default Add Disk**<br/>Konfiguration der Datenträgergröße| 

### Schablone '{{ site.data.keys.product }} (WAS Single Node)'
{: #mobilefirst-foundation-was-single-node-template }
Das folgende Diagramm zeigt den Aufbau der Schablone "MobileFirst Platform (WAS Single Node)".

![Schablone '{{ site.data.keys.product }} (WAS Single Node)'](pureapp_templ_WAS_single_node.jpg)

Die Schablone "{{ site.data.keys.product }} (WAS Single Node)" setzt sich aus folgenden Knoten und Komponenten zusammen: 

| Knoten| Komponenten| 
|------|------------|
| MobileFirst Platform Server| **Standalone Server**<br/>Installation von WebSphere Application Server Full Profile<br/><br/>Einschränkung:<br/>Ändern Sie nicht die Werte für die folgenden Komponentenattribute: {::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}Wenn Sie eines dieser Attribute ändern, schlägt die Implementierung von auf dieser Schablone basierenden Mustern fehl.<br/><br/>**MFP Server Prerequisite**<br/>Vorbedingungen für die Installation von {{ site.data.keys.mf_server }}, einschließlich SSL und Ant<br/><br/>**MFP Server Administration**<br/>Webanwendung für MobileFirst-Server-Verwaltung mit der {{ site.data.keys.mf_console }}<br/><br/>**MFP Server Runtime Deployment**<br/>Konfiguration des Laufzeitkontextstammverzeichnisses<br/><br/>**{{ site.data.keys.product_adj }} App**<br/>{{ site.data.keys.product_adj }}-Anwendung, die zur Implementierung hinzugefügt werden soll<br/><br/>**{{ site.data.keys.product_adj }} Adapter**<br/>{{ site.data.keys.product_adj }}-Adapter, der zur Implementierung hinzugefügt werden soll<br/><br/>**MFP Server Application Adapter Deployment**<br/>Implementierung von Anwendungen und Adaptern in {{ site.data.keys.mf_server }}| 
| MobileFirst Platform DB| **Database Server**<br/>Installation des DB2-Datenbankservers<br/><br/>**MFP Administration DB**<br/>Installation des Schemas für die {{ site.data.keys.product_adj }}-Verwaltungsdatenbank<br/><br/>**MFP Runtime DB**<br/>Installation des Schemas für die {{ site.data.keys.product }}-Laufzeitdatenbank<br/><br/>**Default Add Disk**<br/>Konfiguration der Datenträgergröße| 

### Schablone '{{ site.data.keys.product }} (WAS Server Farm)'
{: #mobilefirst-foundation-was-server-farm-template }
Das folgende Diagramm zeigt den Aufbau der Schablone "MobileFirst Platform (WAS Server Farm)".

![Schablone '{{ site.data.keys.product }} (WAS Server Farm)'](pureapp_templ_WAS_server_farm.jpg)

Die Schablone "{{ site.data.keys.product }} (WAS Server Farm)" setzt sich aus folgenden Knoten und Komponenten zusammen: 

| Knoten| Komponenten| 
|------|------------|
| IHS| **IBM HTTP Server**<br/>Installation von IBM HTTP Server<br/><br/>**MFP IHS Configuration**<br/>Automatische Konfiguration von IBM HTTP Server| 
| MobileFirst Platform Server| **Standalone Server**<br/>Installation von WebSphere Application Server Full Profile<br/><br/>Einschränkung: Ändern Sie nicht die Werte für die folgenden Komponentenattribute: {::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}Wenn Sie eines dieser Attribute ändern, schlägt die Implementierung von auf dieser Schablone basierenden Mustern fehl. <br/><br/>**MFP Server Prerequisite**<br/>Vorbedingungen für die Installation von {{ site.data.keys.mf_server }}, einschließlich SSL und Ant<br/><br/>**MFP Server Administration**<br/>Webanwendung für MobileFirst-Server-Verwaltung mit der {{ site.data.keys.mf_console }}<br/><br/>**MFP Server Runtime Deployment**<br/>Konfiguration des Laufzeitkontextstammverzeichnisses<br/><br/>**{{ site.data.keys.product_adj }} App**<br/>{{ site.data.keys.product_adj }}-Anwendung, die zur Implementierung hinzugefügt werden soll<br/><br/>**{{ site.data.keys.product_adj }}-Adapter**, der zur Implementierung hinzugefügt werden soll<br/><br/>**MFP Server Application Adapter Deployment**<br/>Implementierung von Anwendungen und Adaptern in {{ site.data.keys.mf_server }}<br/><br/>**Base Scaling Policy**<br/>VM-Skalierungsrichtlinie mit der Anzahl virtueller Maschinen| 
| MobileFirst Platform DB| **Database Server**<br/>Installation des DB2-Datenbankservers<br/><br/>**MFP Administration DB**<br/>Installation des Schemas für die {{ site.data.keys.product_adj }}-Verwaltungsdatenbank<br/><br/>**MFP Runtime DB**<br/>Installation des Schemas für die {{ site.data.keys.product }}-Laufzeitdatenbank<br/><br/>**Default Add Disk**<br/>Konfiguration der Datenträgergröße| 

### Schablone '{{ site.data.keys.product }} (WAS ND)'
{: #mobilefirst-foundation-was-nd-template }
Das folgende Diagramm zeigt den Aufbau der Schablone "MobileFirst Platform (WAS ND)".

![Schablone '{{ site.data.keys.product }} (WAS ND)'](pureapp_templ_WAS_ND.jpg)

Die Schablone "{{ site.data.keys.product }} (WAS ND)" setzt sich aus folgenden Knoten und Komponenten zusammen: 

| Knoten| Komponenten| 
|------|------------|
| IHS| **IBM HTTP Server**<br/>Installation von IBM HTTP Server<br/><br/>**MFP IHS Configuration**<br/>Automatische Konfiguration von IBM HTTP Server| 
| DmgrNode| **Deployment Manager**<br/>Installation von WebSphere Application Server Deployment Manager<br/><br/>Einschränkung: Ändern Sie nicht die Werte für die folgenden Komponentenattribute: {::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}Wenn Sie eines dieser Attribute ändern, schlägt die Implementierung von auf dieser Schablone basierenden Mustern fehl. <br/><br/>**MFP Server Prerequisite**<br/>Vorbedingungen für die Installation von {{ site.data.keys.mf_server }}, einschließlich SSL und Ant<br/><br/>**MFP Server Administration**<br/>Webanwendung für MobileFirst-Server-Verwaltung mit der {{ site.data.keys.mf_console }}<br/><br/>**MFP Runtime**<br/>Laufzeit-WAR-Datei<br/><br/>**MFP Server Runtime Deployment**<br/>Konfiguration des Laufzeitkontextstammverzeichnisses<br/><br/>**MFP Application**<br/>{{ site.data.keys.product_adj }}-Anwendung, die zur Implementierung hinzugefügt werden soll<br/><br/>**MFP Adapter**<br/>Adapter, der zur Implementierung hinzugefügt werden soll<br/><br/>**MFP Server Application Adapter Deployment**<br/>Implementierung von Anwendungen und Adaptern in {{ site.data.keys.mf_server }}| 
| MobileFirst Platform DB| **Database Server**<br/>Installation des DB2-Datenbankservers<br/><br/>**MFP Administration DB**<br/>Installation des Schemas für die {{ site.data.keys.product_adj }}-Verwaltungsdatenbank<br/><br/>**MFP Runtime DB**<br/>Installation des Schemas für die {{ site.data.keys.product }}-Laufzeitdatenbank<br/><br/>**Default Add Disk**<br/>Konfiguration der Datenträgergröße| 
| CustomNode| **Custom Nodes**<br/>Details der Zellen und Knoten in Serverclustern mit WebSphere Application Server Network Deployment<br/><br/>Einschränkung: Ändern Sie nicht die Werte für die folgenden Komponentenattribute: {::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}Wenn Sie eines dieser Attribute ändern, schlägt die Implementierung von auf dieser Schablone basierenden Mustern fehl. <br/><br/>**MFP Open Firewall Ports for WAS**<br/>Ports, die offen sein müssen, damit eine Verbindung zum Datenbankserver und zum LDAP-Server hergestellt werden kann<br/><br/>**Base Scaling Policy**<br/>Anzahl der für die gewählte Topologie erforderlichen VM-Instanzen| 

### Schablone '{{ site.data.keys.mf_app_center }} (Liberty Single Node)'
{: #mobilefirst-application-center-liberty-single-node-template }
Das folgende Diagramm zeigt den Aufbau der Schablone "MobileFirst Platform Application Center (Liberty Single Node)".

![Schablone '{{ site.data.keys.mf_app_center }} (Liberty Single Node)'](pureapp_templ_appC_Lib_single_node.jpg)

Die Schablone "{{ site.data.keys.mf_app_center }} (Liberty Single Node)" setzt sich aus folgenden Knoten und Komponenten zusammen: 

| Knoten| Komponenten|
|------|------------|
| MFP AppCenter DB| **Database Server**<br/>Installation des DB2-Datenbankservers<br/><br/>**Default Add Disk**<br/>Konfiguration der Datenträgergröße| 
| MFP AppCenter Server| **Liberty Profile Server**<br/>Installation von WebSphere Application Server Liberty Profile<br/><br/>**MFP Server Prerequisite**<br/>Vorbedingungen für die Installation von {{ site.data.keys.mf_server }}, einschließlich SSL und Ant<br/><br/>**MFP Server Application Center**<br/>Mit diesem Scriptpaket wird der MobileFirst-Application-Center-Server in WebSphere Application Server Full Profile oder WebSphere Application Server Liberty Profile eingerichtet. | 

### Schablone '{{ site.data.keys.mf_app_center }} (WAS Single Node)'
{: #mobilefirst-application-center-was-single-node-template }
Das folgende Diagramm zeigt den Aufbau der Schablone "MobileFirst Platform Application Center (WAS Single Node)".

![Schablone '{{ site.data.keys.mf_app_center }} (WAS Single Node)'](pureapp_templ_appC_WAS_single_node.jpg)

Die Schablone "{{ site.data.keys.mf_app_center }} (WAS Single Node)" setzt sich aus folgenden Knoten und Komponenten zusammen: 

| Knoten| Komponenten| 
|------|------------|
| MFP AppCenter DB| **Database Server**<br/>Installation des DB2-Datenbankservers<br/><br/>**Default Add Disk**<br/>Konfiguration der Datenträgergröße| 
| MFP AppCenter Server| **Standalone Server**<br/>Installation von WebSphere Application Server Full Profile<br/><br/>Einschränkung: Ändern Sie nicht die Werte für die folgenden Komponentenattribute: {::nomarkdown}<ul><li>Cell name</li><li>Node name</li><li>Profile name</li></ul>{:/}Wenn Sie eines dieser Attribute ändern, schlägt die Implementierung von auf dieser Schablone basierenden Mustern fehl. <br/><br/>**MFP WAS SDK Level**<br/>Dieses Script dient dazu, die erforderliche SDK-Version als Standard-SDK für das WAS-Profil festzulegen. <br/><br/>**MFP Server Prerequisite**<br/>Vorbedingungen für die Installation von {{ site.data.keys.mf_server }}, einschließlich SSL und Ant<br/><br/>**MFP Server Application Center**<br/>Mit diesem Scriptpaket wird der MobileFirst-Application-Center-Server in WebSphere Application Server Full Profile oder WebSphere Application Server Liberty Profile eingerichtet. | 


## Scriptpakete für {{ site.data.keys.mf_server }}
{: #script-packages-for-mobilefirst-server }
{{ site.data.keys.mf_system_pattern }} stellt Scriptpakete bereit. Diese Scriptpakete sind logische Bausteine für die Erstellung verschiedener Mustertopologien.  
In den folgenden Abschnitten sind die Parameter für die einzelnen Scriptpakete aufgelistet und beschrieben. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to-2 }
* [MFP Administration DB](#mfp-administration-db)
* [MFP Analytics](#mfp-analytics)
* [MFP IHS Configuration](#mfp-ihs-configuration)
* [MFP Open Firewall Ports for WAS](#mfp-open-firewall-ports-for-was)
* [MFP WAS SDK Level](#mfp-was-sdk-level)
* [MFP Runtime DB](#mfp-runtime-db)
* [MFP Server Administration](#mfp-server-administration)
* [MFP Server Application Adapter Deployment](#mfp-server-application-adapter-deployment)
* [MFP Server Application Center](#mfp-server-application-center)
* [MFP Server Prerequisite](#mfp-server-prerequisite)
* [MFP Server Runtime Deployment](#mfp-server-runtime-deployment)

### MFP Administration DB
{: #mfp-administration-db }
Mit diesem Scriptpaket wird das Verwaltungsdatenbankschema in einer DB2-Datenbank eingerichtet. Es muss mit der
Softwarekomponente des Datenbankservers (DB2) verwendet werden. 

| Parameter| Beschreibung | 
|-----------|-------------|
| db_user| Dieser obligatorische Parameter gibt den Benutzernamen für die Erstellung der Verwaltungsdatenbank an. Er kann dem Instanznamen der Datenbankserverkomponente zugeordnet werden. Standardwert: db2inst1.|
| db_name	| Dieser obligatorische Parameter gibt den Datenbanknamen für die Erstellung der Verwaltungsdatenbank an. Standardwert: WLADM.|
| db_password|	Dieser obligatorische Parameter gibt das Benutzerkennwort für die Erstellung der Verwaltungsdatenbank an. Er kann dem Instanzeigner der Datenbankserverkomponente zugeordnet werden. Standardwert: passw0rd (als Parameter auf Musterebene).|
| other\_db\_args| Vier obligatorische Parameter für die Erstellung der Verwaltungsdatenbank: SQL type, Codeset,Territory und Collate. Standardwert: DB2 UTF-8 US SYSTEM.|

### MFP Analytics
{: #mfp-analytics }
Mit diesem Scriptpaket wird der {{ site.data.keys.mf_analytics_server }}
in
WebSphere Application Server Full Profile
oder
WebSphere Application Server Liberty Profile eingerichtet. Außerdem wird die Verbindung zu einem externen TDS- oder AD-Server konfiguriert und werden die
Verwaltungssicherheitsrollen für Analysen einem externen
TDS- oder AD-Server zugeordnet. Es muss mit der Serversoftwarekomponente
WebSphere Application Server Liberty
Profile oder WebSphere Application Server Full Profile
(Anzeigename: Standalone Server) verwendet werden. Es muss nach der Softwarekomponente "Liberty Profile" oder "Standalone Server" installiert werden. 

| Parameter| Beschreibung | 
|-----------|-------------|
| WAS_ROOT| Obligatorisch{::nomarkdown}<ul><li>Wenn Analytics in WebSphere Application Server Liberty Profile installiert wird, geben Sie das Installationsverzeichnis von WebSphere Application Server Liberty Profile an.</li><li>Wenn Analytics in WebSphere Application Server Full Profile installiert wird, geben Sie das Installationsverzeichnis von WebSphere Application Server Full Profile an.</li></ul>{:/} | 
| HEAP\_MIN\_SIZE| Nur WebSphere Application Server Full Profile.<br/><br/>Abhängig vom Umfang der generierten Analysedaten kann mehr Hauptspeicher für die Datenbehandlung erforderlich sein. Legen Sie den Wert so fest, dass für WebSphere Application Server Full Profile eine größere Mindestgröße des Heapspeichers möglich ist. Stellen Sie sicher, dass die für die Komponente "Core OS" von {{ site.data.keys.mf_analytics }} angegebene Speicherkapazität über diesem Wert liegt. Es wird empfohlen, denselben Wert wie für HEAP_MAX_SIZE festzulegen.<br/><br/>Standardwert: 4096 (MB).| 
| HEAP\_MAX\_SIZE	| Nur WebSphere Application Server Full Profile.<br/><br/>Abhängig vom Umfang der generierten Analysedaten kann mehr Hauptspeicher für die Datenbehandlung erforderlich sein. Legen Sie den Wert so fest, dass für WebSphere Application Server Full Profile eine größere Maximalgröße des Heapspeichers möglich ist. Stellen Sie sicher, dass die für die Komponente "Core OS" von {{ site.data.keys.mf_analytics }} angegebene Speicherkapazität über diesem Wert liegt. Es wird empfohlen, denselben Wert wie für HEAP_MIN_SIZE festzulegen.<br/><br/>Standardwert: 4096 (MB).| 
| WAS\_admin\_user| Nur WebSphere Application Server Full Profile.<br/><br/>Dieser Parameter gibt den Benutzer mit Administratorberechtigung von WebSphere Application Server Full Profile für den Analytics-Server an. Übernehmen Sie für WebSphere Application Server Liberty Profile den Standardwert.| 
| WAS\_admin\_password| Nur WebSphere Application Server Full Profile.<br/><br/>Dieser Parameter gibt das Kennwort des Benutzers mit Administratorberechtigung von WebSphere Application Server Full Profile für den Analytics-Server an. Übernehmen Sie für WebSphere Application Server Liberty Profile den Standardwert.| 
| admin_user| Obligatorisch{::nomarkdown}<ul><li>Wenn das LDAP-Repository nicht aktiviert ist, erstellen Sie zum Schutz der {{ site.data.keys.mf_analytics_console }} einen Standardbenutzer mit Administratorberechtigung.</li><li>Wenn das LDAP-Repository aktiviert ist, geben Sie den Namen des Benutzers mit Administratorberechtigung für {{ site.data.keys.mf_analytics }} an. Dieser Wert wird im LDAP-Repository gespeichert.</li></ul> |
| admin_password| Obligatorisch<ul><li>Wenn kein LDAP-Repository aktiviert ist, geben Sie das Kennwort des Standardbenutzers mit Administratorberechtigung zum Schutz der {{ site.data.keys.mf_analytics_console }} an.</li><li>Wenn ein LDAP-Repository aktiviert ist, geben Sie das Kennwort des Benutzers mit Administratorberechtigung an. Dieser Wert wird im LDAP-Repository gespeichert.</li></ul>{:/} | 
| LDAP_TYPE| Obligatorischer LDAP-Parameter. LDAP-Servertyp Ihrer Benutzerregistry: <br/><br/>None<br/>Die LDAP-Verbindung ist inaktiviert. Wenn dieser Wert festgelegt ist, werden alle anderen LDAP-Parameter nur als Platzhalter betrachtet.<br/><br/>TivoliDirectoryServer<br/>Wählen Sie diesen Wert aus, wenn IBM Tivoli Directory Server als LDAP-Repository verwendet wird.<br/><br/>ActiveDirectory<br/>Wählen Sie diesen Wert aus, wenn Microsoft Active Directory als LDAP-Repository verwendet wird.<br/><br/>Standardwert: None. | 
| LDAP_IP| LDAP-Parameter.     IP-Adresse des LDAP-Servers| 
| LDAP\_SSL\_PORT| Dieser LDAP-Parameter gibt den LDAP-Port für sichere Verbindungen an.| 
| LDAP_PORT| Dieser LDAP-Parameter gibt den LDAP-Port für nicht gesicherte Verbindungen an.| 
| BASE_DN| Dieser LDAP-Parameter gibt den Basis-DN an.| 
| BIND_DN| Dieser LDAP-Parameter gibt den Bindungs-DN an.| 
| BIND_PASSWORD| Dieser LDAP-Parameter gibt das Bindungs-DN-Kennwort an.| 
| REQUIRE_SSL| Setzen Sie diesen LDAP-Parameter für eine sichere Verbindung zum LDAP-Server auf true. {::nomarkdown}<ul><li>Der Wert true gibt an, dass LDAP_SSL_PORT verwendet wird und CERT_FILE_PATH erforderlich ist, um die Zertifizierungsdatei des LDAP-Servers zu finden.</li><li>Der Wert false gibt an, dass LDAP_PORT verwendet wird.</li></ul>{:/}Der Standardwert ist false.| 
| USER_FILTER| Dieser LDAP-Parameter gibt den LDAP-Benutzerfilter an, mit dem die vorhandene Benutzerregistry nach Benutzern durchsucht wird.| 
| GROUP_FILTER| Dieser LDAP-Parameter gibt den LDAP-Gruppenfilter an, mit dem die vorhandene Benutzerregistry nach Gruppen durchsucht wird.| 
| LDAP\_REPOSITORY\_NAME| Dieser LDAP-Parameter gibt den LDAP-Servernamen an.| 
| CERT\_FILE\_PATH| Dieser LDAP-Parameter gibt den Zielpfad für das hochgeladene LDAP-Serverzertifikat an. Er ist obligatorisch, wenn REQUIRE_SSL auf true gesetzt ist.| 
| mfpadmin | Dieser LDAP-Parameter gibt die Verwaltungsrolle für {{ site.data.keys.mf_server }} an:<br/><br/>None<br/>Kein Benutzer<br/><br/>AllAuthenticatedUsers<br/>Authentifizierte Benutzer<br/><br/>Everyone<br/>Alle Benutzer<br/><br/>Standardwert: None. | 
| mfpdeployer | Dieser LDAP-Parameter gibt die Implementiererrolle für {{ site.data.keys.mf_server }} an:<br/><br/>None<br/>Kein Benutzer<br/><br/>AllAuthenticatedUsers<br/>Authentifizierte Benutzer<br/><br/>Everyone<br/>Alle Benutzer<br/><br/>Standardwert: None. | 
| mfpmonitor | Dieser LDAP-Parameter gibt die Monitorrolle für {{ site.data.keys.mf_server }} an:<br/><br/>None<br/>Kein Benutzer<br/><br/>AllAuthenticatedUsers<br/>Authentifizierte Benutzer<br/><br/>Everyone<br/>Alle Benutzer<br/><br/>Standardwert: None. | 
| mfpoperator | Dieser LDAP-Parameter gibt die  Operatorrolle für {{ site.data.keys.mf_server }} an:<br/><br/>None<br/>Kein Benutzer<br/><br/>AllAuthenticatedUsers<br/>Authentifizierte Benutzer<br/><br/>Everyone<br/>Alle Benutzer<br/><br/>Standardwert: None. | 

### MFP IHS Configuration
{: #mfp-ihs-configuration }
Mit diesem Scriptpaket wird IBM HTTP Server als Load Balancer für mehrere Instanzen von
{{ site.data.keys.mf_server }} konfiguriert. Das Paket muss mit der
Softwarekomponente IBM HTTP Server verwendet und nach dieser Softwarekomponente installiert werden. 

| Parameter| Beschreibung | 
|-----------|-------------|
| WAS_ROOT| Dieser obligatorische Parameter gibt das Installationsverzeichnis von WebSphere Application Server Liberty Profile oder WebSphere Application Server Full Profile auf dem Knoten "MobileFirst Platform Server" oder das Installationsverzeichnis für den Deployment Manager auf dem Knoten "DmgrNode" an. In den Musterschablonen wird er dem Ausgabeattribut `install_directory` des Liberty-Profile-Servers, des eigenständigen Servers oder des Deployment Manager zugeordnet.| 
| profile_name| Dieser optionale Parameter gibt den Namen des Profils an, das die Dateien für die WebSphere-Application-Server-Laufzeitumgebung enthält.<br/><br/>In den Musterschablonen wird er dem Ausgabeattribut **dmgr\_profile\_name** des Deployment Manager oder dem Ausgabeattribut **sa\_profile\_name** des eigenständigen Servers zugeordnet.| 
| runtime\_contextRoot\_list| Dieser obligatorische Parameter gibt die Liste der Laufzeitkontextstammverzeichnisse an, die IHS ermöglicht, Anforderungen mit übereinstimmenden Kontextstammverzeichnissen weiterzuleiten. Die Laufzeitkontextstammverzeichnisse müssen jeweils durch ein Semikolon (;) getrennt sein. Beispiel: HelloMobileFirst;HelloWorld<br/><br/>Wichtiger Hinweis: Der Parameter muss an das Kontextstammverzeichnis angeglichen werden, das in "MFP Server Runtime Deployment" angegeben ist. Andernfalls kann IHS Anforderungen mit dem Laufzeitkontextstammverzeichnis nicht ordnungsgemäß weiterleiten.| 
| http_port| Dieser obligatorische Parameter öffnet den Firewall-Port des IHS-Knotens, um den HTTP-Transport von IHS zu {{ site.data.keys.mf_server }} zu ermöglichen. Der Parameter muss auf 9080 gesetzt sein.| 
| https_port| Dieser obligatorische Parameter öffnet den Firewall-Port des IHS-Knotens, um den HTTPS-Transport von IHS zu {{ site.data.keys.mf_server }} zu ermöglichen. Der Parameter muss auf 9443 gesetzt sein.| 
| server_hostname| Dieser obligatorische Parameter gibt den Hostnamen von IBM HTTP Server an. Er wird dem Ausgabeattribut host von IBM HTTP Server in der Musterschablone zugeordnet.| 

### MFP Open Firewall Ports for WAS
{: #mfp-open-firewall-ports-for-was }
Dieses Scriptpaket ist nur auf
die Komponente "Custom Nodes" in der Musterschablone "{{ site.data.keys.product_adj }} (WAS ND)" anwendbar (WebSphere Application Server Network Deployment). Es öffnet die notwendigen Firewallports der benutzerdefinierten Knoten,
die die
{{ site.data.keys.product_adj }}-Verwaltungsservices und die
MobileFirst-Laufzeit bereitstellen. Sie müssen nicht nur einige vordefinierte Ports für
WebSphere Application Server festlegen, sondern auch die anderen Ports
für Verbindungen zum DB2 Server und zum LDAP-Server angeben. 

| Parameter| Beschreibung | 
|-----------|-------------|
| WAS_ROOT| Dieser obligatorische Parameter gibt das Installationsverzeichnis der Komponente "Custom Nodes" von WebSphere Application Server Network Deployment auf dem Knoten "CustomNode" an. In den Musterschablonen wird er dem Ausgabeattribut install_directory des Custom-Nodes-Servers zugeordnet.|
| profile_name| Dieser obligatorische Parameter gibt den Namen des Profils an, das die Dateien für die WebSphere-Application-Server-Laufzeitumgebung enthält. In den Musterschablonen wird er dem Ausgabeattribut cn_profile_name von "Custom Nodes" zugeordnet.| 
| WAS\_admin\_user| Dieser obligatorische Parameter wird in der Musterschablone dem Ausgabeattribut was_admin von "Custom Nodes" zugeordnet.| 
| Ports	| Dieser obligatorische Parameter gibt andere Ports an, die für die Verbindung zum DB2-Server und (optional) zum LDAP-Server geöffnet werden müssen. Die Portwerte können durch ein Semikolon getrennt angegeben werden, z. B. '50000;636'.<br/>br/>Standardwert: 50000.| 

### MFP WAS SDK Level
{: #mfp-was-sdk-level }
Dieses Scriptpaket ist nur anwendbar, wenn die WAS-Profile in der
Musterschablone verfügbar sind (WebSphere Application Server Network Deployment). 

| Parameter| Beschreibung | 
|-----------|-------------|
| WAS_ROOT| Dieser Parameter gibt das Installationsverzeichnis von WebSphere Application Server Liberty Profile oder WebSphere Application Server Full Profile auf dem Knoten "MobileFirst Platform Server" oder das Installationsverzeichnis für den Deployment Manager auf dem Knoten "DmgrNode" an. In den Musterschablonen wird er dem Ausgabeattribut **install_directory** des Liberty-Profile-Servers, des eigenständigen Servers oder des Deployment Manager zugeordnet.|
| profile_name| Dieser Parameter gibt den Namen des Profils an, das die Dateien für die WebSphere-Application-Server-Laufzeitumgebung enthält. In den Musterschablonen wird er dem Ausgabeattribut **dmgr\_profile\_name** des Deployment Manager oder dem Ausgabeattribut **sa\_profile\_name** des eigenständigen Servers zugeordnet.| 
| SDK_name| Name des SDK, das für diese WebSphere-Installation aktiviert werden muss| 

### MFP Runtime DB
{: #mfp-runtime-db }
Mit diesem Scriptpaket wird das Laufzeitdatenbankschema in einer DB2-Datenbank eingerichtet. 

| Parameter| Beschreibung | 
|-----------|-------------|
| db_user| Dieser obligatorische Parameter gibt den Benutzernamen für die Erstellung der Laufzeitdatenbank an. Er kann dem Instanznamen der Datenbankserverkomponente zugeordnet werden. Standardwert: db2inst1.| 
| db_name| Dieser obligatorische Parameter gibt den Datenbanknamen für die Erstellung der Laufzeitdatenbank an. Standardwert: WLRTIME.| 
| db_password| Dieser obligatorische Parameter gibt das Benutzerkennwort für die Erstellung der Laufzeitdatenbank an. Er kann dem Instanzeigner der Datenbankserverkomponente zugeordnet werden. Standardwert: passw0rd (als Parameter auf Musterebene).| 
| other\_db\_args|	Vier obligatorische Parameter für die Erstellung der Laufzeitdatenbank: SQL type, Codeset,Territory und Collate. Standardwert: DB2 UTF-8 US SYSTEM.| 

### MFP Server Administration
{: #mfp-server-administration }
Mit diesem Scriptpaket wird die {{ site.data.keys.product_adj }}-Verwaltung
(einschließlich der {{ site.data.keys.mf_console }}) auf einem Server mit
WebSphere Application Server Full Profile
oder
WebSphere Application Server Liberty Profile eingerichtet. Außerdem wird die Verbindung zu einem externen TDS- oder AD-Server konfiguriert und werden die
Verwaltungssicherheitsrollen einem externen
TDS- oder AD-Server zugeordnet. 

Das Scriptpaket muss
mit der Serversoftwarekomponente von
WebSphere Application Server Liberty Profile oder WebSphere Application Server Full Profile
verwendet werden (Anzeigename: Standalone Server) und nach dem Paket "MFP Server Prerequisite", aber vor allen anderen
MFP*-Scriptpaketen auf dem VM-Knoten mit {{ site.data.keys.mf_server }}
installiert werden. 

| Parameter| Beschreibung |
|-----------|-------------|
| WAS_ROOT| Dieser obligatorische Parameter gibt das Installationsverzeichnis von WebSphere Application Server Liberty Profile oder WebSphere Application Server Full Profile auf dem Knoten "MobileFirst Platform Server" oder das Installationsverzeichnis für den Deployment Manager auf dem Knoten "DmgrNode" an. In den Musterschablonen wird er dem Ausgabeattribut `install_directory` des Liberty-Profile-Servers, des eigenständigen Servers oder des Deployment Manager zugeordnet.| 
| profile_name| Dieser optionale Parameter gibt den Namen des Profils an, das die Dateien für die WebSphere-Application-Server-Laufzeitumgebung enthält. In den Musterschablonen wird er dem Ausgabeattribut dmgr_profile_name des Deployment Manager oder dem Ausgabeattribut sa_profile_name des eigenständigen Servers zugeordnet.| 
| NUMBER\_OF\_CLUSTERMEMBERS| Dieser optionale Parameter gilt nur für die Musterschablone "{{ site.data.keys.product }} (WAS ND)". Er gibt die Anzahl der Cluster-Member des Clusters an, in dem der MFP-Verwaltungsservice implementiert werden soll. Standardwert: 2.| 
| db_user| Dieser obligatorische Parameter gibt den Namen des Benutzers an, der die Verwaltungsdatenbank erstellt hat. In der Musterschablone wird er dem Ausgabeattribut db_user des Scriptpakets MFP Administration DB zugeordnet.| 
| db_name| Dieser obligatorische Parameter gibt den Namen der Verwaltungsdatenbank an. In der Musterschablone wird er dem Ausgabeattribut `db_name` des Scriptpakets MFP Administration DB zugeordnet.| 
| db_password|	Dieser obligatorische Parameter gibt das Kennwort des Benutzers an, der die Verwaltungsdatenbank erstellt hat. In der Musterschablone wird er dem Ausgabeattribut db_password des Scriptpakets MFP Administration DB zugeordnet. | 
| db_ip| Dieser Parameter gibt die IP-Adresse des Datenbankservers an, auf dem die Verwaltungsdatenbank installiert ist. In der Musterschablone wird er dem Ausgabeattribut IP der Datenbankserversoftwarekomponente zugeordnet.| 
| db_port|  Dieser Parameter gibt die Portnummer des Datenbankservers an, auf dem die Verwaltungsdatenbank installiert ist. In der Musterschablone wird er dem Ausgabeattribut instancePort der Softwarekomponente Database Server zugeordnet. | 
| admin_user| Dieser Parameter gibt den Namen des Benutzers mit Administratorberechtigung für {{ site.data.keys.mf_server }} an.{::nomarkdown}<ul><li>Wenn LDAP_TYPE auf None gesetzt ist, wird der Standardbenutzer mit Administratorberechtigung erstellt.</li><li>Wenn LDAP_TYPE auf TivoliDirectoryServer oder ActiveDirectory gesetzt ist und andere LDAP-Parameter entsprechend Ihrer LDAP-Serverkonfiguration angegeben sind, muss der Wert von admin_user aus dem konfigurierten LDAP-Benutzerrepository übernommen werden. Der Parameter ist nicht erforderlich, wenn {{ site.data.keys.mf_server }} auf einem Einzelknoten mit WebSphere Application Server Full Profile implementiert werden soll.</li></ul> | 
| admin_password| Dieser Parameter gibt das Kennwort des Benutzers mit Administratorberechtigung an.<ul><li>Wenn LDAP_TYPE auf None gesetzt ist, wird das Standardkennwort für den Benutzer mit Administratorberechtigung erstellt.</li><li>Wenn ein externer LDAP-Server konfiguriert ist, wird das Benutzerkennwort aus dem LDAP-Repository übernommen. Der Parameter ist nicht erforderlich, wenn {{ site.data.keys.mf_server }} auf einem Einzelknoten mit WebSphere Application Server Full Profile implementiert werden soll.</li></ul> | 
| install_console| Dieser Parameter gibt an, ob die {{ site.data.keys.mf_console }} auf dem MobileFirst-Platform-Server-Knoten implementiert werden soll. Standardwert: Kontrollkästchen ausgewählt|
| WAS\_admin\_user| Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Full Profile implementiert ist, wird dieser optionale Parameter in der Musterschablone dem Ausgabeattribut was_admin des eigenständigen Servers zugeordnet. Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Network Deployment implementiert ist, wird dieser Parameter in der Musterschablone dem Ausgabeattribut was_admin des Deployment Manager zugeordnet.| 
| WAS\_admin\_password| Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Full Profile implementiert ist, wird dieser optionale Parameter in der Musterschablone dem Ausgabeattribut was\_admin\_password des eigenständigen Servers zugeordnet. Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Network Deployment implementiert ist, wird dieser Parameter in der Musterschablone dem Ausgabeattribut was\_admin\_password des Deployment Manager zugeordnet.| 
| server_hostname| Dieser obligatorische Parameter gibt den Hostnamen des {{ site.data.keys.mf_server }} oder des Deployment Manager an. Er wird dem Ausgabeattribut host des Liberty-Profile-Servers, des eigenständigen Servers oder des Deployment Manager zugeordnet.| 
| server\_farm\_mode| Dieser obligatorische Parameter gibt an, ob {{ site.data.keys.mf_server }} im Server-Farmmodus implementiert werden soll. Er muss für eine Server-Farmtopologie ausgewählt und für eine eigenständige Topologie abgewählt sein. Standardwert: Einstellung gemäß der in der Musterschablone definierten Topologie.| 
| webserver_ip| Wenn IBM HTTP Server in der Musterschablone implementiert ist, wird dieser optionale Parameter dem Ausgabeattribut IP von IBM HTTP Server zugeordnet.| 
| LDAP_TYPE| Obligatorischer LDAP-Parameter. LDAP-Servertyp Ihrer Benutzerregistry. Gültige Werte:<ul>None – Die LDAP-Verbindung ist inaktiviert. Wenn dieser Wert ausgewählt ist, werden alle anderen LDAP-Parameter nur als Platzhalter betrachtet.</li><li>TivoliDirectoryServer: Wählen Sie diesen Wert aus, wenn IBM Tivoli Directory Server als LDAP-Repository verwendet wird.</li><li>ActiveDirectory: Wählen Sie diesen Wert aus, wenn Microsoft Active Directory als LDAP-Repository verwendet wird.</li></ul>{:/}Standardwert: None. | 
| LDAP_IP| Dieser LDAP-Parameter gibt die IP-Adresse des LDAP-Servers an.| 
| LDAP_SSL_PORT| Dieser LDAP-Parameter gibt den LDAP-Port für sichere Verbindungen an.| 
| LDAP_PORT| Dieser LDAP-Parameter gibt den LDAP-Port für nicht gesicherte Verbindungen an.| 
| BASE_DN| Dieser LDAP-Parameter gibt den Basis-DN an.| 
| BIND_DN| Dieser LDAP-Parameter gibt den Bindungs-DN an.| 
| BIND_PASSWORD| Dieser LDAP-Parameter gibt das Bindungs-DN-Kennwort an.| 
| REQUIRE_SSL| Dieser LDAP-Parameter wird für eine sichere Verbindung zum LDAP-Server auf true gesetzt.{::nomarkdown}<ul><li>Der Wert true gibt an, dass LDAP\_SSL\_PORT verwendet wird und CERT\_FILE\_PATH erforderlich ist, um die Zertifizierungsdatei des LDAP-Servers zu finden.</li><li>Der Wert false gibt an, dass LDAP_PORT verwendet wird.</li></ul>{:/}Der Standardwert ist false.| 
| USER_FILTER| Dieser LDAP-Parameter gibt den Benutzerfilter an, mit dem die vorhandene Benutzerregistry nach Benutzern durchsucht wird.| 
| GROUP_FILTER| Dieser LDAP-Parameter gibt den LDAP-Gruppenfilter an, mit dem die vorhandene Benutzerregistry nach Gruppen durchsucht wird.| 
| LDAP\_REPOSITORY\_NAME| Dieser LDAP-Parameter gibt den LDAP-Servernamen an.| 
| CERT\_FILE\_PATH| Dieser LDAP-Parameter gibt den Zielpfad für das hochgeladene LDAP-Serverzertifikat an. Er ist obligatorisch, wenn REQUIRE_SSL auf true gesetzt ist.| 
| mfpadmin | Verwaltungsrolle für {{ site.data.keys.mf_server }}. Gültige Werte:<br/><br/>None<br/>Kein Benutzer<br/><br/>AllAuthenticatedUsers<br/>Authentifizierte Benutzer<br/><br/>Everyone<br/>Alle Benutzer<br/><br/>Standardwert: None. | 
| mfpdeployer | Dieser LDAP-Parameter gibt die Implementiererrolle für {{ site.data.keys.mf_server }} an:<br/><br/>None<br/>Kein Benutzer<br/><br/>AllAuthenticatedUsers<br/>Authentifizierte Benutzer<br/><br/>Everyone<br/>Alle Benutzer<br/><br/>Standardwert: None. | 
| mfpmonitor | Dieser LDAP-Parameter gibt die Monitorrolle für {{ site.data.keys.mf_server }} an:<br/><br/>None<br/>Kein Benutzer<br/><br/>AllAuthenticatedUsers<br/>Authentifizierte Benutzer<br/><br/>Everyone<br/>Alle Benutzer<br/><br/>Standardwert: None. | 
| mfpoperator | Dieser LDAP-Parameter gibt die  Operatorrolle für {{ site.data.keys.mf_server }} an:<br/><br/>None<br/>Kein Benutzer<br/><br/>AllAuthenticatedUsers<br/>Authentifizierte Benutzer<br/><br/>Everyone<br/>Alle Benutzer<br/><br/>Standardwert: None. | 

### MFP Server Application Adapter Deployment
{: #mfp-server-application-adapter-deployment }
Mit diesem Scriptpaket werden Anwendungen und Adapter
in {{ site.data.keys.mf_server }} implementiert. Es muss
nach dem Scriptpaket "MFP Server Runtime Deployment" installiert werden, mit dem die Laufzeit installiert wurde, in der die Anwendungen und Adapter
implementiert werden sollen. 

| Parameter| Beschreibung | 
|-----------|-------------|
| artifact_dir| Dieser obligatorische Parameter gibt den Installationspfad von Anwendungen und Adaptern für die Implementierung an. In der Musterschablone wird er dem Ausgabeattribut target_path der {{ site.data.keys.product_adj }}-App-Komponente zugeordnet.| 
| admin_context| Dieser obligatorische Parameter muss auf mfpadmin gesetzt sein.| 
| runtime_context| Dieser obligatorische Parameter muss an das Laufzeitkontextstammverzeichnis angeglichen werden, das in der Komponente "MFP Server Runtime Deployment" angegeben ist. Er wird dem Ausgabeattribut runtime_contextRoot der Komponente "MFP Server Runtime Deployment" zugeordnet.| 
| deployer_user| Dieser obligatorische Parameter gibt das Benutzerkonto mit der Implementierungsberechtigung für Anwendungen und Adapter an. Der Parameter wird in der Musterschablone als Parameter auf Musterebene festgelegt.| 
| deployer_password| Dieser obligatorische Parameter gibt das Kennwort des Benutzers mit der Implementierungsberechtigung für Anwendungen und Adapter an. Der Parameter wird in der Musterschablone als Parameter auf Musterebene festgelegt.| 
| webserver_ip| Wenn IBM HTTP Server in der Musterschablone implementiert ist, wird dieser optionale Parameter dem gleichen Ausgabeattribut von "MFP Server Administration" zugeordnet.| 

### MFP Server Application Center
{: #mfp-server-application-center }
Mit diesem Scriptpaket wird der MobileFirst-Application-Center-Server in WebSphere Application Server Full Profile oder WebSphere Application Server Liberty Profile eingerichtet. Es muss mit der Serversoftwarekomponente "MFP Server Prerequisite" oder "WebSphere Application Server Full Profile (Standalone Server)", "MFP WAS SDK Level" und "MFP Server Prerequisite" verwendet werden. Es muss nach der Softwarekomponente "Liberty Profile" oder "Standalone Server" installiert werden. 

| Parameter| Beschreibung | 
|-----------|-------------|
| WAS_ROOT| Dieser obligatorische Parameter gibt das Installationsverzeichnis von WebSphere Application Server Liberty Profile oder WebSphere Application Server Full Profile auf dem Knoten "MobileFirst Platform Server" an. In den Musterschablonen wird er dem Ausgabeattribut `install_directory` des Liberty-Profile-Servers oder eigenständigen Servers zugeordnet.| 
| profile_name| Dieser Parameter gibt den Namen des Profils an, das die Dateien für die WebSphere-Application-Server-Laufzeitumgebung enthält. In den Musterschablonen wird er dem Ausgabeattribut sa_profile_name des "Standalone Server" zugeordnet.| 
| db_instance| Name der Datenbankinstanz. In der Musterschablone wird er dem Ausgabeattribut instancePort der Softwarekomponente Database Server zugeordnet. | 
| db_user| Dieser Parameter gibt den Namen des Benutzers an, der die Verwaltungsdatenbank erstellt hat. In der Musterschablone wird er dem Ausgabeattribut db_user des Scriptpakets MFP Administration DB zugeordnet.| 
| db_name| Dieser Parameter gibt den Namen der Verwaltungsdatenbank an. In der Musterschablone wird er dem Ausgabeattribut `db_name` des Scriptpakets MFP Administration DB zugeordnet.|
| db_password| Dieser Parameter gibt das Kennwort des Benutzers an, der die Verwaltungsdatenbank erstellt hat. In der Musterschablone wird er dem Ausgabeattribut db_password des Scriptpakets MFP Administration DB zugeordnet. | 
| db_ip| Dieser Parameter gibt die IP-Adresse des Datenbankservers an, auf dem die Verwaltungsdatenbank installiert ist. In der Musterschablone wird er dem Ausgabeattribut IP der Datenbankserversoftwarekomponente zugeordnet.| 
| db_port| Dieser Parameter gibt die Portnummer des Datenbankservers an, auf dem die Verwaltungsdatenbank installiert ist. In der Musterschablone wird er dem Ausgabeattribut instancePort der Softwarekomponente Database Server zugeordnet. |
| admin_user| Dieser Parameter gibt den Namen des Benutzers mit Administratorberechtigung für {{ site.data.keys.mf_server }} an.<br/><br/>Er wird in der Musterschablone als Parameter auf Musterebene dem gleichnamigen Parameter im Scriptpaket MFP Server Administration zugeordnet, um sicherzustellen, dass beide Parameter auf denselben Wert gesetzt sind.| 
| admin_password| Kennwort des Benutzers mit Administratorberechtigung.<br/><br/>Er wird in der Musterschablone als Parameter auf Musterebene dem gleichnamigen Parameter im Scriptpaket MFP Server Administration zugeordnet, um sicherzustellen, dass beide Parameter auf denselben Wert gesetzt sind.| 
| WAS\_admin\_user| Obligatorisch für WebSphere Application Server und optional für WebSphere Application Server Liberty. Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Full Profile implementiert ist, wird dieser optionale Parameter in der Musterschablone dem Ausgabeattribut was_admin des eigenständigen Servers zugeordnet.<br/><br/>Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Network Deployment implementiert ist, wird dieser Parameter in der Musterschablone dem Ausgabeattribut was_admin des Deployment Manager zugeordnet.| 
| WAS\_admin\_password| Obligatorisch für WebSphere Application Server und optional für WebSphere Application Server Liberty. Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Full Profile implementiert ist, wird dieser Parameter in der Musterschablone dem Ausgabeattribut was\_admin\_password des eigenständigen Servers zugeordnet.|
| server_hostname| Dieser Parameter gibt den Hostnamen von {{ site.data.keys.mf_server }} an. Er wird dem Ausgabeattribut host des Liberty-Profile-Servers oder des eigenständigen Servers (Standalone Server) zugeordnet.|
| LDAP_TYPE| Obligatorischer LDAP-Parameter. LDAP-Servertyp Ihrer Benutzerregistry:<br/><br/>None<br/>Die LDAP-Verbindung ist inaktiviert. Wenn dieser Wert festgelegt ist, werden alle anderen LDAP-Parameter nur als Platzhalter betrachtet.<br/><br/>TivoliDirectoryServer<br/>Wählen Sie diesen Wert aus, wenn IBM Tivoli Directory Server als LDAP-Repository verwendet wird.<br/><br/>ActiveDirectory<br/>Wählen Sie diesen Wert aus, wenn Microsoft Active Directory als LDAP-Repository verwendet wird.<br/><br/>Standardwert: None. | 
| LDAP_IP| LDAP-Parameter.     IP-Adresse des LDAP-Servers| 
| LDAP\_SSL\_PORT| Dieser LDAP-Parameter gibt den LDAP-Port für sichere Verbindungen an.| 
| LDAP_PORT| Dieser LDAP-Parameter gibt den LDAP-Port für nicht gesicherte Verbindungen an.| 
| BASE_DN| Dieser LDAP-Parameter gibt den Basis-DN an.| 
| BIND_DN| Dieser LDAP-Parameter gibt den Bindungs-DN an.| 
| BIND_PASSWORD| Dieser LDAP-Parameter gibt das Bindungs-DN-Kennwort an.| 
| REQUIRE_SSL| Setzen Sie diesen LDAP-Parameter für eine sichere Verbindung zum LDAP-Server auf true. {::nomarkdown}<ul><li>Der Wert true gibt an, dass LDAP_SSL_PORT verwendet wird und CERT_FILE_PATH erforderlich ist, um die Zertifizierungsdatei des LDAP-Servers zu finden.</li><li>Der Wert false gibt an, dass LDAP_PORT verwendet wird.</li></ul>Der Standardwert ist false.| 
| USER_FILTER| Dieser LDAP-Parameter gibt den LDAP-Benutzerfilter an, mit dem die vorhandene Benutzerregistry nach Benutzern durchsucht wird.| 
| GROUP_FILTER| Dieser LDAP-Parameter gibt den LDAP-Gruppenfilter an, mit dem die vorhandene Benutzerregistry nach Gruppen durchsucht wird.| 
| LDAP\_REPOSITORY\_NAME| Dieser LDAP-Parameter gibt den LDAP-Servernamen an.| 
| CERT\_FILE\_PATH| Dieser LDAP-Parameter gibt den Zielpfad für das hochgeladene LDAP-Serverzertifikat an. Er ist obligatorisch, wenn REQUIRE_SSL auf true gesetzt ist.| 
| appcenteradmin| Verwaltungsrolle für {{ site.data.keys.mf_app_center }}. Verwenden Sie einen der folgenden Werte:<ul><li>None</li><li>Kein Benutzer</li><li>AllAuthenticatedUsers</li>Authentifizierte Benutzer</li><li>Everyone</li><li>Alle Benutzer</li></ul>{:/}Standardwert: None| 

### MFP Server Prerequisite
{: #mfp-server-prerequisite }
Dieses Scriptpaket enthält alle vorausgesetzten Komponenten
für die Installation
von {{ site.data.keys.mf_server }},
einschließlich des DB2-JDBC-Treibers und Apache Ant. Das Scriptpaket muss
mit der Serversoftwarekomponente von
WebSphere Application Server Liberty Profile oder WebSphere Application Server Full Profile
verwendet werden (Anzeigename: Standalone Server) und nach der Serversoftwarekomponete, aber vor allen anderen
MFP*-Scriptpaketen auf dem MobileFirst-Platform-Server-Knoten
installiert werden. 

| Parameter| Beschreibung |
|-----------|-------------|
| Keiner | Es gibt keine Parameter für dieses Scriptpaket.| 

### MFP Server Runtime Deployment
{: #mfp-server-runtime-deployment }
Mit diesem Scriptpaket wird die MobileFirst-Foundation-Laufzeit
auf einem Server mit WebSphere Application Server Full Profile
oder
WebSphere Application Server Liberty Profile und mit installierter {{ site.data.keys.mf_console }}
installiert. Das Scriptpaket richtet auch die Verbindung
zum {{ site.data.keys.mf_analytics_server }}
ein. Es muss nach dem Scriptpaket "MFP Server Administration" installiert werden. 

| Parameter| Beschreibung |
|-----------|-------------|
| WAS_ROOT| Dieser obligatorische Parameter gibt das Installationsverzeichnis von WebSphere Application Server Liberty Profile oder WebSphere Application Server Full Profile auf dem Knoten "MobileFirst Platform Server" oder das Installationsverzeichnis für den Deployment Manager auf dem Knoten "DmgrNode" an. In den Musterschablonen wird er dem Ausgabeattribut install_directory des Liberty-Profile-Servers oder eigenständigen Servers zugeordnet.| 
| profile_name| Dieser optionale Parameter gibt den Namen des Profils an, das die Dateien für die WebSphere-Application-Server-Laufzeitumgebung enthält. In den Musterschablonen wird er dem Ausgabeattribut **dmgr\_profile\_name** des Deployment Manager oder dem Ausgabeattribut **sa\_profile\_name** des eigenständigen Servers zugeordnet.|
| NUMBER\_OF\_CLUSTERMEMBERS| Dieser optionale Parameter gilt nur für die Musterschablone "{{ site.data.keys.product }} (WAS ND)". Er gibt die Anzahl der Cluster-Member des Clusters an, in dem die MFP-Laufzeit implementiert werden soll. Standardwert: 2.| 
| db_ip| Dieser Parameter gibt die IP-Adresse des Datenbankservers an, auf dem die Laufzeitdatenbank (und optional die Berichtsdatenbank) installiert ist. In der Musterschablone wird er dem Ausgabeattribut IP der Datenbankserversoftwarekomponente zugeordnet.|
| db_port| Dieser Parameter gibt die Portnummer des Datenbankservers an, auf dem die Laufzeitdatenbank (und optional die Berichtsdatenbank) installiert ist. In der Musterschablone wird er dem Ausgabeattribut instancePort der Datenbankserversoftwarekomponente zugeordnet.|
| admin_user| Dieser obligatorische Parameter gibt den Namen des Benutzers mit Administratorberechtigung für {{ site.data.keys.mf_server }} an. Er wird in der Musterschablone als Parameter auf Musterebene dem gleichnamigen Parameter im Scriptpaket MFP Server Administration zugeordnet, um sicherzustellen, dass beide Parameter auf denselben Wert gesetzt sind.| 
| admin_password| Dieser obligatorische Parameter gibt das Kennwort des Benutzers mit Administratorberechtigung an. Er wird in der Musterschablone als Parameter auf Musterebene dem gleichnamigen Parameter im Scriptpaket MFP Server Administration zugeordnet, um sicherzustellen, dass beide Parameter auf denselben Wert gesetzt sind.| 
| runtime_path| Dieser obligatorische Parameter gibt den Installationspfad für die Laufzeit-WAR-Datei an. Er kann in der Musterschablone beispielsweise dem Ausgabeattribut target_path der Komponente "MFP Server Runtime" zugeordnet werden.| 
| runtime_contextRoot| Dieser obligatorische Parameter gibt das Laufzeitkontextstammverzeichnis an. Er muss mit einem Schrägstrich (/) beginnen, z. B. "/HelloWorld". Der Parameter wird in der Musterschablone als Parameter auf Musterebene festgelegt.| 
| rtdb_name| Dieser obligatorische Parameter gibt den Namen der Laufzeitdatenbank an. In der Musterschablone wird er dem Ausgabeattribut `db_name` des Scriptpakets "MFP Runtime DB" zugeordnet.| 
| rtdb_user| Dieser obligatorische Parameter gibt den Benutzer an, der die Laufzeitdatenbank erstellt hat. In der Musterschablone wird er dem Ausgabeattribut `db_user` des Scriptpakets "MFP Runtime DB" zugeordnet.|
| rtdb_password| Dieser obligatorische Parameter gibt das Kennwort des Benutzers an, der die Laufzeitdatenbank erstellt hat. In der Musterschablone wird er dem Ausgabeattribut `db_password` des Scriptpakets "MFP Runtime DB" zugeordnet.|
| rptdb_name| Dieser optionale Parameter gibt den Namen der Berichtsdatenbank an. In der Musterschablone wird er dem Ausgabeattribut `db_name` des Scriptpakets "MFP Reports DB" zugeordnet. Machen Sie keine Angabe, wenn Sie keine Verbindung zu einer Berichtsdatenbank herstellen möchten.|
| rptdb_user| Dieser optionale Parameter gibt den Benutzer an, der die Berichtsdatenbank erstellt hat. In der Musterschablone wird er dem Ausgabeattribut `db_user` des Scriptpakets "MFP Reports DB" zugeordnet.| 
| rptdb_password| Dieser optionale Parameter gibt das Kennwort des Benutzers an, der die Berichtsdatenbank erstellt hat. In der Musterschablone wird er dem Ausgabeattribut `db_password` des Scriptpakets "MFP Reports DB" zugeordnet.\ 
| was\_admin\_user	| Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Full Profile implementiert ist, wird dieser optionale Parameter in der Musterschablone dem Ausgabeattribut was_admin des eigenständigen Servers zugeordnet. Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Network Deployment implementiert ist, wird dieser Parameter in der Musterschablone dem Ausgabeattribut was_admin des Deployment Manager zugeordnet.|
| was_admin_password| Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Full Profile implementiert ist, wird dieser optionale Parameter in der Musterschablone dem Ausgabeattribut was_admin_password des eigenständigen Servers zugeordnet. Wenn {{ site.data.keys.mf_server }} in WebSphere Application Server Network Deployment implementiert ist, wird dieser Parameter in der Musterschablone dem Ausgabeattribut was_admin_password des Deployment Manager zugeordnet.| 
| server_farm_mode| Dieser obligatorische Parameter wird dem gleichnamigen Attribut in "MFP Server Administration" zugeordnet.| 
| server_hostname| Dieser obligatorische Parameter gibt den Hostnamen von {{ site.data.keys.mf_server }} an. Er wird dem Ausgabeattribut host des Liberty-Profile-Servers, des eigenständigen Servers oder des Deployment Manager zugeordnet.|
| analytics_ip| Dieser optionale Parameter gibt die IP-Adresse des Knotens mit {{ site.data.keys.mf_analytics }} an, um die Analysefunktionalität der Komponente "MFP Server Runtime" zu aktivieren.|
| analytics_admin_user| Dieser optionale Parameter gibt den Namen des Administrators für den {{ site.data.keys.mf_analytics_server }} an.| 
| analytics_admin_password| Dieser optionale Parameter gibt das Kennwort des Administrators für den {{ site.data.keys.mf_analytics_server }} an.| 

## Upgrade für {{ site.data.keys.mf_system_pattern }}
{: #upgrading-mobilefirst-system-pattern }
Wenn Sie in Upgrade für {{ site.data.keys.mf_system_pattern }}
durchführen möchten, müssen Sie die Datei **.tgz** mit den neuesten Updates
hochladen. 

1. Melden Sie sich beim IBM PureApplication System mit einem Account an, der die Berechtigung hat, neue System-Plug-ins hochzuladen.
2. Navigieren Sie in der Konsole von IBM PureApplication System zu **Katalog → System-Plug-ins**.
3. Laden Sie die **.tgz**-Datei hoch, die die Aktualisierungen für {{ site.data.keys.mf_system_pattern }} enthält.
4. Aktivieren Sie die hochgeladenen Plug-ins.
5. Implementieren Sie das Muster neu.

