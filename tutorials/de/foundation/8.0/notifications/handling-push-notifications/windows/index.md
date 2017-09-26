---
layout: tutorial
title: Push-Benachrichtigungen in Windows 8.1 Universal und Windows 10 UWP
breadcrumb_title: Windows
relevantTo: [windows]
weight: 7
downloads:
  - name: Universelles Windows-8.1-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80
  - name: Windows-10-UWP-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin10/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können
die {{ site.data.keys.product_adj }}-API für Benachrichtigungen verwenden,
um Geräte zu registrieren und Geräteregistrierungen aufzuheben und um
Tags zu abonnieren und Tagabonnements zu beenden. In diesem Lernprogramm werden Sie lernen, wie
Push-Benachrichtigungen in universellen Windows-8.1-Anwendungen und Windows-10-UWP-Anwendungen mit C# gehandhabt werden. 

**Voraussetzungen:**

* Stellen Sie sicher, dass Sie die folgenden Lernprogramme durchgearbeitet haben: 
	* [Übersicht über Push-Benachrichtigungen](../../)
    * [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/#installing-a-development-environment)
    * [{{ site.data.keys.product_adj }}-SDK zu Windows-Anwendungen hinzufügen](../../../application-development/sdk/windows-8-10)
* {{ site.data.keys.mf_server }} wird lokal oder fern ausgeführt. 
* Die {{ site.data.keys.mf_cli }} ist auf der Entwicklerworkstation installiert. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Benachrichtigungskonfiguration](#notifications-configuration)
* [API für Benachrichtigungen](#notifications-api)
* [Handhabung von Push-Benachrichtigungen](#handling-a-push-notification)

## Benachrichtigungskonfiguration
{: #notifications-configuration }
Erstellen Sie ein neues Visual-Studio-Projekt oder verwenden Sie ein vorhandenes Projekt.   
Wenn das native {{ site.data.keys.product_adj }}-Windows-SDK noch nicht im Projekt enthalten ist, folgen Sie den Anweisungen
im Lernprogramm [{{ site.data.keys.product_adj }}-SDK zu Windows-Anwendungen hinzufügen](../../../application-development/sdk/windows-8-10). 

### Push-SDK hinzufügen
{: #adding-the-push-sdk }
1. Wählen Sie "Extras → NuGet Package Manager → Package Manager Console" aus.
2. Wählen Sie das Projekt aus, in dem Sie die
{{ site.data.keys.product_adj }}-Push-Komponente installieren wollen.
3. Fügen Sie das {{ site.data.keys.product_adj }}-Push-SDK hinzu, indem Sie den Befehl
**Install-Package IBM.MobileFirstPlatformFoundationPush** ausführen. 

## Vorausgesetzte WNS-Konfiguration
{: pre-requisite-wns-configuration }
1. Stellen Sie sicher, dass die Anwendung über die Popup-Benachrichtigungsfunktion (Toast) verfügt. Sie können die Funktion in Package.appxmanifest aktivieren.
2. `Identitätsname des Pakets` und `Publisher` müssen mit den registrierten Werten aus dem WNS aktualisiert worden sein. 
3. Löschen Sie die Datei TemporaryKey.pfx (optional). 

## API für Benachrichtigungen
{: #notifications-api }
### MFPPush-Instanz
{: #mfppush-instance }
Alle API-Aufrufe müssen für eine Instanz von `MFPPush` ausgeführt werden. Zu diesem Zweck können Sie eine Variable
erstellen, z. B. `private MFPPush PushClient = MFPPush.GetInstance();`, und dann in der gesamten Klasse `PushClient.methodName()` aufrufen. 

Alternativ dazu könen Sie `MFPPush.GetInstance().methodName()` für jede Instanz aufrufen, in der
Sie auf die Push-API-Methoden zugreifen müssen. 

### Abfrage-Handler
{: #challenge-handlers }
Wenn der Bereich `push.mobileclient` einer **Sicherheitsüberprüfung** zugeordnet ist,
müssen Sie sicherstellen, dass passende **Abfrage-Handler** registriert sind, bevor Push-APIs verwendet werden. 

> Weitere Informationen zu Abfrage-Handlern enthält das Lernprogramm [Berechtigungsnachweise validieren](../../../authentication-and-security/credentials-validation/ios).



### Clientseite
{: #client-side }

| C-Sharp-Methoden| Beschreibung |
|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [`Initialize()`](#initialization)                                                                            | Initialisiert MFPPush für den angegebenen Kontext|
| [`IsPushSupported()`](#is-push-supported)                                                                    | Unterstützt das Gerät Push-Benachrichtigungen?|
| [`RegisterDevice(JObject options)`](#register-device--send-device-token)                  | Registriert das Gerät beim Push-Benachrichtigungsservice|
| [`GetTags()`](#get-tags)                                | Ruft die verfügbaren Tags einer Instanz des Push-Benachrichtigungsservice ab|
| [`Subscribe(String[] Tags)`](#subscribe)     | Richtet das Geräteabonnement für die angegebenen Tags ein|
| [`GetSubscriptions()`](#get-subscriptions)              | Ruft die derzeit vom Gerät abonnierten Tags ab |
| [`Unsubscribe(String[] Tags)`](#unsubscribe) | Beendet das Abonnement bestimmter Tags|
| [`UnregisterDevice()`](#unregister)                     | Hebt die Registrierung des Geräts beim Push-Benachrichtigungsservice auf|

#### Initialisierung
{: #initialization }
Die Initialisierung ist erforderlich, damit die Clientanwendung eine Verbindung zum Service MFPPush herstellen kann. 

* Die Methode `Initialize` muss aufgerufen werden, bevor andere MFPPush-APIs verwendet werden.
* Die Callback-Funktion wird für die Handhabung empfangener Push-Benachrichtigungen registriert. 

```csharp
MFPPush.GetInstance().Initialize();
```

#### Wird Push unterstützt?
{: #is-push-supported }
Es wird überprüft, ob das Gerät Push-Benachrichtigungen unterstützt. 

```csharp
Boolean isSupported = MFPPush.GetInstance().IsPushSupported();

if (isSupported ) {
    // Push wird unterstützt.
} else {
    // Push wird nicht unterstützt.
}
```

#### Gerät registrieren und Gerätetoken senden
{: #register-device--send-device-token }
Registrieren Sie das Gerät beim Push-Benachrichtigungsservice. 

```csharp
JObject Options = new JObject();
MFPPushMessageResponse Response = await MFPPush.GetInstance().RegisterDevice(Options);         
if (Response.Success == true)
{
    // Erfolgreich registriert
     } else {
         // Registrierung mit Fehler fehlgeschlagen
     }
 ```

#### Tags abrufen
{: #get-tags }
Rufen Sie alle verfügbaren Tags vom Push-Benachrichtigungsservice ab. 

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetTags();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
} else{
    Message = new MessageDialog("Failed to get Tags list");
}
```

#### Abonnement
{: #subscribe }
Abonnieren Sie die gewünschten Tags. 

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// Abonnementtag abrufen
MFPPushMessageResponse Response = await MFPPush.GetInstance().Subscribe(Tags);
if (Response.Success == true)
{
    // Push-Tag erfolgreich abonniert
}
else
{
    // Abonnement von Push-Tags fehlgeschlagen
}
```

#### Abonnements abrufen
{: #get-subscriptions }
Rufen Sie die derzeit vom Gerät abonnierten Tags ab. 

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().GetSubscriptions();
if (Response.Success == true)
{
    Message = new MessageDialog("Avalibale Tags: " + Response.ResponseJSON["tagNames"]);
}
else
{
    Message = new MessageDialog("Failed to get subcription list...");
}
```

#### Abonnement beenden
{: #unsubscribe }
Beenden Sie das Tagabonnement. 

```csharp
string[] Tags = ["Tag1" , "Tag2"];

// Tagabonnement beenden
MFPPushMessageResponse Response = await MFPPush.GetInstance().Unsubscribe(Tags);
if (Response.Success == true)
{
    // Erfolg
}
else
{
    // Tagabonnement fehlgeschlagen
}
```

#### Registrierung aufheben
{: #unregister }
Sie können die Registrierung des Geräts bei der Instanz des Push-Benachrichtigungsservice
aufheben. 

```csharp
MFPPushMessageResponse Response = await MFPPush.GetInstance().UnregisterDevice();         
if (Response.Success == true)
{
    // Erfolgreich registriert
     } else {
         // Registrierung mit Fehler fehlgeschlagen
     }
 ```

## Handhabung von Push-Benachrichtigungen
{: #handling-a-push-notification }
Für die Handhabung von Push-Benachrichtigungen müssen Sie einen `MFPPushNotificationListener` einrichten. Zu diesem Zweck können Sie die folgende Methode implementieren. 

1. Erstellen Sie eine Klasse. Verwenden Sie dazu eine Schnittstelle vom Typ MFPPushNotificationListener. 

   ```csharp
   internal class NotificationListner : MFPPushNotificationListener
   {
        public async void onReceive(String properties, String payload)
   {
        // Hier Behandlung von Push-Benachrichtigungen
   }
   }
   ```

2. Definieren Sie die Klasse als Listener, indem Sie `MFPPush.GetInstance().listen(new NotificationListner())` aufrufen.
3. In der Methode onReceive empfangen Sie die Push-Benachrichtigung und können für die Benachrichtigung das gewünschte Verhalten festlegen.


<img alt="Beispielanwendung" src="sample-app.png" style="float:right"/>

## Universeller Windows-Push-Benachrichtigungsservice
{: #windows-universal-push-notifications-service }
In Ihrer Serverkonfiguration muss kein bestimmter Port offen sein. 

WNS verwendet reguläre HTTP- oder HTTPS-Anforderungen. 


## Beispielanwendung
{: #sample-application }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80), um das universelle Windows-8.1-Projekt herunterzuladen.   
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsWin8/tree/release80), um das Windows-10-UWP-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
