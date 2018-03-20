---
layout: tutorial
title: Abfrage-Handler in JavaScript-Anwendungen (Cordova, Web) implementieren
breadcrumb_title: JavaScript
relevantTo: [javascript]
weight: 2
downloads:
  - name: Download PreemptiveLogin Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginCordova/tree/release80
  - name: Download PreemptiveLogin Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWeb/tree/release80
  - name: Download RememberMe Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeCordova/tree/release80
  - name: Download RememberMe Web project
    url: https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWeb/tree/release80
  - name: Download SecurityCheck Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
**Voraussetzung:** Arbeiten Sie zuerst den Abschnitt **CredentialsValidationSecurityCheck** des Lernprogramms
[Abfrage-Handler implementieren](../../credentials-validation/javascript) durch. 

Der Abfrage-Handler demonstriert einige zusätzliche Features (APIs) wie
die bevorrechtigte Anmeldung und Abmeldung sowie das bevorrechtigte Abrufen eines Zugriffstokens für einen Bereich
(`login`, `logout` und `obtainAccessToken`).

## Anmeldung
{: #login }
In diesem Beispiel erwartet `UserLogin`, dass die Schlüsselwerte (*key:values*) `username` und `password` aufgerufen werden. Optional wird auch ein boolescher Schlüssel `rememberMe` akzeptiert, der
die Sicherheitsüberprüfung auffordert, sich diesen Benutzer für einen längeren Zeitraum zu merken, In der Beispielanwendung wird dieser boolesche Wert in Form eines Kontrollkästchens im Anmeldeformular erfasst. 

```js
userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password, rememberMe: rememberMeState});
```

Vielleicht möchten Sie ja, dass sich ein Benutzer ohne den Empfang einer Abfrage anmelden kann. Es könnte beispielsweise eine Anmeldeanzeige als
erste Anzeige der Anwendung eingeblendet oder eine Anmeldeanzeige nach der Abmeldung oder nach einem Anmeldefehler angezeigt werden. Diese
Szenarien werden als **bevorrechtigte Anmeldungen** bezeichnet.

Sie können die API `submitChallengeAnswer` nicht aufrufen, wenn es keine zu beantwortende Abfrage gibt. Für solche Szenarien enthält das
SDK der {{ site.data.keys.product }} die API `login`. 

```js
WLAuthorizationManager.login(securityCheckName,{'username':username, 'password':password, rememberMe: rememberMeState}).then(
    function () {
        WL.Logger.debug("login onSuccess");
    },
    function (response) {
        WL.Logger.debug("login onFailure: " + JSON.stringify(response));
    });
```

Wenn die Berechtigungsnachweise nicht stimmen, sendet die Sicherheitsüberprüfung eine **Abfrage** zurück.

Es ist die Verantwortung des Anwendungsentwicklers zu wissen, wann für eine bestimmte Anwendung
`login` und wann `submitChallengeAnswer` zu verwenden ist. Dazu kann der Entwickler
beispielsweise ein boolesches Flag definieren, z. B. `isChallenged`, und dieses auf `true` setzen,
wenn `handleChallenge` erreicht wird, oder das Flag in allen anderen Fällen (Fehler, Erfolg, Initialisierung usw.) auf
`false` setzen. 

Wenn der Benutzer auf die Anmeldeschaltfläche (**Login**) klickt, kann dynamisch entschieden werden, welche API zu verwenden ist: 

```js
if (isChallenged){
    userLoginChallengeHandler.submitChallengeAnswer({'username':username, 'password':password, rememberMe: rememberMeState});
} else {
    WLAuthorizationManager.login(securityCheckName,{'username':username, 'password':password, rememberMe: rememberMeState}).then(
//...
    );
}
```

> **Hinweis:**
>Die `WLAuthorizationManager`-API `login()` hat ihre eigenen
Methoden `onSuccess` und `onFailure`. Die Methode `handleSuccess` oder `handleFailure` des
betreffenden Abfrage-Handlers
wird **ebenfalls** aufgerufen. 

## Zugriffstoken anfordern
{: #obtaining-an-access-token }
Da diese Sicherheitsüberprüfung die Funktion **RememberMe** (in Form des booleschen Schlüssels
`rememberMe`) unterstützt, sollte sinnvollerweise überprüft werden,
ob der Client angemeldet ist, wenn die Anwendung gestartet wird. 

Das SDK der {{ site.data.keys.product }} stellt die API `obtainAccessToken` bereit, um den Server nach einem gültigen Token zu fragen: 

```js
WLAuthorizationManager.obtainAccessToken(userLoginChallengeHandler.securityCheckName).then(
    function (accessToken) {
        WL.Logger.debug("obtainAccessToken onSuccess");
        showProtectedDiv();
    },
    function (response) {
        WL.Logger.debug("obtainAccessToken onFailure: " + JSON.stringify(response));
        showLoginDiv();
});
```
> **Hinweis:**
> Die `WLAuthorizationManager`-API `obtainAccessToken()` hat ihre eigenen
Methoden `onSuccess` und `onFailure`. Die Methode `handleSuccess` oder `handleFailure` des
betreffenden Abfrage-Handlers
wird **ebenfalls** aufgerufen. 

Wenn der Client bereits angemeldet ist oder erinnert wird (Zustand *remembered*), löst die API einen Erfolg aus. Wenn der Client nicht angemeldet ist, sendet die Sicherheitsüberprüfung eine Abfrage zurück. 

Die API `obtainAccessToken` nimmt einen Gültigkeitsbereich (**scope**) auf. Der Bereich kann den Namen Ihrer
**Sicherheitsüberprüfung** haben.

> Weitere Informationen zu Bereichen (**scopes**) enthält das Lernprogramm [Autorisierungskonzepte](../../). 

## Authentifizierten Benutzer abrufen
{: #retrieving-the-authenticated-user }
Die Methode `handleSuccess` des Abfrage-Handlers empfängt Daten (`data`) als Parameter.
Wenn die Sicherheitsüberprüfung einen authentifizierten Benutzer (`AuthenticatedUser`) definiert, enthält dieses Objekt die Eigenschaften des Benutzers. Mit `handleSuccess` können Sie den aktuellen Benutzer speichern. 

```js
userLoginChallengeHandler.handleSuccess = function(data) {
    WL.Logger.debug("handleSuccess");
    isChallenged = false;
    document.getElementById ("rememberMe").checked = false;
    document.getElementById('username').value = "";
    document.getElementById('password').value = "";
    document.getElementById("helloUser").innerHTML = "Hello, " + data.user.displayName;
    showProtectedDiv();
}
```

Hier hat `data` einen Schlüssel mit der Bezeichnung
`user`, der wiederum ein `JSONObject` enthält, das den authentifizierten Benutzer (`AuthenticatedUser`) repräsentiert. 

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
Das SDK der {{ site.data.keys.product }} stellt eine API `logout` für die Abmeldung bei einer bestimmten Sicherheitsüberprüfung bereit. 

```js
WLAuthorizationManager.logout(securityCheckName).then(
    function () {
        WL.Logger.debug("logout onSuccess");
        location.reload();
    },
    function (response) {
        WL.Logger.debug("logout onFailure: " + JSON.stringify(response));
    });
```

## Beispielanwendungen
{: #sample-applications }
Zu diesem Lernprogramm gibt es zwei Beispiele: 

- **PreemptiveLogin**: Diese Anwendung wird immer mit einer Anmeldeanzeige gestartet, die die API `login` für bevorrechtigte Anmeldung verwendet. 
- **RememberMe**: Diese Anwendung hat ein Kontrollkästchen *Remember Me*. Wenn die Anwendung das nächste Mal geöffnet wird, kann der Benutzer die Anmeldeanzeige umgehen. 

Beide Beispiele verwenden dieselbe Sicherheitsüberprüfung `UserLogin` des Adapter-Maven-Projekts **SecurityCheckAdapters**. 

- [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SecurityCheckAdapters/tree/release80), um das Maven-Projekt SecurityCheckAdapters herunterzuladen.   
- [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeCordova/tree/release80), um das Cordova-Projekt RememberMe herunterzuladen.   
- [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginCordova/tree/release80), um das Cordova-Projekt PreemptiveLogin herunterzuladen. 
- [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/RememberMeWeb/tree/release80), um das Webprojekt RememberMe herunterzuladen. 
- [Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PreemptiveLoginWeb/tree/release80), um das Webprojekt PreemptiveLogin herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. Benutzername und Kennwort für die App müssen übereinstimmen, z. B. "john"/"john".

![Beispielanwendung](sample-application.png)
