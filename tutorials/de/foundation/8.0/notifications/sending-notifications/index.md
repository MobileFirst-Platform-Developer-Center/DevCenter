---
layout: tutorial
title: Benachrichtigungen senden
relevantTo: [ios,android,windows,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Für das Senden von Push- oder SMS-Benachrichtigungen an
iOS-, Android- oder Windows-Geräte muss zunächst {{ site.data.keys.mf_server }} mit den GCM-Details für Android, einem APNS-Zertifikat für
iOS oder mit WNS-Berechtigungsnachweisen für Windows 8.1 Universal / Windows 10 UWP konfiguriert werden.
Anschließend können Benachrichtigungen an alle Geräte gesendet werden (Broadcast), an Geräte, die für bestimmte Tags registriert sind,
an eine einzelne Geräte-ID, an Benutzer-IDs, nur an iOS-Geräte, nur an Android-Geräte, nur an Windows-Geräte
oder augehend vom authentifizierten Benutzer. 

**Voraussetzung**: Arbeiten Sie das Lernprogramm [Benachrichtigungen im Überblick](../) durch. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Benachrichtigungen einrichten](#setting-up-notifications)
    * [Google Cloud Messaging / Firebase Cloud Messaging](#google-cloud-messaging--firebase-cloud-messaging)
    * [Apple Push Notifications Service](#apple-push-notifications-service)
    * [Windows Push Notifications Service](#windows-push-notifications-service)
    * [SMS-Benachrichtigungsservice](#sms-notification-service)
    * [Bereichszuordnung](#scope-mapping)
    * [Authentifizierte Benachrichtigungen](#authenticated-notifications)
* [Tags definieren](#defining-tags)
* [Benachrichtigungen senden](#sending-notifications)    
    * [{{ site.data.keys.mf_console }}](#mobilefirst-operations-console)
    * [REST-APIs](#rest-apis)
    * [Benachrichtigungen anpassen](#customizing-notifications)
* [Proxyunterstützung](#proxy-support)
* [Nächste Lernprogramme](#tutorials-to-follow-next)

## Benachrichtigungen einrichten
{: #setting-up-notifications }
Für die Aktivierung der Unterstützung für Benachrichtigungen müssen mehrere Konfigurationsschritte in {{ site.data.keys.mf_server }} und in der Clientanwendung ausgeführt werden.   
Fahren Sie mit dem Abschnitt zum serverseitigen Setup fort oder lesen Sie den Abschnitt [Clientseitiges Setup](#tutorials-to-follow-next).

Auf der Serverseite gehören zum Setup das Konfigurieren des erforderlichen Anbieters (APNS, GCM oder WNS) und die Zuordnung des Bereichs "push.mobileclient". 

### Google Cloud Messaging / Firebase Cloud Messaging
{: #google-cloud-messaging--firebase-cloud-messaging }
> **Hinweis:** Google [kündigte kürzlich](https://firebase.google.com/support/faq/#gcm-fcm) einen Wechsel von GCM zu FCM an. Die folgenden Anweisungen wurden entsprechend aktualisiert. Beachten Sie auch, das bestehende GCM-Konfigurationen weiterhin funktionieren. Dies gilt jedoch nicht für neue GCM-Konfigurationen. Verwenden Sie stattdessen FCM.

Android-Geräte verwenden den Service Firebase Cloud Messaging (FCM) für Push-Benachrichtigungen.   
Gehen Sie wie folgt vor, um FCM zu konfigurieren:

1. Öffnen Sie die [Firebase Console](https://console.firebase.google.com/?pli=1).
2. Erstellen Sie ein neues Projekt und geben Sie einen Projektnamen an. 
3. Klicken Sie auf das Zahnradsymbol für die Einstellungen und wählen Sie **Project settings** aus.
4. Klicken Sie auf das Register **Cloud Messaging**, um einen
**Server API Key** und eine **Sender ID** zu generieren. Klicken Sie dann auf **Save**.

> Sie können FCM auch
mit der [REST-API
für den {{ site.data.keys.product_adj }}-Push-Service](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_gcm_settings_put.html#Push-GCM-Settings--PUT-)
oder
der [REST-API für den {{ site.data.keys.product_adj }}-Verwaltungsservice](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html#restservicesapi)
konfigurieren.
#### Hinweise
{: #notes }
Wenn es in Ihrer Organisation eine Firewall gibt, die den Datenverkehr zum oder vom Internet einschränkt, müssen Sie die folgenden
Schritte ausführen:   

* Konfigurieren Sie die Firewall so, dass Verbindungen zu FCM möglich sind, damit Ihre FCM-Client-Apps Nachrichten empfangen können. 
* Die Ports
5228, 5229 und 5230 müssen geöffnet werden. FCM verwendet normalerweise nur den Port
5228, manchmal aber auch die Ports 5229 und 5230.  
* FCM stellt keine bestimmte IP-Adresse bereit. Stellen Sie daher sicher, dass Ihre Firewall abgehende Verbindungen zu allen IP-Adressen akzeptiert, die
in den IP-Blöcken enthalten sind, die in Google ASN
15169 aufgelistet sind. 
* Stellen Sie sicher, dass Ihre Firewall am Port 443 abgehende Verbindungen
von {{ site.data.keys.mf_server }} zu android.googleapis.com akzeptiert. 

<img class="gifplayer" alt="GCM-Berechtigungsnachweise hinzufügen" src="gcm-setup.png"/>

### Apple Push Notifications Service
{: #apple-push-notifications-service }
iOS-Geräte verwenden den Apple Push Notification Service (APNS) für Push-Benachrichtigungen.   
Gehen Sie wie folgt vor, um APNS zu konfigurieren:

1. [Generieren Sie ein Zertifikat für Push-Benachrichtigungen für die Entwicklung oder Produktion](https://medium.com/@ankushaggarwal/generate-apns-certificate-for-ios-push-notifications-85e4a917d522#.67yfba5kv).
2. Wählen Sie in der {{ site.data.keys.mf_console }} unter **[Ihre Anwendung] → Push → Push-Einstellungen**
den Zertifikattyp aus und geben Sie die Zertifikatdatei und das Kennwort an. Klicken Sie dann auf **Speichern**.

#### Hinweise
{: #notes-apns }
* Die folgenden Server müssen für eine MobileFirst-Server-Instanz zugänglich sein, damit Push-Benachrichtigungen gesendet werden können:   
    * Sandbox-Server:  
        * gateway.sandbox.push.apple.com:2195
        * feedback.sandbox.push.apple.com:2196
    * Produktionsserver:  
        * gateway.push.apple.com:2195
        * Feedback.push.apple.com:2196
        * 1-courier.push.apple.com 5223
* Verwenden Sie in der Entwicklungsphase die Sandbox-Zertifikatdatei apns-certificate-sandbox.p12. 
* Verwenden Sie in der Produktionsphase die Produktionszertifikatdatei apns-certificate-production.p12. 
    * Das APNS-Produktionszertifikat kann erst getestet werden, wenn die Anwendung, die das Zertifikat verwendet, erfolgreich an den Apple App Store übergeben wurde.

> Sie können den APNS auch
mit der [REST-API
für den {{ site.data.keys.product_adj }}-Push-Service](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_apns_settings_put.html#Push-APNS-settings--PUT-)
oder
der [REST-API für den {{ site.data.keys.product_adj }}-Verwaltungsservice](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc)
konfigurieren.
<img class="gifplayer" alt="APNS-Berechtigungsnachweise hinzufügen" src="apns-setup.png"/>

### Windows Push Notifications Service
{: #windows-push-notifications-service }
Windows-Geräte verwenden den Windows Push Notifications Service (WNS) für Push-Benachrichtigungen.   
Gehen Sie wie folgt vor, um den WNS zu konfigurieren:

1. Folgen Sie den [Anweisungen von Microsoft](https://msdn.microsoft.com/en-in/library/windows/apps/hh465407.aspx) für das Generieren
der Werte für **Paketsicherheits-ID (SID)** und **Geheimer Clientschlüssel**. 
2. Fügen Sie diese Werte in der {{ site.data.keys.mf_console }} unter **[Ihre Anwendung] → Push → Push-Einstellungen**
hinzu und klicken Sie auf **Speichern**.

> Sie können den WNS auch
mit der [REST-API
für den {{ site.data.keys.product_adj }}-Push-Service](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_wns_settings_put.html?view=kc)
oder
der [REST-API für den {{ site.data.keys.product_adj }}-Verwaltungsservice](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_wns_settings_put.html?view=kc)
konfigurieren.
<img class="gifplayer" alt="WNS-Berechtigungsnachweise hinzufügen" src="wns-setup.png"/>

### SMS-Benachrichtigungsservice
{: #sms-notification-service }
Das SMS-Gateway wird mit folgender JSON für das Senden von SMS-Benachrichtigungen eingerichtet. [Verwenden Sie die
REST-API smsConf](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_sms_settings_put.html), um {{ site.data.keys.mf_server }} mit der SMS-Gateway-Konfiguration zu aktualisieren. 

```json
{
	"host": "2by0.com",
	"name": "dummy",
	"port": "80",
	"programName": "gateway/add.php",
	"parameters": [{
		"name": "xmlHttp",
		"value": "false",
		"encode": "true"
	}, {
		"name": "httpsEnabled",
		"value": "false",
		"encode": "true"
	}]

}
```

> Weitere SMS-bezogene REST-APIs finden Sie in den [Referenzinformationen zur Push-Service-API](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html).

### Bereichszuordnung
{: #scope-mapping }
Ordnen Sie der Anwendung das Bereichselement **push.mobileclient** zu. 

1. Laden Sie die {{ site.data.keys.mf_console }} und navigieren Sie zu
**[Ihre Anwendung] → Sicherheit → Zuordnung von Bereichselementen** und klicken Sie auf **Neu**.
2. Schreiben Sie in das Feld **Bereichselement** den Wert "push.mobileclient". Klicken Sie dann auf **Hinzufügen**.

    <div class="panel-group accordion" id="scopes" role="tablist" aria-multiselectable="false">
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="additional-scopes">
                <h4 class="panel-title">
                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#additional-scopes" data-target="#collapse-additional-scopes" aria-expanded="false" aria-controls="collapse-additional-scopes"><b>Hier für eine Liste zusätzlich verfügbarer Bereiche klicken</b></a>
                </h4>
            </div>

            <div id="collapse-additional-scopes" class="panel-collapse collapse" role="tabpanel" aria-labelledby="zip-file">
                <div class="panel-body">
                    <table class="table table-striped">
                        <tr>
                            <td><b>Bereich</b></td>
                            <td><b>Beschreibung</b></td>
                        </tr>
                        <tr>
                            <td>apps.read	</td>
                            <td>Berechtigung, eine Anwendungsressource zu lesen</td>
                        </tr>
                        <tr>
                            <td>apps.write	</td>
                            <td>Berechtigung, eine Anwendungsressource zu erstellen, zu aktualisieren und zu löschen</td>
                        </tr>
                        <tr>
                            <td>gcmConf.read	</td>
                            <td>Berechtigung, die GCM-Konfigurationseinstellungen (API Key und Sender ID) zu lesen</td>
                        </tr>
                        <tr>
                            <td>gcmConf.write	</td>
                            <td>Berechtigung, die GCM-Konfigurationseinstellungen zu aktualisieren und zu löschen</td>
                        </tr>
                        <tr>
                            <td>apnsConf.read	</td>
                            <td>Berechtigung, APNS-Konfigurationseinstellungen zu lesen</td>
                        </tr>
                        <tr>
                            <td>apnsConf.write	</td>
                            <td>Berechtigung, APNS-Konfigurationseinstellungen zu aktualisieren und zu löschen</td>
                        </tr>
                        <tr>
                            <td>devices.read	</td>
                            <td>Berechtigung, ein Gerät zu lesen</td>
                        </tr>
                        <tr>
                            <td>devices.write	</td>
                            <td>Berechtigung, ein Gerät zu erstellen, zu aktualisieren und zu löschen</td>
                        </tr>
                        <tr>
                            <td>subscriptions.read	</td>
                            <td>Berechtigung, Abonnements zu lesen</td>
                        </tr>
                        <tr>
                            <td>subscriptions.write	</td>
                            <td>Berechtigung, Abonnements zu erstellen, zu aktualisieren und zu löschen</td>
                        </tr>
                        <tr>
                            <td>messages.write	</td>
                            <td>Berechtigung, Push-Benachrichtigungen zu senden</td>
                        </tr>
                        <tr>
                            <td>webhooks.read	</td>
                            <td>Berechtigung, Ereignisbenachrichtigungen zu lesen</td>
                        </tr>
                        <tr>
                            <td>webhooks.write	</td>
                            <td>Berechtigung, Ereignisbenachrichtigungen zu senden</td>
                        </tr>
                        <tr>
                            <td>smsConf.read	</td>
                            <td>Berechtigung, SMS-Konfigurationseinstellungen zu lesen</td>
                        </tr>
                        <tr>
                            <td>smsConf.write	</td>
                            <td>Berechtigung, SMS-Konfigurationseinstellungen zu aktualisieren und zu löschen</td>
                        </tr>
                        <tr>
                            <td>wnsConf.read	</td>
                            <td>Berechtigung, WNS-Konfigurationseinstellungen zu lesen</td>
                        </tr>
                        <tr>
                            <td>wnsConf.write	</td>
                            <td>Berechtigung, WNS-Konfigurationseinstellungen zu aktualisieren und zu löschen</td>
                        </tr>
                    </table>
                    <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#additional-scopes" data-target="#collapse-additional-scopes" aria-expanded="false" aria-controls="collapse-additional-scopes"><b>Abschnitt schließen</b></a>
                </div>
            </div>
        </div>
    </div>

    <img class="gifplayer" alt="Bereichszuordnung" src="scope-mapping.png"/>

### Authentifizierte Benachrichtigungen
{: #authenticated-notifications }
Authentifizierte Benachrichtigungen werden an `userIds` gesendet.  

Ordnen Sie der für die Anwendung verwendeten Sicherheitsüberprüfung das Bereichselement **push.mobileclient** zu.   

1. Laden Sie die {{ site.data.keys.mf_console }} und navigieren Sie zu
**[Ihre Anwendung] → Sicherheit → Zuordnung von Bereichselementen** und klicken Sie auf **Neu** oder bearbeiten Sie einen vorhandenen Bereichszuordnungseintrag. 
2. Wählen Sie eine Sicherheitsüberprüfung aus. Klicken Sie dann auf **Hinzufügen**.

    <img class="gifplayer" alt="Authentifizierte Benachrichtigungen" src="authenticated-notifications.png"/>
    
## Tags definieren
{: #defining-tags }
Klicken Sie in der {{ site.data.keys.mf_console }} unter **[Ihre Anwendung] → Push → Tags**
auf **Neu**.  
Geben Sie den entsprechenden `Tagnamen` und eine `Beschreibung` an und klicken Sie auf **Speichern**.

<img class="gifplayer" alt="Tags hinzufügen" src="adding-tags.png"/>

Bei einem Abonnement werden eine Geräteregistrierung
und ein Tag miteinander verbunden. Wenn die Registrierung eines Gerätes für einen Tag aufgehoben wird, beendet das Gerät selbst
alle zugehörigen Abonnements. Wenn ein Gerät von mehreren Benutzern verwendet wird, sollten
Abonnements auf der Basis von Benutzeranmeldungskriterien
in mobilen Anwendungen implementiert werden. Der Aufruf für das Abonnement könnte beispielsweise erfolgen, nachdem sich ein Benutzer
erfolgreich bei einer Anwendung angemeldet hat. Der Aufruf zum Beenden des Abonnements würde explizit im Rahmen der Abmeldeaktion
abgesetzt. 

## Benachrichtigungen senden
{: #sending-notifications }
Push-Benachrichtigungen können von der {{ site.data.keys.mf_console }} aus oder über REST-APIs gesendet werden.

* Von der {{ site.data.keys.mf_console }} aus können zwei Arten von Benachrichtigungen gesendet werden, tagbasierte Benachrichtigungen und Broadcastbenachrichtigungen. 
* Mit den REST-APIs können alle Arten von Benachrichtigungen gesendet werden, tagbasierte und authentifizierte Benachrichtigungen sowie Broadcastbenachrichtigungen. 

### {{ site.data.keys.mf_console }}
{: #mobilefirst-operations-console }
Benachrichtigungen können an eine einzelne Geräte-ID, an bestimmte Benutzer-IDs, nur an iOS-Geräte oder nur an Android-Geräte oder an Geräte, die Tags abonniert haben, gesendet werden. 

#### Tagbasierte Benachrichtigungen
{: #tag-notifications }
Tagbasierte Benachrichtigungen sind Hinweisnachrichten, die an alle Geräte gesendet werden, die einen bestimmten Tag abonniert haben. Tags stehen für Themen, die für den Benutzer von Interesse sind, und
ermöglichen dem Benutzer, Benachrichtigungen zu den ihn interessierenden Themen zu erhalten.  

Wählen Sie in der {{ site.data.keys.mf_console }} unter **[Ihre Anwendung] → Push** das Register **Benachrichtigungen
senden** aus. Wählen Sie dann
auf der Registerkarte **Senden an** die Option **Geräte nach Tags** aus und geben Sie den
**Benachrichtigungstext** an. Klicken Sie dann auf **Senden**. 

<img class="gifplayer" alt="Senden nach Tag" src="sending-by-tag.png"/>

#### Broadcastbenachrichtigungen
{: #breadcast-notifications }
Broadcastbenachrichtigungen sind eine Form der tagbasierten Push-Benachrichtigungen, die an alle eingeschriebenen Geräte gesendet werden. Broadcastbenachrichtigungen werden standardmäßig
für alle Push-fähigen {{ site.data.keys.product_adj }}-Anwendungen
durch das Abonnement eines reservierten Tags `Push.all` aktiviert. (Der Tag wird automatisch für jedes Gerät erstellt.) Das Abonnement des Tags
`Push.all` kann programmgestützt beendet werden. 

Wählen Sie in der {{ site.data.keys.mf_console }} unter **[Ihre Anwendung] → Push** das Register **Benachrichtigung senden** aus.
Wählen Sie dann auf der Registerkarte **Senden an** die Option **Alle** aus und geben Sie den
**Benachrichtigungstext** an. Klicken Sie dann auf **Senden**. 

![Senden an alle](sending-to-all.png)

### REST-APIs
{: #rest-apis }
Mit den REST-APIs können alle Arten von Benachrichtigungen gesendet werden, tagbasierte Benachrichtigungen und Broadcastbenachrichtigungen sowie authentifizierte Benachrichtigungen. 

Für das Senden einer Benachrichtigung wird eine POST-Anforderung an den REST-Endpunkt abgesetzt: `imfpush/v1/apps/<Anwendungs-ID>/messages`.  
Beispiel-URL:  

```bash
https://myserver.com:443/imfpush/v1/apps/com.sample.PinCodeSwift/messages
```

> Eine Übersicht über alle REST-APIs für Push-Benachrichtigungen finden Sie im Abschnitt [REST-API-Laufzeitservices](https://www.ibm.com/support/knowledgecenter/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/c_restapi_runtime.html) der Benutzerdokumentation.

#### Nutzdaten von Benachrichtigungen
{: #notification-payload }
Die Anforderung kann die folgenden Nutzdateneigenschaften enthalten:  

Eigenschaften der Nutzdaten| Definition
--- | ---
message | Die zu sendende Alertnachricht
settings | Die Einstellungen sind verschiedene Attribute der Benachrichtigung.
target | Ziele können Consumer-IDs, Geräte, Plattformen oder Tags sein. Es kann nur ein Ziel festgelegt werden.
deviceIds | Array der Geräte, die durch die Gerätekennungen repräsentiert werden. Geräte mit diesen IDs empfangen eine Unicastbeanchrichtigung.
notificationType | Ganzzahliger Wert für den Kanal (Push/SMS), über den die Nachricht gesendet wird. Gültige Werte sind 1 (nur Push), 2 (nur SMS) und 3 (Push und SMS).
platforms | Array der Geräteplattformen. Geräte mit diesen Plattformen empfangen die Benachrichtigung. Unterstützte Werte sind A (Apple/iOS), G (Google/Android) und M (Microsoft/Windows).
tagNames | Array mit Tags, die als Tagnamen angegeben sind. Geräte, die diese Tags abonniert haben, empfangen die Benachrichtigung. Verwenden Sie diese Einstellung für "target" für tagbasierte Benachrichtigungen.
userIds | Array mit Benutzern, repräsentiert durch die Benutzer-IDs, an die eine Unicastbenachrichtigung gesendet wird.
phoneNumber | Telefonnummer für die Registrierung des Geräts und den Empfang von Unicastbenachrichtigungen.

**JSON-Beispiel für die Nutzdaten von Push-Benachrichtigungen**

```json
{
  "message" : {
    "alert" : "Test message",
  },
  "settings" : {
    "apns" : {
      "badge" : 1,
      "iosActionKey" : "Ok",
      "payload" : "",
      "sound" : "song.mp3",
      "type" : "SILENT",
    },
    "gcm" : {
      "delayWhileIdle" : ,
      "payload" : "",
      "sound" : "song.mp3",
      "timeToLive" : ,
    },
  },
  "target" : {
    // Die folgende Liste dient nur zur Demonstration. Gemäß Dokumentation ist immer nur jeweils 1 Ziel erlaubt.
    "deviceIds" : [ "MyDeviceId1", ... ],
    "platforms" : [ "A,G", ... ],
    "tagNames" : [ "Gold", ... ],
    "userIds" : [ "MyUserId", ... ],
  },
}
```

**JSON-Beispiel für die Nutzdaten von SMS-Benachrichtigungen**

```json
{
  "message": {
    "alert": "Hello World from an SMS message"
  },
  "notificationType":3,
   "target" : {
     "deviceIds" : ["38cc1c62-03bb-36d8-be8e-af165e671cf4"]
   }
}
```

#### Benachrichtigung senden
{: #sending-the-notification }
Die Benachrichtigung kann mit verschiedenen Tools gesendet werden.   
Nachfolgend wird für Testzwecke Postman verwendet. 

1. [Konfigurieren Sie einen vertraulichen Client](../../authentication-and-security/confidential-clients/).
       
Wenn Sie eine Push-Benachrichtigung über die REST-API senden, werden die jeweils durch ein Leerzeichen getrennten
Bereichselemente `messages.write` und `push.application.<Anwendungs-ID>` verwendet. 
    
    <img class="gifplayer" alt="Vertraulichen Client konfigurieren" src="push-confidential-client.png"/>

2. [Erstellen Sie ein Zugriffstoken](../../authentication-and-security/confidential-clients#obtaining-an-access-token).  
    
    
3. Setzen Sie eine **POST**-Anforderung an **http://localhost:9080/imfpush/v1/apps/com.sample.PushNotificationsAndroid/messages** ab. 
    - Wenn Sie {{ site.data.keys.product_adj }} über Fernzugriff verwenden, ersetzen Sie `Hostnamen` und `Port` durch Ihre eigenen Werte. 
    - Aktualisieren Sie die Anwendungs-ID. Geben Sie Ihren eigenen Wert an. 

4. Legen Sie einen Header fest:
    - **Authorization**: `Bearer eyJhbGciOiJSUzI1NiIsImp ...`
    - Ersetzen Sie den Wert hinter "Bearer" durch den Wert Ihres Zugriffstokens aus Schritt (1). 
    
    ![Autorisierungsheader](postman_authorization_header.png)

5. Legen Sie einen Hauptteil fest: 
    - Aktualisieren Sie die Eigenschaften gemäß der Beschreibung im obigen Abschnitt [Nutzdaten von Benachrichtigungen](#notification-payload). 
    - Fügen Sie beispielsweise die Eigenschaft **target** mit dem Attribut **userIds** hinzu,
wenn Sie eine Benachrichtigung an bestimmte registrierte Benutzer senden möchten. 

   ```json
   {
        "message" : {
            "alert" : "Hello World!"
        }
   }
   ```
    
   ![Autorisierungsheader](postman_json.png)
    
Wenn Sie auf die Schaltfläche **Senden** geklickt haben, müsste das Gerät eine Benachrichtigung empfangen haben: 

![Beispielanwendung](notifications-app.png)

### Benachrichtigungen anpassen
{: #customizing-notifications }
Vor dem Senden der Benachrichtigung können Sie die folgenden Benachrichtigungsattribute anpassen.   

Blenden Sie in der {{ site.data.keys.mf_console }} unter **[Ihre Anwendung] → Push → Tags** auf der
Registerkarte **Benachrichtigungen senden**
den Abschnitt **Angepasste iOS/Android-Einstellungen** ein, um die Benachrichtigungsattribute zu ändern. 

### Android
{: #android }
* Benachrichtigungsklang, Dauer der Aufbewahrung einer Benachrichtigung im GCM-Speicher, angepasste Nutzdaten usw. 
* Wenn Sie den Benachrichtigungstitel ändern möchten, fügen Sie zur Datei
**strings.xml** des Android-Projekts `push_notification_tile` hinzu. 

### iOS
{: #ios }
* Benachrichtigungsklang, angepasste Nutzdaten, Titel für Aktionsschlüssel, Benachrichtigungstyp und Kennzeichnungsnummer

![Push-Benachrichtigungen anpassen](customizing-push-notifications.png)

## Proxyunterstützung
{: #proxy-support }
In den Proxy-Einstellungen können Sie den optionalen Proxy festlegen, über den Benachrichtigungen
an Android-
und iOS-Geräte gesendet werden. Verwenden Sie die Konfigurationseigenschaften **push.apns.proxy.** und **push.gcm.proxy.**, um den Proxy festzulegen. Weitere Informationen
finden Sie in der [Liste der
JNDI-Eigenschaften für den MobileFirst-Server-Push-Service](../../installation-configuration/production/server-configuration/#list-of-jndi-properties-for-mobilefirst-server-push-service).

## Nächste Lernprogramme
{: #tutorials-to-follow-next }
Da die Serverseite jetzt eingerichtet ist, fahren Sie mit dem clientseitigen Setup und der Handhabung empfangener Benachrichtigungen fort. 

* Handhabung von Push-Benachrichtigungen
    * [Handhabung von Push-Benachrichtigungen in Cordova-Anwendungen](../handling-push-notifications/cordova)
    * [Handhabung von Push-Benachrichtigungen in iOS-Anwendungen](../handling-push-notifications/ios)
    * [Handhabung von Push-Benachrichtigungen in Android-Anwendungen](../handling-push-notifications/android)
    * [Handhabung von Push-Benachrichtigungen in Windows-Anwendungen](../handling-push-notifications/windows)

* Handhabung von SMS-Benachrichtigungen
    * [Handhabung von SMS-Benachrichtigungen in Cordova-Anwendungen](../handling-sms-notifications/cordova) 
    * [Handhabung von SMS-Benachrichtigungen in iOS-Anwendungen](../handling-sms-notifications/ios)
    * [Handhabung von SMS-Benachrichtigungen in Android-Anwendungen](../handling-sms-notifications/android) 
