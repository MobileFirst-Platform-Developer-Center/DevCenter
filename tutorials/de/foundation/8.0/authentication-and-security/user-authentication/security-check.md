---
layout: tutorial
title: Klasse UserAuthenticationSecurityCheck implementieren
breadcrumb_title: Security Check
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: Download Security Checks
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Diese abstrakte Klasse erweitert `CredentialsValidationSecurityCheck` und baut auf diese auf,
um die häufigsten Anwendungsfälle der einfachen Benutzerauthentifizierung abzudecken. Sie validiert nicht nur die Berechtigungsnachweise, sondern
erstellt auch eine **Benutzeridentität**, auf die von mehreren Teilen des Frameworks zugegriffen werden kann, sodass Sie
den aktuellen Benutzer identifizieren können. `UserAuthenticationSecurityCheck` kann bei Bedarf auch Erinnerungsfunktionen (**Remember Me**) bereitstellen. 

In diesem Lernprogramm wird eine Beispielsicherheitsüberprüfung verwendet, die einen Benutzernamen und ein Kennwort anfordert
und einen authentifizierten Benutzer mit dem Benutzernamen darstellt. 

**Voraussetzung:** Sie müssen das Lernprogramm [CredentialsValidationSecurityCheck](../../credentials-validation/) durchgearbeitet haben. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Sicherheitsüberprüfung erstellen](#creating-the-security-check)
* [Abfrage erstellen](#creating-the-challenge)
* [Benutzerberechtigungsnachweise validieren](#validating-the-user-credentials)
* [AuthenticatedUser-Objekt erstellen](#creating-the-authenticateduser-object)
* [Funktion RememberMe hinzufügen](#adding-rememberme-functionality)
* [Sicherheitsüberprüfung konfigurieren](#configuring-the-security-check)
* [Beispiel für eine Sicherheitsüberprüfung](#sample-security-check)

## Sicherheitsüberprüfung erstellen
{: #creating-the-security-check }
[Erstellen Sie einen Java-Adapter](../../../adapters/creating-adapters) und fügen Sie eine
Java-Klasse mit der Bezeichnung `UserLogin` hinzu, die `UserAuthenticationSecurityCheck` erweitert.

```java
public class UserLogin extends UserAuthenticationSecurityCheck {

    @Override
    protected AuthenticatedUser createUser() {
        return null;
    }

    @Override
    protected boolean validateCredentials(Map<String, Object> credentials) {
        return false;
    }

    @Override
    protected Map<String, Object> createChallenge() {
        return null;
    }

    }
```

## Abfrage erstellen
{: #creating-the-challenge }
Die Abfrage ist exakt die unter
[CredentialsValidationSecurityCheck implementieren](../../credentials-validation/security-check/) beschriebene.

```java
@Override
    protected Map<String, Object> createChallenge() {
        Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

## Benutzerberechtigungsnachweise validieren
{: #validating-the-user-credentials }
Wenn der Client die Antwort auf die Abfrage sendet, wird die Antwort als Zuordnung (`Map`) an
`validateCredentials` übergeben. Verwenden Sie diese Methode für die Implementierung Ihrer Logik. Die Methode gibt `true` zurück, wenn die
Berechtigungsnachweise gültig sind. 

In diesem Beispiel werden die Berechtigungsnachweise als gültig (valid) angesehen, wenn die Werte von
`username` und `password` übereinstimmen: 

```java
@Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
        String username = credentials.get("username").toString();
        String password = credentials.get("password").toString();
        if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
            return true;
        }
        else {
            errorMsg = "Wrong Credentials";
        }
    }
    else{
        errorMsg = "Credentials not set properly";
    }
    return false;
}
```

## AuthenticatedUser-Objekt erstellen
{: #creating-the-authenticateduser-object }
Die Klasse `UserAuthenticationSecurityCheck` speichert eine Darstellung des aktuellen Clients
(Benutzer, Gerät, Anwendung) in Form persistenter Daten, sodass Sie
den aktuellen Benutzer in verschiedenen Abschnitten Ihres Codes abrufen
können, z. B. in den Abfrage-Handlern oder in den Adaptern.
Benutzer werden von einer Instanz der Klasse `AuthenticatedUser` dargestellt. Der Konstruktor dieser Klasse wird mit den Parametern
`id`, `displayName` und `securityCheckName` verwendet. 

In diesem Beispiel wird `username` für die Parameter `id` und `displayName` verwendet. 

1. Modifizieren Sie zunächst die Methode `validateCredentials`, um das Argument `username` zu speichern: 

   ```java
   private String userId, displayName;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
        String username = credentials.get("username").toString();
        String password = credentials.get("password").toString();
        if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
            userId = username;
                displayName = username;
                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "The credentials are not set properly.";
        }
        return false;
   }
   ```

2. Überschreiben Sie dann die Methode `createUser`, um eine neue Instanz von `AuthenticatedUser` zurückzugeben:

   ```java
   @Override
   protected AuthenticatedUser createUser() {
        return new AuthenticatedUser(userId, displayName, this.getName());
   }
   ```

Sie können `this.getName()` verwenden, um den Namen der aktuellen Sicherheitsüberprüfung abzurufen. 

`UserAuthenticationSecurityCheck` ruft Ihre Implementierung von `createUser()` nach einem Erfolg von
`validateCredentials` auf. 

### Attribute in AuthenticatedUser speichern
{: #storing-attributes-in-the-authenticateduser }
`AuthenticatedUser` hat einen alternativen Konstruktor: 

```java
AuthenticatedUser(String id, String displayName, String securityCheckName, Map<String, Object> attributes);
```

Dieser Konstruktor fügt eine Zuordnung (`Map`) angepasster Attribute hinzu, die mit der Benutzerdarstellung gespeichert werden sollen. Die Zuordnung kann genutzt werden, um weitere Informationen zu speichern, z. B. ein Profilbild, eine Website usw.
Diese Informationen sind für die Clientseite (Abfrage-Handler) und die Ressource (über Introspektionsdaten) zugänglich. 

> **Hinweis:**
> Die Attributzuordnung (`Map`) darf nur Objekte von Typen/Klassen aus der Java-Bibliothek (z. B.
`String`, `int`, `Map` usw.) und **keine** angepassten Klassen enthalten. 

## Funktion RememberMe hinzufügen
{: #adding-rememberme-functionality }
`UserAuthenticationSecurityCheck` verwendet standardmäßig die Eigenschaft `successStateExpirationSec`, um festzustellen,
wie lange der Erfolgszustand andauert. Diese Eigenschaft wird von `CredentialsValidationSecurityCheck` übernommen.

Wenn Sie Benutzern erlauben möchten, über den von `successStateExpirationSec` angegebenen Zeitraum hinaus angemeldet zu bleiben,
fügt `UserAuthenticationSecurityCheck` diese Möglichkeit hinzu. 

`UserAuthenticationSecurityCheck` fügt eine Eigenschaft
`rememberMeDurationSec` mit dem Standardwert `0` hinzu.
Benutzer werden standardmäßig für **0 Sekunden** erinnert. Das bedeutet, dass das Feature standardmäßig
inaktiviert ist. Setzen Sie diese Eigenschaft auf einen für Ihre Anwendung passenden Wert (einen Tag, eine Woche, einen Monat...).

Sie können das Feature auch verwalten. Überschreiben Sie dazu die Methode `rememberCreatedUser()`,
die standardmäßig `true` zurückgibt. Das heißt, das Feature ist standardmäßig
aktiv (sofern Sie die Eigenschaft für den Zeitraum geändert haben). 

Im folgenden Beispiel entscheidet der Client über die Aktivierung/Inaktivierung des Features **RememberMe**, indem
er einen booleschen Wert (`boolean`) als Teil der übergebenen Berechtigungsnachweise sendet. 

1. Modifizieren Sie zunächst die Methode `validateCredentials`, um die Auswahl für `rememberMe` zu speichern: 

   ```java
   private String userId, displayName;
   private boolean rememberMe = false;

   @Override
   protected boolean validateCredentials(Map<String, Object> credentials) {
        if(credentials!=null &&  credentials.containsKey("username") &&  credentials.containsKey("password")){
        String username = credentials.get("username").toString();
        String password = credentials.get("password").toString();
        if(!username.isEmpty() &&  !password.isEmpty() &&  username.equals(password)) {
            userId = username;
                displayName = username;

                // Optionales RememberMe
                if(credentials.containsKey("rememberMe") ){
                    rememberMe = Boolean.valueOf(credentials.get("rememberMe").toString());
                }

                return true;
            }
            else {
                errorMsg = "Wrong Credentials";
            }
        }
        else{
            errorMsg = "Credentials not set properly";
        }
        return false;
   }
   ```

2. Überschreiben Sie dann die Methode `rememberCreatedUser()`: 

   ```java
   @Override
   protected boolean rememberCreatedUser() {
        return rememberMe;
   }
   ```

## Sicherheitsüberprüfung konfigurieren
{: #configuring-the-security-check }
Fügen Sie in der Datei **adapter.xml** ein Element `<securityCheckDefinition>` hinzu: 

```xml
<securityCheckDefinition name="UserLogin" class="com.sample.UserLogin">
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed."/>
  <property name="blockedStateExpirationSec" defaultValue="10" description="How long before the client can try again (seconds)."/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)."/>
  <property name="rememberMeDurationSec" defaultValue="120" description="How long is the user remembered by the RememberMe feature (seconds)."/>
</securityCheckDefinition>
```
Wie bereits angegeben übernimmt `UserAuthenticationSecurityCheck` alle `CredentialsValidationSecurityCheck`-Eigenschaften
(`blockedStateExpirationSec`, `successStateExpirationSec` usw.).



Zusätzlich können Sie eine Eigenschaft `rememberMeDurationSec` konfigurieren. 

## Beispiel für eine Sicherheitsüberprüfung
{: #sample-security-check }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt für Sicherheitsüberprüfungen herunterzuladen. 

Dieses Maven-Projekt enthält eine Implementierung von `UserAuthenticationSecurityCheck`.
