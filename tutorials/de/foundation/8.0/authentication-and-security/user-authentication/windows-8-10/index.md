---
layout: tutorial
title: Abfrage-Handler in universellen Windows-8.1-Anwendungen und Windows-10-UWP-Anwendungen implementieren
breadcrumb_title: Windows
relevantTo: [windows]
weight: 5
downloads:
  - name: Win8-Projekt RememberMe herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin8/tree/release80
  - name: Win10-Projekt RememberMe herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin10/tree/release80
  - name: Win8-Projekt PreemptiveLogin herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin8/tree/release80
  - name: Win10-Projekt PreemptiveLogin herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin10/tree/release80
  - name: Maven-Projekt SecurityCheck herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
**Voraussetzung:** Arbeiten Sie zuerst den Abschnitt
**CredentialsValidationSecurityCheck** des Lernprogramms [Abfrage-Handler implementieren](../../credentials-validation/windows-8-10) durch. 

Das Abfrage-Handler-Lernprogramm demonstriert einige zusätzliche Features (APIs) wie die bevorrechtigte Anmeldung und Abmeldung sowie das bevorrechtigte Abrufen eines Zugriffstokens für einen Bereich
(`Login`, `Logout` und `ObtainAccessToken`).

## Anmeldung
{: #login }
In diesem Beispiel erwartet `UserLoginSecurityCheck`, dass die Schlüsselwerte (*key:values*) `username` und `password` aufgerufen werden. Optional wird auch ein boolescher Schlüssel `rememberMe` akzeptiert, der
die Sicherheitsüberprüfung auffordert, sich diesen Benutzer für einen längeren Zeitraum zu merken, In der Beispielanwendung wird dieser boolesche Wert in Form eines Kontrollkästchens im Anmeldeformular erfasst. 

Das Argument `credentials` ist ein `JSONObject`,
das `username`, `password` und `rememberMe` enthält:

```csharp
public override void SubmitChallengeAnswer(object answer)
{
    challengeAnswer = (JObject)answer;
}
```

Vielleicht möchten Sie ja, dass sich ein Benutzer ohne den Empfang einer Abfrage anmelden kann. Sie könnten beispielsweise eine Anmeldeanzeige als erste Anzeige der Anwendung einblenden oder eine Anmeldeanzeige nach der Abmeldung oder nach einem Anmeldefehler anzeigen. Diese Szenarien werden als **bevorrechtigte Anmeldungen** bezeichnet.

Sie können die API `challengeAnswer` nicht aufrufen, wenn es keine zu beantwortende Abfrage gibt. Für solche Szenarien enthält das
SDK der {{ site.data.keys.product }} die API `Login`. 

```csharp
WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Login(String securityCheckName, JObject credentials);
```

Wenn die Berechtigungsnachweise nicht stimmen, sendet die Sicherheitsüberprüfung eine **Abfrage** zurück.

Es ist die Verantwortung des Anwendungsentwicklers zu wissen, wann für eine bestimmte Anwendung `Login` und wann `challengeAnswer` zu verwenden ist. Dazu kann der Entwickler
beispielsweise ein boolesches Flag definieren, z. B. `isChallenged`, und dieses auf `true` setzen,
wenn `HandleChallenge` erreicht wird, oder das Flag in allen anderen Fällen (Fehler, Erfolg, Initialisierung usw.) auf
`false` setzen. 

Wenn der Benutzer auf die Anmeldeschaltfläche (**Login**) klickt, kann dynamisch entschieden werden, welche API zu verwenden ist: 

```csharp
public async void login(JSONObject credentials)
{
    if(isChallenged)
    {
        challengeAnswer= credentials;
    }
    else
    {
        WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Login(securityCheckName, credentials);
    }
}
```
## Zugriffstoken anfordern
{: #obtaining-an-access-token }
Da diese Sicherheitsüberprüfung die Funktion **RememberMe** (in Form des booleschen Schlüssels
`rememberMe`) unterstützt, sollte sinnvollerweise überprüft werden,
ob der Client angemeldet ist, wenn die Anwendung gestartet wird. 

Das SDK der {{ site.data.keys.product }} stellt die API `ObtainAccessToken` bereit, um den Server nach einem gültigen Token zu fragen: 

```csharp
WorklightAccessToken accessToken = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.ObtainAccessToken(String scope);

if(accessToken.IsValidToken && accessToken.Value != null && accessToken.Value != "")
{
  Debug.WriteLine("Auto login success");
}
else
{
  Debug.WriteLine("Auto login failed");
}

```

Wenn der Client bereits angemeldet ist oder erinnert wird (Zustand *remembered*), löst die API einen Erfolg aus. Wenn der Client nicht angemeldet ist, sendet die Sicherheitsüberprüfung eine Abfrage zurück. 

Die API `ObtainAccessToken` nimmt einen Gültigkeitsbereich (**scope**) auf. Der Bereich kann den Namen Ihrer
**Sicherheitsüberprüfung** haben.

> Weitere Informationen zu Bereichen (**scopes**) enthält das Lernprogramm [Autorisierungskonzepte](../../). 

## Authentifizierten Benutzer abrufen
{: #retrieving-the-authenticated-user }
Die Methode `HandleSuccess` des Abfrage-Handlers empfängt eine `JObject identity` als Parameter.
Wenn die Sicherheitsüberprüfung einen authentifizierten Benutzer (`AuthenticatedUser`) definiert, enthält dieses Objekt die Eigenschaften des Benutzers. Mit `HandleSuccess` können Sie den aktuellen Benutzer speichern. 

```csharp
public override void HandleSuccess(JObject identity)
{
    isChallenged = false;
    try
    {
        // Aktuellen Benutzer speichern
        var localSettings = Windows.Storage.ApplicationData.Current.LocalSettings;
        localSettings.Values["useridentity"] = identity.GetValue("user");

    } catch (Exception e) {
        Debug.WriteLine(e.StackTrace);
    }
}
```

Hier hat `identity` einen Schlüssel mit der Bezeichnung
`user`, der wiederum ein `JObject` enthält, das den authentifizierten Benutzer (`AuthenticatedUser`) repräsentiert. 

```json
{
  "user": {
    "id": "john",
    "displayName": "john",
    "authenticatedAt": 1455803338008,
    "authenticatedBy": "UserLogin"
  }
}
```

## Abmeldung
{: #logout }
Das SDK der {{ site.data.keys.product }} stellt eine API `Logout` für die Abmeldung bei einer bestimmten Sicherheitsüberprüfung bereit. 

```csharp
WorklightResponse response = await Worklight.WorklightClient.CreateInstance().AuthorizationManager.Logout(securityCheckName);
```

## Beispielanwendungen
{: #sample-applications }
Zu diesem Lernprogramm gibt es zwei Beispiele: 

- **PreemptiveLoginWin**: Diese Anwendung wird immer mit einer Anmeldeanzeige gestartet, die die API `Login` für bevorrechtigte Anmeldung verwendet. 
- **RememberMeWin**: Diese Anwendung hat ein Kontrollkästchen *Remember Me*. Wenn die Anwendung das nächste Mal geöffnet wird, kann der Benutzer die Anmeldeanzeige umgehen. 

Beide Beisiele verwenden dieselbe Sicherheitsüberprüfung (`UserLoginSecurityCheck`) des
Adapter-Maven-Projekts **SecurityCheckAdapters**. 

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt SecurityCheckAdapters herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin8/tree/release80), um das Win8-Projekt "Remember Me" herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWin10/tree/release80), um das Win10-Projekt "Remember Me" herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin8/tree/release80), um das Win8-Projekt PreemptiveLogin herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWin10/tree/release80), um das Win10-Projekt PreemptiveLogin herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. Benutzername und Kennwort für die App müssen übereinstimmen, z. B. "john"/"john".

![Beispielanwendung](RememberMe.png)
