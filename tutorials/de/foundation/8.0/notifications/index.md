---
layout: tutorial
title: Benachrichtigungen
show_children: true
relevantTo: [ios,android,windows,cordova]
weight: 8
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Benachrichtigungen ermöglichen einem mobilen Gerät, Nachrichten zu empfangen, die ein Server mit einer Push-Operation gesendet hat.   
Benachrichtigungen werden unabhängig davon empfangen, ob die Anwendung im Vordergrund oder im Hintergrund ausgeführt wird.   

Die {{ site.data.keys.product_full }} stellt einheitliche API-Methoden zum Senden von Push- oder
SMS-Benachrichtigungen an iOS-, Android-, universelle Windows-8.1-, Windows-10-UWP- und Cordova-Anwendungen (iOS, Android) bereit. Die Benachrichtigungen
werden von {{ site.data.keys.mf_server }} an die Anbieterinfrastruktur (Apple, Google, Microsoft, SMS-Gateways)
gesendet und von dort an die betreffenden Geräte. Der einheitliche Benachrichtigungsmechanismus
macht den gesamten Prozess der Kommunikation
mit Benutzern und Geräten für den Entwickler vollkommen transparent. 

#### Geräteunterstützung
{: #device-support }
Push- und SMS-Benachrichtigungen in der {{ site.data.keys.product }} werden für die folgenden Plattformen unterstützt:

* iOS ab Version 8.x
* Android ab Version 4.x
* Windows 8.1, Windows 10

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Push-Benachrichtigungen](#push-notifications)
* [SMS-Benachrichtigungen](#sms-notifications)
* [Proxy-Einstellungen](#proxy-settings)
* [Nächste Lernprogramme](#tutorials-to-follow-next)

## Push-Benachrichtigungen
{: #push-notifications }
Es gibt verschiedene Arten von Benachrichtigungen: 

* **Alert (iOS, Android, Windows)** -  Popup-Textnachricht
* **Sound (iOS, Android, Windows)** - Audiodatei, die beim Empfang einer Benachrichtigung abgespielt wird
* **Badge (iOS), Tile (Windows)** - grafische Darstellung für einen kurzen Text oder ein Bild 
* **Banner (iOS), Toast (Windows)** - Popup-Textnachricht oben in der Geräteanzeige, die wieder ausgeblendet wird
* **Interactive (iOS ab Version 8)** - Aktionsschaltflächen im Banner einer empfangenen Benachrichtigung
* **Silent (iOS ab Version 8)** - Senden von Benachrichtigungen, ohne den Benutzer zu stören

### Arten von Push-Benachrichtigungen 
{: #push-notification-types }
#### Tagbasierte Benachrichtigungen
{: #tag-notifications }
Tagbasierte Benachrichtigungen sind Hinweisnachrichten, die an alle Geräte gesendet werden, die einen bestimmten Tag abonniert haben.   

Bei tagbasierten Benachrichtigungen ist es möglich, die Benachrichtigungen ausgehend von Themenbereichen oder Topics bestimmten Segmenten zuzuordnen. Empfänger der Benachrichtigungen
können angeben, dass sie nur Benachrichtigungen zu einem bestimmten Thema oder einem sie interessierenden Topic empfangen möchten. Bei tagbasierten Benachrichtigungen gibt es zu diesem Zweck
eine Möglichkeit, Empfänger Segmenten zuzuordnen. Mit diesem Feature können Tags definiert werden, um
dann Nachrichten auf der Basis von Tags zu senden und zu empfangen. Eine Nachricht wird nur an die Geräte gesendet, die einen Tag abonniert haben. 

#### Broadcastbenachrichtigungen
{: #broadcast-notifications }
Broadcastbenachrichtigungen sind eine Form der tagbasierten Push-Benachrichtigungen, die an alle eingeschriebenen Geräte gesendet werden und standardmäßig
für alle Push-fähigen {{ site.data.keys.product_adj }}-Anwendungen
durch das Abonnement eines reservierten Tags `Push.all` aktiviert werden. (Der Tag wird automatisch für jedes Gerät erstellt.) Broadcastbenachrichtigungen können inaktiviert werden, indem
das Abonnement des reservierten Tags `Push.all` beendet wird. 

#### Unicastbenachrichtigungen
{:# unicast-notifications }
Unicastbenachrichtigungen oder mit OAuth geschützte authentifizierte Benachrichtigungen sind Benachrichtigungen, die an ein bestimmtes Gerät oder an bestimmte Benutzer-IDs gesendet werden. Die Benutzer-ID (userID) im Benutzerabonnement kann aus dem
zugrunde liegenden Sicherheitskontext stammen. 

#### Interaktive Benachrichtigungen
{: #interactive-notifications }
Wenn eine interaktive Benachrichtigung eingeht, können Benutzer Aktionen ausführen, ohne die Anwendung zu öffnen. Beim Eintreffen einer interaktiven Benachrichtigung zeigt das Gerät die Nachricht und Aktionsschaltflächen an. Interaktive Benachrichtigungen werden zurzeit auf Geräten mit iOS ab Version 8 unterstützt. Wenn eine interaktive Benachrichtigung an ein iOS-Gerät mit einer älteren Version als Version 8 gesendet wird, werden die Benachrichtigungsaktionen nicht angezeigt. 

> Informieren Sie sich über die Handhabung [interaktiver Benachrichtigungen](handling-push-notifications/interactive).

#### Benachrichtigungen im Hintergrund
{: #silent-notifications }
Die Benachrichtigung im Hintergrund erfolgt ohne Anzeige von Alerts oder andere Störungen des Benutzers. Wenn eine Benachrichtigung im Hintergrund eingeht,
wird der Handling-Code der Anwendung im Hintergrund ausgeführt, ohne die Anwendung in den Vordergrund zu bringen. Zurzeit werden Benachrichtigungen im Hintergrund auf
iOS-Geräten der Version 7 oder einer aktuelleren Version unterstützt. Wenn die Benachrichtigung im Hintergrund an iOS-Geräte mit einer älteren Version als Version 7
gesendet wird und die Anwendung im Hintergrund ausgeführt wird, wird die Benachrichtigung ignoriert. Falls
die Anwendung im Vordergrund ausgeführt wird, wird die Callback-Methode für Benachrichtigungen aufgerufen.

> Informieren Sie sich über die Handhabung von [Benachrichtigungen im Hintergrund](handling-push-notifications/silent).

**Hinweis:** Unicastbenachrichtigungen enthalten keinen Tag in den Nutzdaten. Die Benachrichtigung kann an mehrere Geräte oder Benutzer
gesendet werden, wenn im Zielblock der API "Message (POST)"
mehrere deviceIDs bzw. userIDs angegeben werden.

## SMS-Benachrichtigungen
{: #sms-notifications }
Für eine Anwendung muss zunächst das Abonnement von SMS-Benachrichtigungen registriert sein, damit sie SMS-Benachrichtigungen empfangen kann. Für das Abonnement von SMS-Benachrichtigungen gibt der Benutzer eine
Handynummer an und bestätigt das Abonnement von Benachrichtigungen. Bei Empfang der Benutzerbestätigung wird eine Abonnementanforderung an
{{ site.data.keys.mf_server }} gesendet. Wenn eine Benachrichtigung von der
{{ site.data.keys.mf_console }} empfangen wird, wird sie verarbeitet und über ein vorkonfiguriertes SMS-Gateway gesendet. 

Informationen zum Konfigurieren eines Gateways enthält das Lernprogramm [Benachrichtigungen senden](sending-notifications). 

## Proxy-Einstellungen
{: #proxy-settings }
In den Proxy-Einstellungen können Sie den optionalen Proxy festlegen, über den Benachrichtigungen
an APNS
und GCM gesendet werden. Verwenden Sie die Konfigurationseigenschaften **push.apns.proxy.*** und **push.gcm.proxy.***, um den Proxy festzulegen. Weitere Informationen
finden Sie in der [Liste der
JNDI-Eigenschaften für den MobileFirst-Server-Push-Service](../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

> **Hinweis:** WNS bietet keine Proxyunterstützung. 

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Führen Sie die folgenden Schritte für das erforderliche server- und clientseitige Setup aus, damit Sie Push-Benachrichtigungen senden und empfangen können. 
