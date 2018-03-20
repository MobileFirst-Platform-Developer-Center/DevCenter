---
layout: tutorial
title: Geräte-Single-Sign-on konfigurieren
breadcrumb_title: Device SSO
relevantTo: [android,ios,windows,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Die {{ site.data.keys.product_full }} bietet ein SSO-Feature (Single Sign-on) an,
mit dem mehrere Anwendungen auf einem Gerät den Zustand angepaster Sicherheitsüberprüfungen teilen können. Benutzer können sich beispielsweise mit dem Geräte-SSO erfolgreich bei einer Anwendung auf ihrem Gerät anmelden und werden gleichzeitig für andere Anwendungen dieser Implementierung auf demselben Gerät authentifiziert. 

**Voraussetzung**: Arbeiten Sie die Lernprogramme zum Thema [Authentifizierung und Sicherheit](../) durch. 

## SSO konfigurieren
{: #configuring-sso }
Gehen Sie in der {{ site.data.keys.mf_console }} wie folgt vor:

1. Navigieren Sie zum Abschnitt **[Ihre Anwendung] → Register "Sicherheit" →  Konfigurationen für Sicherheitsüberprüfungen**. 
2. Klicken Sie auf die Schaltfläche **Neu**, um eine neue
Sicherheitsprüfungskonfiguration zu erstellen, oder auf das Symbol
**Bearbeiten**, falls es bereits eine Sicherheitsprüfungskonfiguration gibt. 
3. Setzen Sie im Dialog **Eigenschaften für Sicherheitsüberprüfungen konfigurieren**
die Einstellung **Geräte-SSO aktivieren** auf **wahr** und klicken Sie auf `OK`.

Wiederholen Sie diese Schritte für jede Anwendung, für die Sie das Geräte-SSO aktivieren möchten. 

<img class="gifplayer" alt="Geräte-SSO in der {{ site.data.keys.mf_console }} konfigurieren" src="enable-device-sso.png"/>

Sie können auch die JSON-Konfigurationsdatei der Anwendung manuell bearbeiten und die erforderliche Konfiguration definieren.
Senden Sie dann die Änderungen per Push-Operation zurück an {{ site.data.keys.mf_server }}.

1. Navigieren Sie in eiem **Befehlszeilenfenster** zum Projektstammverzeichnis
und führen Sie den Befehl `mfpdev app pull` aus.
2. Öffnen Sie die Konfigurationsdatei aus dem Ordner **[Projektordner]\mobilefirst**. 
3. Bearbeiten Sie die Datei, um das Geräte-SSO für Ihre ausgewählte angepasste Sicherheitsüberprüfung zu aktivieren.
Das Geräte-SSO wird aktiviert, indem die Eigenschaft `enableSSO` einer angepassten Sicherheitsüberprüfung auf
`true` gesetzt wird. Die Eigenschaftskonfiguration ist in einem Sicherheitsprüfungsobjekt enthalten, das sich verschachtelt in einem
Objekt `securityCheckConfigurations` befindet. Suchen
Sie diese Objekte in Ihrer Anwendungsdeskriptordatei oder - wenn sie nicht vorhanden sind - erstellen Sie sie. Beispiel: 

   ```xml
   "securityCheckConfigurations": {
        "UserAuthentication": {
            ...
            ...
            "enableSSO": true
        }
   }
   ```
   
4. Implementieren Sie die aktualisierte JSON-Konfigurationsdatei. Führen Sie dazu den Befehl `mfpdev app push` aus.

## Geräte-SSO für vorhandenes Beispiel verwenden
{: #using-device-sso-with-a-pre-existing-sample }
Gehen Sie das Lernprogramm [Berechtigungsnachweise validieren](../credentials-validation/) durch, weil das Beispiel aus dem Lernprogramm für das Konfigurieren des Geräte-SSO verwendet wird.   
Zur Demonstration wird die Cordova-Beispielanwendung verwendet. Sie können aber auch die iOS-, Android- oder Windows-Beispielanwendung verwenden. 

1. Folgen Sie den [Anweisungen zur Verwendung des Beispiels](../credentials-validation/javascript/#sample-usage).
2. Wiederholen Sie die Schritte mit einem anderen Beispielnamen und einer anderen Anwendungs-ID. 
3. Führen Sie beide Anwendungen auf demselben Gerät aus. Wie Sie sehen, werden Sie in jeder Anwendung zur Eingabe des PIN-Codes ("1234") aufgefordert.
4. Setzen Sie in der {{ site.data.keys.mf_console }} die Einstellung `Geräte-SSO aktivieren` für jede der Anwendungen auf
`wahr`, wie weiter oben beschrieben. 
5. Beenden Sie beide Anwendungen und versuchen Sie es erneut. In der ersten Anwendung, die Sie öffnen, werden Sie zur einmaligen Eingabe des PIN-Codes aufgefordert, wenn Sie auf die Schaltfläche **Get Balance** tippen. Wenn Sie die zweite Anwendung öffnen und auf die Schaltfläche **Get Balance** tippen, müssen Sie
den PIN-Code nicht erneut eingeben, um den Kontostand abrufen zu können.
`Beachten Sie`, dass das Token für die Sicherheitsüberprüfung von PinCodeAttempts nach 60 Sekunden abläuft. Wenn also ein weiterer Versuch nach Ablauf von 60 Sekunden unternommen wird, ist für die zweite Anwendung ein PIN-Code erforderlich. 

![Cordova-Beispielanwendung mit PIN-Code](pincode-attempts-cordova.png)
