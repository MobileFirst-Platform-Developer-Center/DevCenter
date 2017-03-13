---
layout: tutorial
title: Push-Benachrichtigungen in iOS
breadcrumb_title: iOS
relevantTo: [ios]
weight: 5
downloads:
  - name: Xcode-Projekt herunterladen
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie können
die {{ site.data.keys.product_adj }}-API für Benachrichtigungen verwenden,
um Geräte zu registrieren und Geräteregistrierungen aufzuheben und um
Tags zu abonnieren und Tagabonnements zu beenden. In diesem Lernprogramm werden Sie lernen, wie
Push-Benachrichtigungen in iOS-Anwendungen mit Swift gehandhabt werden. 

Informationen zu Benachrichtigungen im Hintergrund und interaktiven Benachrichtigungen finden Sie in folgenden Abschnitten: 

* [Benachrichtigungen im Hintergrund](../silent)
* [Interaktive Benachrichtigungen](../interactive)

**Voraussetzungen: **

* Stellen Sie sicher, dass Sie die folgenden Lernprogramme durchgearbeitet haben: 
	* [Übersicht über Push-Benachrichtigungen](../../)
    * [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/#installing-a-development-environment)
    * [SDK der {{ site.data.keys.product }} zu iOS-Anwendungen hinzufügen](../../../application-development/sdk/ios)
* {{ site.data.keys.mf_server }} wird lokal oder fern ausgeführt. 
* Die {{ site.data.keys.mf_cli }} ist auf der Entwicklerworkstation installiert. 


### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Benachrichtigungskonfiguration](#notifications-configuration)
* [API für Benachrichtigungen](#notifications-api)
* [Handhabung von Push-Benachrichtigungen](#handling-a-push-notification)


### Benachrichtigungskonfiguration
{: #notifications-configuration }
Erstellen Sie ein Xcode-Projekt oder verwenden Sie ein vorhandenes Projekt. Wenn das native {{ site.data.keys.product_adj }}-iOS-SDK noch nicht im Projekt enthalten ist,
folgen Sie den Anweisungen im Lernprogramm [SDK der {{ site.data.keys.product }} zu iOS-Anwendungen hinzufügen](../../../application-development/sdk/ios).




### Push-SDK hinzufügen
{: #adding-the-push-sdk }
1. Öffnen Sie die vorhandene **podfile** des Projekts und fügen Sie die folgenden Zeilen hinzu: 

   ```xml
   use_frameworks!

   platform :ios, 8.0
   target "Xcode-project-target" do
        pod 'IBMMobileFirstPlatformFoundation'
        pod 'IBMMobileFirstPlatformFoundationPush'
   end

   post_install do |installer|
        workDir = Dir.pwd

        installer.pods_project.targets.each do |target|
            debugXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.debug.xcconfig"
            xcconfig = File.read(debugXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(debugXcconfigFilename, "w") { |file| file << newXcconfig }

            releaseXcconfigFilename = "#{workDir}/Pods/Target Support Files/#{target}/#{target}.release.xcconfig"
            xcconfig = File.read(releaseXcconfigFilename)
            newXcconfig = xcconfig.gsub(/HEADER_SEARCH_PATHS = .*/, "HEADER_SEARCH_PATHS = ")
            File.open(releaseXcconfigFilename, "w") { |file| file << newXcconfig }
        end
   end
   ```
    - Ersetzen Sie **Xcode-project-target** durch den Namen Ihres Xcode-Projektziels. 

2. Speichern Sie die **podfile** und schließen Sie sie.
3. Navigieren Sie in einem **Befehlszeilenfenster** zum Stammverzeichnis des Projekts. 
4. Führen Sie den Befehl `pod install` aus. 
5. Öffnen Sie das Projekt über die Datei **.xcworkspace**. 

## API für Benachrichtigungen
{: #notifications-api }
### MFPPush-Instanz
{: #mfppush-instance }
Alle API-Aufrufe müssen für eine Instanz von `MFPPush` ausgeführt werden. Zu diesem Zweck können Sie
eine Variable (`var`) in einem Ahnsichtencontroller erstellen, z. B. `var push = MFPPush.sharedInstance();`,
und dann im gesamten Ansichtencontroller `push.methodName()` aufrufen. 

Alternativ dazu könen Sie `MFPPush.sharedInstance().methodName()` für jede Instanz aufrufen, in der
Sie auf die Push-API-Methoden zugreifen müssen. 

### Abfrage-Handler
{: #challenge-handlers }
Wenn der Bereich `push.mobileclient` einer **Sicherheitsüberprüfung** zugeordnet ist,
müssen Sie sicherstellen, dass passende **Abfrage-Handler** registriert sind, bevor Push-APIs verwendet werden. 

> Weitere Informationen zu Abfrage-Handlern enthält das Lernprogramm [Berechtigungsnachweise validieren](../../../authentication-and-security/credentials-validation/ios).

### Clientseite
{: #client-side }

| Swift-Methoden | Beschreibung  |
|---------------|--------------|
| [`initialize()`](#initialization) | Initialisiert MFPPush für den angegebenen Kontext |
| [`isPushSupported()`](#is-push-supported) | Unterstützt das Gerät Push-Benachrichtigungen? |
| [`registerDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#register-device--send-device-token) | Registriert das Gerät beim Push-Benachrichtigungsservice|
| [`sendDeviceToken(deviceToken: NSData!)`](#register-device--send-device-token) | Sendet das Gerätetoken an den Server |
| [`getTags(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-tags) | Ruft die verfügbaren Tags einer Instanz des Push-Benachrichtigungsservice ab |
| [`subscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#subscribe) | Richtet das Geräteabonnement für die angegebenen Tags ein |
| [`getSubscriptions(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#get-subscriptions)  | Ruft die derzeit vom Gerät abonnierten Tags ab  |
| [`unsubscribe(tagsArray: [AnyObject], completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unsubscribe) | Beendet das Abonnement bestimmter Tags |
| [`unregisterDevice(completionHandler: ((WLResponse!, NSError!) -> Void)!)`](#unregister) | Hebt die Registrierung des Geräts beim Push-Benachrichtigungsservice auf              |

#### Initialisierung
{: #initialization }
Die Initialisierung ist erforderlich, damit die Clientanwendung eine Verbindung zum Service MFPPush herstellen kann. 

* Die Methode `initialize` muss aufgerufen werden, bevor andere MFPPush-APIs verwendet werden.
* Die Callback-Funktion wird für die Handhabung empfangener Push-Benachrichtigungen registriert. 

```swift
MFPPush.sharedInstance().initialize();
```

#### Wird Push unterstützt?
{: #is-push-supported }
Es wird überprüft, ob das Gerät Push-Benachrichtigungen unterstützt. 

```swift
let isPushSupported: Bool = MFPPush.sharedInstance().isPushSupported()

if isPushSupported {
    // Push wird unterstützt.
} else {
    // Push wird nicht unterstützt.
}
```

#### Gerät registrieren und Gerätetoken senden
{: #register-device--send-device-token }
Registrieren Sie das Gerät beim Push-Benachrichtigungsservice.

```swift
MFPPush.sharedInstance().registerDevice(nil) { (response, error) -> Void in
    if error == nil {
        self.enableButtons()
        self.showAlert("Registered successfully")
        print(response?.description ?? "")
    } else {
        self.showAlert("Registrations failed.  Error \(error?.localizedDescription)")
        print(error?.localizedDescription ?? "")
    }
}
```

<!--`options` = `[NSObject : AnyObject]` which is an optional parameter that is a dictionary of options to be passed with your register request, sends the device token to the server to register the device with its unique identifier.-->

```swift
MFPPush.sharedInstance().sendDeviceToken(deviceToken)
```

> **Hinweis:** Dieser Aufruf wird in der Regel im **AppDelegate**
in der Methode `didRegisterForRemoteNotificationsWithDeviceToken` ausgeführt. 

#### Tags abrufen
{: #get-tags }
Rufen Sie alle verfügbaren Tags vom Push-Benachrichtigungsservice ab. 

```swift
MFPPush.sharedInstance().getTags { (response, error) -> Void in
    if error == nil {
        print("The response is: \(response)")
        print("The response text is \(response?.responseText)")
        if response?.availableTags().isEmpty == true {
            self.tagsArray = []
            self.showAlert("There are no available tags")
        } else {
            self.tagsArray = response!.availableTags() as! [String]
            self.showAlert(String(describing: self.tagsArray))
            print("Tags response: \(response)")
        }
    } else {
        self.showAlert("Error \(error?.localizedDescription)")
        print("Error \(error?.localizedDescription)")
    }
}
```


#### Abonnement
{: #subscribe }
Abonnieren Sie die gewünschten Tags. 

```swift
var tagsArray: [String] = ["Tag 1", "Tag 2"]

MFPPush.sharedInstance().subscribe(self.tagsArray) { (response, error)  -> Void in
    if error == nil {
        self.showAlert("Subscribed successfully")
        print("Subscribed successfully response: \(response)")
    } else {
        self.showAlert("Failed to subscribe")
        print("Error \(error?.localizedDescription)")
    }
}
```


#### Abonnements abrufen
{: #get-subscriptions }
Rufen Sie die derzeit vom Gerät abonnierten Tags ab. 

```swift
MFPPush.sharedInstance().getSubscriptions { (response, error) -> Void in
   if error == nil {
       var tags = [String]()
       let json = (response?.responseJSON)! as [AnyHashable: Any]
       let subscriptions = json["subscriptions"] as? [[String: AnyObject]]
       for tag in subscriptions! {
           if let tagName = tag["tagName"] as? String {
            print("tagName: \(tagName)")
               tags.append(tagName)
           }
       }
       self.showAlert(String(describing: tags))
   } else {
       self.showAlert("Error \(error?.localizedDescription)")
       print("Error \(error?.localizedDescription)")
   }
}
```


#### Abonnement beenden
{: #unsubscribe }
Beenden Sie das Tagabonnement. 

```swift
var tags: [String] = {"Tag 1", "Tag 2"};

// Tagabonnement beenden
MFPPush.sharedInstance().unsubscribe(self.tagsArray) { (response, error)  -> Void in
    if error == nil {
        self.showAlert("Unsubscribed successfully")
        print(String(describing: response?.description))
    } else {
        self.showAlert("Error \(error?.localizedDescription)")
        print("Error \(error?.localizedDescription)")
    }
}
```

#### Registrierung aufheben
{: #unregister }
Sie können die Registrierung des Geräts bei der Instanz des Push-Benachrichtigungsservice
aufheben. 

```swift
MFPPush.sharedInstance().unregisterDevice { (response, error)  -> Void in
   if error == nil {
       // Schaltflächen inaktivieren
       self.disableButtons()
       self.showAlert("Unregistered successfully")
       print("Subscribed successfully response: \(response)")
   } else {
       self.showAlert("Error \(error?.localizedDescription)")
       print("Error \(error?.localizedDescription)")
   }
}
```

## Handhabung von Push-Benachrichtigungen
{: #handling-a-push-notification }

Push-Benachrichtigungen werden direkt vom nativen iOS-Framework behandelt. Welche Methoden vom iOS-Framework aufgerufen werden, richtet sich nach Ihrem Anwendungslebenszyklus. 

Wenn beispielsweise eine einfahce Benachrichtigung empfangen wird, währen die Anwendung aktiv ist,
wird `didReceiveRemoteNotification` von **AppDelegate** ausgelöst. 

```swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    print("Received Notification in didReceiveRemoteNotification \(userInfo)")
    // Alerttext anzeigen
      if let notification = userInfo["aps"] as? NSDictionary,
        let alert = notification["alert"] as? NSDictionary,
        let body = alert["body"] as? String {
            showAlert(body)
    }
}
```

> Weitere Informationen zur Handhabung von Benachrichtigungen in iOS finden Sie in der Apple-Dokumentation unter http://bit.ly/1ESSGdQ. 

<img alt="Beispielanwendung" src="notifications-app.png" style="float:right"/>

## Beispielanwendung
{: #sample-application }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsSwift/tree/release80), um das Xcode-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
