---
layout: tutorial
title: Klasse CredentialsValidationSecurityCheck implementieren
breadcrumb_title: Sicherheitsüberprüfung
relevantTo: [android,ios,windows,javascript]
weight: 1
downloads:
  - name: Sicherheitsüberprüfungen herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Diese abstrakte Klasse erweitert `ExternalizableSecurityCheck` und implementiert die meisten Methoden dieser Klasse, um die Nutzung zu vereinfachen. Die beiden Methoden `validateCredentials` und `createChallenge` sind obligatorisch.   
Die Klasse `CredentialsValidationSecurityCheck` ist für einfache Abläufe gedacht, um
beliebige Berechtigungsnachweise zu validieren, damit der Zugriff auf eine Ressource gewährt werden kann. Es gibt zudem eine integrierte Funktion,
die nach einer Reihe von Versuchen den Zugriff blockiert. 

In diesem Lernprogramm wird ein Beispiel für einen fest codierten PIN-Code zum Schutz einer Ressource
verwendet, der dem Benutzer drei Versuche einräumt (nach denen die Client-App-Instanz für 60 Sekunden blockiert wird). 

**Voraussetzung:** Sie müssen
die Lernprogramme [Autorisierungskonzepte](../../) und [Sicherheitsüberprüfung erstellen](../../creating-a-security-check) durcharbeiten. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Sicherheitsüberprüfung erstellen](#creating-the-security-check)
* [Abfrage erstellen](#creating-the-challenge)
* [Benutzerberechtigungsnachweise validieren](#validating-the-user-credentials)
* [Sicherheitsüberprüfung konfigurieren](#configuring-the-security-check)
* [Beispiel für eine Sicherheitsüberprüfung](#sample-security-check)

## Sicherheitsüberprüfung erstellen
{: #creating-the-security-check }
[Erstellen Sie einen Java-Adapter](../../../adapters/creating-adapters) und fügen Sie eine
Java-Klasse mit der Bezeichnung `PinCodeAttempts` hinzu, die `CredentialsValidationSecurityCheck` erweitert.

```java
public class PinCodeAttempts extends CredentialsValidationSecurityCheck {

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
Wenn die Sicherheitsüberprüfung ausgelöst wird, sendet sie eine Abfrage an den Client. Wenn `null` zurückgegeben wird,
wird eine leere Abfrage erstellt, die in einigen Fällen ausreichend sein kann.   
Bei Bedarf können Sie Daten mit der Abfrage zurückgeben, z. B. eine anzuzeigende Fehlernachricht oder andere Daten, die vom Client verwendet werden können. 

`PinCodeAttempts` sendet beispielsweise eine vordefinierte Fehlernachricht und die Anzahl der verbleibenden Versuche. 

```java
@Override
protected Map<String, Object> createChallenge() {
    Map challenge = new HashMap();
    challenge.put("errorMsg",errorMsg);
    challenge.put("remainingAttempts",getRemainingAttempts());
    return challenge;
}
```

> Die Implementierung von `errorMsg` ist in der Beispielanwendung enthalten. 

`getRemainingAttempts()` wird von `CredentialsValidationSecurityCheck` übernommen.

## Benutzerberechtigungsnachweise validieren
{: #validating-the-user-credentials }
Wenn der Client die Antwort auf die Abfrage sendet, wird die Antwort als Zuordnung (`Map`) an
`validateCredentials` übergeben. Diese Methode sollte Ihre Logik implementieren und `true` zurückgeben, wenn die Berechtigungsnachweise gültig sind. 

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey("pin")){
        String pinCode = credentials.get("pin").toString();

        if(pinCode.equals("1234")){
            return true;
        }
        else {
            errorMsg = "The pin code is not valid.";
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    // In allen anderen Fällen sind Berechtigungsnachweise nicht gültig.
    return false;

}
```

### Konfigurationsklasse
{: #configuration-class }
Sie können einen gültigen PIN-Code auch in der Datei adapter.xml und in der {{ site.data.keys.mf_console }} konfigurieren.

Erstellen Sie eine neue Java-Klasse, die `CredentialsValidationSecurityCheckConfig` erweitert. Es ist wichtig, eine Klasse zu erweitern, die zur übergeordneten Klasse für Sicherheitsüberprüfungen passt, damit die Standardkonfiguration übernommen wird. 

```java
public class PinCodeConfig extends CredentialsValidationSecurityCheckConfig {

    public String pinCode;

    public PinCodeConfig(Properties properties) {
        super(properties);
        pinCode = getStringProperty("pinCode", properties, "1234");
    }

}
```

Die einzige erforderliche Methode dieser Klasse ist ein Konstruktor, der eine `Properties`-Instanz bearbeiten kann. Verwenden Sie die Methode
`get[Type]Property`, um eine bestimmte Eigenschaft aus der Datei adapter.xml abzurufen. Wenn kein Wert gefunden wird, definiert der dritte Parameter
einen Wert (`1234`).

Sie können mit der Methode `addMessage` eine Fehlerbehandlung zu diesem Konstruktor hinzufügen: 

```java
public PinCodeConfig(Properties properties) {
    // Die übergeordneten Eigenschaften müssen geladen werden.
    super(properties);

    // Eigenschaft pinCode laden
    pinCode = getStringProperty("pinCode", properties, "1234");

    // Überprüfung, ob der PIN-Code aus mindestens 4 Zeichen besteht. Auslösung eines Fehlers.
    if(pinCode.length() < 4) {
        addMessage(errors,"pinCode","pinCode needs to be at least 4 characters");
    }

    // Überprüfung, ob der PIN-Code numerisch ist. Auslösung einer Warnung.
    try {
        int i = Integer.parseInt(pinCode);
    }
    catch(NumberFormatException nfe) {
        addMessage(warnings,"pinCode","PIN code contains non-numeric characters");
    }
}
```

Fügen Sie zu Ihrer Hauptklasse (`PinCodeAttempts`) die beiden folgenden Methoden hinzu, um die Konfiguration laden zu können: 

```java
@Override
public SecurityCheckConfiguration createConfiguration(Properties properties) {
    return new PinCodeConfig(properties);
}
@Override
protected PinCodeConfig getConfiguration() {
    return (PinCodeConfig) super.getConfiguration();
}
```

Sie können die Methode `getConfiguration().pinCode` verwenden, um den Standard-PIN-Code abzurufen.   

Sie können die Methode `validateCredentials` so ändern, dass anstelle des fest codierten Wertes der PIN-Code aus der Konfiguration verwendet wird. 

```java
@Override
protected boolean validateCredentials(Map<String, Object> credentials) {
    if(credentials!=null && credentials.containsKey(PINCODE_FIELD)){
        String pinCode = credentials.get(PINCODE_FIELD).toString();

        if(pinCode.equals(getConfiguration().pinCode)){
            return true;
        }
        else {
            errorMsg = "Pin code is not valid. Hint: " + getConfiguration().pinCode;
        }

    }
    else{
        errorMsg = "The pin code was not provided.";
    }

    // In allen anderen Fällen sind Berechtigungsnachweise nicht gültig.
    return false;

}
```

## Sicherheitsüberprüfung konfigurieren
{: #configuring-the-security-check }
Fügen Sie zu Ihrer Datei adapter.xml ein Element `<securityCheckDefinition>` hinzu: 

```xml
<securityCheckDefinition name="PinCodeAttempts" class="com.sample.PinCodeAttempts">
  <property name="pinCode" defaultValue="1234" description="The valid PIN code"/>
  <property name="maxAttempts" defaultValue="3" description="How many attempts are allowed"/>
  <property name="blockedStateExpirationSec" defaultValue="60" description="How long before the client can try again (seconds)"/>
  <property name="successStateExpirationSec" defaultValue="60" description="How long is a successful state valid for (seconds)"/>
</securityCheckDefinition>
```

Das Attribut `name` muss die Sicherheitsüberprüfung benennen. Setzen Sie den Parameter `class` auf die Klasse, die Sie zuvor erstellt haben. 

Eine Sicherheitsprüfungsdefinition (`securityCheckDefinition`) kann null oder mehr `property`-Elemente enthalten. Die Eigenschaft
`pinCode` ist die in der Konfigurationsklasse `PinCodeConfig` definierte Eigenschaft. Die anderen Eigenschaften werden von der Konfigurationsklasse
`CredentialsValidationSecurityCheckConfig` übernommen. 

Wenn Sie diese Eigenschaften nicht in der Datei adapter.xml angeben, erhalten Sie standardmäßig die von
`CredentialsValidationSecurityCheckConfig` festgelegten Standardwerte:

```java
public CredentialsValidationSecurityCheckConfig(Properties properties) {
    super(properties);
    maxAttempts = getIntProperty("maxAttempts", properties, 1);
    attemptingStateExpirationSec = getIntProperty("attemptingStateExpirationSec", properties, 120);
    successStateExpirationSec = getIntProperty("successStateExpirationSec", properties, 3600);
    blockedStateExpirationSec = getIntProperty("blockedStateExpirationSec", properties, 0);
}
```
Die Klasse `CredentialsValidationSecurityCheckConfig` definiert die folgenden Eigenschaften:

- `maxAttempts`: Zulässige Anzahl von Versuchen, bis ein Fehler (*failure*) eintritt
- `attemptingStateExpirationSec`: Intervall (in Sekunden), in dem der Client gültige Berechtigungsnachweise angeben muss. Die Versuche werden gezählt. 
- `successStateExpirationSec`: Intervall (in Sekunden), in dem eine gültige Anmeldung stattfinden muss
- `blockedStateExpirationSec`: Intervall (in Sekunden) für die Blockierung des Clients nach dem Erreichen von `maxAttempts`

Beachten Sie, dass `blockedStateExpirationSec` standardmäßig auf `0` gesetzt ist.
Wenn der Client ungültige Berechtigungsnachweise sendet, kann er also nach 0 Sekunden einen neuen Versuch unternehmen. Das bedeutet, dass das Feature für die Anzahl von Versuchen
standardmäßig inaktiviert ist. 


## Beispiel für eine Sicherheitsüberprüfung
{: #sample-security-check }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt für Sicherheitsüberprüfungen herunterzuladen. 

Das Maven-Projekt enthält eine Implementierung von CredentialsValidationSecurityCheck.
