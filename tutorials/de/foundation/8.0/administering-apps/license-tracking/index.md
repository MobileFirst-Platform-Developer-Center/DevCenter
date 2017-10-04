---
layout: tutorial
title: Lizenzüberwachung
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die Lizenzüberwachung ist in der
{{ site.data.keys.product_full }} standardmäßig aktiviert, sodass
für die Lizenzierungsrichtlinie relevante Metriken wie aktive Clientgeräte,
adressierbare Geräte und installierte Apps überwacht werden.Mithilfe dieser Angaben kann festgestellt werden,
ob die aktuelle
Nutzung der {{ site.data.keys.product }} im Rahmen der Lizenzberechtigungen
liegt. Potenzielle Lizenzverstöße lassen sich so verhindern.

Dadurch, dass {{ site.data.keys.product_adj }}-Administratoren die Nutzung der Clientgeräte überwachen, können
sie feststellen, ob die Geräte aktiv sind, und Geräte stilllegen, die nicht mehr auf die
{{ site.data.keys.mf_server }} zugreifen. Dies träfe beispielsweise zu, wenn ein Mitarbeiter das
Unternehmen verlässt. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }

* [Angaben zur Anwendungslizenz festlegen](#setting-the-application-license-information)
* [Lizenzüberwachungsbericht](#license-tracking-report)
* [Validierung von Tokenlizenzen](#token-license-validation)
* [Integration des IBM License Metric Tool](#integration-with-ibm-license-metric-tool)

## Angaben zur Anwendungslizenz festlegen
{: #setting-the-application-license-information }
Hier erfahren Sie, wie die Angaben zur Anwendungslizenz für Apps, die Sie bei
{{ site.data.keys.mf_server }} registrieren, festgelegt werden.

In den Lizenzbedingungen wird zwischen
{{ site.data.keys.product_full }},
{{ site.data.keys.product_full }} Consumer,
{{ site.data.keys.product_full }} Enterprise und IBM {{ site.data.keys.product_adj }} Additional Brand Deployment unterschieden. Legen Sie die Lizeninformationen einer Anwendung fest, wenn Sie sie bei einem Server registrieren, damit die richtigen Lizenzinformationen für
die Lizenzüberwachungsberichte
generiert werden. Wenn Ihr Server für die Tokenlizenzierung konfiguriert ist, checkt der Lizenzserver ausgehend von den Lizenzinformationen das richtige Feature aus. 

Sie können den Anwendungstyp und den Tokenlizenztyp
festlegen. Gültige Werte für den Anwendungstyp:   

* **B2C**: Verwenden Sie diesen Anwendungstyp, wenn Ihre Anwendung für {{ site.data.keys.product_full }} Consumer lizenziert ist.
* **B2E**: Verwenden Sie diesen Anwendungstyp, wenn Ihre Anwendung für {{ site.data.keys.product_full }} Enterprise lizenziert ist.
* **UNDEFINED**: Verwenden Sie diesen Anwendungstyp, wenn Sie die Konformität für die Metrik "Adressierbare Geräte" nicht verfolgen möchten. 

Gültige Werte für den Tokenlizenztyp: 

* **APPLICATION**: Dies ist der Standardwert, den Sie für die meisten Anwendungen verwenden können. 
* **ADDITIONAL\_BRAND\_DEPLOYMENT**: Verwenden Sie ADDITIONAL\_BRAND\_DEPLOYMENT, wenn Ihre Anwendung
als IBM {{ site.data.keys.product_adj }} Additional Brand Deployment lizenziert ist.
* **NON_PRODUCTION**: Verwenden Sie NON\_PRODUCTION, wenn Sie die Anwendung auf dem
Produktionsserver entwickeln und testen. Für Anwendungen mit demn
Tokenlizenztyp NON_PRODUCTION wird kein Token ausgecheckt. 

> **Wichtiger Hinweis:** Die Verwendung
von NON_PRODUCTION für eine in der Produktion eingesetzte App stellt einen Bruch der Lizenzvereinbarung
dar. 

**Hinweis:** Wenn Ihr Server für die Tokenlizenzierung konfiguriert ist und Sie eine Anwendung mit dem
Tokenlizenztyp ADDITIONAL\_BRAND\_DEPLOYMENT oder NON_PRODUCTION registrieren möchten, legen Sie die
Lizenzinformationen für die Anwendung fest, bevor Sie die erste Version der Anwendung registrieren. Mit dem Programm mfpadm können Sie die Lizeninformationen
für eine Anwendung festlegen, bevor eine Version registriert wird. Nach dem Festlegen der Lizenzinformationen wird beim Registrieren der ersten Version der App die richtige
Anzahl Token ausgecheckt. Weitere Informationen zur Tokenvalidierung finden Sie unter "Validierung von Tokenlizenzen". 

Gehen Sie wie folgt vor, um den Lizenztyp in der {{ site.data.keys.mf_console }} festzulegen: 

1. Wählen Sie Ihre Anwendung aus. 
2. Wählen Sie **Einstellungen** aus. 
3. Legen Sie den **Anwendungstyp** und den **Tokenlizenztyp** fest. 
4. Klicken Sie auf **Speichern**. 

Wenn Sie den Lizenztyp mit dem Programm mfpadm festlegen möchten, verwenden Sie `mfpadm app <App-Name> set license-config <Anwendungstyp> <Tokenlizenztyp>`. 

Im folgenden Beispiel werden für die Anwendung
**my.test.application** die Lizeninformationen B2E/APPLICATION festgelegt. 

```bash
echo password:admin > password.txt
mfpadm --url https://localhost:9443/mfpadmin --secure false --user admin \ --passwordfile password.txt \ app mfp my.test.application ios 0.0.1 set license-config B2E APPLICATION
rm password.txt
```

## Lizenzüberwachungsbericht
{: #license-tracking-report }
Die {{ site.data.keys.product }} stellt für die Metriken
"Clientgeräte", "Adressierbare Geräte" und "Anwendungen" einen Lizenzüberwachungsbericht bereit. Dieser Bericht enthält auch Langzeitdaten.

Der Lizenzüberwachungsbericht präsentiert die folgenden Daten:

* Anzahl der im {{ site.data.keys.mf_server }} implementierten Anwendungen
* Anzahl der adressierbaren Geräte im aktuellen Kalendermonat
* Anzahl der aktiven und stillgelegten Clientgeräte
* Gemeldete Höchstzahl von Clientgeräten in den letzten n Tagen, wobei n die Anzahl der
Inaktivitätstage ist, nach denen das Gerät
stillgelegt wird

Wenn Sie die Daten weiter analysieren möchten, können Sie eine CSV-Datei herunterladen, die die Lizenzberichte sowie eine Langzeitauflistung der Lizenzmetriken
enthält. 

Gehen Sie für den Zugriff auf den Lizenzüberwachungsbericht wie folgt vor: 

1. Öffnen Sie die {{ site.data.keys.mf_console }}.
2. Klicken Sie auf das Menü **Hallo Ihr_Name**. 
3. Wählen Sie **Lizenzen** aus.

Wenn Sie
den Lizenzüberwachungsbericht als CSV-Datei abrufen möchten, klicken Sie auf **Aktionen: Bericht herunterladen**.

## Validierung von Tokenlizenzen
{: #token-license-validation }
Wenn Sie IBM {{ site.data.keys.mf_server }} für die Tokenlizenzierung installieren und konfigurieren,
werden vom Server Lizenzen in verschiedenen Szenarien validiert. Wenn Ihre Konfiguration nicht korrekt ist, wird die Lizenz bei der Anwendungsregistrierung oder beim Löschen der Anwendung nicht
validiert. 

### Validierungsszenarien
{: #validation-scenarios }
Es gibt verschiedene Szenarien der Lizenzvalidierung: 

#### Registrierung einer Anwendung
{: #on-application-registration }
Die Anwendungsregistrierung schlägt fehl, wenn für den Tokenlizenztyp Ihrer Anwendung nicht genug Token
verfügbar sind. 

> **Tipp:** Bevor Sie die erste Version Ihrer App registrieren, können Sie
den Tokenlizenztyp festlegen. 

Lizenzen werden pro Anewendung einmal überprüft. Wenn Sie für eine Anwendung eine neue Plattform registrieren oder für eine vorhandene Anwendung und Plattform eine neue
Version registrieren, wird ein neues Token angefordert. 

#### Änderung des Tokenlizenztyps
{: #on-token-license-type-change }
Wenn Sie den Tokenlizenztyp für eine Anwendung ändern, werden die Token für die Anwendung freigegeben und dann für den
neuen Lizenztyp zurückgegeben. 

#### Löschen einer Anwendung
{: #on-application-deletion }
Wenn die letzte Version einer Anwendung gelöscht ist, werden die Lizenzen eingecheckt. 

#### Serverstart
{: #at-server-start }
Die Lizenz wird für jede registrierte Anwendung ausgecheckt. Der Server inaktiviert Anwendungen, wenn nicht genug Token für alle Anwendungen
verfügbar sind. 

> **Wichtiger Hinweis:** Die Anwendungen werden nicht automatisch vom Server reaktiviert. Wenn Sie die Anzahl der verfügbaren Token erhöht haben, müssen Sie die Anwendungen
manuell reaktivieren. Weitere Informationen zum Inaktivieren und Aktivieren von Anwendungen finden Sie unter
[Anwendungszugriff auf geschützte Ressourcen über Fernzugriff inaktivieren](../using-console/#remotely-disabling-application-access-to-protected-resources).

#### Ablauf der Lizenz
{: #on-license-expiration }
Nach einer bestimmten Zeit laufen die Lizenzen ab und müssen neu ausgecheckt werden. Der Server inaktiviert Anwendungen, wenn nicht genug Token für alle Anwendungen
verfügbar sind. 

> **Wichtiger Hinweis:** Die Anwendungen werden nicht automatisch vom Server reaktiviert. Wenn Sie die Anzahl der verfügbaren Token erhöht haben, müssen Sie die Anwendungen
manuell reaktivieren. Weitere Informationen zum Inaktivieren und Aktivieren von Anwendungen finden Sie unter
[Anwendungszugriff auf geschützte Ressourcen über Fernzugriff inaktivieren](../using-console/#remotely-disabling-application-access-to-protected-resources).

#### Herunterfahren des Servers
{: #at-server-shutdown }
Die Lizenz für jede implementierte Anwendung wird beim Herunterfahren des Servers eingecheckt. Die Token werden erst freigegeben, wenn der letzte Server
eines Clusters oder einer Farm heruntergefahren ist. 

### Ursachen für Fehler bei der Lizenzvalidierung
{: #causes-of-license-validation-failure }
Die Lizenzvalidierung beim Registrieren oder Löschen der Anwendung kann in folgenden Fällen fehlschlagen: 

* Die native Bibliothek von Rational Common
Licensing ist nicht installiert und konfiguriert. 
* Der Verwaltungsservice ist nicht für die Tokenlizenzierung konfiguriert.
Weitere Informationen finden Sie unter
[Installation und
Konfiguration für die Tokenlizenzierung](../../installation-configuration/production/token-licensing).
* Es kann nicht auf Rational License Key
Server zugegriffen werden. 
* Es sind nicht genug Token verfügbar. 
* Die Lizenz ist abgelaufen.

### IBM Rational License Key Server für die {{ site.data.keys.product_full }}
{: #ibm-rational-license-key-server-feature-name-used-by-ibm-mobilefirst-foundation }
Je nach Lizenztyp einer Anwendung werden die folgenden
Features verwendet. 

| Tokenlizenztyp| Featurename| 
|--------------------|--------------|
| APPLICATION| 	ibmmfpfa| 
| ADDITIONAL\_BRAND\_DEPLOYMENT|	ibmmfpabd| 
| NON_PRODUCTION	| (kein Feature)| 

## Integration des IBM License Metric Tool
{: #integration-with-ibm-license-metric-tool }
Mit dem IBM License Metric Tool können Sie die Einhaltung Ihrer IBM Lizenzbedingungen auswerten. 

Wenn Sie keine Version von IBM License Metric Tool mit Unterstützung für SLMT- (Software License Metric Tag)
oder SWID-Dateien (Software-ID) installiert haben, können Sie die Lizenznutzung
anhand der Lizenzüberwachungsbereichte in der
{{ site.data.keys.mf_console }} überwachen. Weitere Informationen finden Sie unter
[Lizenzüberwachungsbericht](#license-tracking-report).

### PVU-basierte Lizenzierung mit SWID-Dateien
{: #about-pvu-based-licensing-using-swid-files }
Wenn Sie das Angebot IBM MobileFirst Foundation Extension Version 8.0.0 gekauft haben, wird es mit der Metrik Prozessor-Value-Unit
(PVU) lizenziert. 

Die PVU-Berechnung basiert auf der Unterstützung des IBM License Metric Tool für ISO/IEC 19970-2 und für SWID-Dateien. Die SWID-Dateien werden
in den Server geschrieben, wenn IBM Installation Manager {{ site.data.keys.mf_server }} oder {{ site.data.keys.mf_analytics_server }} installiert. Wenn das IBM License Metric Tool
eine laut aktuellem Katalog ungültige SWID-Datei für ein Produkt findet,
wird das Widget "Softwarekatalog" mit einem Warnsymbol angezeigt. Weitere Informationen zur Verwendung von SWID-Dateien durch das
IBM License Metric Tool finden Sie unter
[https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_iso\_tags.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_iso_tags.html).

Die Anzahl der Application-Center-Installationen ist bei PVU-basierter Lizenzierung nicht beschränkt. 

Die PVU-Lizenz für Foundation Extension kann nur zusammen mit einer der folgenden Produktlizenzen erworben werden:
IBM WebSphere  Application Server Network Deployment, IBM API Connect™ Professional oder IBM API Connect Enterprise. IBM Installation Manager
fügt die SWID-Datei hinzu oder aktualisiert sie, damit sie vom License Metric Tool verwendet werden kann.

> Weitere Informationen zu {{ site.data.keys.product_full }} Extension finden Sie unter
[https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN](https://www.ibm.com/common/ssi/cgi-bin/ssialias?infotype=AN&subtype=CA&htmlfid=897/ENUS216-367&appname=USN).

> Weitere Informationen zur PVU-Lizenzierung finden Sie unter [https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c\_processor\_value\_unit\_licenses.html](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html).

### SLMT-Tags
{: #slmt-tags }
Die IBM MobileFirst Foundation
generiert SLMT-Dateien (IBM Software License Metric Tag). Versionen des IBM License Metric Tool, die
SLMT unterstützen, können Berichte zum Lizenzbedarf generieren. In diesem Abschnitt erfahren Sie, wie solche Berichte für
{{ site.data.keys.mf_server }} zu interpretieren sind
und wie die Generierung von SLMT-Dateien konfiguriert wird.

Jede Instanz einer aktiven
MobileFirst-Laufzeitumgebung generiert
eine SLMT-Datei. Die überwachten Metriken sind `CLIENT_DEVICE`, `ADDRESSABLE_DEVICE` und `APPLICATION`.
Die Werte dieser Metriken werden
alle 24 Stunden aktualisiert.

#### Metrik CLIENT_DEVICE
{: #about-the-client_device-metric }
Folgende Subtypen der
Metrik `CLIENT_DEVICE` sind möglich:

* Active Devices

    Anzahl der nicht stillgelegten Clientgeräte,
die die MobileFirst-Laufzeitumgebung oder eine
andere MobileFirst-Laufzeitinstanz
im selben Cluster oder in derselben Server-Farm verwendet haben. Weitere Informationen zu stillgelegten Geräten
finden Sie unter
[Lizenzüberwachung für
Clientgeräte und adressierbare Geräte konfigurieren](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device).

* Inactive Devices

    Anzahl der stillgelegten Clientgeräte,
die die MobileFirst-Laufzeitumgebung oder eine
andere MobileFirst-Laufzeitinstanz
im selben Cluster oder in derselben Server-Farm verwendet haben. Weitere Informationen zu stillgelegten Geräten
finden Sie unter
[Lizenzüberwachung für
Clientgeräte und adressierbare Geräte konfigurieren](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device).

Es gibt folgende Sonderfälle:

* Wenn das Gerät nur für kurze Zeit stillgelegt wird, wird der Subtyp "Inactive Devices" durch den Subtyp "Active or Inactive Devices" ersetzt.
* Bei inaktivierter Geräteüberwachung wird für `CLIENT_DEVICE` nur ein Eintrag mit dem Wert 0 und dem Subtyp "Device Tracking Disabled" generiert.

#### Metrik APPLICATION
{: #about-the-application-metric }
Für die Metrik APPLICATION gibt es keinen Subtyp,
sofern die MobileFirst-Laufzeitumgebung nicht in einem
Entwicklungsserver ausgeführt wird.

Der für diese Metrik gemeldete Wert ist die Anzahl der
in der
MobileFirst-Laufzeitumgebung implementierten Anwendungen. Jede Anwendung wird unabhängig davon, ob es sich um eine neue Anwendung, eine Implementierung eines zusätzlichen Produktbereichs oder
einen zusätzlichen Typ für eine vorhandene Anwendung (z. B. eine native Anwendung, eine Hybrid- oder Webanwendung) handelt,
als eine Einheit gezählt.

#### Metrik ADDRESSABLE_DEVICE
{: #about-the-addressable_device-metric }
Die Metrik ADDRESSABLE_DEVICE hat folgenden Subtyp: 

* Application: `<Anwendungsname>`, Category: `<Anwendungstyp>`

Der Anwendungstyp ist **B2C**, **B2E** oder
**UNDEFINED**. Wie der Anwendungstyp für eine Anwendung definiert wird, erfahren Sie unter [Daten der Anwendungslizenz festlegen](#setting-the-application-license-information).

Es gibt folgende Sonderfälle:

* Wenn das Gerät für weniger als 30 Tage stillgelegt wird, wird an den Subtyp die Warnung "Short decommissioning period"
angefügt. 
* Bei inaktivierter Lizenzüberwachung wird kein Bericht zu adressierbaren Geräten generiert. 

Weitere Informationen zur Lizenzüberwachung finden
Sie unter: 

* [Lizenzüberwachung für
Clientgeräte und adressierbare Geräte konfigurieren](../../installation-configuration/production/server-configuration/#configuring-license-tracking-for-client-device-and-addressable-device)
* [Protokolldateien von
IBM License Metric Tool konfigurieren](../../installation-configuration/production/server-configuration/#configuring-ibm-license-metric-tool-log-files)
