---
layout: tutorial
title: Interaktive Benachrichtigungen
relevantTo: [ios, cordova]
show_in_nav: false
weight: 2
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Wenn eine interaktive Benachrichtigung eingeht, können Benutzer Aktionen ausführen, ohne die Anwendung zu öffnen. Beim Eintreffen einer interaktiven Benachrichtigung zeigt das Gerät die Nachricht und Aktionsschaltflächen an. 

Interaktive Benachrichtigungen werden auf Geräten mit iOS ab Version 8 unterstützt. Wenn eine interaktive Benachrichtigung an ein iOS-Gerät mit einer älteren Version als Version 8 gesendet wird, werden die Benachrichtigungsaktionen nicht angezeigt. 

## Interaktive Push-Benachrichtigung senden
{: #sending-interactive-push-notification }
Bereiten Sie die Benachrichtigung vor und senden Sie sie. Weitere Informationen finden Sie unter [Push-Benachrichtigungen senden](../../sending-notifications).

Unter **{{ site.data.keys.mf_console }} → [Ihre Anwendung] → Push → Benachrichtigungen senden → Angepasste
iOS-Einstellungen** können Sie eine Zeichenfolge festlegen, um die Kategorie der Benachrichtigung mit dem Benachrichtigungsobjekt anzugeben. Die Aktionsschaltflächen für die Benachrichtigung werden ausgehend vom Kategoriewert angezeigt. Beispiel: 

![Kategorien für interaktive iOS-Benachrichtigungen in der {{ site.data.keys.mf_console }} festlegen](categories-for-interactive-notifications.png)

## Interaktive Benachrichtigungen in Cordova-Anwendungen
{: #handling-interactive-push-notifications-in-cordova-applications }
Gehen Sie wie folgt vor, um interaktive Benachrichtigungen zu empfangen:

1. Definieren Sie im Haupt-JavaScript die registrierten Kategorien für interaktive Benachrichtigungen und übergeben Sie sie an den Aufruf `MFPPush.registerDevice` für Geräteregistrierung.

   ```javascript
   var options = {
        ios: {
            alert: true,
            badge: true,
            sound: true,     
            categories: [{
                // Beim Senden der Benachrichtigung verwendete Kategorie-ID
                id : "poll", 

                // Optionales Array mit Aktionen, um zusammen mit der Nachricht die Aktionsschaltflächen anzuzeigen	
                actions: [{
                    // Aktions-ID
                    id: "poll_ok",

                    // Aktionstitel, der als Teil der Benachrichtigungsschaltfläche angezeigt wird
                    title: "OK",

                    // Optionaler Modus für die Ausführung der Aktion im Vorder- oder Hintergrund (1 für Vordergrund, 0 für Hintergrund). Standardmäßig erfolgt die Ausführung im Vordergrund.
                    mode: 1,  

                    // Optionale Eigenschaft für die Darstellung der Aktionsschaltfläche in rot. Standardwert ist 'false'.
                    destructive: false,

                    // Optionale Eigenschaft, um festzulegen, ob vor Ausführung der Aktion eine Authentifizierung erforderlich ist (Bildschirmsperre)
                    // Beim Vordergrundmodus hat diese Eigenschaft immer den Wert 'true'.
                    authenticationRequired: true
                },
                {
                    id: "poll_nok",
                    title: "NOK",
                    mode: 1,
                    destructive: false,
                    authenticationRequired: true
                }],
                    
                // Optionale Liste mit Aktionen, die im Falle eines Alerts angezeigt werden muss
                // Fehlt die Liste, werden die ersten vier Aktionen angezeigt.
                defaultContextActions: ['poll_ok','poll_nok'],

                // Optionale Liste mit Aktionen, die im Lockscreen mit der Benachrichtigungszentrale angezeigt werden muss
                // Fehlt die Liste, werden die ersten beiden Aktionen angezeigt.
                minimalContextActions: ['poll_ok','poll_nok'] 
            }]     
        }
   }
   ```

2. Übergeben Sie das `options`-Objekt während der Registrierung des Geräts für Push-Benachrichtigungen. 

   ```javascript
   MFPPush.registerDevice(options, function(successResponse) {
  		navigator.notification.alert("Successfully registered");
  		enableButtons();
   });  
   ```

## Interaktive Benachrichtigungen in nativen iOS-Anwendungen
{: #handling-interactive-push-notifications-in-native-ios-applications }
Führen Sie für den Empfang interaktiver Benachrichtigungen
die folgenden Schritte aus: 

1. Aktivieren Sie die Anwendungsfunktion für die Ausführung von Hintergrundtasks beim Empfang der fernen Benachrichtigungen. Dieser Schritt ist erforderlich, wenn
einige der Aktionen im Hintergrund ausgeführt werden können.
2. Definieren Sie registrierte Kategorien für interaktive Benachrichtigungen und übergeben Sie sie als Optionen an `MFPPush.registerDevice`.

   ```swift
   // Kategorien für interaktives Push definieren
   let acceptAction = UIMutableUserNotificationAction()
   acceptAction.identifier = "OK"
   acceptAction.title = "OK"
   acceptAction.activationMode = .Foreground

   let rejetAction = UIMutableUserNotificationAction()
   rejetAction.identifier = "Cancel"
   rejetAction.title = "Cancel"
   rejetAction.activationMode = .Foreground

   let category = UIMutableUserNotificationCategory()
   category.identifier = "poll"
   category.setActions([acceptAction, rejetAction], forContext: .Default)

   let categories:Set<UIUserNotificationCategory> = [category]

   let options = ["alert":true, "badge":true, "sound":true, "categories": categories]

   // Gerät registrieren
    MFPPush.sharedInstance().registerDevice(options as [NSObject : AnyObject], completionHandler: {(response: WLResponse!, error: NSError!) -> Void in
   ```
