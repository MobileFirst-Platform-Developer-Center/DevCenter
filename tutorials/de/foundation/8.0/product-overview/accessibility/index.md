---
layout: tutorial
title: Funktionen der IBM MobileFirst Foundation zur behindertengerechten Bedienung
breadcrumb_title: Funktionen zur behindertengerechten Bedienung
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
<br/>
Funktionen zur behindertengerechten Bedienung unterstützen Benutzer mit eingeschränkter Bewegungsfähigkeit oder einer Sehbehinderung
bei der erfolgreichen Nutzung von IT-Inhalten. ### Funktionen zur behindertengerechten Bedienung
{: #accessibility-features }
Die {{ site.data.keys.product_full }}
stellt die folgenden Funktionen zur behindertengerechten Bedienung bereit: 

* Ausschließliche Bedienung über die Tastatur
* Operationen, die die Verwendung eines Sprachausgabeprogramms unterstützen

Die {{ site.data.keys.product }} wendet den neuesten W3C-Standard [WAI-ARIA 1.0](http://www.w3.org/TR/wai-aria/) an,
um die Konformität mit
[US Section 508](http://www.access-board.gov/guidelines-and-standards/communications-and-it/about-the-section-508-standards/section-508-standards)
und den [Web Content Accessibility Guidelines (WCAG) 2.0](http://www.w3.org/TR/WCAG20/) zu gewährleisten. Nutzen Sie das aktuellste Release Ihres Sprachausgabeprogramms in Kombination mit dem neuesten von diesem Produkt unterstützten Browser, um
von den FFunktionen zur behindertengerechten Bedienung profitieren zu können. 

### Tastaturnavigation
{: #keyboard-navigation }
In diesem Produkt werden die Standardnavigationstasten verwendet. 

### Schnittstelleninformationen
{: #interface-informaton }
Auf den Benutzerschnittstellen der
{{ site.data.keys.product }} gibt es keine Inhalte, die
2-55 Mal pro Sekunde aufblinken. 

Sie können ein Sprachausgabeprogramm mit einem digitalen Sprachsynthesizer
verwenden, um sich den Inhalt Ihrer Anzeige vorlesen zu lassen. Details zur
Verwendung des Sprachausgabeprogramms mit diesem Produkt und der zugehörigen Dokumentation
finden Sie in der Dokumentation zu Ihrer Technologie für behindertengerechte Bedienung. 

### {{ site.data.keys.mf_cli }}
{: #mobilefirst-cli }
Die {{ site.data.keys.mf_cli }} zeigt Statusnachrichten standardmäßig
in verschiedenen Farben für Erfolgsmeldungen, Fehlernachrichten und Warnungen an. Wenn Sie für einen
Befehl der {{ site.data.keys.mf_cli }} die Option `--no-color`
verwenden,
wird die Verwendung der Farben für diesen Befehl unterdrückt. Ist `--no-color` angegeben, erscheint die Ausgabe in den für die Betriebssystemkonsole festgelegten
Textanzeigefarben. 

### Webschnittstelle 
{: #web-interface }
Die Webbenutzerschnittstellen der {{ site.data.keys.product }} nutzen für die korrekte Darstellung
von Inhalten und eine angemessene Benutzererfahrung
Cascading Style Sheets. Die Anwendung stellt für Menschen mit Sehbehinderung ein Äquivalent für die Anzeigeeinstellungen des Systems bereit. Dazu gehört auch ein Modus für kontraststarke Anzeige. Sie können die Schriftgröße über das Gerät oder über die Web-Browser-Einstellungen
steuern. 

Mithilfe von Tastenkombinationen können Sie durch die verschiedenen {{ site.data.keys.product_adj }}-Umgebungen und die zugehörige
Dokumentation navigieren. In Eclipse gibt es Eingabehilfen für Eclipse-Umgebungen. Internet-Browser stellen ebenfalls Funktionen
zur behindertengerechten Bedienung von Webanwendungen
bereit, z. B. für die
{{ site.data.keys.mf_console }}, die  {{ site.data.keys.mf_analytics_console }},
die
MobileFirst-Foundation-Application-Center-Konsole und den mobilen MobileFirst-Foundation-Application-Center-Client. 

Auf der Webbenutzerschnittstelle der
{{ site.data.keys.product }} gibt es unter anderem
WAI-ARIA-Navigationsmarkierungen, die Sie nutzen können, um schnell zu Funktionsbereichen der Anwendung zu navigieren. 

### Installation und Konfiguration
{: #installation-and-configuration }
Die
{{ site.data.keys.product }} kann auf zwei Wegen installiert und konfiguriert werden,
auf der grafischen Benutzerschnittstelle (GUI) oder über die Befehlszeile. 

Die grafische Benutzerschnittstelle (IBM Installation Manager im Assistentenmodus oder das Server
Configuration Tool) stellt keine Informationen zu Benutzerschnittstellenobjekten bereit. Eine entsprechende Funktion ist jedoch über die
Befehlszeilenschnittstelle verfügbar. Alle Funktionen der grafischen Benutzerschnittstelle werden auch von der Befehlszeile unterstützt.
Über die Befehlszeile sind bestimmte zusätzliche Installations- und Konfigurationsfeatures verfügbar. Über die Funktionen zur behindertengerechten Bedienung von
[IBM Installation Manager](http://www.ibm.com/support/knowledgecenter/SSDV2W/im_family_welcome.html?lang=en&view=kc) können Sie sich im
IBM Knowledge Center informieren.

In den folgenden Abschnitten finden Sie Informationen zur Installation und Konfiguration ohne grafische Benutzerschnittstelle: 

* Mit Beispielantwortdateien für IBM Installation Manager arbeiten:
Bei dieser Methode ist eine
unbeaufsichtigte Installation und Konfiguration von
{{ site.data.keys.mf_server }}
und des Application Center möglich.
Sie können sich gegen die Installation des Application Center entscheiden.
Verwenden Sie in dem Fall die Antwortdatei install-no-appcenter.xml. Sie können das Application Center später mit Ant-Tasks
installieren (siehe
"Application Center mit Ant-Tasks installieren"). Die Installation des
Application Center und das Upgrade für das Application Center können in dem Fall
unabhängig erfolgen. 
* Installation mit Ant-Tasks
* Application Center
mit Ant-Tasks installieren

### Software anderer Anbieter
{: #vendor-software }
Die {{ site.data.keys.product }}
enthält bestimmte Software anderer Anbieter, die nicht unter dei IBM Lizenzvereinbarung fällt. IBM gibt keine Erklärung über die Funktionen zur behindertengerechten Bedienung
dieser Produkte ab. Wenden Sie sich an den Anbieter des jeweiligen Produkts, um Informationen zur behindertengerechten Bedienung zu erhalten. 

### Zugehörige Informationen zur behindertengerechten Bedienung
{: #related-accessibility-information }
Für gehörlose oder hörgeschädigte Kunden hat IBM zusätzlich zum
Help-Desk und zu den Standard-Support-Websites einen TTY-Telefonservice für Verkaufs- und Untertsützungsdienstleistungen
eingerichtet: 

Teletype-Service
  
800-IBM-3383 (800-426-3383)
  
(in Nordamerika)

### IBM und Barrierefreiheit
{: #ibm-and-accessibility }
Weitere Informationen zum Engagement von IBM in Bezug auf die behindertengerechte Bedienung finden Sie
unter [IBM Accessibility](http://www.ibm.com/able). 


