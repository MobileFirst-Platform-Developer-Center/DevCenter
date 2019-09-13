---
layout: tutorial
title: Abfrage-Handler in Android-Anwendungen implementieren
breadcrumb_title: Android
relevantTo: [android]
weight: 4
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80
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

Erstellen Sie eine Java-Klasse, die `SecurityCheckChallengeHandler` erweitert:

```java
public class PinCodeChallengeHandler extends SecurityCheckChallengeHandler {

}
```

## Abfrage bearbeiten
{: #handling-the-challenge }
Die Mindestanforderung des Protokolls `SecurityCheckChallengeHandler` ist die Implementierung
eines Konstruktors und einer Methode `handleChallenge`, die den Benutzer zur Angabe der Berechtigungsnachweise auffordert. Die Methode
`handleChallenge` empfängt die Abfrage als `JSONObject`. 

Fügen Sie eine Konstruktormethode hinzu: 

```java
public PinCodeChallengeHandler(String securityCheck) {
    super(securityCheck);
}
```

Im folgenden `handleChallenge`-Beispiel wird der Benutzer in einem Alert aufgefordert, den PIN-Code einzugeben: 

```java
@Override
public void handleChallenge(JSONObject jsonObject) {
    Log.d("Handle Challenge", jsonObject.toString());
    Log.d("Failure", jsonObject.toString());
    Intent intent = new Intent();
    intent.setAction(Constants.ACTION_ALERT_MSG);
    try{
        if (jsonObject.isNull("errorMsg")){
            intent.putExtra("msg", "This data requires a PIN code.\n Remaining attempts: " + jsonObject.getString("remainingAttempts"));
            broadcastManager.sendBroadcast(intent);
        } else {
            intent.putExtra("msg", jsonObject.getString("errorMsg") + "\nRemaining attempts: " + jsonObject.getString("remainingAttempts"));
            broadcastManager.sendBroadcast(intent);
        }
    } catch (JSONException e) {
        e.printStackTrace();
    }
}

```

> Die Implementierung von `alertMsg` ist in der Beispielanwendung enthalten. 

Wenn die Berechtigungsnachweise nicht stimmen, können Sie erwarten, dass das Framework erneut `handleChallenge` aufruft. 

## Antwort auf die Abfrage übergeben
{: #submitting-the-challenges-answer }
Wenn die Berechtigungsnachweise auf der Benutzerschnittstelle erfasst wurden,
verwenden Sie die Methode `submitChallengeAnswer(JSONObject answer)` von
`SecurityCheckChallengeHandler`, um eine Antwort an die Sicherheitsüberprüfung zu senden. Im folgenden Beispiel erwartet `PinCodeAttempts`
eine Eigenschaft mit der Bezeichnung `pin`, die den übergebenen PIN-Code enthält: 

```java
submitChallengeAnswer(new JSONObject().put("pin", pinCodeTxt.getText()));
```

## Abfrage abbrechen
{: #cancelling-the-challenge }
Es kann vorkommen, dass Sie dem Framework mitteilen möchten, dass diese Abfrage komplett verworfen werden soll, z. B., wenn
auf eine Schaltfläche **Cancel** geklickt wird. 

Verwenden Sie dazu die Methode `cancel()` von `SecurityCheckChallengeHandler`. 

## Fehlerbehandlung
{: #handling-failures }
In einigen Szenarien kann ein Fehler ausgelöst werden (z. B. bei Erreichung der maximalen Anzahl von Versuchen). Implementieren Sie für solche Fälle die
Methode `handleFailure` von `SecurityCheckChallengeHandler`.
  
Die Struktur des als Parameter übergebenen JSON-Objekts (`JSONObject`) hängt in starkem Maße von der Art des Fehlers ab. 

```java
@Override
public void handleFailure(JSONObject jsonObject) {
    Log.d("Failure", jsonObject.toString());
    Intent intent = new Intent();
    intent.setAction(Constants.ACTION_ALERT_ERROR);
    try {
        if (!jsonObject.isNull("failure")) {
            intent.putExtra("errorMsg", jsonObject.getString("failure"));
            broadcastManager.sendBroadcast(intent);
        } else {
            intent.putExtra("errorMsg", "Unknown error");
            broadcastManager.sendBroadcast(intent);
        }
    } catch (JSONException e) {
        e.printStackTrace();
    }
}
```

> Die Implementierung von `alertError` ist in der Beispielanwendung enthalten. 

## Erfolgsbehandlung
{: #handling-successes }
Im Erfolgsfall erlaubt das Framework generell die weitere Ausführung der Anwendung. 

Bei Bedarf können Sie entscheiden, eine Aktion auszuführen, bevor das Framework den Abfrage-Handler-Ablauf schließt,
indem Sie die Methode `handleSuccess()` von `createSecurityCheckChallengeHandler` implementieren. Auch hier sind Inhalt und
Struktur des als Parameter übergebenen JSON-Objekts (`JSONObject`) davon abhängig, was die Sicherheitsüberprüfung sendet. 

In der Beispielanwendung `PinCodeAttempts` gibt es im `JSONObject` keine zusätzlichen Daten. Daher ist
`handleSuccess` nicht implemetiert. 

## Abfrage-Handler registrieren
{: #registering-the-challenge-handler }
Sie müssen das Framework anweisen, dem Abfrage-Handler den Namen einer bestimmten Sicherheitsüberprüfung zuzuordnen, damit der Abfrage-Handler auf dem Empfang der richtigen Abfragen wartet. 

Initialisieren Sie den Abfrage-Handler dafür wie folgt mit der Sicherheitsüberprüfung: 

```java
PinCodeChallengeHandler pinCodeChallengeHandler = new PinCodeChallengeHandler("PinCodeAttempts", this);
```

Anschließend müssen Sie die Abfrage-Handler-Instanz **registrieren**: 

```java
WLClient client = WLClient.createInstance(this);
client.registerChallengeHandler(pinCodeChallengeHandler);
```

**Hinweis:** Die Erstellung einer `WLClient`-Instanz
und die Registrierung des Abfrage-Handlers sollte im gesamten Anwendungslebenszyklus nur einmal erfolgen. Es wird empfohlen, dafür die Android-Application-Klasse zu verwenden. 

## Beispielanwendung
{: #sample-application }
**PinCodeAndroid** ist eine Android-Beispielanwendung, die `WLResourceRequest` verwendet, um einen Kontostand abzurufen.   
Die Methode ist mit meinem PIN-Code geschützt, für den es maximal drei Eingabeversuche gibt. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt SecurityAdapters herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PinCodeAndroid/tree/release80), um das Android-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 

![Beispielanwendung](sample-application-android.png)
