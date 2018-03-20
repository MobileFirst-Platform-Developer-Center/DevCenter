---
layout: tutorial
title: Abfrage-Handler in JavaScript-Anwendungen (Cordova, Web) implementieren
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
downloads:
  - name: Download Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn Sie versuchen, auf eine geschützte Ressource zuzugreifen,
sendet der Server (die Sicherheitsüberprüfung)
eine Liste
mit mindestens einer **Abfrage** an den Client zur Bearbeitung zurück.   
Die Liste wird als `JSON`-Objekt empfangen, in dem die Namen der Sicherheitsüberprüfungen sowie
optional weitere `JSON`-Daten enthalten sind. 

```json
{
  "challenges": {
    "SomeSecurityCheck1":null,
    "SomeSecurityCheck2":{
      "some property": "some value"
    }
  }
}
```

Der Client sollte für jede Sicherheitsüberprüfung einen **Abfrage-Handler** registrieren.   
Der Abfrage-Handler definiert das clientseitige Verhalten für die jeweilige Sicherheitsüberprüfung. 

## Abfrage-Handler erstellen
{: creating-the-challenge-handler }
Ein Abfrage-Handler bearbeitet von {{ site.data.keys.mf_server }} gesendete Abfragen.
Er zeigt beispielsweise eine Anmeldeanzeige an, erfasst Berechtigungsnachweise und übermittelt diese
an die Sicherheitsüberprüfung. 

In diesem Beispiel geht es um die Sicherheitsüberprüfung
`PinCodeAttempts`, die im Abschnitt [CredentialsValidationSecurityCheck implementieren](../security-check) definiert wurde. Die von dieser
Sicherheitsüberprüfung gesendete Abfrage enthält die verbleibende Anzahl von Anmeldeversuchen (`remainingAttempts`) und
optional eine Fehlernachricht (`errorMsg`).


Verwenden Sie die API-Methode `WL.Client.createSecurityCheckChallengeHandler()`, um einen Abfrage-Handler zu erstellen und zu registrieren: 

```javascript
PinCodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
```

## Abfrage bearbeiten
{: #handling-the-challenge }
Die Mindestanforderung des Protokolls `createSecurityCheckChallengeHandler` ist die Implementierung
der Methode `handleChallenge()`, die dafür zuständig ist, den Benutzer zur Angabe der Berechtigungsnachweise aufzufordern. Die Methode
`handleChallenge` empfängt die Abfrage als `JSON`-Objekt. 

Im folgenden Beispiel wird der Benutzer in einem Alert aufgefordert, den PIN-Code einzugeben: 

```javascript
PinCodeChallengeHandler.handleChallenge = function(challenge) {
    var msg = "";

    // Titelzeichenfolge für die Eingabeaufforderung erstellen
    if(challenge.errorMsg != null) {
        msg =  challenge.errorMsg + "\n";
    } else {
        msg = "This data requires a PIN code.\n";
    }

    msg += "Remaining attempts: " + challenge.remainingAttempts;

    // Aufforderung zur Eingabe des PIN-Codes anzeigen
    var pinCode = prompt(msg, "");

    if(pinCode){ // Aufruf von submitChallengeAnswer mit dem eingegebenen Wert
        PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
    } else { // Abbruch aufrufen, wenn der Benutzer auf die Abbruchschaltfläche geklickt hat
        PinCodeChallengeHandler.cancel();
    }
};
```

Wenn die Berechtigungsnachweise nicht stimmen, können Sie erwarten, dass das Framework erneut `handleChallenge` aufruft. 

## Antwort auf die Abfrage übergeben
{: #submitting-the-challenges-answer }
Wenn die Berechtigungsnachweise auf der Benutzerschnittstelle erfasst wurden, verwenden Sie die Methode
`submitChallengeAnswer()` von `createSecurityCheckChallengeHandler`,
um eine Antwort an die Sicherheitsüberprüfung zu senden. Im folgenden Beispiel erwartet `PinCodeAttempts`
eine Eigenschaft mit der Bezeichnung `pin`, die den übergebenen PIN-Code enthält: 

```javascript
PinCodeChallengeHandler.submitChallengeAnswer({"pin":pinCode});
```

## Abfrage abbrechen
{: #cancelling-the-challenge }
Es kann vorkommen, dass Sie dem Framework mitteilen möchten, dass diese Abfrage komplett verworfen werden soll, z. B., indem Sie auf die Schaltfläche **Cancel** klicken.  
Rufen Sie zu diesem Zweck Folgendes auf: 

```javascript
PinCodeChallengeHandler.cancel();
```

## Fehlerbehandlung
{: #handling-failures }
In einigen Szenarien kann ein Fehler ausgelöst werden (z. B. bei Erreichung der maximalen Anzahl von Versuchen). Implementieren Sie für solche Fälle
die Methode `handleFailure()` von `createSecurityCheckChallengeHandler`.   
Die Struktur des als Parameter übergebenen JSON-Objekts hängt in starkem Maße von der Art des Fehlers ab. 

```javascript
PinCodeChallengeHandler.handleFailure = function(error) {
    WL.Logger.debug("Challenge Handler Failure!");

    if(error.failure &&  error.failure == "account blocked") {
        alert("No Remaining Attempts!");  
    } else {
        alert("Error! " + JSON.stringify(error));
    }
};
```

## Erfolgsbehandlung
{: #handling-successes }
Im Erfolgsfall erlaubt das Framework generell die weitere Ausführung der Anwendung. 

Bei Bedarf können Sie entscheiden, eine Aktion auszuführen, bevor das Framework den Abfrage-Handler-Ablauf schließt,
indem Sie die Methode `handleSuccess()`
von `createSecurityCheckChallengeHandler` implementieren. Auch hier sind Inhalt und
Struktur des JSON-Objekts `success` davon abhängig, was die Sicherheitsüberprüfung sendet. 

In der Beispielanwendung `PinCodeAttemptsCordova` gibt es im Erfolgsfall keine zusätzlichen Daten. 

## Abfrage-Handler registrieren
{: #registering-the-challenge-handler }
Sie müssen das Framework anweisen, dem Abfrage-Handler den Namen einer bestimmten Sicherheitsüberprüfung zuzuordnen, damit der Abfrage-Handler auf dem Empfang der richtigen Abfragen wartet.   
Erstellen Sie den Abfrage-Handler dafür wie folgt mit der Sicherheitsüberprüfung: 

```javascript
someChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("the-securityCheck-name");
```

## Beispielanwendungen
{: #sample-applications }
Die Projekte **PinCodeWeb** und **PinCodeCordova**  verwenden `WLResourceRequest`, um einen Kontostand abzurufen.   
Die Methode ist mit meinem PIN-Code geschützt, für den es maximal drei Eingabeversuche gibt. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWeb/tree/release80), um das Webprojekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeCordova/tree/release80), um das Cordova-Projekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt SecurityAdapters herunterzuladen.   

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 

![Beispielanwendung](pincode-attempts-cordova.png)
