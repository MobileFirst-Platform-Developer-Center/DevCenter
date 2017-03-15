---
layout: tutorial
title: Ereignisquellenbasierte Benachrichtigungen auf Push-Benachrichtigungen umstellen
breadcrumb_title: Push-Benachrichtigungen umstellen
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Ab {{ site.data.keys.product_full }} Version 8.0
wird das auf Ereignisquellen basierende Modell nicht mehr unterstützt. Dafür wird die Push-Benachrichtigungsfunktion komplett über das Push-Servicemodell realisiert. Wenn vorhandene, auf Ereignisquellen basierende Anwendungen frührerer
{{ site.data.keys.product_adj }}-Versionen auf
Version 8.0 umgestellt werden sollen, müssen Sie auf das neue
Push-Servicemodell migriert werden. 

Bei der Umstelllung müssen Sie beachten, dass es nicht um die Verwendung einer anderen API geht, sondern um die Anwendung eines neuen Modells bzw. einer neuen
Methode. 

Wenn Sie beim ereignisquellenbasierten Modell beispielsweise die Benutzer Ihrer mobilen Anwendung Segmenten zugeordnet haben, um Benachrichtigungen
an bestimmte Segmente zu senden, mussten Sie jedes Segment als eine bestimmte Ereignisquelle modellieren. Beim Push-Servicemodell erreichen Sie dasselbe, indem Sie Tags definieren, die Segmente repräsentieren, und
Benutzer die jeweiligen Tags abonnieren lassen. Tagbasierte Benachrichtigungen ersetzen die auf Ereignissen basierenden Benachrichtigungen. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Migrationsszenarien](#migration-scenarios)
* [Migrationstool](#migration-tool)

<br/>

Die folgende Tabelle enthält eine Gegenüberstellung der beiden Modelle. 

| Benutzeranforderung | Ereignisquellenmodell | Push-Servicemodell | 
|------------------|--------------------|--------------------|
| Push-Benachrichtigungen in der Anwendung ermöglichen | {::nomarkdown}<ul><li>Sie erstellen einen Ereignisquellenadapter und in dem Adapter eine Ereignisquelle (EventSource).</li><li>Sie konfigurieren Ihre Anwendung mit Push-Berechtigungsnachweisen. </li></ul>{:/} | Sie konfigurieren Ihre Anwendung mit Push-Berechtigungsnachweisen.  | 
| Push-Benachrichtigungen in der mobilen Clientanwendung ermöglichen | {::nomarkdown}<ul><li>Sie erstellen WLClient. </li><li>Sie stellen eine Verbindung zu {{ site.data.keys.mf_server }} her. </li><li>Sie rufen eine Instanz des Push-Clients an. </li><li>Sie abonnieren die Ereignisquelle. </li></ul>{:/} | {::nomarkdown}<ul><li>Sie instanziieren den Push-Client. </li><li>Sie initialisieren den Push-Client. </li><li>Sie registrieren das mobile Gerät. </li></ul>{:/} |
| Auf bestimmten Tags basierende Push-Benachrichtigungen in der mobilen Clientanwendung ermöglichen | Nicht unterstützt | Sie abonnieren den interessierenden Tag (unter Angabe des Tagnamens).  | 
| Benachrichtigungen in der mobilen Clientanwendung empfangen und handhaben  | Sie registrieren eine Listenerimplementierung.  | Sie registrieren eine Listenerimplementierung.  |
| Push-Benachrichtigungen an mobile Clientanwendungen senden | {::nomarkdown}<ul><li>Sie implementieren Adapterprozeduren, die intern die WL.Server-APIs aufrufen, um Push-Benachrichtigungen zu senden. </li><li>WL-Server-APIs stellen Mittel bereit, Benachrichtigungen wie folgt zu senden: <ul><li>Nach Benutzer</li><li>Nach Gerät</li><li><li>Broadcasts (alle Geräte)</li></ul></li><li>Back-End-Serveranwendungen können die Adapterprozeduren aufrufen, um Push-Benachrichtigungen als Teil ihrer Anwendungslogik auszulösen. </li></ul>{:/} | {::nomarkdown}<ul><li>Back-End-Serveranwendungen können direkt die REST-API für Nachrichten aufrufen. Diese Anwendungen müssen jedoch als vertraulicher Client bei {{ site.data.keys.mf_server }} registriert werden und ein gültiges OAuth-Zugriffstoken erhalten, das an den Autorisierungsheader der REST-API übergeben werden muss.</li><li>Die REST-API stellt Optionen bereit, Benachrichtigungen wie folgt zu senden:<ul><li>Nach Benutzer</li><li>Nach Gerät</li><li>Nach Plattform</li><li>Nach Tags</li><li>Broadcasts (alle Geräte)</li></ul></li></ul>{:/} |
| Push-Benachrichtigungen in regelmäßigen Abständen auslösen (Sendeaufrufintervalle) |  Sie implementieren die Funktion für das Senden von Push-Benachrichtigungen im Ereignisquellenadapter als Teil des createEventSource-Funktionsaufrufs. | Nicht unterstützt |
| Hook mit Namen, URL und Ereignistypen registrieren | Hooks im Pfad eines Geräts implementieren, das Push-Benachrichtigungen abonniert oder das Abonnement solcher Benachrichtigungen beendet | Nicht unterstützt | 

## Migrationsszenarien
{: #migration-scenarios }
Ab
{{ site.data.keys.product }} Version 8.0 wird das ereignisquellenbasierte Modell nicht mehr unterstützt.
Die Funktion für Push-Benachrichtigungen wird in der {{ site.data.keys.product }}
vollständig über das Push-Servicemodell ermöglicht, das eine simplere und agilere Alternative zum Ereignisquellenmodell ist. 

Vorhandene, auf Ereignisquellen basierende Anwendungen frührerer
Versionen der IBM MobileFirst Platform Foundation müssen auf das neue Push-Servicemodell von
Version 8.0 umgestellt werden. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Hybridanwendungen](#hybrid-applications)
* [Native Android-Anwendungen](#native-android-applications)
* [Native iOS-Anwendungen](#native-ios-applications)
* [Native universelle Windows-Anwendungen](#native-windows-universal-applications)

### Hybridanwendungen
{: #hybrid-applications }
Die Beispielszenarien für die Migration decken Anwendungen ab, die einzelne Ereignisquellen oder mehrere Quellen, Broadcast- bzw. Unicastbenachrichtigungen oder
Tagbenachrichtigungen verwenden. 

#### Szenario 1: Anwendungen mit einzelner Ereignisquelle
{: #hybrid-scenario-1-existing-applications-using-single-event-source-in-their-application }
In früheren Versionen der
{{ site.data.keys.product_adj }} verwendeten Anwendungen eine einzelne Ereignisquelle, da Push nur über das
auf Ereignisquellen basierende Modell unterstützt wurde. 

##### Client
{: #client-hybrid-1 }
Für die Umstellung auf
Version 8.0 muss dieses Modell
in Unicastbenachrichtigungen konvertiert werden. 

1. Initialisieren Sie die {{ site.data.keys.product_adj }}-Push-Clientinstanz in Ihrer Anwendung und regstrieren Sie im Callback für den Erfolgsfall die Callback-Methode, die die Benachrichtigung empfangen soll. 

   ```javascript
   MFPPush.initialize(function(successResponse){
   MFPPush.registerNotificationsCallback(notificationReceived); }, 
   function(failureResponse){alert("Failed to initialize");    
                              }  
   );
   ```
    
2. Implementieren Sie die Callback-Methode für Benachrichtigungen. 

   ```javascript
   var notificationReceived = function(message) {
        alert(JSON.stringify(message)); 
   };
   ```
    
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 
 
   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```
    
5. Entfernen Sie WL.Client.Push.isPushSupported() (sofern verwendet) und verwenden Sie Folgendes: 

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	   },
	   function(failureResponse) {
	       alert("Failed to get the push suport status");
	   }
   );
   ```
    
6. Entfernen Sie die folgenden `WL.Client.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks. 
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

##### Server
{: #server-hybrid-1 }
1. Entfernen Sie die folgenden WL.Server-APIs aus Ihrem Adapter (sofern verwendet): 
    * `notifyAllDevices()`
    * `notifyDevice()`
    * `notifyDeviceSubscription()`
    * `createEventSource()`
2. Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 
    1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

        Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
    2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu. 
    3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen
(siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)). 
    4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
        * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
        * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`

#### Szenario 2: Anwendungen mit mehreren Ereignisquellen
{: #hybrid-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
Bei Anwendungen, die mehrere Ereignisquellen nutzen, müssen Benutzer ausgehend von Abonnements bestimmten Segmenten zugeordnet werden. 

##### Client
{: #client-hybrid-2 }
Bei der Zuordnung zu Tags werden die Benutzer/Geräte ausgehend von interessierenden Themen Segmenten zugeordnet. Bei der Umstellung
kann dieses Modell
in die tagbasierte Benachrichtigung konvertiert werden. 

1. Initialisieren Sie die MFPPush-Clientinstanz in Ihrer Anwendung und regstrieren Sie im Callback für den Erfolgsfall die Callback-Methode, die die Benachrichtigung empfangen soll. 

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					}, 
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```
    
2. Implementieren Sie die Callback-Methode für Benachrichtigungen. 

   ```javascript
   var notificationReceived = function(message) {
		alert(JSON.stringify(message));
   };
   ```

3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```
    
5. Entfernen Sie `WL.Client.Push.isPushSupported()` (sofern verwendet) und verwenden Sie Folgendes: 

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	    },
	  function(failureResponse) {
		alert("Failed to get the push suport status");
	    }
   );
   ```
    
6. Entfernen Sie die folgenden `WL.Client.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks. 
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * `onReadyToSubscribe()`

7. Abonnieren Sie wie folgt Tags: 

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
    	alert("Successfully subscribed");
        },
      function(failureResponse) {
    	alert("Failed to subscribe");
        }
   );
   ```

8. Sie können das Abonnement der Tags wie folgt wieder beenden. 

   ```javascript
   MFPPush.unsubscribe(tags, function(successResponse) {
		alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```
    
##### Server
{: #server-hybrid-2 }
Entfernen Sie die folgenden `WL.Server`-APIs aus Ihrem Adapter (sofern verwendet): 

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`

#### Szenario 3: Anwendungen mit Broadcast-/Unicastbenachrichtigung
{: #hybrid-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### Client
{: #client-hybrid-3 }
1. Initialisieren Sie die MFPPush-Clientinstanz in Ihrer Anwendung und regstrieren Sie im Callback für den Erfolgsfall die Callback-Methode, die die Benachrichtigung empfangen soll. 

   ```javascript
   MFPPush.initialize(function(successResponse){
        MFPPush.registerNotificationsCallback(notificationReceived);              					}, 
        function(failureResponse){
            alert("Failed to initialize");
        }
   );
   ```
    
2. Implementieren Sie die Callback-Methode für Benachrichtigungen. 

   ```javascript
   var notificationReceived = function(message) {
        alert(JSON.stringify(message));
   };
   ```
    
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
        alert("Successfully registered");
        },
      function(failureResponse) {
        alert("Failed to register");
        }
   );
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
        alert("Successfully unregistered");
        },
      function(failureResponse) {
        alert("Failed to unregister");
        }
   );
   ```

5. Entfernen Sie WL.Client.Push.isPushSupported() (sofern verwendet) und verwenden Sie Folgendes: 

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
        alert(successResponse);
        },
      function(failureResponse) {
        alert("Failed to get the push suport status");
        }
   );
   ```

6. Entfernen Sie die folgenden `WL.Client.Push`-APIs: 
    * `onReadyToSubscribe()`
    * `onMessage()`

##### Server
{: #server-hybrid-3 }
Entfernen Sie `WL.Server.sendMessage()` aus Ihrem Adapter (sofern verwendet).   
Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`

#### Szenario 4: Anwendungen mit Tagbenachrichtigungen
{: #hybrid-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### Client
{: #client-hybrid-4 }
1. Initialisieren Sie die MFPPush-Clientinstanz in Ihrer Anwendung und regstrieren Sie im Callback für den Erfolgsfall die Callback-Methode, die die Benachrichtigung empfangen soll. 

   ```javascript
   MFPPush.initialize(function(successResponse){
		MFPPush.registerNotificationsCallback(notificationReceived);              					}, 
		function(failureResponse){
			alert("Failed to initialize");
		}
   );
   ```

2. Implementieren Sie die Callback-Methode für Benachrichtigungen. 

   ```javascript
   var notificationReceived = function(message) {
		alert(JSON.stringify(message));
   };
   ```

3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```javascript
   MFPPush.registerDevice(function(successResponse) {
		alert("Successfully registered");
	    },
	  function(failureResponse) {
		alert("Failed to register");
	    }
   );
   ```

4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```javascript
   MFPPush.unregisterDevice(function(successResponse) {
		alert("Successfully unregistered");
	    },
	  function(failureResponse) {
		alert("Failed to unregister");
	    }
   );
   ```
    
5. Entfernen Sie `WL.Client.Push.isPushSupported()` (sofern verwendet) und verwenden Sie Folgendes: 

   ```javascript
   MFPPush.isPushSupported (function(successResponse) {
		alert(successResponse);
	    },
	  function(failureResponse) {
		alert("Failed to get the push suport status");
	    }
   );
   ```

6. Entfernen Sie die folgenden `WL.Client.Push`-APIs: 
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * `onReadyToSubscribe()`
    * `onMessage()`

7. Abonnieren Sie wie folgt Tags: 

   ```javascript
   var tags = ['sample-tag1','sample-tag2'];
   MFPPush.subscribe(tags, function(successResponse) {
		alert("Successfully subscribed");
	    },
	  function(failureResponse) {
		alert("Failed to subscribe");
	    }
   );
   ```

8. Sie können das Abonnement der Tags wie folgt wieder beenden: 

   ```javascript
   MFPPush.unsubscribe(tags, function(successResponse) {
		alert("Successfully unsubscribed");
	    },
	  function(failureResponse) {
		alert("Failed to unsubscribe");
	    }
   );
   ```

##### Server
{: #client-hybrid-4 }
Entfernen Sie `WL.Server.sendMessage()` aus Ihrem Adapter (sofern verwendet).   
Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId` 

### Native Android-Anwendungen
{: #native-android-applications }
Die Beispielszenarien für die Migration decken Anwendungen ab, die einzelne Ereignisquellen oder mehrere Quellen, Broadcast- bzw. Unicastbenachrichtigungen oder
Tagbenachrichtigungen verwenden. 

#### Szenario 1: Anwendungen mit einzelner Ereignisquelle
{: #android-scenario-1-existing-applications-using-single-event-source-in-their-application }
In früheren MobileFirst-Versionen
verwendeten Anwendungen eine einzelne Ereignisquelle, da Push nur über das
auf Ereignisquellen basierende Modell unterstützt wurde. 

##### Client
{: #client-android-1 }
Für die Umstellung auf
Version 8.0 muss dieses Modell
in Unicastbenachrichtigungen konvertiert werden. 

1. Initialisieren Sie die MFPPush-Clientinstanz in Ihrer Anwendung. 

   ```java
   MFPPush push = MFPPush.getInstance();
        push.initialize(_this);
   ```

2. Implementieren Sie die Schnittstelle MFPPushNotificationListener und definieren Sie
onReceive().

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```
    
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
           Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
             Log.i("Push Notifications", "Unregistered successfully");
        }
   });
   ```
    
5. Entfernen Sie `WLClient.Push.isPushSupported()` (sofern verwendet) und verwenden Sie
`push.isPushSupported();`. 
6. Entfernen Sie die folgenden `WLClient.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks: 
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * Implementierung von `WLOnReadyToSubscribeListener` und `WLNotificationListener`

##### Server
{: #server-android-1 }
Entfernen Sie die folgenden `WL.Server`-APIs aus Ihrem Adapter (sofern verwendet): 

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId` 

#### Szenario 2: Anwendungen mit mehreren Ereignisquellen
{: #android-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
Bei Anwendungen, die mehrere Ereignisquellen nutzen, müssen Benutzer ausgehend von Abonnements bestimmten Segmenten zugeordnet werden. 

##### Client
{: #client-android-2 }
Bei der Zuordnung zu Tags werden die Benutzer/Geräte ausgehend von interessierenden Themen Segmenten zugeordnet. Für die Umstellung auf
{{ site.data.keys.product }} Version 8.0.0 muss dieses Modell
in die tagbasierte Benachrichtigung konvertiert werden. 

1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung: 

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```
    
2. Implementieren Sie die Schnittstelle MFPPushNotificationListener und definieren Sie
onReceive().

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```

3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){   
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");
        }
   });
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben: 
  
   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){   
       @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```
    
5. Entfernen Sie `WLClient.Push.isPushSupported()` (sofern verwendet) und verwenden Sie
`push.isPushSupported();`. 
6. Entfernen Sie die folgenden `WLClient.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks: 
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`

7. Implementierung von `WLOnReadyToSubscribeListener` und `WLNotificationListener`
8. Abonnieren Sie wie folgt Tags: 

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```
    
9. Sie können das Abonnement der Tags wie folgt wieder beenden: 
 
   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){

        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```
   
##### Server
{: #server-android-2 }
Entfernen Sie die folgenden `WL.Server`-APIs aus Ihrem Adapter (sofern verwendet): 

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`     

#### Szenario 3: Anwendungen mit Broadcast-/Unicastbenachrichtigung
{: #android-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### Client
{: #client-android-3 }

1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung: 

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```
    
2. Implementieren Sie die Schnittstelle `MFPPushNotificationListener` und definieren Sie
`onReceive()`.

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```
    
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");

        }
   });
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
       @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```

5. Entfernen Sie `WLClient.Push.isPushSupported()` (sofern verwendet) und verwenden Sie
`push.isPushSupported();`. 
6. Entfernen Sie die folgenden WLClient.Push-APIs: 
    * `registerEventSourceCallback()`
    * Implementierung von `WLOnReadyToSubscribeListener` und `WLNotificationListener`

##### Server
{: #server-android-3 }
Entfernen Sie die WL.Server.sendMessage()-APIs aus Ihrem Adapter (sofern verwendet): 

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen Mapping** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen
(siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)). 
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`    

#### Szenario 4: Anwendungen mit Tagbenachrichtigungen
{: #android-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### Client
{: #client-android-4 }

1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung: 

   ```java
   MFPPush push = MFPPush.getInstance();
   push.initialize(_this);
   ```

2. Implementieren Sie die Schnittstelle MFPPushNotificationListener und definieren Sie
onReceive().
 
   ```java
   @Override
   public void onReceive(MFPSimplePushNotification message) {
        Log.i("Push Notifications", message.getAlert());
   }
   ```
    
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 
    
   ```java
   push.registerDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to register");
	    }
        @Override
        public void onSuccess(String arg0) {
            Log.i("Push Notifications", "Registered successfully");
        }
   });
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 
 
   ```java
   push.unregisterDevice(new MFPPushResponseListener<String>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unregister");

        }
        @Override
        public void onSuccess(String arg0) {
            Log.i( "Push Notifications", "Unregistered successfully");
        }
   });
   ```
    
5. Entfernen Sie `WLClient.Push.isPushSupported()` (sofern verwendet) und verwenden Sie
`push.isPushSupported()`. 
6. Entfernen Sie die folgenden `WLClient.Push`-APIs: 
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * Implementierung von `WLOnReadyToSubscribeListener` und `WLNotificationListener`

7. Abonnieren Sie wie folgt Tags: 

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.subscribe(tags, new MFPPushResponseListener<String[]>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Failed to subscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i( "Subscribed successfully");
        }
   });
   ```

8. Sie können das Abonnement der Tags wie folgt wieder beenden: 

   ```java
   String[] tags = new String[2];
   tags[0] ="sample-tag1";
   tags[1] ="sample-tag2";
   push.unsubscribe(tags, new MFPPushResponseListener<String[]>(){
        @Override
        public void onFailure(MFPPushException arg0) {
            Log.i("Push Notifications", "Failed to unsubscribe");
        }

        @Override
        public void onSuccess(String[] arg0) {
            Log.i("Push Notifications", "Unsubscribed successfully");
        }
   });
   ```

##### Server
{: #server-android-4 }
Entfernen Sie `WL.Server.sendMessage()` aus Ihrem Adapter (sofern verwendet). 

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung für Bereichselemente** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`

### Native iOS-Anwendungen
{: #native-ios-applications }
Die Beispielszenarien für die Migration decken Anwendungen ab, die einzelne Ereignisquellen oder mehrere Quellen, Broadcast- bzw. Unicastbenachrichtigungen oder
Tagbenachrichtigungen verwenden. 

#### Szenario 1: Anwendungen mit einzelner Ereignisquelle
{: #ios-scenario-1-existing-applications-using-single-event-source-in-their-application }
In früheren Versionen der
{{ site.data.keys.product_adj }} verwendeten Anwendungen eine einzelne Ereignisquelle, da Push nur über das
auf Ereignisquellen basierende Modell unterstützt wurde. 

##### Client
{: #client-ios-1 }
Für die Umstellung auf
Version 8.0 muss dieses Modell
in Unicastbenachrichtigungen konvertiert werden. 

1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung. 

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```
    
2. Implementieren Sie die Benachrichtigungsverarbeitung in
`didReceiveRemoteNotification()`.
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
    	   NSLog(@"Failed to register");
        } else {
            NSLog(@"Successfullyregistered");
        }
   }];
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        } else {
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
5. Entfernen Sie `WLClient.Push.isPushSupported()` (sofern verwendet) und verwenden Sie Folgendes: 

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. Entfernen Sie die folgenden `WLClient.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks: 
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * Implementierung von `WLOnReadyToSubscribeListener`

7. Rufen Sie `sendDeviceToken()` in
`didRegisterForRemoteNotificationsWithDeviceToken` auf. 

   ```objc
   [[MFPPush sharedInstance] sendDeviceToken:deviceToken];
   ```
    
##### Server
{: #server-ios-1 }
Entfernen Sie die folgenden WL.Server-APIs aus Ihrem Adapter (sofern verwendet): 

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`

#### Szenario 2: Anwendungen mit mehreren Ereignisquellen
{: #ios-scenario-2-existing-applications-using-multiple-event-sources-in-their-application }
Bei Anwendungen, die mehrere Ereignisquellen nutzen, müssen Benutzer ausgehend von Abonnements bestimmten Segmenten zugeordnet werden. 

##### Client
{: #client-ios-2}
Bei der Zuordnung zu Tags werden die Benutzer/Geräte ausgehend von interessierenden Themen Segmenten zugeordnet. Für die Umstellung auf
{{ site.data.keys.product_adj }} Version 8.0.0 muss dieses Modell
in die tagbasierte Benachrichtigung konvertiert werden. 

1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung. 

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. Implementieren Sie die Benachrichtigungsverarbeitung in
`didReceiveRemoteNotification()`.
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice: 

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben: 

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
5. Entfernen Sie `WLClient.Push.isPushSupported()` (sofern verwendet) und verwenden Sie Folgendes: 

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```
    
6. Entfernen Sie die folgenden `WLClient.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks: 
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * Implementierung von `WLOnReadyToSubscribeListener`

7. Rufen Sie `sendDeviceToken()` in
`didRegisterForRemoteNotificationsWithDeviceToken` auf. 
8. Abonnieren Sie wie folgt Tags: 

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
9. Sie können das Abonnement der Tags wie folgt wieder beenden: 

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
##### Server
:{: #server-ios-2 }
Entfernen Sie `WL.Server` aus Ihrem Adapter (sofern verwendet). 

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`    

#### Szenario 3: Anwendungen mit Broadcast-/Unicastbenachrichtigung
{: #ios-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }
##### Client
{: #client-ios-3 }
1. Initialisieren Sie die MFPPush-Clientinstanz in Ihrer Anwendung: 

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```
    
2. Implementieren Sie die Benachrichtigungsverarbeitung in
`didReceiveRemoteNotification()`.
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice: 

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
5. Entfernen Sie `WLClient.Push.isPushSupported()` (sofern verwendet) und verwenden Sie Folgendes: 

   ```objc
   [[MFPPush sharedInstance] isPushSupported]
   ```

6. Entfernen Sie die folgenden `WLClient.Push`-APIs: 
    * `registerEventSourceCallback()`
    * Implementierung von `WLOnReadyToSubscribeListener`

##### Server
{: #server-ios-3 }
Entfernen Sie `WL.Server.sendMessage` aus Ihrem Adapter (sofern verwendet). 

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`  

#### Szenario 4: Anwendungen mit Tagbenachrichtigungen
{: #ios-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### Client
{: #client-ios-4 }

1. Initialisieren Sie die MFPPush-Clientinstanz in Ihrer Anwendung: 

   ```objc
   [[MFPPush sharedInstance] initialize];
   ```

2. Implementieren Sie die Benachrichtigungsverarbeitung in
`didReceiveRemoteNotification()`.
3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice: 

   ```objc
   [[MFPPush sharedInstance] registerDevice:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to register");
        }else{
        	NSLog(@"Successfullyregistered");
        }
   }];
   ```
    
4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben: 
 
   ```objc
   [MFPPush sharedInstance] unregisterDevice:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{
	       NSLog(@"Successfully unregistered");
        }
   }];
   ```
    
5. Entfernen Sie `WLClient.Push.isPushSupported()` (sofern verwendet) und verwenden Sie `[[MFPPush
sharedInstance] isPushSupported]`.
6. Entfernen Sie die folgenden `WLClient.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks: 
    * `registerEventSourceCallback()`
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * Implementierung von `WLOnReadyToSubscribeListener`

7. Rufen Sie `sendDeviceToken()` in
`didRegisterForRemoteNotificationsWithDeviceToken` auf. 
8. Abonnieren Sie wie folgt Tags: 
 
   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] subscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
	       NSLog(@"Failed to unregister");
        }else{    
	       NSLog(@"Successfully unregistered");
       }
   }];
   ```
    
9. Sie können das Abonnement der Tags wie folgt wieder beenden: 

   ```objc
   NSMutableArray *tags = [[NSMutableArray alloc]init];
   [tags addObject:@"sample-tag1"];
   [tags addObject:@"sample-tag2"];
   [MFPPush sharedInstance] unsubscribe:tags completionHandler:^(WLResponse *response, NSError *error) {
        if(error){
        	NSLog(@"Failed to unregister");
        }else{
        	NSLog(@"Successfully unregistered");
        }
   }];
   ```

##### Server
{: server-ios-4 }
Entfernen Sie `WL.Server.sendMessage` aus Ihrem Adapter (sofern verwendet). 

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie die Berechtigungsnachweise in der
{{ site.data.keys.mf_console }} ein (siehe
[Einstellungen für
Push-Benachrichtigungen konfigurieren](../../notifications/sending-notifications)). 

Sie können die Berechtigungsnachweise auch mit der REST-API [Update GCM Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_gcm_settings_put.html?view=kc#Update-GCM-settings--PUT-) für Android-Anwendungen oder der REST-API [Update APNS Settings (PUT)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/apiref/r_restapi_update_apns_settings_put.html?view=kc#Update-APNs-settings--PUT-) für iOS-Anwendungen einrichten.
2. Fügen Sie unter **Zuordnung von Bereichselementen Mapping** den Bereich `push.mobileclient` hinzu.
3. Erstellen Sie Tags, um das Senden von Push-Benachrichtigungen an Abonnenten zu ermöglichen (siehe [Tags für Push-Benachrichtigungen definieren](../../notifications/sending-notifications/#defining-tags)).
4. Sie können Benachrichtigungen auf einem der folgenden Wege senden: 
    * Über die {{ site.data.keys.mf_console }}
(siehe
[Push-Benachrichtigungen an
Abonnenten senden](../../notifications/sending-notifications/#sending-notifications))
    * Über die REST-API
[Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit
`userId`/`deviceId`  

### Native universelle Windows-Anwendungen
{: #native-windows-universal-applications }
Die Beispielszenarien für die Migration decken Anwendungen ab, die einzelne Ereignisquellen oder mehrere Quellen, Broadcast- bzw. Unicastbenachrichtigungen oder
Tagbenachrichtigungen verwenden. 

#### Szenario 1: Anwendungen mit einzelner Ereignisquelle
{: #windows-scenario-1-existing-applications-using-single-event-source-in-their-application }
Für die Umstellung auf
Version 8.0 muss dieses Modell
in Unicastbenachrichtigungen konvertiert werden. 

##### Client
{: #windows-client-1}

1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung. 

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        { 
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```
    
2. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. Entfernen Sie ggf. `WLClient.Push.IsPushSupported()` und verwenden Sie
`push.IsPushSupported();`.
5. Entfernen Sie die folgenden `WLClient.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks: 
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * Implementierung von `WLOnReadyToSubscribeListener` und `WLNotificationListener`

##### Server
{: #windows-server-1 }
Entfernen Sie die folgenden `WL.Server`-APIs aus Ihrem Adapter (sofern verwendet): 

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie auf der Seite **Push-Einstellungen**
der {{ site.data.keys.mf_console }} die WNS-Berechtigungsnachweise ein oder verwenden Sie die
REST-API für WNS-Einstellungen. 
2. Fügen Sie auf der Registerkarte "Sicherheit" der {{ site.data.keys.mf_console }} den Bereich `push.mobileclient` zum Abschnitt **Sicherheitsüberprüfungen Bereichselemente zuordnen** hinzu.
3. Sie können auch die
REST-API [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-)
mit
`userId`/`deviceId` verwenden, um eine Nachricht zu senden. 

#### Szenario 2: Anwendungen mit mehreren Ereignisquellen
{: #windows-scenario-2-existing-applications-using-multiple-event-sources-in-their-appliction }
Bei Anwendungen, die mehrere Ereignisquellen nutzen, müssen Benutzer ausgehend von Abonnements bestimmten Segmenten zugeordnet werden. 

##### Client
{: #windows-client-2 }
Bei der Zuordnung zu Tags werden die Benutzer/Geräte ausgehend von interessierenden Themen Segmenten zugeordnet. Für die Umstellung auf
{{ site.data.keys.product_adj }} Version 8.0.0 muss dieses Modell
in die tagbasierte Benachrichtigung konvertiert werden. 

1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung: 

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        { 
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```
    
2. Registrieren Sie das mobile Gerät beim Service IMFPUSH. 

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. Sie können die Registrierung des mobilen Geräts beim Service IMFPUSH
wie folgt wieder aufheben: 

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

4. Entfernen Sie ggf. `WLClient.Push.IsPushSupported()` und verwenden Sie
`push.IsPushSupported();`.
5. Entfernen Sie die folgenden `WLClient.Push`-APIs, da es keine zu abonnierende Ereignisquelle gibt, und registrieren Sie Benachrichtigungs-Callbacks: 
    * `registerEventSourceCallback()`
    * `subscribe()`
    * `unsubscribe()`
    * `isSubscribed()`
    * Implementierung von `WLOnReadyToSubscribeListener` und `WLNotificationListener`

6. Abonnieren Sie wie folgt Tags: 

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```
    
7. Sie können das Abonnement der Tags wie folgt wieder beenden: 

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```
    
##### Server
{: #windows-server-2 }
Entfernen Sie die folgenden `WL.Server`-APIs aus Ihrem Adapter (sofern verwendet): 

* `notifyAllDevices()`
* `notifyDevice()`
* `notifyDeviceSubscription()`
* `createEventSource()`

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie auf der Seite **Push-Einstellungen**
der {{ site.data.keys.mf_console }} die WNS-Berechtigungsnachweise ein oder verwenden Sie die
REST-API für WNS-Einstellungen. 
2. Fügen Sie auf der Registerkarte **Sicherheit** der {{ site.data.keys.mf_console }} den Bereich `push.mobileclient` zum Abschnitt **Sicherheitsüberprüfungen Bereichselemente zuordnen** hinzu. 
3. Erstellen Sie auf der Seite **Tags** der {{ site.data.keys.mf_console }} Push-Tags.
4. Sie können auch die REST-API [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit `userId`/`deviceId`/`tagNames` als Ziel verwenden, um eine Nachricht zu senden.

#### Szenario 3: Anwendungen mit Broadcast-/Unicastbenachrichtigung
{: #windows-scenario-3-existing-applications-using-broadcast-unicast-notification-in-their-application }

##### Client
{:# windows-client-3 }
1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung: 

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   Implement the interface MFPPushNotificationListener and define onReceive().
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        { 
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

2. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

3. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```
    
4. Entfernen Sie ggf. `WLClient.Push.isPushSupported()` und verwenden Sie
`push.IsPushSupported();`.
5. Entfernen Sie die folgenden `WLClient.Push`-APIs: 
    * `registerEventSourceCallback()`
    * Implementierung von `WLOnReadyToSubscribeListener` und `WLNotificationListener`

##### Server
{: #windows-server-3 }
Entfernen Sie `WL.Server.sendMessage()` aus Ihrem Adapter (sofern verwendet). 

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie auf der Seite **Push-Einstellungen** der {{ site.data.keys.mf_console }} die WNS-Berechtigungsnachweise ein oder verwenden Sie die REST-API für WNS-Einstellungen.
2. Fügen Sie auf der Registerkarte **Sicherheit** der {{ site.data.keys.mf_console }} den Bereich `push.mobileclient` zum Abschnitt **Sicherheitsüberprüfungen Bereichselemente zuordnen** hinzu. 
3. Erstellen Sie auf der Seite **Tags** der {{ site.data.keys.mf_console }} Push-Tags.
4. Sie können auch die REST-API [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit `userId`/`deviceId`/`tagNames` als Ziel verwenden, um eine Nachricht zu senden.

#### Szenario 4: Anwendungen mit Tagbenachrichtigungen
{: #windows-scenario-4-existing-applications-using-tag-notifications-in-their-application }
##### Client
{: #windows-client-4 }

1. Initialisieren Sie die `MFPPush`-Clientinstanz in Ihrer Anwendung: 

   ```csharp
   MFPPush push = MFPPush.GetInstance();
   push.Initialize();
   ```
    
2. Implementieren Sie die Schnittstelle MFPPushNotificationListener und definieren Sie
onReceive().

   ```csharp
   class Pushlistener : MFPPushNotificationListener
   {
        public void onReceive(String properties, String payload)
        { 
                Debug.WriteLine("Push Notifications\n properties:" + properties + "\n payload:" + payload);
        }
   }
   ```

3. Registrieren Sie das mobile Gerät beim Push-Benachrichtigungsservice. 

   ```csharp
   MFPPushMessageResponse Response = await push.RegisterDevice(null);
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Registered successfully");
   } 
   else
   {
        Debug.WriteLine("Push Notifications Failed to register");
   }
   ```

4. Sie können die Registrierung des mobilen Geräts beim Push-Benachrichtigungsservice
wie folgt wieder aufheben. 

   ```csharp
   MFPPushMessageResponse Response = await push.UnregisterDevice();
   if (Response.Success == true)
   {
        Debug.WriteLine("Push Notifications Failed to unregister");
   }
   else
   {
        Debug.WriteLine("Push Notifications Unregistered successfully");
   }
   ```

5. Entfernen Sie ggf. `WLClient.Push.IsPushSupported()` und verwenden Sie
`push.IsPushSupported();`.
6. Entfernen Sie die folgenden `WLClient.Push`-APIs: 
    * `subscribeTag()`
    * `unsubscribeTag()`
    * `isTagSubscribed()`
    * Implementierung von `WLOnReadyToSubscribeListener` und `WLNotificationListener`

7. Abonnieren Sie wie folgt Tags: 

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Subscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Subscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to subscribe");
   }
   ```
    
8. Sie können das Abonnement der Tags wie folgt wieder beenden: 

   ```csharp
   String[] Tag = { "sample-tag1", "sample-tag2" };
   MFPPushMessageResponse Response = await push.Unsubscribe(Tag);
   if (Response.Success == true)
   {
        Debug.WriteLine("Unsubscribed successfully");
   }
   else
   {
        Debug.WriteLine("Failed to unsubscribe");
   }
   ```
    
##### Server
{: #windows-server-4 }
Entfernen Sie `WL.Server.sendMessage()` aus Ihrem Adapter (sofern verwendet). 

Führen Sie die folgende nSchritte für jede Anwendung aus, die dieselbe Ereignisquelle verwendet hat: 

1. Richten Sie auf der Seite **Push-Einstellungen** der {{ site.data.keys.mf_console }} die WNS-Berechtigungsnachweise ein oder verwenden Sie die REST-API für WNS-Einstellungen.
2. Fügen Sie auf der Registerkarte **Sicherheit** der {{ site.data.keys.mf_console }} den Bereich `push.mobileclient` zum Abschnitt **Sicherheitsüberprüfungen Bereichselemente zuordnen** hinzu. 
3. Erstellen Sie auf der Seite **Tags** der {{ site.data.keys.mf_console }} Push-Tags.
4. Sie können auch die REST-API [Push Message (POST)](http://www.ibm.com/support/knowledgecenter/en/SSHS8R_8.0.0/com.ibm.worklight.apiref.doc/rest_runtime/r_restapi_push_message_post.html?view=kc#Push-Message--POST-) mit `userId`/`deviceId`/`tagNames` als Ziel verwenden, um eine Nachricht zu senden.

## Migrationstool
{: #migration-tool }
Das Migrationstool vereinfacht
die Umstellung von Push-Daten von MobileFirst Platform Foundation 7.1 (Geräte, Benutzerabonnements,
Berechtigungsnachweise und Tags) auf {{ site.data.keys.product }} 8.0.  
Das Migrationstool führt die folgenden Funktionen aus, um den Prozess zu vereinfachen: 

1. Es liest die Geräte, Berechtigungsnachweise, Tags und Benutzerabonnements für jede Anwendung aus der Datenbank von MobileFirst Platform Foundation 7.1. 
2. Es kopiert die Daten in die entsprechenden Tabellen für die jeweilige Anwendung in der Datenbank von {{ site.data.keys.product }} 8.0. 
3. Es migriert alle Push-Daten aller Umgebungen aus Version 7.1 ungeachtet der Umgebungen in der Anwendung in Version 8.0. 

Das Migrationstool modifiziert keine Daten im Zusammenhang mit Benutzerabonnements, Anwendungsumgebungen oder Geräten.   

Die folgenden Informationen müssen vor Verwendung des Migrationstools beachtet werden: 

1. Java ab Version 1.6 muss installiert sein. 
2. Stellen Sie sicher, dass MobileFirst Server 7.1 und {{ site.data.keys.mf_server }} 8.0 eingerichtet und betriebsbereit sind. 
3. Erstellen Sie eine Sicherung für MobileFirst Server 7.1 und {{ site.data.keys.mf_server }} 8.0.
4. Registrieren Sie die neueste Version der Anwendung(en) in {{ site.data.keys.mf_server }} 8.0.
	* Der Anzeigename einer Anwendung sollte mit dem der entsprechenden Anwendung in MobileFirst Platform Foundation 7.1 übereinstimmen.
	* Notieren Sie den Paketnamen und die Bundle-ID (PacakgeName/BundleID) und geben Sie eben diese Werte für die Anwendungen an. 
	* Wenn die Anwendung nicht in {{ site.data.keys.mf_server }} 8.0 registriert ist, gelingt die Migration nicht. 
5. Geben Sie für jede Umgebung einer Anwendung Bereichselementzuordnungen an. [Informieren Sie sich über Bereichszuordnungen](../../notifications/sending-notifications/#scope-mapping).

#### Vorgehensweise
{: #procedure }
1. Laden Sie das Migrationstool aus dem folgenden [GitHub-Repository](http://github.com) herunter.
2. Machen Sie nach dem Download des Tools die folgenden Angaben in der Datei **migration.properties**:
	
    | Wert                | Beschreibung  | Beispielwerte |
    |----------------------|--------------|---------------|
    | w.db.type		       | Typ der betreffenden Datenbank	           | pw.db.type = db2 (gültige Werte: DB2, Oracle, MySql, Derby) | 
    | pw.db.url			   | URL der Worklight-Datenbank von MobileFirst Platform Foundation 7.1  | jdbc:mysql://localhost:3306/WRKLGHT |
    | pw.db.adminurl	   | URL der Verwaltungsdatenbank von MobileFirst Platform Foundation 7.1      | jdbc:mysql://localhost:3306/ADMIN |
    | pw.db.username	   | Benutzername für die Worklight-Datenbank von MobileFirst Platform Foundation 7.1 | pw.db.username=root |
    | pw.db.password	   | Kennwort für die Worklight-Datenbank von MobileFirst Platform Foundation 7.1 | pw.db.password=root |
    | pw.db.adminusername  | Benutzername für die Verwaltungsdatenbank von MobileFirst Platform Foundation 7.1     | pw.db.adminusername=root |
    | pw.db.adminpassword  | Kennwort für die Verwaltungsdatenbank von MobileFirst Platform Foundation 7.1     | pw.db.adminpassword=root |
    | pw.db.urlTarget	   | URL der Datenbank von MFP 8.0						        | jdbc:mysql://localhost:3306/MFPDATA |
    | pw.db.usernameTarget | Benutzername für die Datenbank von MFP 8.0						| pw.db.usernameTarget=root |
    | pw.db.passwordTarget | Kennwort für die Datenbank von MFP 8.0						| pw.db.passwordTarget=root |
    | pw.db.schema         | Schema der Worklight-Datenbank von MobileFirst Platform Foundation 7.1 | WRKLGT |
    | pw.db.adminschema    | Schema der Verwaltungsdatenbank von MobileFirst Platform Foundation 7.1     | WLADMIN |
    | pw.db.targetschema   | Schema der Worklight-Datenbank von {{ site.data.keys.product }} 8.0    | MFPDATA |
    | runtime			   | Laufzeitname von MobileFirst Platform Foundation 7.1		 | runtime=worklight |
    | applicationId	       | Liste mit durch Kommata (,) getrennten Anwendungen, die in MobileFirst Platform Foundation 7.1 registriert sind | HybridTestApp,NativeiOSTestApp |
    | targetApplicationId  | Liste mit durch Kommata (,) getrennten Anwendungen, die in {{ site.data.keys.product }} 8.0 registriert sind   | com.HybridTestApp,com.NativeiOSTestApp |

    * Stellen Sie sicher, dass die Werte für **applicationID** und **targetApplicationId** in der richtigen Reihenfolge angegeben sind. Die Zuordnung erfolgt 1:1 (oder n:n). Das heißt, Daten der ersten Anwendung in der **applicationId**-Liste werden der ersten Anwendung in der **targetApplicationId**-Liste zugeordnet.
	* Geben Sie in der **targetApplicationId**-Liste einen Paketnamen bzw. eine Bundle-ID (packageName/BundleId) für die Anwendung an. Für die TestApp1 in MobileFirst Platform Foundation 7.1 enthält die **targetApplicationId**-Liste beispielsweise den Wert com.TestApp1 als packageName/BundleId, weil in MobileFirst Platform Foundation 7.1 **applicationId** der Anwendungsname ist, in {{ site.data.keys.mf_server }} 8.0 der Paketname bzw. die Bundle-ID oder der Paket-ID-Name (packageName/BundleId/packageIdentityName) jedoch auf der Anwendungsumgebung basiert.

2. Führen Sie das Tool mit folgendem Befehl aus:

   ```bash
   java -jar pushDataMigration.jar Pfad_zu_migration.properties
   ```
   
   * Ersetzen Sie **Pfad_zu_migration.properties** durch den Pfad zur Datei **migration.properties**, wenn sich die JAR-Datei und die Eigenschaftendatei an verschiedenen Positionen befinden. Entfernen Sie andernfalls den Pfad aus dem Befehl.

