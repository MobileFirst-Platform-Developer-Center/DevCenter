---
layout: tutorial
title: Lizenzierung für MobileFirst Server
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
IBM {{ site.data.keys.mf_server }} unterstützt zwei verschiedene, von der Art der gekauften Lizenzen
abhängige Lizenzierungsmethoden. 

Wenn Sie zeitlich unbegrenzte Lizenzen erworben haben, können Sie diese nutzen
und Ihre vertragskonforme Verwendung auf der Seite
**Lizenzüberwachung** der
{{ site.data.keys.mf_console }} sowie anhand des
[Lizenzüberwachungsberichts](../../administering-apps/license-tracking/#license-tracking-report) verifizieren.
Wenn Sie Tokenlizenzen erworben haben,
konfigurieren Sie Ihren {{ site.data.keys.mf_server }} so, dass er mit einem fernen Tokenlizenzserver
kommuniziert. 

### Lizenzen für Anwendungen oder adressierbare Geräte
{: #application-or-addressable-device-licenses }
Wenn Sie Lizenzen für Anwendungen oder adressierbare Geräte erworben haben, können Sie diese nutzen
und Ihre vertragskonforme Verwendung auf der Seite
"Lizenzüberwachung" der {{ site.data.keys.mf_console }} sowie anhand des
Lizenzüberwachungsberichts verifizieren.


### PVU-Lizenzierung
{: #processor-value-unit-pvu-licensing }
Die PVU-Lizenzierung (Prozessor-Value-Unit) ist verfügbar, wenn Sie
IBM {{ site.data.keys.product }} Extension gekauft haben
(siehe Dokumente mit den [Lizenzinformationen](http://www.ibm.com/software/sla/sladb.nsf/lilookup/C154C7B1C8C840F38525800A0037B46E?OpenDocument)).
Voraussetzung ist jedoch, dass Sie bereits IBM  WebSphere Application Server Network Deployment, IBM API Connect™ Professional oder
IBM API Connect Enterprise erworben haben. 

Bei einer PVU-Lizenz richtet sich die Preisstruktur nach Typ und Anzahl der Prozessoren, die für installierte Produkte verfügbar sind. Berechtigungen können dem Full-Capacity- oder dem Sub-Capacity-Modell entsprechen. Gemäß der PVU-Lizenzierungsstruktur wird die Software
abhängig von der jedem Prozessorkern zugeordneten Anzahl von Value-Units lizenziert. 

Nehmen wir beispielsweise an, einem Prozessortyp A sind 80 Value-Units pro Kern zugeordnet und einem Prozessortyp B 100 Value-Units pro Kern. Wenn Sie eine Produktlizenz für die Ausführung von zwei Prozessoren vom Typ A benötigen, müssen Sie eine
Berechtigung für 160 Value-Units pro Kern anfordern. Wird das Produkt auf zwei Prozessoren vom Typ B ausgeführt, sind Berechtigungen für 200 Value-Units pro Kern erforderlich. 

> [Weitere Informationen zur PVU-Lizenzierung](https://www.ibm.com/support/knowledgecenter/SS8JFY_9.2.0/com.ibm.lmt.doc/Inventory/overview/c_processor_value_unit_licenses.html)

### Tokenlizenzierung
{: #token-licensing }
In einer Tokenumgebung konsumiert jedes Produkt pro Lizenz eine vordefinierte Tokenanzahl. In einer
traditionellen Floating-Umgebung wird dagegen eine vordefinierte Anzahl von Lizenzen konsumiert.
Der Lizenzschlüssel verfügt über einen Tokenpool.
Der Lizenzserver berechnet auf der Basis dieses Pools die Token, die ein- und ausgecheckt werden. Wenn ein Produkt Lizenzen vom Lizenzserver
ein- oder auscheckt, werden Token konsumiert oder freigegeben. 

In Ihrem Lizenzvertrag ist definiert, ob Sie die
Tokenlizenzierung nutzen können, wie viele Token verfügbar sind und welche Features von Token validiert werden
(siehe "Tokenlizenzvalidierung").

Wenn Sie
tokenbasierte Lizenzen erworben haben, installieren Sie
eine Version von {{ site.data.keys.mf_server }}, die
Tokenlizenzen unterstützt, und konfigurieren Sie Ihren Anwendungsserver so, dass Ihr Server mit dem fernen Tokenserver kommunizieren
kann (siehe "Installation und Konfiguration für
die Tokenlizenzierung"). 

Bei der
Tokenlizenzierung können Sie für jede App im Anwendungsdeskriptor den App-Typ für die Lizenzierung angeben, bevor Sie die App implementieren. Der App-Typ für die Lizenzierung
kann APPLICATION oder ADDITIONAL_BRAND_DEPLOYMENT sein.
Für Tests können Sie den App-Typ für die Lizenzierung auf NON_PRODUCTION setzen.
Weitere Informationen finden Sie unter
"Anwendungslizenzinformationen definieren".

Das mit Rational License Key Server 8.1.4.9
bereitgestellte Rational License Key Server Administration and Reporting Tool
kann die von
der {{ site.data.keys.product }} konsumierten Lizenzen verwalten und entsprechende
Berichte generieren.
Die relevanten Abschnitte des Berichts finden Sie mithilfe der folgenden Anzeigenamen:
**MobileFirst Platform Foundation Application** und **MobileFirst
Platform Additional Brand Deployment**. Diese Namen beziehen sich auf den App-Typ, für den
Lizenzierungstoken konsumiert werden. Weitere Informationen finden Sie in der
[Übersicht über das Rational License Key Server Administration and Reporting Tool](https://www.ibm.com/support/knowledgecenter/SSSTWP_8.1.4/com.ibm.rational.license.doc/topics/c_rlks_admin_tool_overview.html)
und im
[Rational License Key Server Administration and Reporting Tool Fixpack 9 (8.1.4.9)](http://www.ibm.com/support/docview.wss?uid=swg24040300).

Informationen zur Planung der Tokenlizienzierung für
{{ site.data.keys.mf_server }} finden Sie
unter
"Verwendung der
Tokenlizenzierung planen".

Wenn Sie Lizenzschlüssel für
die {{ site.data.keys.product }} anfordern möchten, benötigen Sie Zugang zum
IBM Rational License Key Center.
Weitere Informationen zum Generieren und Verwalten Ihrer Lizenzschlüssel finden Sie unter [IBM Support - Licensing](http://www.ibm.com/software/rational/support/licensing/).
