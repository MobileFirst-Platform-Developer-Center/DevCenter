---
layout: tutorial
title: Vereinbarung einer Sicherheitsüberprüfung
breadcrumb_title: security check contract
relevantTo: [android,ios,windows,javascript]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Jede Sicherheitsüberprüfung muss die Schnittstelle
`com.ibm.mfp.server.security.external.SecurityCheck` implementieren. Diese Schnittstelle begründet den Basisvertrag zwischen der Sicherheitsüberprüfung
und dem {{ site.data.keys.product_adj }}-Sicherheitsframework. Die Implementierung von Sicherheitsüberprüfungen muss folgende Voraussetzungen erfüllen: 

* **Funktionen**: Die Sicherheitsüberprüfung muss die Clientfunktionen für Autorisierung und Introspektion (`authorization`
und `introspection`) bereitstellen. 
* **Zustandsmanagement**: Die Sicherheitsüberprüfung muss ihren Zustand verwalten, einschließlich Erstellung, Löschung und Verwaltung des aktuellen Zustands. 
* **Konfiguration**: Die Sicherheitsüberprüfung muss ein Konfigurationsobjekt für Sicherheitsüberprüfungen erstellen, in dem die unterstützten Konfigurationseigenschaften für
Sicherheitsüberprüfungen definiert sind und das bei Anpassungen der Basiskonfiguration Typen und Werte validiert. 

In den [API-Referenzinformationen zu `SecurityCheck`](../../../api/server-side-api/java/) können Sie sich umfassend über die Schnittstelle für Sicherheitsüberprüfungen informieren.

## Funktionen von Sicherheitsüberprüfungen
{: #securityc-check-functions }
Eine Sicherheitsüberprüfung
stellt zwei Hauptfunktionen für das Sicherheitsframework bereit:

### Autorisierung
{: #authorization }
Das Framework verwendet die Methode `SecurityCheck.authorize`, um Clientanforderungen
zu autorisieren. Wenn die Clientanforderungen auf einen bestimmten
OAuth-Bereich zugreifen, ordnet das Framework die Bereichselemente Sicherheitsüberprüfungen zu. Für jede Sicherheitsüberprüfung im Bereich ruft das Framework
die Methode
`authorize` auf, um die Autorisierung für einen Bereich anzufordern, der die dieser Sicherheitsüberprüfung zugeordneten Bereichselemente
enthält. Der Bereich wird mit dem Parameter **scope** der Methode angegeben.


Die Sicherheitsüberprüfung fügt ihre Antwort zum
[`AuthorizationResponse`-Objekt](../../../api/server-side-api/java/)
hinzu, das
mit dem Parameter "response" an die Sicherheitsüberprüfung übergeben wurde. Die Antwort enthält den Namen der Sicherheitsüberprüfung und den Antworttyp, der "success", "failure" oder "challenge" sein kann (siehe [`AuthorizationResponse.ResponseType`](../../../api/server-side-api/java/)).

Wenn die Antwort ein
Abfrageobjekt (challenge) enthält oder angepasste Erfolgs- bzw. Fehlerdaten (success, failure), übergibt das Framework die Daten in einem JSON-Objekt
an den Client-Abfrage-Handler
für Sicherheitsüberprüfungen. Bei einem Erfolg (success) enthält die Antwort auch den (im Parameter **scope** definierten) Bereich, für
den die Autorisierung
angefordert wurde, und die Ablaufzeit für die gewährte Autorisierung. Die Methode
`authorize` der Sicherheitsüberprüfungen für jeden Bereich müssen "success" zurückgeben, damit dem Client der Zugriff auf den angeforderten Bereich
gewährt wird. Außerdem muss jede Ablaufzeit nach dem aktuellen Datum liegen. 

### Introspektion
{: #introspection }
Das Framework verwendet die Methode `SecurityCheck.introspect`, um Introspektionsdaten für einen Ressourcenserver
abzurufen. Diese Methode wird für jede Sicherheitsüberprüfung aufgerufen, die in dem Bereich, für den Introspektion angefordert wurde, enthalten ist. Wie die Methode
`authorize` empfängt die Methode
`introspect` einen Parameter **scope** mit den Bereichselementen, die dieser Sicherheitsüberprüfung zugeordnet sind. Vor der Rückgabe der
Introspektionsdaten überprüft die Methode, ob der aktuelle Zustand der Sicherheitsüberprüfung noch die zuvor für diesen Bereich gewährte
Autorisierung unterstützt. Wenn die Autorisierung noch gültig ist, fügt die Methode
`introspect` ihre Antwort zum
[IntrospectionResponse-Objekt](../../../api/server-side-api/java/) hinzu,
das mit dem Parameter **response** an die Methode übergeben wurde. 

Die Antwort enthält den Namen der Sicherheitsüberprüfung, den
(im Parameter **scope** definierten) Bereich, für
den die Autorisierung
angefordert wurde, die Ablaufzeit für die gewährte Autorisierung und die angeforderten angepassten Introspektionsdaten. Wenn die Autorisierung nicht mehr erteilt werden kann (weil
beispeilsweise der Ablaufzeitpunkt für einen zuvor erfolgreichen Zustand erreicht ist) kehrt die Methode zurück, ohne eine Antwort hinzuzufügen. 

**Hinweis:**

* Das Sicherheitsframework stellt die Verarbeitungsergebnisse der Sicherheitsüberprüfungen zusammen und übergibt relevante Daten an den Client. Die Frameworkverarbeitung
hat keinerlei Kenntnis von den Zuständen der Sicherheitsüberprüfungen.
* Aufrufe der Methode `authorize` oder `introspect` können zu einer Änderung des aktuellen Zustands der
Sicherheitsüberprüfung führen, auch wenn der Ablaufzeitpunkt für den aktuellen Zustand noch nicht erreicht ist. 

> Weitere Informationen zu den Methoden `authorize` und
`introspect` enthält das Lernprogramm [ExternalizableSecurityCheck](../../externalizable-security-check).



### Zustandsverwaltung für Sicherheitsüberprüfungen
{: #security-check-state-management }
Sicherheitsüberprüfungen sind zustandsabhängig,
sodass eine Sicherheitsüberprüfung für die Verfolgung und Beibehaltung ihres Interaktionszustands verantwortlich ist. Bei jeder
Autorisierungs- oder Introspektionsanforderung empfängt das Sicherheitsframework den Zustand der relevanten Sicherheitsüberprüfungen aus einem externen Speicher
(in der Regel einem verteilten Cache). Am Ende der Anforderungsverarbeitung speichert das Framework den Zustand der Sicherheitsüberprüfung
wieder in dem externen Speicher. 

Die Vereinbarung der Sicherheitsüberprüfung erfordert Folgendes: 

* Eine Sicherheitsüberprüfung implementiert die Schnittstelle `java.io.Externalizable`.
Sie verwaltet mit dieser Schnittstelle die Serialisierung und Deserialisierung ihres Zustands. 
* Eine Sicherheitsüberprüfung definiert eine Ablaufzeit und ein Inaktivitätszeitlimit für ihren aktuellen Zustand. Der Zustand der Sicherheitsüberprüfung ist eine Stufe im Autorisierungsprozess und kann nicht
unendlich andauern. Die konkreten Zeiträume für die Gültigkeit des Zustands und für die maximale Inaktivität werden in der
Implementierung der Sicherheitsüberprüfung gemäß der implementierten Logik festgelegt. Die Sicherheitsüberprüfung informiert das Framework über die Implementierung der
Methoden
`getExpiresAt` und `getInactivityTimeoutSec` der Schnittstelle SecurityCheck über die gewählten Werte für
Ablaufzeit und Inaktivitätszeitlimit. 

### Konfiguration von Sicherheitsüberprüfungen
{: #security-check-configuration }
Eine Sicherheitsüberprüfung
kann Konfigurationseigenschaften zugänglich machen, deren Werte auf der Adapterebene und auf der Anwendungsebene angepasst sein können. Die Sicherheitsprüfungsdefinition für eine bestimmte Klasse
legt fest, welche der unterstützten Konfigurationseigenschaften dieser Klasse zugänglich gemacht werden sollen, und kann die in der Klassendefinition festgelegten
Standardwerte anpassen. Die Eigenschaftswerte können dynamisch weiter angepasst werden. Dies gilt für den Adapter, der die Sicherheitsüberprüfungen definiert, und für jede Anwendung, die die Überprüfung
verwendet. 

Eine Sicherheitsprüfungsklasse macht ihre unterstützten Eigenschaften zugänglich, indem sie eine
Methode `createConfiguration` implementiert. Diese Methode erstellt eine Instanz einer Klasse für Sicherheitsprüfungskonfigurationen, die
die Schnittstelle `com.ibm.mfp.server.security.external.SecurityCheckConfiguration` implementiert. Diese Schnittstelle ergänzt
die Schnittstelle `SecurityCheck` und ist auch Teil der Vereinbarung der Sicherheitsüberprüfung. Die Sicherheitsüberprüfung
kann ein Konfigurationsobjekt erstellen, das keine Eigenschaften zugänglich macht.
Die Methode `createConfiguration` muss jedoch ein gültiges Konfigurationsobjekt
zurückgeben und kann nicht null zurückgeben. Vollständige Referenzinformationen zur Schnittstelle für
Sicherheitsüberprüfungen finden Sie unter
[`SecurityCheckConfiguration`](../../../api/server-side-api/java/).

Das Sicherheitsframework ruft die Methode
`createConfiguration` der Sicherheitsüberprüfung während der Implementierung auf, was bei jeder Konfigurationsänderung für einen
Adapter oder eine Anwendung der Fall ist. Der Methodenparameter properties enthält die Eigenschaften, die in der Sicherheitsprüfungsdefinition
des Adapters festgelegt sind, sowie deren aktuelle angepasste Werte (oder die Standardwerte, wenn keine Anpassung erfolgte). Die Implementierung der Sicherheitsprüfungskonfiguration
sollte die Werte der empfangenen Eigenschaften validieren und Methoden für das Zurückgeben der Validierungsergebnisse bereitstellen. 

Die
Sicherheitsprüfungskonfiguration muss die Methoden `getErrors`, `getSyswarnings` und
`getInfo` implementieren. Die abstrakte Klasse für
Sicherheitsprüfungskonfigurationen
[`SecurityCheckConfigurationBase`](../../../api/server-side-api/java/)
definiert und implementiert außerdem die angepssten Methoden
`getStringProperty`, `getIntProperty` und
`addMessage`. Einzelheiten finden Sie in der Codebeschreibung zu dieser Klasse. 

**Hinweis:** Die Namen und Werte der Konfigurationseigenschaften in der Sicherheitsprüfungsdefinition und in jeder Adapter- oder Anwendungsanpassung müssen mit den unterstützten Eigenschaften und zulässigen Werten der Konfigurationsklasse übereinstimmen.

> Weitere Informationen zur [Erstellung angepasster Eigenschaften](../#security-check-configuration) finden Sie unter "Sicherheitsüberprüfungen". 
