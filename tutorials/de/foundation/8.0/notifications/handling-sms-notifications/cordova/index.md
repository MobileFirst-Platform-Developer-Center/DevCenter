---
layout: tutorial
title: Handhabung von SMS-Benachrichtigungen in Cordova
breadcrumb_title: Handling SMS in Cordova
relevantTo: [cordova]
weight: 8
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsCordova/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
SMS-Benachrichtigungen sind eine Untergruppe der Push-Benachrichtigungen.
Beschäftigen Sie sich daher zuerst mit dem Lernprogramm zu [Push-Benachrichtigungen in Cordova](../../).   
SMS-Benachrichtigungen in Cordova-Anwendungen werden unter iOS und Android unterstützt.

**Voraussetzungen:**

* Stellen Sie sicher, dass Sie die folgenden Lernprogramme durchgearbeitet haben: 
  * [Benachrichtigungen im Überblick](../../)
  * [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/#installing-a-development-environment)
  * [SDK der {{ site.data.keys.product }} zu iOS-Anwendungen hinzufügen](../../../application-development/sdk/cordova)
* {{ site.data.keys.mf_server }} wird lokal oder fern ausgeführt. 
* Die {{ site.data.keys.mf_cli }} ist auf der Entwicklerworkstation installiert. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [API für Benachrichtigungen](#notifications-api)   
* [Servlet für SMS-Abonnement verwenden](#using-an-sms-subscribe-servlet)     
* [Beispielanwendung](#sample-application)

## API für Benachrichtigungen
{: #notifications-api }
Wenn ein Gerät für SMS-Benachrichtigungen registriert wird, wird eine Telefonnummer übergeben. 

#### Gerät registrieren
{: #register-device }
Registrieren Sie das Gerät beim Push-Benachrichtigungsservice.

```javascript
MFPPush.registerNotificationsCallback(notificationReceived);

function registerDevice() {
    var phoneNumber = prompt("Enter Your 10 digit phone number");
    if(phoneNumber != null &&  phoneNumber!="" &&  /^\d+$/.test(phoneNumber)) {
        var options = {};
        options.phoneNumber = phoneNumber;
        MFPPush.registerDevice(options, 
        function(successResponse) {
            alert("Successfully registered");
            enableButtons();
        }, function(failureResponse) {
            alert("Failed to register");
        });
        return true;
    }

    else {
        alert("Failed to register, You have entered invalid number");
    }
}
```

> Sie können ein Gerät auch
mit der [REST-API Push Device Registration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_device_registration_post.html)
registrieren.
## Servlet für SMS-Abonnement verwenden
{: #using-an-sms-subscribe-servlet}
Benachrichtigungen werden mit REST-APIs an die registrierten Geräte gesendet. Alle Arten von Benachrichtigungen
können gesendet werden (tagbasierte und Broadcastbenachrichtigungen sowie authentifizierte Benachrichtigungen). 

Für das Senden einer Benachrichtigung wird eine POST-Anforderung an den REST-Endpunkt abgesetzt: `imfpush/v1/apps/<Anwendungs-ID>/messages`.  
Beispiel-URL:  

```bash
https://myserver.com:443/imfpush/v1/apps/com.sample.sms/messages
```

> Eine Übersicht über alle REST-APIs für Push-Benachrichtigungen finden Sie im Abschnitt <a href="https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html">REST-API-Laufzeitservices</a> in der Benutzerdokumentation.



Informationen zum Senden einer Benachrichtigung enthält das Lernprogramm [Benachrichtigungen senden](../../sending-notifications). 

<img alt="Beispielanwendung" src="sample-app.png" style="float:right"/>
## Beispielanwendung
{: #sample-application }
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsSwift/tree/release80), um das Cordova-Projekt herunterzuladen. 

**Hinweis:** Für die Ausführung des Beispiels muss auf jedem Android-Gerät die neueste Version der Google Play Services installiert sein. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
