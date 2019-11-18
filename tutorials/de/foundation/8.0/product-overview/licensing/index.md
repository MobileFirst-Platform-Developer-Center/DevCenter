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


### VPC-Lizenzierung
{: #vpc-licensing}

Die Mobile Foundation ist auch mit kapazitätsabhängiger Lizenzierung (VPC, Virtual Processor Cores) verfügbar. VPC ist eine Maßeinheit zur Bestimmung der Lizenzierungsgebühren für die Mobile Foundation und gibt die Anzahl der verfügbaren virtuellen Prozessorkerne an. Zurzeit ist diese Metrik nur für Cloud Pak for Applications verfügbar.

Diese Metrik kann wie folgt charakterisiert werden:

* Kunden können beliebig viele Anwendungen und Geräte verwenden. Diese Art der Lizenzierung ist daher in Szenarien, in denen Kunden viele Apps in ihrer Implementierung haben, vorteilhafter als die Anwendungslizenz.

* Sie richtet sich an anderen Produkten im Portfolio aus und gibt Kunden die Möglichkeit, Hybridcloudimplementierungen zu nutzen.


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
