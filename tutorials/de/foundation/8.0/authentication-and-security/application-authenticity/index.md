---
layout: tutorial
title: Anwendungsauthentizität
relevantTo: [android,ios,windows,javascript]
weight: 9
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }

Aktivieren Sie die vordefinierte [Sicherheitsüberprüfung](../#security-check) der {{ site.data.keys.product_adj }}-Anwendungsauthentizität
(`appAuthenticity`). Diese Überprüfung validiert die Authentizität der Anwendung, bevor Services für die Anwendung bereitgestellt werden. 

Zum Aktivieren der Anwendungsauthentizität können Sie den in der **{{ site.data.keys.mf_console }}** unter **[Ihre Anwendung]**
→ **Authentizität** angezeigten Anweisungen folgen oder auch die nachstehenden Informationen durchlesen. 

#### Verfügbarkeit
{: #availability }
* Die Anwendungsauthentizität ist auf allen unterstützten Plattformen (iOS, Android, Windows 8.1 Universal, Windows 10 UWP)
für Cordova-Anwendungen und native Anwendungen verfügbar. 

#### Einschränkungen
{: #limitations }
* Die Anwendungsauthentizität bietet unter iOS keine Unterstützung für **Bitcode**. Vor Verwendung der Anwendungsauthentizität müssen Sie daher
Bitcode in den Xcode-Projekteigenschaften inaktivieren. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
- [Ablauf für Anwendungsauthentizität](#application-authenticity-flow)
- [Anwendungsauthentizität aktivieren](#enabling-application-authenticity)
- [Anwendungsauthentizität konfigurieren](#configuring-application-authenticity)

## Ablauf für Anwendungsauthentizität
{: #application-authenticity-flow }
Standardmäßig findet die Sicherheitsüberprüfung der Anwendungsauthentizität während der Registrierung der Anwendungslaufzeit bei
{{ site.data.keys.mf_server }} statt, d. h., wenn eine Instanz der Anwendung zum ersten Mal versucht, eine
Verbindung zum Server herzustellen. Die Authentizitätsabfrage wird nur einmal ausgeführt. 

Unter [Anwendungsauthentizität konfigurieren](#configuring-application-authenticity) erfahren Sie, wie dieses Verhalten angepasst werden kann. 

## Anwendungsauthentizität aktivieren
{: #enabling-application-authenticity }
Wenn Sie die Anwendungsauthentizität in Ihrer Cordova-Anwendung
oder nativen Anwendung aktivieren möchten,
müssen Sie die Binärdatei der Anwendung mit dem Tool mfp-app-authenticity signieren. Auswählbare Binärdateien sind `ipa`-Dateien für
iOS, `apk`-Dateien für Android und `appx`-Dateien für Windows 8.1 Universal und Windows 10 UWP.

1. Laden Sie das Tool mfp-app-authenticity über das Download-Center in der **{{ site.data.keys.mf_console }}** herunter.
2. Öffnen Sie ein **Befehlszeilenfenster** und führen Sie den Befehl `java -jar path-to-mfp-app-authenticity.jar path-to-binary-file` aus. 

   Beispiel: 

   ```bash
   java -jar /Users/your-username/Desktop/mfp-app-authenticity.jar /Users/your-username/Desktop/MyBankApp.ipa
   ```

   Dieser Befehl generiert neben der Datei `MyBankApp.ipa` eine Datei `MyBankApp.authenticity_data`. 

3. Öffnen Sie die {{ site.data.keys.mf_console }} in Ihrem bevorzugten Browser. 
4. Wählen Sie Ihre Anwendung in der Navigationsseitenleiste aus und klicken Sie auf den Menüeintrag **Authentizität**. 
5. Klicken Sie auf **Authentizitätsdatei hochladen**, um die `.authenticity_data`-Datei hochzuladen. 

Wenn die `.authenticity_data`-Datei hochgeladen wurde, ist die Anwendungsauthentizität aktiviert. 

![Anwendungsauthentizität aktivieren](enable_application_authenticity.png)

### Anwendungsauthentizität inaktivieren
{: #disabling-application-authenticity }
Wenn Sie die Anwendungsauthentizität inaktivieren möchten, klicken Sie auf die Schaltfläche
**Authentizitätsdatei löschen**. 

## Anwendungsauthentizität konfigurieren
{: #configuring-application-authenticity }
Die Anwendungsauthentizität wird standardmäßig nur während der Clientregistrierung überprüft. Für Ihre
Anwendungsressourcen können Sie neben jeder anderen Sicherheitsüberprüfung den Schutz mit der
Sicherheitsüberprüfung `appAuthenticity` in der Konsole auswählen.
Folgen Sie dazu den Anweisungen unter [Ressourcen schützen](../#protecting-resources).

Sie können die vordefinierte
Sicherheitsüberprüfung der Anwendungsauthentizität
mit folgender Eigenschaft konfigurieren: 

- `expirationSec`: Der Standardwert liegt bei 3600 Sekunden (1 Stunde). Die Eigenschaft definiert die Zeit bis zum Ablauf des Authentizitätstokens. 

Eine durchgeführte Authentizitätsprüfung findet erst erneut statt, wenn das Token gemäß dem festgelegten Wert abgelaufen ist. 

#### Gehen Sie wie folgt vor, um die Eigenschaft `expirationSec` zu konfigurieren: 
{: #to-configure-the-expirationsec property }
1. Laden Sie die {{ site.data.keys.mf_console }}, navigieren Sie zu
**[Ihre Anwendung]** → **Sicherheit** → **Konfigurationen für Sicherheitsüberprüfungen** und klicken Sie
auf **Neu**.

2. Suchen Sie das Bereichselement `appAuthenticity`. 

3. Legen Sie eine neue Zeit in Sekunden fest. 

![Eigenschaft expirationSec in der Konsole konfigurieren](configuring_expirationSec.png)
