---
layout: tutorial
title: MobileFirst Server für die Authentifizierung externer Ressourcen verwenden
breadcrumb_title: Protecting External Resources
relevantTo: [android,ios,windows,javascript]
weight: 12
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Geschützte Ressourcen können in {{ site.data.keys.mf_server }}
ausgeführt werden (z. B. **Adapter**) oder auf **externen Servern**. Sie können Ressourcen auf externen Servern mit den
Validierungsmodulen der {{ site.data.keys.product }} schützen.

In diesem Lernprogramm erfahren Sie, wie ein externer **Ressourcenserver**
durch die Implementierung eines **Filters** für die Validierung eines
{{ site.data.keys.product_adj }}-**Zugriffstokens** geschützt wird.  
Sie können einen derartigen Schutz vollständig mit angepasstem Code implementieren oder mit
einer der Helper-Bibliotheken der {{ site.data.keys.product }}, in die ein Teil des Ablaufs eingebunden ist. 

**Voraussetzung:**  

* Sie müssen das [{{ site.data.keys.product_adj }}-Sicherheitsframework](../) verstehen.

## Ablauf
{: #flow }
![Diagramm zum Schutz externer Ressourcen](external_resources_flow.jpg)

Eine Komponente von {{ site.data.keys.mf_server }} ist der
**Introspektionsendpunkt**. Diese Komponente ist in der Lage,
Daten eines {{ site.data.keys.product_adj }}-**Zugriffstokens** zu validieren und zu extrahieren. Der Introspektionsendpunkt ist über eine
REST-API verfügbar. 

1. Eine Anwendung mit dem {{ site.data.keys.product }}-Client-SDK setzt einen Anforderungsaufruf
(oder eine HTTP-Anforderung) mit der Anforderung einer geschützten Ressource mit oder ohne `Authorization`-Header (**Clientzugriffstoken**) ab.
2. Für die Kommunikation mit dem Introspektionsendpunkt muss der **Filter** auf dem Ressourcenserver für sich selbst ein gesondertes Token anfordern
(siehe Abschnitt **Vertraulicher Client**). 
3. Der **Filter** auf dem Ressourcenserver extrahiert das **Clientzugriffstoken** aus Schritt 1 und sendet es
zur Validierung an den Introspektionsendpunkt. 
4. Wenn der {{ site.data.keys.product_adj }}-Autorisierungsserver feststellt, dass das Token ungültig (oder nicht vorhanden) ist,
leitet der Ressourcenserver den Client
weiter, um ein neues Token für den erforderlichen Bereich abzurufen. Dies geschieht intern, wenn das
{{ site.data.keys.product_adj }}-Client-SDK verwendet wird. 

## Vertraulicher Client
{: #confidential-client }
Da der Introspektionsendpunkt eine mit dem Bereich `authorization.introspect` intern geschützte Ressource ist,
muss der Ressourcenserver ein separates Token abrufen, um Daten an den Endpunkt senden zu können. Wenn Sie versuchen, eine Anforderung ohne Authorization-Header
an den Introspektionsendpunkt abzusetzen, wird eine Antwort 401 zurückgegeben. 

Wenn der externe Ressourcenserver ein Token für den Bereich `authorization.introspect` anfordern können soll,
muss der Server in der
{{ site.data.keys.mf_console }} als **vertraulicher Client** registriert werden.   

> Weitere Informationen enthält das Lernprogramm [Vertrauliche Clients](../confidential-clients/). 

Fügen Sie in der {{ site.data.keys.mf_console }} unter
**Einstellungen → Vertrauliche Clients** einen neuen Eintrag hinzu. Wählen Sie
einen Wert für **Geheimer Clientschlüssel** und für **Geheimer API-Schlüssel** aus. Vergewissern Sie sich, dass
**Zulässiger Bereich** auf `authorization.introspect` gesetzt ist. 

<img class="gifplayer" alt="Vertraulichen Client konfigurieren" src="confidential-client.png"/>

## Implementierungen
{: #implementations }
Dieser Ablauf kann manuell mit direkten HTTP-Anforderungen an die diversen REST-APIs implementiert werden (siehe Dokumentation).   
Die {{ site.data.keys.product }} stellt für eine Implementierung auch Bibliotheken
für **WebSphere**-Server mit dem verfügbaren
**Trust Association Interceptor** oder für Java-Filter mit dem verfügbaren **Java-Token-Validator** bereit. 
