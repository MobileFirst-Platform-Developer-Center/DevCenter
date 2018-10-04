---
layout: tutorial
title: Abfrage-Handler in iOS-Anwendungen implementieren
breadcrumb_title: iOS
relevantTo: [ios]
weight: 3
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeSwift/tree/release80
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

Der Client muss für jede Sicherheitsüberprüfung einen **Abfrage-Handler** registrieren.   
Der Abfrage-Handler definiert das clientseitige Verhalten für die jeweilige Sicherheitsüberprüfung. 

## Abfrage-Handler erstellen
{: #creating-the-challenge-handler }
Ein Abfrage-Handler ist eine Klasse, die von {{ site.data.keys.mf_server }} gesendete Abfragen bearbeitet.
Er zeigt beispielsweise eine Anmeldeanzeige an, erfasst Berechtigungsnachweise und übermittelt diese
an die Sicherheitsüberprüfung. 

In diesem Beispiel geht es um die Sicherheitsüberprüfung
`PinCodeAttempts`, die im Abschnitt [CredentialsValidationSecurityCheck implementieren](../security-check) definiert wurde. Die von dieser
Sicherheitsüberprüfung gesendete Abfrage enthält die verbleibende Anzahl von Anmeldeversuchen (`remainingAttempts`) und
optional eine Fehlernachricht (`errorMsg`).

Erstellen Sie eine Swift-Klasse, die `SecurityCheckChallengeHandler` erweitert:

```swift
class PinCodeChallengeHandler : SecurityCheckChallengeHandler {

}
```

## Abfrage bearbeiten
{: #handling-the-challenge }
Die Mindestanforderung des Protokolls `SecurityCheckChallengeHandler` ist die Implementierung
der Methode `handleChallenge`, die den Benutzer zur Angabe der Berechtigungsnachweise auffordert. Die Methode
`handleChallenge` empfängt die `JSON`-Abfrage als `Verzeichnis`.

Im folgenden Beispiel wird der Benutzer in einem Alert aufgefordert, den PIN-Code einzugeben: 

```swift
override func handleChallenge(challenge: [NSObject : AnyObject]!) {
    NSLog("%@",challenge)
    var errorMsg : String
    if challenge["errorMsg"] is NSNull {
        errorMsg = "This data requires a PIN code."
    }
    else{
        errorMsg = challenge["errorMsg"] as! String
    }
    let remainingAttempts = challenge["remainingAttempts"] as! Int

    showPopup(errorMsg,remainingAttempts: remainingAttempts)
}
```

> Die Implementierung von `showPopup` ist in der Beispielanwendung enthalten. 

Wenn die Berechtigungsnachweise nicht stimmen, können Sie erwarten, dass das Framework erneut `handleChallenge` aufruft. 

## Antwort auf die Abfrage übergeben
{: #submitting-the-challenges-answer }
Wenn die Berechtigungsnachweise auf der Benutzerschnittstelle erfasst wurden, verwenden Sie die Methode
`submitChallengeAnswer(answer: [NSObject : AnyObject]!)` von `WLChallengeHandler`,
um eine Antwort an die Sicherheitsüberprüfung zu senden. Im folgenden Beispiel erwartet `PinCodeAttempts`
eine Eigenschaft mit der Bezeichnung `pin`, die den übergebenen PIN-Code enthält: 

```swift
self.submitChallengeAnswer(["pin": pinTextField.text!])
```

## Abfrage abbrechen
{: #cancelling-the-challenge }
Es kann vorkommen, dass Sie dem Framework mitteilen möchten, dass diese Abfrage komplett verworfen werden soll, z. B., wenn auf
eine Schaltfläche **Cancel** geklickt wird. 

Rufen Sie zu diesem Zweck Folgendes auf: 

```swift
self.cancel()
```

## Fehlerbehandlung
{: #handling-failures }
In einigen Szenarien kann ein Fehler ausgelöst werden (z. B. bei Erreichung der maximalen Anzahl von Versuchen). Implementieren Sie für solche Fälle die
Methode `handleFailure` von `SecurityCheckChallengeHandler`.
Die Struktur des als Parameter übergebenen Verzeichnisses (`Dictionary`) hängt in starkem Maße von der Art des Fehlers ab. 

```swift
override func handleFailure(failure: [NSObject : AnyObject]!) {
    if let errorMsg = failure["failure"] as? String {
        showError(errorMsg)
    }
    else{
        showError("Unknown error")
    }
}
```

> Die Implementierung von `showError` ist in der Beispielanwendung enthalten. 

## Erfolgsbehandlung
{: #handling-successes }
Im Erfolgsfall erlaubt das Framework generell die weitere Ausführung der Anwendung. 

Bei Bedarf können Sie entscheiden, eine Aktion auszuführen, bevor das Framework den Abfrage-Handler-Ablauf schließt,
indem Sie die Methode
`handleSuccess(success: [NSObject : AnyObject]!)` von `SecurityCheckChallengeHandler` implementieren. Auch hier sind Inhalt und
Struktur des Verzeichnisses `success` davon abhängig, was die Sicherheitsüberprüfung sendet. 

In der Beispielanwendung `PinCodeAttemptsSwift` gibt es im Erfolgsfall keine zusätzlichen Daten. Daher ist
`handleSuccess` nicht implemetiert. 

## Abfrage-Handler registrieren
{: #registering-the-challenge-handler }
Sie müssen das Framework anweisen, dem Abfrage-Handler den Namen einer bestimmten Sicherheitsüberprüfung zuzuordnen, damit der Abfrage-Handler auf dem Empfang der richtigen Abfragen wartet. 

Initialisieren Sie den Abfrage-Handler dafür wie folgt mit der Sicherheitsüberprüfung: 

```swift
var someChallengeHandler = SomeChallengeHandler(securityCheck: "securityCheckName")
```

Anschließend müssen Sie die Abfrage-Handler-Instanz **registrieren**: 

```swift
WLClient.sharedInstance().registerChallengeHandler(someChallengeHandler)
```

Geben Sie in diesem Beispiel Folgendes in einer Zeile ein: 

```swift
WLClient.sharedInstance().registerChallengeHandler(PinCodeChallengeHandler(securityCheck: "PinCodeAttempts"))
```

**Hinweis:** Der Abfrage-Handler sollte im gesamten Anwendungslebenszyklus nur einmal registriert werden. Es wird empfohlen, dafür die iOS-AppDelegate-Klasse zu verwenden. 

## Beispielanwendung
{: #sample-application }
**PinCodeSwift** ist eine iOS-Swift-Beispielanwendung, die `WLResourceRequest` verwendet, um einen Kontostand abzurufen.   
Die Methode ist mit meinem PIN-Code geschützt, für den es maximal drei Eingabeversuche gibt. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt SecurityAdapters herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeSwift/tree/release80), um das native iOS-Projekt PinCodeSwift herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 

![Beispielanwendung](sample-application.png)

