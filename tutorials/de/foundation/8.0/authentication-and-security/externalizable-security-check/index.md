---
layout: tutorial
title: ExternalizableSecurityCheck implementieren
breadcrumb_title: ExternalizableSecurityCheck
relevantTo: [android,ios,windows,javascript]
weight: 5
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die abstrakte Klasse `ExternalizableSecurityCheck` implementiert die Schnittstelle
`SecurityCheck` und handhabt zwei wichtige Aspekte der Funktionalität für Sicherheitsüberprüfungen:
die Externalisierung und die Zustandsverwaltung. 

* Externalization (Externalisierung) - Diese Klasse implementiert die Schnittstelle `Externalizable`,
sodass die abgeleiteten Klassen sich nicht selbst implementieren müssen. 
* State management (Zustandsveraltung) - Diese Klasse definiert einen Zustand `STATE_EXPIRED`, der bedeutet,
dass die Sicherheitsüberprüfung abgelaufen ist und der Zustand der Prüfung nicht aufrechterhalten werden kann. Die abgeleiteten Klassen müssen andere, von ihrer Sicherheitsüberprüfung unterstützte Zustände definieren. 

Die Unterklassen müssen die drei Methoden `initStateDurations`, `authorize` und `introspect` implementieren.

In diesem Lernprogramm ist erläutert, wie die Klassen implementiert und wie Zustände verwaltet werden. 

**Voraussetzung:** Sie müssen
die Lernprogramme [Autorisierungskonzepte](../) und [Sicherheitsüberprüfung erstellen](../creating-a-security-check) durcharbeiten. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Methode initStateDurations](#the-initstatedurations-method)
* [Methode authorize](#the-authorize-method)
* [Methode introspect](#the-introspect-method)
* [AuthorizationContext-Objekt](#the-authorizationcontext-object)
* [RegistrationContext-Objekt](#the-registrationcontext-object)

## Methode initStateDurations
{: #the-initstatedurations-method }
`ExternalizableSecurityCheck` definiert eine abstrakte Methode mit der Bezeichnung `initStateDurations`. Die Unterklassen müssen diese Methode implementieren, indem sie für alle von ihrer Sicherheitsüberprüfung unterstützten Zustände einen Namen und eine Dauer angeben. Der Wert für die Dauer stammt in der Regel aus einer Sicherheitsprüfungskonfiguration. 

```java
private static final String SUCCESS_STATE = "success";

protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((SecurityCheckConfig) config).successStateExpirationSec);
}
```

> Weitere Informationen zur Sicherheitsprüfungskonfiguration finden Sie
im Abschnitt [Konfigurationsklasse](../credentials-validation/security-check/#configuration-class)
des Lernprogramms "CredentialsValidationSecurityCheck implementieren".

## Methode authorize
{: #the-authorize-method }
Die Schnittstelle `SecurityCheck` definiert eine Methode mit der Bezeichnung `authorize`. Diese Methode ist für die Implementierung der wesentlichen Logik der
Sicherheitsüberprüfung, die Verwaltung von Zuständen und das Senden einer Antwort an den Client
("success", "challenge" oder "failure") verantwortlich. 

Verwenden Sie die folgenden Helper-Methoden für die Zustandsverwaltung: 

```java
protected void setState(String name)
```
```java
public String getState()
```
Im folgenden Beipiel wird einfach überprüft, ob der Benutzer angemeldet ist, und entsprechend ein Erfolg (success) oder ein Fehler (failure) zurückgegeben:

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (loggedIn){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();           
        failure.put("failure", "User is not logged-in");
        response.addFailure(getName(), failure);
    }
}
```

Die Methode `AuthorizationResponse.addSuccess` fügt den Bereich "success" und dessen Auflauf zum Antwortobjekt hinzu. Sie erfordert Folgendes: 

* Von der Sicherheitsüberprüfung zugewiesener Bereich
* Ablauf des zugewiesenen Bereichs   
Die Helper-Methode `getExpiresAt` gibt den Zeitpunkt zurück, zu dem der aktuelle Zustand abläuft. Wenn der aktuelle Zustand gleich null ist, wird 0 zurückgegeben. 

  ```java
  public long getExpiresAt()
  ```
   
* Name der Sicherheitsüberprüfung

Die Methode `AuthorizationResponse.addFailure` fügt einen Fehler (failure) zum Antwortobjekt hinzu. Sie erfordert Folgendes: 

* Name der Sicherheitsüberprüfung
* `Map`-Objekt für Fehler

Die Methode `AuthorizationResponse.addChallenge` fügt eine Abfrage an dieses Antwortobjekt hinzu. Sie erfordert Folgendes: 

* Name der Sicherheitsüberprüfung
* `Map`-Objekt für Abfrage

## Methode introspect
{: #the-introspect-method }
Die Schnittstelle `SecurityCheck` definiert eine Method emit der Bezeichnung `introspect`. Diese Methode muss sicherstellen, dass die Sicherheitsüberprüfung den Zustand hat, der eine Zuordnung des angeforderten Bereichs sicherstellt. Wenn der Bereich zugewiesen ist, muss die Sicherheitsüberprüfung
dem Ergebnisparameter den zugeordneten Bereich, den Ablauf dieses Bereiches und angepasste Introspektionsdaten mitteilen. Wenn der Bereich nicht zugewiesen wird, führt die Sicherheitsüberprüfung keine Schritte aus.   
Diese Methode kann den Zustand der Sicherheitsüberprüfung und/oder den Datensatz der Clientregistrierung ändern. 

```java
public void introspect(Set<String> checkScope, IntrospectionResponse response) {
    if (getState().equals(SUCCESS_STATE)) {
        response.addIntrospectionData(getName(),checkScope,getExpiresAt(),null);
    }
}
```

## AuthorizationContext-Objekt
{: #the-authorizationcontext-object }
Die Klasse `ExternalizableSecurityCheck` stellt ein Objekt `AuthorizationContext authorizationContext`
bereit, in dem temporäre Daten zum aktuellen Client für die Sicherheitsüberprüfung gespeichert werden.   
Verwenden Sie die folgenden Methoden, um Daten zu speichern und anzufordern. 

* Abrufen des authentifizierten Benutzers, der von dieser Sicherheitsüberprüfung für den aktuellen Client definiert ist: 

  ```java
  AuthenticatedUser getActiveUser();
  ```
  
* Festlegen des aktiven Benutzers für den aktuellen Client durch diese Sicherheitsüberprüfung: 

  ```java
  void setActiveUser(AuthenticatedUser user);
  ```

## RegistrationContext-Objekt
{: #the-registrationcontext-object }
Die Klasse `ExternalizableSecurityCheck` stellt ein Objekt `RegistrationContext registrationContext`
bereit, in dem persistente Daten bzw. Implementierungsdaten im Zusammenhang mit dem aktuellen Client gespeichert werden.   
Verwenden Sie die folgenden Methoden, um Daten zu speichern und anzufordern. 

* Abrufen des Benutzers, der von dieser Sicherheitsüberprüfung für den aktuellen Client registriert wurde: 

  ```java
  AuthenticatedUser getRegisteredUser();
  ```
  
* Registrieren des gegebenen Benutzers für den aktuellen Client: 

  ```java
  setRegisteredUser(AuthenticatedUser user);
  ```
  
* Abrufen der öffentlichen persistenten Attribute des aktuellen Clients: 

  ```java
  PersistentAttributes getRegisteredPublicAttributes();
  ```
  
* Abrufen der geschützten persistenten Attribute des aktuellen Clients: 

  ```java
  PersistentAttributes getRegisteredProtectedAttributes();
  ```
  
* Finden der Registrierungsdaten von moiblen Clients mit den gegebenen Suchkriterien: 

  ```java
  List<ClientData> findClientRegistrationData(ClientSearchCriteria criteria);
  ```

## Beispielanwendung
{: #sample-application }
Ein Beispiel, das `ExternalizableSecurityCheck` implementiert, enthält das Lernprogramm
[Registrierung](../enrollment). 
