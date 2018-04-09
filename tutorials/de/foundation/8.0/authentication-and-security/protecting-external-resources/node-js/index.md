---
layout: tutorial
title: Node.js-Validator
breadcrumb_title: Node.js validator
relevantTo: [android,ios,windows,javascript]
weight: 3
downloads:
  - name: Download sample
    url: https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} stellt ein Node.js-Framework für die Umsetzung von Sicherheitsfunktionen für externe Ressourcen bereit.   
Das Node.js-Framework wird als npm-Modul (**passport-mfp-token-validation**) zur Verfügung gestellt.

Dieses Lernprogramm zeigt, wie eine einfache Node.js-Ressource (`GetBalance`) mit einem Gültigkeitsbereich (`accessRestricted`) geschützt wird.

**Voraussetzungen:**  

* Gehen Sie das Lernprogramm [Externe Ressource mit {{ site.data.keys.mf_server }} authentifizieren](../) durch. 
* Sie müssen das [{{ site.data.keys.product }}-Sicherheitsframework](../../) verstehen.

## Modul 'passport-mfp-token-validation'
{: #the-passport-mfp-token-validation-module }
Das Modul "passport-mfp-token-validation" stellt einen Authentifizierungsmechanismus für die Überprüfung
der von {{ site.data.keys.mf_server }} ausgegebenen Zugriffstoken bereit.

Führen Sie für die Installation des Moduls den folgenden Befehl aus: 

```bash
npm install passport-mfp-token-validation@8.0.X
```

## Verwendung
{: #usage }
* Im Beispiel werden die Module `express` und `passport-mfp-token-validation` verwendet. 

  ```javascript
  var express = require('express');
  var passport = require('passport-mfp-token-validation').Passport;
  var mfpStrategy = require('passport-mfp-token-validation').Strategy;
  ```

* Definieren Sie `Strategy` wie folgt: 

  ```javascript
  passport.use(new mfpStrategy({
    authServerUrl: 'http://localhost:9080/mfp/api',
    confClientID: 'testclient',
    confClientPass: 'testclient',
    analytics: {
        onpremise: {
            url: 'http://localhost:9080/analytics-service/rest/v3',
            username: 'admin',
            password: 'admin'
        }
    }
  }));
  ```
  
 * `authServerUrl`: Ersetzen Sie `localhost:9080` durch die IP-Adresse und
Portnummer Ihres {{ site.data.keys.mf_server }}. 
 * `confClientID`, `confClientPass`: Ersetzen Sie die ID und das Kennwort des vertraulichen Clients
durch die in der {{ site.data.keys.mf_console }} definierten Werte.
 * `analytics`: Das Element analytics ist generell optional und nur erforderlich, wenn Sie
in der {{ site.data.keys.product }} Analyseereignisse protokollieren möchten.  
Ersetzen Sie `localhost:9080`, `username` und `password` durch die IP-Adresse, die Portnummer, den Benutzernamen und das Kennwort für Ihren Analytics Server.

* Rufen Sie für die Authentifizierung von Anforderungen `passport.authenticate` auf: 

  ```javascript
  var app = express();
  app.use(passport.initialize());

  app.get('/getBalance', passport.authenticate('mobilefirst-strategy', {
      session: false,
      scope: 'accessRestricted'
  }),
  function(req, res) {
      res.send('17364.9');
  });

  var server = app.listen(3000, function() {
      var port = server.address().port
      console.log("Sample app listening at http://localhost:%s", port)
  });
  ```

 * Die zu implementierende Strategie (`Strategy`) sollte `mobilefirst-strategy` sein.
 * Setzen Sie `session` auf `false`.
 * Geben Sie für `scope` den Bereichsnamen an. 

## Beispielanwendung 
{: #sample-application }
[Laden Sie das Node.js-Beispiel herunter](https://github.com/MobileFirst-Platform-Developer-Center/NodeJSValidator/tree/release80).

### Verwendung des Beispiels
{: #sample-usage }
1. Navigieren Sie zum Stammordner des Beispiels und führen Sie den Befehl `npm install`, gefolgt von `npm start`, aus.
2. Sie müssen [den vertraulichen Client](../#confidential-client)
und die geheimen Schlüssel in der {{ site.data.keys.mf_console }} aktualisieren.
3. Implementieren Sie eine der Sicherheitsüberprüfungen: **[UserLogin](../../user-authentication/security-check/)**
oder **[PinCodeAttempts](../../credentials-validation/security-check/)**.
4. Registrieren Sie die passende Anwendung. 
5. Ordnen Sie der Sicherheitsüberprüfung den Bereich `accessRestricted` zu. 
6. Aktualisieren Sie die Clientanwendung so, dass `WLResourceRequest` Ihre Servlet-URL ist. 
