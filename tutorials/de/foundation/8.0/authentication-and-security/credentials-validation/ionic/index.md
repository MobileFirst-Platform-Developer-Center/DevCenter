---
layout: tutorial
title: Abfrage-Handler in Ionic-Anwendungen implementieren
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
downloads:
  - name: Download Ionic project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PincodeIonic
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn Sie versuchen, auf eine geschützte Ressource zuzugreifen,
sendet der Server (die Sicherheitsüberprüfung)
eine Liste
mit mindestens einer **Abfrage** an den Client zur Bearbeitung.  
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

Anschließend wird erwartet, dass der Client für jede Sicherheitsüberprüfung einen **Abfrage-Handler** registriert.  
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
PincodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
```

## Abfrage bearbeiten
{: #handling-the-challenge }
Die Mindestanforderung des Protokolls `createSecurityCheckChallengeHandler` ist die Implementierung
der Methode `handleChallenge()`, die dafür zuständig ist, den Benutzer zur Angabe der Berechtigungsnachweise aufzufordern. Die Methode
`handleChallenge` empfängt die Abfrage als `JSON`-Objekt. 

Im folgenden Beispiel wird der Benutzer in einem Alert aufgefordert, den PIN-Code einzugeben: 

```javascript
 registerChallengeHandler() {
    this.PincodeChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("PinCodeAttempts");
    this.PincodeChallengeHandler.handleChallenge = ((challenge: any) => {
      console.log('--> PincodeChallengeHandler.handleChallenge called');
      this.displayLoginChallenge(challenge);
    });
  }

  displayLoginChallenge(response) {
    if (response.errorMsg) {
      var msg = response.errorMsg + ' <br> Remaining attempts: ' + response.remainingAttempts;
      console.log('--> displayLoginChallenge ERROR: ' + msg);
    }
    let prompt = this.alertCtrl.create({
      title: 'MFP Gateway',
      message: msg,
      inputs: [
        {
          name: 'pin',
          placeholder: 'please enter the pincode',
          type: 'password'
        }
      ],
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel',
          handler: () => {
            console.log('PincodeChallengeHandler: Cancel clicked');
            this.PincodeChallengeHandler.Cancel();
            prompt.dismiss();
            return false
          }
        },
        {
          text: 'Ok',
          handler: data => {
            console.log('PincodeChallengeHandler', data.username);
            this.PincodeChallengeHandler.submitChallengeAnswer(data);
          }
        }
      ]
    });
    prompt.present();
}
```

Wenn die Berechtigungsnachweise nicht stimmen, können Sie erwarten, dass das Framework erneut `handleChallenge` aufruft. 

## Antwort auf die Abfrage übergeben
{: #submitting-the-challenges-answer }
Wenn die Berechtigungsnachweise auf der Benutzerschnittstelle erfasst wurden, verwenden Sie die Methode
`submitChallengeAnswer()` von `createSecurityCheckChallengeHandler`,
um eine Antwort an die Sicherheitsüberprüfung zu senden. Im folgenden Beispiel erwartet `PinCodeAttempts`
eine Eigenschaft mit der Bezeichnung `pin`, die den übergebenen PIN-Code enthält: 

```javascript
PincodeChallengeHandler.submitChallengeAnswer(data);
```

## Abfrage abbrechen
{: #cancelling-the-challenge }
Es kann vorkommen, dass Sie dem Framework mitteilen möchten, dass diese Abfrage komplett verworfen werden soll, z. B., wenn auf eine Schaltfläche **Cancel** geklickt wird.   
Rufen Sie zu diesem Zweck Folgendes auf: 

```javascript
PincodeChallengeHandler.cancel();
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

In der Beispielanwendung `PinCodeAttemptsIonic` gibt es im Erfolgsfall keine zusätzlichen Daten. 

## Abfrage-Handler registrieren
{: #registering-the-challenge-handler }
Sie müssen das Framework anweisen, dem Abfrage-Handler den Namen einer bestimmten Sicherheitsüberprüfung zuzuordnen, damit der Abfrage-Handler auf dem Empfang der richtigen Abfragen wartet.   
Erstellen Sie den Abfrage-Handler dafür wie folgt mit der Sicherheitsüberprüfung: 

```javascript
someChallengeHandler = WL.Client.createSecurityCheckChallengeHandler("the-securityCheck-name");
```

## Beispielanwendungen
{: #sample-applications }
Das Projekt **PinCodeIonic** verwendet `WLResourceRequest`, um einen Kontostand abzurufen.   
Die Methode ist mit meinem PIN-Code geschützt, für den es maximal drei Eingabeversuche gibt. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PincodeIonic), um das Ionic-Projekt herunterzuladen.  
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt SecurityAdapters herunterzuladen.   

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 

![Beispielanwendung](pincode-attempts-cordova.png)
