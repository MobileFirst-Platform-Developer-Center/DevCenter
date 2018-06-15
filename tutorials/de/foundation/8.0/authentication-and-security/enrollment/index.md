---
layout: tutorial
title: Registrierung
breadcrumb_title: Enrollment
relevantTo: [android,ios,windows,javascript]
weight: 7
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentCordova/tree/release80
  - name: Download iOS Swift project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentSwift/tree/release80
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentAndroid/tree/release80
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Dieses Beispiel demonstriert einen angepassten Registrierungsprozess und eine intensivierte Autorisierung. Während dieses einmaligen Registrierungsprozesses muss der Benutzer seinen
Benutzernamen und sein Kennwort eingeben und einen PIN-Code definieren.   

**Voraussetzung:** Sie müssen die Lernprogramme
[ExternalizableSecurityCheck](../externalizable-security-check/) und [Intensivierung](../step-up/) durcharbeiten. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Anwendungsablauf](#application-flow)
* [Daten in persistenten Attributen speichern](#storing-data-in-persistent-attributes)
* [Sicherheitsüberprüfungen](#security-checks)
* [Beispielanwendungen](#sample-applications)

## Anwendungsablauf
{: #application-flow }
* Wenn die Anwendung zum ersten Mal (d. h. vor der Registrierung) startet, zeigt sie die Benutzerschnittstelle mit den beiden Schaltflächen
**Get public data** (Öffentliche Daten abrufen) und **Enroll** (Registrieren).
* Wenn der Benutzer auf die Schaltfläche **Enroll** tippt, um die Registrierung zu starten,
wird ein Anmeldeformular angezeigt. Der Benutzer wird aufgefordert, einen PIN-Code festzulegen. 
* Wenn sich der Benutzer erfolgreich registriert hat, enthält die Benutzerschnittstelle
die vier Schaltflächen **Get public data** (Öffentliche Daten abrufen), **Get balance** (Kontostand abrufen),
**Get transactions** (Transaktionen abrufen) und **Logout** (Abmelden). Der Benutzer kann auf alle vier Schaltflächen
zugreifen, ohne den PIN-Code einzugeben. 
* Wenn die Anwendung zum zweiten Mal (d. h. nach der Registrierung) gestartet wird,
enthält die Benutzerschnittstelle weiter alle vier Schaltflächen. Tippt der Benutzer jedoch auf die Schaltfläche
**Get transactions***, muss er den PIN-Code eingeben. 

Nach drei ungültigen Eingabeversuchen für den PIN-Code wird der Benutzer aufgefordert, sich erneut mit einem Benutzernamen und einem Kennwort zu authentifizieren und den PIN-Code zurückzusetzen. 

## Daten in persistenten Attributen speichern
{: #storing-data-in-persistent-attributes }
Sie haben die Möglichkeit, geschützte Daten im `PersistentAttributes`-Objekt zu speichern. Dieses Objekt ist ein Container für angepasste Attribute eines registrierten Clients. Auf das Objekt kann eine Sicherheitsprüfungsklasse oder eine Adapterressourcenklasse zugreifen. 

In der bereitgestellten Beispielanwendung wird das `PersistentAttributes`-Objekt in der
Adapterressourcenklasse verwendet, um den PIN-Code zu speichern. 

* Die Ressource **setPinCode** fügt das Attribut **pinCode**
hinzu und ruft die Methode `AdapterSecurityContext.storeClientRegistrationData()` auf, um die Änderungen zu speichern. 

  ```java
  @POST
  @OAuthSecurity(scope = "setPinCode")
  @Path("/setPinCode/{pinCode}")
  
  public Response setPinCode(@PathParam("pinCode") String pinCode){
  		ClientData clientData = adapterSecurityContext.getClientRegistrationData();
  		clientData.getProtectedAttributes().put("pinCode", pinCode);
  		adapterSecurityContext.storeClientRegistrationData(clientData);
  		return Response.ok().build();
  }
  ```
  
  Hier hat `users` einen Schlüssel mit der Bezeichnung `EnrollmentUserLogin`,
der wiederum das `AuthenticatedUser`-Objekt enthält. 

* Die Ressource **unenroll** löscht das Attribut **pinCode** und ruft
die Methode `AdapterSecurityContext.storeClientRegistrationData()` auf, um die Änderungen zu speichern. 

  ```java
  @DELETE
  @OAuthSecurity(scope = "unenroll")
  @Path("/unenroll")
  
  public Response unenroll(){
  		ClientData clientData = adapterSecurityContext.getClientRegistrationData();
  		if (clientData.getProtectedAttributes().get("pinCode") != null){
  			clientData.getProtectedAttributes().delete("pinCode");
  			adapterSecurityContext.storeClientRegistrationData(clientData);
  		}
  		return Response.ok().build();
  }
  ```

## Sicherheitsüberprüfungen
{: #security-checks }
Das Registrierungsbeispiel enthält drei Sicherheitsüberprüfungen: 

### EnrollmentUserLogin
{: #enrollmentuserlogin }
Die Sicherheitsüberprüfung `EnrollmentUserLogin` schützt die Ressource **setPinCode**,
sodass nur authentifizierte Benutzer einen PIN-Code festlegen können. Diese Sicherheitsüberprüfung soll eine kurze Ablaufzeit haben, da sie nur für die "Ersterfahrung" des Benutzers bestimmt ist. Die Sicherheitsüberprüfung stimmt mit der Überprüfung `UserLogin` überein,
die im Lernprogramm [UserAuthenticationSecurityCheck](../user-authentication/security-check) erläutert ist,
verfügt jedoch zusätzlich über die Methoden `isLoggedIn` und `getRegisteredUser`.   
Die Methode `isLoggedIn` gibt `true` zurück, wenn die Sicherheitsüberprüfung erfolgreich war (SUCCESS). Andernfalls gibt sie
`false` zurück.   
Die Methode `getRegisteredUser` gibt den authentifizierten Benutzer zurück. 

```java
public boolean isLoggedIn(){
    return getState().equals(STATE_SUCCESS);
}
```
```java
public AuthenticatedUser getRegisteredUser() {
    return registrationContext.getRegisteredUser();
}
```

### EnrollmentPinCode
{: #enrollmentpincode }
Die Sicherheitsüberprüfung `EnrollmentPinCode` schützt die Ressource
**Get transactions** und ist mit der Sicherheitsüberprüfung `PinCodeAttempts` vergleichbar, die
im Lernprogramm [CredentialsValidationSecurityCheck implementieren](../credentials-validation/security-check) erläutert ist.
Beide Überprüfungen unterscheiden sich nur in einigen wenigen Punkten. 

In dem in diesem Lernprogramm verwendeten Beispiel ist `EnrollmentPinCode` **abhängig** von `EnrollmentUserLogin`. Nach erfolgreicher Anmeldung bei `EnrollmentUserLogin` wird der Benutzer nur aufgefordert, einen PIN-Code einzugeben. 

```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

Wenn die Anwendung **zum ersten Mal** gestartet wird und der Benutzer erfolgreich registriert wurde,
muss er auf die Ressource **Get transactions** zugreifen können, ohne den gerade festgelegten PIN-Code
einzugeben. Die Methode `authorize` verwendet zu diesem Zweck die Methode `EnrollmentUserLogin.isLoggedIn`, um zu überprüfen,
ob der Benutzer angemeldet ist. Das bedeutet, dass der Benutzer auf **Get transactions**
zugreifen kann, solange `EnrollmentUserLogin` nicht abgelaufen ist. 

```java
@Override

public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    if (userLogin.isLoggedIn()){
        setState(STATE_SUCCESS);
        response.addSuccess(scope, userLogin.getExpiresAt(), getName());
    }
}
```

Wenn der Benutzer dreimal vergeblich versucht, den richtigen PIN-Code einzugeben,
wird in diesem Lernprogramm das Attribut **pinCode** gelöscht, bevor der Benutzer
aufgefordert wird, sich mit seinem Benutzernamen und seinem Kennwort zu authentifizieren
und den PIN-Code zurückzusetzen. 

```java
@Override

public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (userLogin.isLoggedIn()){
        setState(STATE_SUCCESS);
        response.addSuccess(scope, userLogin.getExpiresAt(), getName());
    } else {
        super.authorize(scope, credentials, request, response);
        if (getState().equals(STATE_BLOCKED)){
            attributes.delete("pinCode");
        }
    }
}
```

Die Methode `validateCredentials`
ist die gleiche wie in der Sicherheitsüberprüfung `PinCodeAttempts`, nur dass hier
die Berechtigungsnachweise mit dem gespeicherten Attribut **pinCode** verglichen werden. 

```java
@Override

protected boolean validateCredentials(Map<String, Object> credentials) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if(credentials!=null &&  credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals(attributes.get("pinCode"))){
            errorMsg = null;
            return true;
        }
        else {
            errorMsg = "The pin code is not valid. Hint: " + attributes.get("pinCode");
        }
    }
    else{
        errorMsg = "The pin code was not provided.";
    }
    // In allen anderen Fällen sind Berechtigungsnachweise nicht gültig.
    return false;
}
```

### IsEnrolled
{: #isenrolled }
Die Sicherheitsüberprüfung `IsEnrolled` schützt Folgendes: 

* Die Ressource **getBalance**, sodass nur registrierte Benutzer den Kontostand sehen können
* Die Ressource **transactions**, sodass nur registrierte Benutzer die Transaktionen abrufen können
* Die Ressource **unenroll**, sodass der PIN-Code (**pinCode**) nur gelöscht werden kann, wenn er zuvor festgelegt wurde 

#### Sicherheitsüberprüfung erstellen
{: #creating-the-security-check }
[Erstellen Sie einen Java-Adapter](../../adapters/creating-adapters/) und fügen Sie eine
Java-Klasse mit der Bezeichnung `IsEnrolled` hinzu, die `ExternalizableSecurityCheck` erweitert.

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    protected void initStateDurations(Map<String, Integer> durations) {}

    public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {}

    public void introspect(Set<String> scope, IntrospectionResponse response) {}
}
```

#### Konfigurationsklasse IsEnrolledConfig
{: #the-isenrolledconfig-configuration-class }
Erstellen Sie eine Konfigurationsklasse `IsEnrolledConfig`, die `ExternalizableSecurityCheckConfig` erweitert:

```java
public class IsEnrolledConfig extends ExternalizableSecurityCheckConfig {

    public int successStateExpirationSec;

    public IsEnrolledConfig(Properties properties) {
        super(properties);
        successStateExpirationSec = getIntProperty("expirationInSec", properties, 8000);
    }
}
```

Fügen Sie die Methode `createConfiguration` zur Klasse `IsEnrolled` hinzu: 

```java
public class IsEnrolled  extends ExternalizableSecurityCheck{
    @Override
    public SecurityCheckConfiguration createConfiguration(Properties properties) {
        return new IsEnrolledConfig(properties);
    }
}
```
#### Methode initStateDurations
{: #the-initstatedurations-method }
Setzen Sie die Dauer des Erfolgszustands (SUCCESS) auf `successStateExpirationSec`:

```java
@Override
protected void initStateDurations(Map<String, Integer> durations) {
    durations.put (SUCCESS_STATE, ((IsEnrolledConfig) config).successStateExpirationSec);
}
```

#### Methode authorize
{: #the-authorize-method }
Das Codebeispiel überprüft lediglich, ob der Benutzer registriert ist, und gibt je nach Ergebnis "sucess" oder "failure" zurück: 

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```

* Wenn das Attribut `pinCode` vorhanden ist: 

 * wird der Zustand mit der Methode `setState` auf SUCCESS (Erfolg) gesetzt. 
 * wird der Erfolg mit der Methode `addSuccess` zum Antwortobjekt hinzugefügt. 

* Wenn das Attribut `pinCode` nicht vorhanden ist: 

 * wird der Zustand mit der Methode `setState` auf EXPIRED (Abgelaufen) gesetzt. 
 * wird der Fehlschlag mit der Methode `addFailure` zum Antwortobjekt hinzugefügt. 

<br/>
Die Sicherheitsüberprüfung `IsEnrolled` ist **abhängig** von `EnrollmentUserLogin`:



```java
@SecurityCheckReference
private transient EnrollmentUserLogin userLogin;
```

Definieren Sie den aktiven Benutzer, indem Sie den folgenden Code hinzufügen: 

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        // Ist zurzeit ein Benutzer aktiv?
        if (!userLogin.isLoggedIn()){
            // Wenn nicht, hier einen festlegen
            authorizationContext.setActiveUser(userLogin.getRegisteredUser());
        }
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), this.getName());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```
   
Die Ressource `transactions` empfängt anschließend das aktuelle `AuthenticatedUser`-Objekt, um den Anzeigenamen zu präsentieren:

```java
@GET
@Produces(MediaType.TEXT_PLAIN)
@OAuthSecurity(scope = "transactions")
@Path("/transactions")

public String getTransactions(){
  AuthenticatedUser currentUser = securityContext.getAuthenticatedUser();
  return "Transactions for " + currentUser.getDisplayName() + ":\n{'date':'12/01/2016', 'amount':'19938.80'}";
}
```
    
> Weitere Informationen zu
`securityContext` finden Sie im Abschnitt [Sicherheits-API](../../adapters/java-adapters/#security-api) des Lernprogramms
für Java-Adapter.



Fügen Sie den registrierten Benutzer zum Antwortobjekt hinzu. Fügen Sie dafür folgenden Code hinzu: 

```java
public void authorize(Set<String> scope, Map<String, Object> credentials, HttpServletRequest request, AuthorizationResponse response) {
    PersistentAttributes attributes = registrationContext.getRegisteredProtectedAttributes();
    if (attributes.get("pinCode") != null){
        // Ist zurzeit ein Benutzer aktiv?
        if (!userLogin.isLoggedIn()){
            // Wenn nicht, hier einen festlegen
            authorizationContext.setActiveUser(userLogin.getRegisteredUser());
        }
        setState(SUCCESS_STATE);
        response.addSuccess(scope, getExpiresAt(), getName(), "user", userLogin.getRegisteredUser());
    } else  {
        setState(STATE_EXPIRED);
        Map <String, Object> failure = new HashMap<String, Object>();
        failure.put("failure", "User is not enrolled");
        response.addFailure(getName(), failure);
    }
}
```
    
In umserem Beispielcode verwendet die Methode `handleSuccess` des Abfrage-Handlers von `IsEnrolled` das Benutzerobjekt, um den Anzeigenamen zu präsentieren.

<img alt="Beispielanwendung für Registrierung" src="sample_application.png" style="float:right"/>
## Beispielanwendungen
{: #sample-applications }

### Sicherheitsüberprüfung
{: #security-check }
Die Sicherheitsüberprüfungen `EnrollmentUserLogin`, `EnrollmentPinCode`
und `IsEnrolled` sind im SecurityChecks-Projekt unter dem Maven-Projekt für Registrierung verfügbar.
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt für Sicherheitsüberprüfungen herunterzuladen. 

### Anwendungen
{: #applications }
Beispielanwendungen sind für iOS (Swift), Android, Cordova und das World Wide Web verfügbar. 

* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentCordova/tree/release80), um das Cordova-Projekt herunterzuladen. 
* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentSwift/tree/release80), um das iOS-Swift-Projekt herunterzuladen. 
* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentAndroid/tree/release80), um das Android-Projekt herunterzuladen. 
* [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/EnrollmentWeb/tree/release80), um das Web-App-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
