---
layout: tutorial
title: Abfrage-Handler in universellen Windows-8.1-Anwendungen und Windows-10-UWP-Anwendungen implementieren
breadcrumb_title: Windows
relevantTo: [windows]
weight: 5
downloads:
  - name: Download Win8 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80
  - name: Download Win10 project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80
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
{: #creating-the-challenge-handler }
Ein Abfrage-Handler ist eine Klasse, die von {{ site.data.keys.mf_server }} gesendete Abfragen bearbeitet.
Er zeigt beispielsweise eine Anmeldeanzeige an, erfasst Berechtigungsnachweise und übermittelt diese
an die Sicherheitsüberprüfung. 

In diesem Beispiel geht es um die Sicherheitsüberprüfung
`PinCodeAttempts`, die im Abschnitt [CredentialsValidationSecurityCheck implementieren](../security-check) definiert wurde. Die von dieser
Sicherheitsüberprüfung gesendete Abfrage enthält die verbleibende Anzahl von Anmeldeversuchen (`remainingAttempts`) und
optional eine Fehlernachricht (`errorMsg`).

Erstellen Sie eine C#-Klasse, die `Worklight.SecurityCheckChallengeHandler` erweitert:

```csharp
public class PinCodeChallengeHandler : Worklight.SecurityCheckChallengeHandler
{
}
```

## Abfrage bearbeiten
{: #handling-the-challenge }
Die Mindestanforderung der Klasse `SecurityCheckChallengeHandler` ist,
einen Konstruktor zu implementieren sowie eine Methode `HandleChallenge`, die dafür zuständig ist, den Benutzer zur Angabe der Berechtigungsnachweise aufzufordern. Die Methode `HandleChallenge`
empfängt die Abfrage als Objekt (`Object`).

Fügen Sie eine Konstruktormethode hinzu: 

```csharp
public PinCodeChallengeHandler(String securityCheck) {
    this.securityCheck = securityCheck;
}
```

Im folgenden `HandleChallenge`-Beispiel wird der Benutzer in einem Alert aufgefordert, den PIN-Code einzugeben: 

```csharp
public override void HandleChallenge(Object challenge)
{
    try
    {
      JObject challengeJSON = (JObject)challenge;

      if (challengeJSON.GetValue("errorMsg") != null)
      {
          if (challengeJSON.GetValue("errorMsg").Type == JTokenType.Null)
              errorMsg = "This data requires a PIN Code.\n";
      }

      await CoreApplication.MainView.CoreWindow.Dispatcher.RunAsync(CoreDispatcherPriority.Normal,
           async () =>
           {
               _this.HintText.Text = "";
               _this.LoginGrid.Visibility = Visibility.Visible;
               if (errorMsg != "")
               {
                   _this.HintText.Text = errorMsg + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }
               else
               {
                   _this.HintText.Text = challengeJSON.GetValue("errorMsg") + "\n" + "Remaining attempts: " + challengeJSON.GetValue("remainingAttempts");
               }

               _this.GetBalance.IsEnabled = false;
           });
    } catch (Exception e)
    {
        Debug.WriteLine(e.StackTrace);
    }
}
```

> Die Implementierung von `showChallenge` ist in der Beispielanwendung enthalten. 

Wenn die Berechtigungsnachweise nicht stimmen, können Sie erwarten, dass das Framework erneut `HandleChallenge` aufruft. 

## Antwort auf die Abfrage übergeben
{: #submitting-the-challenges-answer }
Wenn die Berechtigungsnachweise auf der Benutzerschnittstelle erfasst wurden, verwenden Sie die Methoden `ShouldSubmitChallengeAnswer()`
und `GetChallengeAnswer()`
von `SecurityCheckChallengeHandler`, um eine Antwort an die Sicherheitsüberprüfung zu senden. `ShouldSubmitChallengeAnswer()` gibt einen booleschen Wert
zurück, der angibt, ob die Antwort auf die Abfrage an die Sicherheitsüberprüfung gesendet werden soll. Im folgenden Beispiel erwartet `PinCodeAttempts`
eine Eigenschaft mit der Bezeichnung `pin`, die den übergebenen PIN-Code enthält: 

```csharp
public override bool ShouldSubmitChallengeAnswer()
{
  JObject pinJSON = new JObject();
  pinJSON.Add("pin", pinCodeTxt.Text);
  this.challengeAnswer = pinJSON;
  return this.shouldsubmitchallenge;
}

public override JObject GetChallengeAnswer()
{
  return this.challengeAnswer;
}

```

## Abfrage abbrechen
{: #cancelling-the-challenge }
Es kann vorkommen, dass Sie dem Framework mitteilen möchten, dass diese Abfrage komplett verworfen werden soll, z. B., wenn auf
eine Schaltfläche **Cancel** geklickt wird. 

Überschreiben Sie zu diesem Zweck wie folgt die Methode `ShouldCancel`: 


```csharp
public override bool ShouldCancel()
{
  return shouldsubmitcancel;
}
```

## Abfrage-Handler registrieren
{: #registering-the-challenge-handler }
Sie müssen das Framework anweisen, dem Abfrage-Handler den Namen einer bestimmten Sicherheitsüberprüfung zuzuordnen, damit der Abfrage-Handler auf dem Empfang der richtigen Abfragen wartet. 

Initialisieren Sie den Abfrage-Handler dafür wie folgt mit der Sicherheitsüberprüfung: 

```csharp
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts");
```

Anschließend müssen Sie die Abfrage-Handler-Instanz **registrieren**: 

```csharp
IWorklightClient client = WorklightClient.createInstance();
client.RegisterChallengeHandler(pinCodeChallengeHandler);
```

## Beispielanwendung
{: #sample-application }
Die Beispiele **PinCodeWin8** und **PinCodeWin10** sind C#-Anwendungen, die
`ResourceRequest` verwenden, um einen Kontostand abzurufen.   
Die Methode ist mit meinem PIN-Code geschützt, für den es maximal drei Eingabeversuche gibt. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt SecurityCheckAdapters herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin8/tree/release80), um das Windows-8-Projekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeWin10/tree/release80), um das Windows-10-UWP-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 

![Beispielanwendung](sample-application.png)   
