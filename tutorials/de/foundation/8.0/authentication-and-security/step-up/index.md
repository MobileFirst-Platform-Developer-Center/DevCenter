---
layout: tutorial
title: Authentifizierung einrichten
breadcrumb_title: Step Up Authentication
relevantTo: [android,ios,windows,javascript]
weight: 5
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80
  - name: Download iOS Swift project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80
  - name: Download Win8 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80
  - name: Download Win10 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Ressourcen können mit diversen Sicherheitsüberprüfungen geschützt werden. In einem solchen Szenario
sendet {{ site.data.keys.mf_server }} alle relevanten Abfragen gleichzeitig an die Anwendung.   

Eine Sicherheitsüberprüfung kann von einer anderen Sicherheitsüberprüfung abhängig sein. Daher ist es wichtig, dass gesteuert werden kann, wann die Abfragen gesendet werden.   
In diesem Lernprogramm ist beispielsweise eine Anwendung beschrieben, deren beide Ressourcen mit einem
Benutzernamen und einem Kennwort geschützt sind.
Für die zweite Ressource ist zudem ein PIN-Code erforderlich. 

**Voraussetzung:** Gehen Sie die Lernprogramme [CredentialsValidationSecurityCheck](../credentials-validation) und [UserAuthenticationSecurityCheck](../user-authentication) durch, bevor Sie hier fortfahren. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Verweis auf eine Sicherheitsüberprüfung](#referencing-a-security-check)
* [Zustandsmaschine](#state-machine)
* [Methode Authorize](#the-authorize-method)
* [Abfrage-Handler](#challenge-handlers)
* [Beispielanwendungen](#sample-applications)

## Verweis auf eine Sicherheitsüberprüfung
{: #referencing-a-security-check }
Erstellen Sie die beiden Sicherheitsüberprüfungen `StepUpPinCode` und `StepUpUserLogin`. Die Erstimplementierung dieser Überprüfungen ist
die in den Lernprogrammen [Berechtigungsnachweise validieren](../credentials-validation/security-check/)
und [Benutzerauthentifizierung](../user-authentication/security-check/) beschriebene Implementierung. 

In diesem Beispiel ist `StepUpPinCode` **abhängig** von `StepUpUserLogin`. Der Benutzer sollte erst nach einer erfolgreichen Anmeldung
bei `StepUpUserLogin` aufgefordert werden, einen PIN-Code einzugeben. Zu diesem Zweck muss
`StepUpPinCode` in der Lage sein, die Klasse `StepUpUserLogin` zu **referenzieren**.   

Das {{ site.data.keys.product_adj }}-Framework stellt eine Annotation zum Injizieren einer Referenz bereit.   
Fügen Sie zu Ihrer Klasse `StepUpPinCode` auf der Klassenebene Folgendes hinzu: 

```java
@SecurityCheckReference
private transient StepUpUserLogin userLogin;
```

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Wichtiger Hinweis:** Beide Implementierungen von Sicherheitsüberprüfungen
müssen in einem Adapter gebündelt werden.



Zum Auflösen dieser Referenz sucht das Framework nach einer Sicherheitsüberprüfung mit der entsprechenden Klasse und injiziert diese Referenz in die abhängige Sicherheitsüberprüfung.   
Für den Fall, dass es für eine Klasse mehr als eine Sicherheitsüberprüfung gibt, hat die Annomation einen optionalen Parameter
`name`, mit dem Sie einen eindeutigen Namen der referenzierten Überprüfung angeben können. 

## Zustandsmaschine
{: #state-machine }
Alle Klassen, die `CredentialsValidationSecurityCheck` erweitern (wozu
`StepUpPinCode` und `StepUpUserLogin` gehören), übernehmen eine einfache Zustandsmaschine. Die Sicherheitsüberprüfung kann sich zu jedem konkreten Zeitpunkt in einem der folgenden Zustände befinden: 

- `STATE_ATTEMPTING`: Eine Abfrage wurde gesendet, und die Sicherheitsüberprüfung wartet auf die Clientantwort. Während dieses Zustands wird die Anzahl der Versuche gezhählt. 
- `STATE_SUCCESS`: Die Berechtigungsnachweise wurden erfolgreich validiert. 
- `STATE_BLOCKED`: Die maximale Anzahl von Versuchen ist erreicht und die Überprüfung wird gesperrt. 

Der aktuelle Zustand kann mit der übernommenen Methode `getState()` abgerufen werden. 

Fügen Sie in `StepUpUserLogin` eine Methode hinzu, mit der Sie ohne großen Aufwand überprüfen können, ob der Benutzer zurzeit angemeldet ist.
Diese Methode wird später im Lernprogramm verwendet. 

```java
public boolean isLoggedIn(){
    return this.getState().equals(STATE_SUCCESS);
}
```

## Methode Authorize
{: #the-authorize-method }
Die Schnittstelle `SecurityCheck` definiert eine Methode mit der Bezeichnung `authorize`. Diese Methode ist für die Implementierung der wesentlichen Logik der
Sicherheitsüberprüfung verantwortlich, z. B. für das Senden einer Abfrage oder für die Validierung der Anforderung.   
Die Klasse `CredentialsValidationSecurityCheck`, die `StepUpPinCode` erweitert,
enthält bereits eine Implementierung dieser Methode. In diesem Fall besteht das Ziel jedoch darin,
den Zustand von `StepUpUserLogin` zu überprüfen, bevor das Standardverhalten der Methode
`authorize` ausgelöst wird. 

Dafür müssen Sie die Methode `authorize` **überschreiben**: 

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        super.authorize(scope, credentials, request, response);
    }
}
```

Diese Implementierung überprüft den aktuellen Zustand der `StepUpUserLogin`-Referenz: 

* Wenn der Zustand `STATE_SUCCESS` ist (d. h. der Benutzer angemeldet ist), folgt der normale Ablauf der Sicherheitsüberprüfung. 
* Wenn sich `StepUpUserLogin` in einem anderen Zustand befindet, wird kein Schritt ausgeführt. Das bedeutet, es wird keine Abfrage gesendet und es gibt keine Erfolgs- oder Fehlermeldung. 

Angenommen, die Ressource wird mit ** `StepUpPinCode` und mit `StepUpUserLogin` geschützt.
In dem Fall stellt der Ablauf sicher, dass der Benutzer angemeldet ist, bevor er zur Eingabe eines zweiten Berechtigungsnachweises (des PIN-Codes) aufgefordert wird.
Der Client emfpängt beide Abfragen nie zur selben Zeit, auch wenn beide Sicherheitsüberprüfungen aktiviert sind. 

Wenn die Ressource dagegen **nur** mit `StepUpPinCode` geschützt wird
(das Framework also nur diese Sicherheitsüberprüfung aktiviert), können Sie die
Implementierung von `authorize` so ändern, dass `StepUpUserLogin` manuell ausgelöst wird. 

```java
@Override
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if(userLogin.isLoggedIn()){
        // Wenn StepUpUserLogin erfolgreich ist, mit normaler Verarbeitung von StepUpPinCode fortfahren
        super.authorize(scope, credentials, request, response);
    } else {
        // In allen anderen Fällen stattdessen StepUpUserLogin verarbeiten
        userLogin.authorize(scope, credentials, request, response);
    }
}
```

## Aktuellen Benutzer abrufen
{: #retrieve-current-user }
In der Sicherheitsüberprüfung `StepUpPinCode` geht es darum, die ID des aktuellen Benutzers zu erfahren, damit in einer Datenbank nach
dem PIN-Code dieses
Benutzers gesucht werden kann. 

Fügen Sie in der Sicherheitsüberprüfung `StepUpUserLogin` die folgende Methode hinzu, um den
aktuellen Benutzer aus dem **Autorisierungskontext** abzurufen:

```java
public AuthenticatedUser getUser(){
    return authorizationContext.getActiveUser();
}
```

In `StepUpPinCode` können Sie dann die Methode
`userLogin.getUser()` verwenden, um den aktuellen Benutzer von der Sicherheitsüberprüfung
`StepUpUserLogin` abzurufen und den gültigen PIN-Code für diesen konkreten Benutzer zu überprüfen: 

```java
@Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        // Richtigen PIN-Code aus der Datenbank abrufen
    User user = userManager.getUser(userLogin.getUser().getId());

    if(credentials!=null &&  credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(user.getPinCode())){
            errorMsg = null;
            return true;
        }
        else{
            errorMsg = "Wrong credentials. Hint: " + user.getPinCode();
        }
    }
    return false;
}
```

## Abfrage-Handler
{: #challenge-handlers }
Auf der Clientseite gibt es keine spezifischen APIs für die Handhabung mehrerer Schritte. Vielmehr handhabt jeder Abfrage-Handler seine eigenen Abfragen. In diesem Beispiel müssen Sie zwei separate Abfrage-Handler registrieren, einen für die Abfragen von `StepUpUserLogin` und einen für die Abfragen von `StepUpPincode`.

<img alt="Beispielanwendung für Intensivierung" src="sample_application.png" style="float:right"/>
## Beispielanwendungen
{: #sample-applications }
### Sicherheitsüberprüfung
{: #security-check }
Die Sicherheitsüberprüfungen `StepUpUserLogin` und `StepUpPinCode`
sind im SecurityChecks-Projekt unter dem StepUp-Maven-Projekt verfügbar.
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt für Sicherheitsüberprüfungen herunterzuladen. 

### Anwendungen
{: #applications }
Beispielanwendungen sind für iOS (Swift), Android, Cordova, Windows 8.1/10 und das World Wide Web verfügbar. 

* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/StepUpCordova/tree/release80), um das Cordova-Projekt herunterzuladen. 
* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/StepUpSwift/tree/release80), um das iOS-Swift-Projekt herunterzuladen. 
* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/StepUpAndroid/tree/release80), um das Android-Projekt herunterzuladen. 
* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin8/tree/release80), um das Windows-8.1-Projekt herunterzuladen. 
* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWin10/tree/release80), um das Windows-10-Projekt herunterzuladen. 
* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/StepUpWeb/tree/release80), um das Web-App-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
