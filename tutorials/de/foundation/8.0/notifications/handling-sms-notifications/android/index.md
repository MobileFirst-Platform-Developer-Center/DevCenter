---
layout: tutorial
title: Handhabung von SMS-Benachrichtigungen in Android
breadcrumb_title: Handling SMS in Android
relevantTo: [android]
weight: 10
downloads:
  - name: Download Android project
    url: https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsAndroid/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
SMS-Benachrichtigungen sind eine Untergruppe der Push-Benachrichtigungen.
Beschäftigen Sie sich daher zuerst mit dem Lernprogramm zu [Push-Benachrichtigungen in Android](../../). 

**Voraussetzungen:**

* Stellen Sie sicher, dass Sie die folgenden Lernprogramme durchgearbeitet haben: 
  * [Benachrichtigungen im Überblick](../../)
  * [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/#installing-a-development-environment)
  * [SDK der {{ site.data.keys.product }} zu iOS-Anwendungen hinzufügen](../../../application-development/sdk/ios)
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

#### Abfrage-Handler
{: #challenge-handlers }
Wenn der Bereich `push.mobileclient` einer **Sicherheitsüberprüfung** zugeordnet ist,
müssen Sie sicherstellen, dass passende **Abfrage-Handler** registriert sind, bevor Push-APIs verwendet werden. 

#### Initialisierung
{: #initialization }
Die Initialisierung ist erforderlich, damit die Clientanwendung mit dem richtigen Anwendungskontext eine Verbindung zum Service MFPPush herstellen kann. 

* Die API-Methode muss aufgerufen werden, bevor andere MFPPush-APIs verwendet werden.
* Die Callback-Funktion wird für die Handhabung empfangener Push-Benachrichtigungen registriert. 

```java
MFPPush.getInstance().initialize(this);
```

#### Gerät registrieren
{: #register-device }
Registrieren Sie das Gerät beim Push-Benachrichtigungsservice.

```java
MFPPush.getInstance().registerDevice(new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        // Erfolgreich registriert
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Registrierung mit Fehler fehlgeschlagen
     }
 }, optionObject);
```

* **optionObject**: `JSONObject` mit der Telefonnummer für die Registrierung des Geräts. Beispiel:

```java
JSONObject optionObject = new JSONObject();
try {
    // Eingegebene Telefonnummer abrufen
    optionObject.put("phoneNumber", editPhoneText.getText().toString());
}
catch(Exception ex) {
    ex.printStackTrace();
}
```

> Sie können ein Gerät auch
mit der [REST-API Push Device Registration (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_device_registration_post.html)
registrieren.
#### Registrierung des Geräts aufheben
{: #unregister-device }
Sie können die Registrierung des Geräts bei der Instanz des Push-Benachrichtigungsservice
aufheben. 

```java
MFPPush.getInstance().unregisterDevice(new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        disableButtons();
        // Aufhebung der Registrierung erfolgreich
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Aufhebung der Registrierung fehlgeschlagen
    }
});
```

## Servlet für SMS-Abonnement verwenden
{: #using-an-sms-subscribe-servlet }
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
[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/SMSNotificationsAndroid/tree/release80), um das Android-Projekt herunterzuladen. 

**Hinweis:** Für die Ausführung des Beispiels muss auf jedem Android-Gerät die neueste Version der Google Play Services installiert sein. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 
