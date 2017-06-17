---
layout: tutorial
title: Anwendungen verwalten
weight: 11
show_children: true
---
## Übersicht
{: #overview }
In der {{ site.data.keys.product_full }} gibt es mehrere Möglichkeiten,
MobileFirst-Anwendungen in der Entwicklung oder der Produktion zu verwalten. Die zentrale, webbasierte {{ site.data.keys.mf_console }} ist
das Haupttool, mit dem Sie alle implementierten MobileFirst-Anwendungen überwachen können.

Nachfolgend sind die wichtigsten Operationen angegeben, die Sie in der
{{ site.data.keys.mf_console }} ausführen können:

* Mobile Anwendungen bei
{{ site.data.keys.mf_server }} registrieren und konfigurieren
* Adapter in {{ site.data.keys.mf_server }} implementieren und konfigurieren
* Anwendungsversionen steuern, um neue Versionen zu implementieren oder alte Versionen über Fernzugriff zu inaktivieren
* Mobile Geräte und Benutzer verwalten, um den Zugriff auf ein bestimmtes Gerät oder den Zugriff eines bestimmten Benutzers auf eine Anwendung
zu steuern
* Benachrichtigungen beim Anwendungsstart anzeigen
* Push-Benachrichtigungsservices überwachen
* Clientseitige Protokolle zu bestimmten Anwendungen, die auf einem bestimmten Gerät installiert sind, erfassen

## Verwaltungsrollen
{: #administration-roles }
Nicht jeder Benutzer mit Verwaltungsaufgaben kann alle Verwaltungsoperationen ausführen. In der {{ site.data.keys.mf_console }}
und allen Verwaltungstools sind für die Verwaltung von
MobileFirst-Anwendungen die folgenden vier Rollen definiert:

**Monitor**  
Ein Benutzer mit dieser Rolle kann implementierte MobileFirst-Projekte und Artefakte überwachen. Diese Rolle hat keinen Schreibzugriff.

**Operator**  
Ein Benutzer mit der Rolle "Operator" kann alle Verwaltungsoperationen für mobile Anwendungen ausführen, jedoch keine
Anwendungsversionen oder Adapter hinzufügen bzw. entfernen.

**Deployer**  
Ein Benutzer mit dieser Rolle kann dieselben Operationen wie ein "Operator" ausführen und außerdem Anwendungen und Adapter implementieren.

**Administrator**  
Ein Benutzer mit dieser Rolle kann alle Anwendungsverwaltungsoperationen ausführen.

> Weitere Informationen zu {{ site.data.keys.product_adj }}-Verwaltungsrollen finden Sie unter
[Benutzerauthentifizierung
für die MobileFirst-Server-Verwaltung konfigurieren](../installation-configuration/production/server-configuration/#configuring-user-authentication-for-mobilefirst-server-administration).
## Verwaltungstools
{: #administration-tools }
Neben der {{ site.data.keys.mf_console }} gibt es weitere
Möglichkeiten, MobileFirst-Anwendungen zu verwalten. Die {{ site.data.keys.product }} stellt
auch Tools für die Aufnahme von Verwaltungsoperationen in Ihren Build- und Implementierungsprozess bereit.

Zusätzlich stehen REST-Services für die Ausführung von Verwaltungsoperationen zur Verfügung.
Die Referenzdokumentation zur API dieser Services finden Sie in [REST-API für den MobileFirst-Server-Verwaltungsservice](../api/rest/administration-service/). 

Mit diesen REST-Services können Sie dieselben Operationen wie in der
{{ site.data.keys.mf_console }} ausführen.
Sie können Anwendungen und Adapter verwalten und beispielsweise eine neue Version einer Anwendung hochladen oder eine alte Anwendungsversion
inaktivieren.

{{ site.data.keys.product_adj }}-Amwendungen können auch mit Ant-Tasks oder mit dem Befehlszeilentool
**mfpadm** verwaltet werden
(siehe [{{ site.data.keys.product_adj }}-Anwendungen mit Ant verwalten](using-ant)
oder [{{ site.data.keys.product_adj }}-Anwendungen mit dem Befehlszeilentool verwalten](using-cli)).

Die REST-Services, Ant-Tasks und Befehlszeilentools sind ähnlich wie die webbasierte Konsole geschützt und erfordern
für die Ausführung von Operationen die Angabe
Ihrer Administratorberechtigungsnachweise. 

### Wählen Sie ein Thema aus: 
{: #select-a-topic }
