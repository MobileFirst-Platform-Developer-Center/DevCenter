---
layout: tutorial
title: Handhabung von Push-Benachrichtigungen in Android
breadcrumb_title: Android
relevantTo: [android]
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Sie müssen Unterstützung für Google Play Services konfigurieren, damit Android-Anwendungen empfangene Push-Benachrichtigungen handhaben können. Wenn eine Anwendung konfiguriert ist,
kann die {{ site.data.keys.product_adj }}-API für Benachrichtigungen verwendet werden,
um Geräte zu registrieren und Geräteregistrierungen aufzuheben und um
Tags zu abonnieren und Tagabonnements zu beenden. In diesem Lernprogramm werden Sie lernen, wie
Push-Benachrichtigungen in Android-Anwendungen gehandhabt werden. 

**Voraussetzungen:**

* Stellen Sie sicher, dass Sie die folgenden Lernprogramme durchgearbeitet haben: 
    * [{{ site.data.keys.product_adj }}-Entwicklungsumgebung einrichten](../../../installation-configuration/#installing-a-development-environment)
    * [SDK der {{ site.data.keys.product }} zu Android-Anwendungen hinzufügen](../../../application-development/sdk/android)
    * [Übersicht über Push-Benachrichtigungen](../../)
* {{ site.data.keys.mf_server }} wird lokal oder fern ausgeführt. 
* Die {{ site.data.keys.mf_cli }} ist auf der Entwicklerworkstation installiert. 

#### Fahren Sie mit folgenden Abschnitten fort: 
{: #jump-to }
* [Benachrichtigungskonfiguration](#notifications-configuration)
* [API für Benachrichtigungen](#notifications-api)
* [Handhabung von Push-Benachrichtigungen](#handling-a-push-notification)
* [Beispielanwendung](#sample-application)
* [Clientanwendungen für Android auf FCM umstellen](#migrate-to-fcm)

## Benachrichtigungskonfiguration
{: #notifications-configuration }
Erstellen Sie ein neues Android-Studio-Projekt oder verwenden Sie ein vorhandenes Projekt.   
Wenn das native {{ site.data.keys.product_adj }}-Android-SDK noch nicht im Projekt enthalten ist,
folgen Sie den Anweisungen im Lernprogramm [SDK der {{ site.data.keys.product }} zu Android-Anwendungen hinzufügen](../../../application-development/sdk/android).



### Projekt-Setup
{: #project-setup }
1. Wählen Sie unter **Android → Gradle scripts** die Datei
**build.gradle (Module: app)** aus und fügen Sie zu `dependencies` die folgenden Zeilen hinzu:

   ```bash
   com.google.android.gms:play-services-gcm:9.0.2
   ```
   - **Hinweis:** Es gibt einen [bekannten Google-Defect](https://code.google.com/p/android/issues/detail?id=212879), der
die Verwendung der neuesten Play-Services-Version (zurzeit Version 9.2.0) verhindert. Verwenden Sie eine ältere Version. 

   Fügen Sie außerdem folgende Zeilen hinzu: 

   ```xml
   compile group: 'com.ibm.mobile.foundation',
            name: 'ibmmobilefirstplatformfoundationpush',
            version: '8.0.+',
            ext: 'aar',
            transitive: true
   ```
    
   Oder in einer einzelnen Zeile: 

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationpush:8.0.+'
   ```

2. Öffnen Sie unter **Android → app → manifests** die Datei `AndroidManifest.xml`. 
	* Fügen Sie am Anfang des Tags `manifest` die folgenden Berechtigungen hinzu: 

	  ```xml
	  <!-- Permissions -->
      <uses-permission android:name="android.permission.WAKE_LOCK" />

      <!-- GCM Permissions -->
      <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
      <permission
    	    android:name="your.application.package.name.permission.C2D_MESSAGE"
    	    android:protectionLevel="signature" />
      ```
      
	* Fügen Sie Folgendes zum Tag `application` hinzu: 

	  ```xml
      <!-- GCM Receiver -->
      <receiver
            android:name="com.google.android.gms.gcm.GcmReceiver"
            android:exported="true"
            android:permission="com.google.android.c2dm.permission.SEND">
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
                <category android:name="your.application.package.name" />
            </intent-filter>
      </receiver>

      <!-- MFPPush Intent Service -->
      <service
            android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.android.c2dm.intent.RECEIVE" />
            </intent-filter>
      </service>

      <!-- MFPPush Instance ID Listener Service -->
      <service
            android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushInstanceIDListenerService"
            android:exported="false">
            <intent-filter>
                <action android:name="com.google.android.gms.iid.InstanceID" />
            </intent-filter>
      </service>
      
      <activity android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushNotificationHandler"
           android:theme="@android:style/Theme.NoDisplay"/>
	  ```

	  > **Hinweis:** Sie müssen `your.application.package.name` durch den Paketnamen Ihrer Anwendung ersetzen. 

    * Fügen Sie den folgenden `intent-filter` zur Aktivität der Anwendung hinzu. 
      
      ```xml
      <intent-filter>
          <action android:name="your.application.package.name.IBMPushNotification" />
          <category android:name="android.intent.category.DEFAULT" />
      </intent-filter>
      ```
      
## API für Benachrichtigungen
{: #notifications-api }
### MFPPush-Instanz
{: #mfppush-instance }
Alle API-Aufrufe müssen für eine Instanz von `MFPPush` ausgeführt werden. Zu diesem Zweck können Sie ein Feld auf Klassenebene erstellen, z. B. `private MFPPush push = MFPPush.getInstance();`, und dann in der gesamten Klasse `push.<API-Aufruf>` aufrufen. 

Alternativ dazu können Sie `MFPPush.getInstance().<API-Aufruf>` für jede Instanz aufrufen, in der Sie auf die Push-API-Methoden zugreifen müssen. 

### Abfrage-Handler
{: #challenge-handlers }
Wenn der Bereich `push.mobileclient` einer **Sicherheitsüberprüfung** zugeordnet ist,
müssen Sie sicherstellen, dass passende **Abfrage-Handler** registriert sind, bevor Push-APIs verwendet werden. 

> Weitere Informationen zu Abfrage-Handlern enthält das Lernprogramm [Berechtigungsnachweise validieren](../../../authentication-and-security/credentials-validation/android).



### Clientseite
{: #client-side }

|Java-Methoden|Beschreibung |
|-----------------------------------------------------------------------------------|-------------------------------------------------------------------------|
|[`initialize(Context context);`](#initialization) |Initialisiert MFPPush für den angegebenen Kontext|
|[`isPushSupported();`](#is-push-supported) |Unterstützt das Gerät Push-Benachrichtigungen?|
|[`registerDevice(JSONObject, MFPPushResponseListener);`](#register-device) |Registriert das Gerät beim Push-Benachrichtigungsservice|
|[`getTags(MFPPushResponseListener)`](#get-tags) |Ruft die verfügbaren Tags einer Instanz des Push-Benachrichtigungsservice ab|
|[`subscribe(String[] tagNames, MFPPushResponseListener)`](#subscribe) |Richtet das Geräteabonnement für die angegebenen Tags ein|
|[`getSubscriptions(MFPPushResponseListener)`](#get-subscriptions) |Ruft die derzeit vom Gerät abonnierten Tags ab |
|[`unsubscribe(String[] tagNames, MFPPushResponseListener)`](#unsubscribe) |Beendet das Abonnement bestimmter Tags|
|[`unregisterDevice(MFPPushResponseListener)`](#unregister) |Hebt die Registrierung des Geräts beim Push-Benachrichtigungsservice auf|

#### Initialisierung
{: #initialization }
Die Initialisierung ist erforderlich, damit die Clientanwendung mit dem richtigen Anwendungskontext eine Verbindung zum Service MFPPush herstellen kann. 

* Die API-Methode muss aufgerufen werden, bevor andere MFPPush-APIs verwendet werden.
* Die Callback-Funktion wird für die Handhabung empfangener Push-Benachrichtigungen registriert. 

```java
MFPPush.getInstance().initialize(this);
```

#### Wird Push unterstützt?
{: #is-push-supported }
Es wird überprüft, ob das Gerät Push-Benachrichtigungen unterstützt. 

```java
Boolean isSupported = MFPPush.getInstance().isPushSupported();

if (isSupported ) {
    // Push wird unterstützt.
} else {
    // Push wird nicht unterstützt.
}
```

#### Gerät registrieren
{: #register-device }
Registrieren Sie das Gerät beim Push-Benachrichtigungsservice.

```java
MFPPush.getInstance().registerDevice(null, new MFPPushResponseListener<String>() {
    @Override
    public void onSuccess(String s) {
        // Erfolgreich registriert
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Registrierung mit Fehler fehlgeschlagen
    }
});
```

#### Tags abrufen
{: #get-tags }
Rufen Sie alle verfügbaren Tags vom Push-Benachrichtigungsservice ab. 

```java
MFPPush.getInstance().getTags(new MFPPushResponseListener<List<String>>() {
    @Override
    public void onSuccess(List<String> strings) {
        // Tags erfolgreich als Liste von Zeichenfolgen abgerufen
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Empfang von Tags mit Fehler fehlgeschlagen
    }
});
```

#### Abonnement
{: #subscribe }
Abonnieren Sie die gewünschten Tags. 

```java
String[] tags = {"Tag 1", "Tag 2"};

MFPPush.getInstance().subscribe(tags, new MFPPushResponseListener<String[]>() {
    @Override
    public void onSuccess(String[] strings) {
        // Abonnement erfolgreich
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Abonnement fehlgeschlagen
    }
});
```

#### Abonnements abrufen
{: #get-subscriptions }
Rufen Sie die derzeit vom Gerät abonnierten Tags ab. 

```java
MFPPush.getInstance().getSubscriptions(new MFPPushResponseListener<List<String>>() {
    @Override
    public void onSuccess(List<String> strings) {
        // Abonnements erfolgreich als Liste von Zeichenfolgen empfangen
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Abruf der Abonnements mit Fehler fehlgeschlagen
    }
});
```

#### Abonnement beenden
{: #unsubscribe }
Beenden Sie das Tagabonnement. 

```java
String[] tags = {"Tag 1", "Tag 2"};

MFPPush.getInstance().unsubscribe(tags, new MFPPushResponseListener<String[]>() {
    @Override
    public void onSuccess(String[] strings) {
        // Beendigung des Abonnements erfolgreich
    }

    @Override
    public void onFailure(MFPPushException e) {
        // Beendigung des Abonnements fehlgeschlagen
    }
});
```

#### Registrierung aufheben
{: #unregister }
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

## Handhabung von Push-Benachrichtigungen
{: #handling-a-push-notification }
Für die Handhabung von Push-Benachrichtigungen müssen Sie einen `MFPPushNotificationListener` einrichten. Zu diesem Zweck können Sie eine der
folgenden Methoden implementieren. 

### Option eins
{: #option-one }
Führen Sie in der Aktivität, in der Sie Push-Benachrichtigungen behandeln möchten, die folgenden Schritte aus: 

1. Fügen Sie `implements MFPPushNofiticationListener` zur Klassendeklaration hinzu.
2. Definieren Sie die Klasse als Listener, indem Sie `MFPPush.getInstance().listen(this)` in der Methode `onCreate` aufrufen.
2. Anschließend müssen Sie die folgende *erforderliche* Methode hinzufügen:

   ```java
   @Override
   public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Hier Behandlung von Push-Benachrichtigungen
   }
   ```

3. In dieser Methode werden Sie `MFPSimplePushNotification` empfangen und können für die Benachrichtigung das gewünschte Verhalten festlegen.

### Option zwei
{: #option-two }
Erstellen Sie einen Listener, indem Sie wie folgt `listen(new MFPPushNofiticationListener())` für eine Instanz von `MFPPush` aufrufen: 

```java
MFPPush.getInstance().listen(new MFPPushNotificationListener() {
    @Override
    public void onReceive(MFPSimplePushNotification mfpSimplePushNotification) {
        // Hier Behandlung von Push-Benachrichtigungen
    }
});
```

<img alt="Beispielanwendung" src="notifications-app.png" style="float:right"/>

## Beispielanwendung
{: #sample-application }

[Klicken Sie hier](https://github.com/MobileFirst-Platform-Developer-Center/PushNotificationsAndroid/tree/release80), um das Android-Studio-Projekt herunterzuladen. 

### Verwendung des Beispiels
{: #sample-usage }
Anweisungen finden Sie in der Datei README.md zum Beispiel. 

## Clientanwendungen für Android auf FCM umstellen
{: #migrate-to-fcm }

Google Cloud Messaging (GCM) [wird nicht mehr verwendet](https://developers.google.com/cloud-messaging/faq) und wurde in Firebase Cloud Messaging (FCM) integriert. Google wird die meisten GCM-Services bis April 2019 einstellen.

Wenn Sie ein GCM-Projekt verwenden, [stellen Sie die GCM-Client-Apps für Android auf FCM um](https://developers.google.com/cloud-messaging/android/android-migrate-fcm) .

Momentan funktionieren die vorhandenen Anwendungen, die GCM-Services nutzen, unverändert weiter. Da der Push-Benachrichtigungsservice aktualisiert wurde und jetzt FCM-Endpunkte verwendet, müssen alle neuen Anwendungen FCM nutzen. 

**Hinweis**: Nach der Umstellung auf FCM müssen Sie Ihr Projekt aktualisieren, damit es anstelle der alten GCM-Berechtigungsnachweise FCM-Berechtigungsnachweise verwendet. 

### Einrichtung eines FCM-Projekts

Die Einrichtung einer Anwendung in FCM unterscheidet sich vom alten GCM-Modell.  

 1. Fordern Sie die Berechtigungsnachweise Ihres Benachrichtigungsproviders an, erstellen Sie ein FCM-Projekt und fügen Sie beides zu Ihrer Android-Anwendung hinzu. Nehmen Sie als Paketnamen Ihrer Anwendung `com.ibm.mobilefirstplatform.clientsdk.android.push` auf. Folgen Sie [hier der Dokumentation](https://console.bluemix.net/docs/services/mobilepush/push_step_1.html#push_step_1_android) bis zu dem Schritt, nach dem Sie die Datei `google-services.json` generiert haben.

 2. Konfigurieren Sie Ihre Gradle-Datei. Fügen Sie Folgendes zur Datei `build.gradle` der App hinzu: 

    ```xml
    dependencies {
       ......
       compile 'com.google.firebase:firebase-messaging:10.2.6'
       .....

    }
    ```
	
    apply plugin: 'com.google.gms.google-services'
    
    - Fügen Sie die folgende Abhängigkeit zur `buildscript`-Datei hinzu:
    
    `classpath 'com.google.gms:google-services:3.0.0'`

 3. Konfigurieren Sie die Android-Manifestdatei. Die folgenden Änderungen an der Datei `Android manifest.xml` sind erforderlich: 

**Entfernen Sie folgende Einträge:**

```xml
    <receiver android:exported="true" android:name="com.google.android.gms.gcm.GcmReceiver" android:permission="com.google.android.c2dm.permission.SEND">
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.RECEIVE" />
            <category android:name="your.application.package.name" />
        </intent-filter>
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.REGISTRATION" />
            <category android:name="your.application.package.name" />
        </intent-filter>
    </receiver>  
	
    <service android:exported="false" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushInstanceIDListenerService">
        <intent-filter>
            <action android:name="com.google.android.gms.iid.InstanceID" />
        </intent-filter>
    </service>

    <uses-permission android:name="your.application.package.name.permission.C2D_MESSAGE" />
    <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
```

**Folgende Einträge müssen modifiziert werden:**

```xml
    <service android:exported="true" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService">
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.RECEIVE" />
        </intent-filter>
    </service>
```

**Nach der Modifikation müssen die Einträge wie folgt aussehen:**

```xml
    <service android:exported="true" android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPushIntentService">
        <intent-filter>
            <action android:name="com.google.firebase.MESSAGING_EVENT" />
        </intent-filter>
    </service>
```

**Fügen Sie den folgenden Eintrag hinzu:**

```xml
    <service android:name="com.ibm.mobilefirstplatform.clientsdk.android.push.api.MFPPush"
            android:exported="true">
            <intent-filter>
                <action android:name="com.google.firebase.INSTANCE_ID_EVENT" />
            </intent-filter>
    </service>
```
	
 4. Öffnen Sie die App in Android Studio. Kopieren Sie die Datei `google-services.json`, die Sie in **Schritt 1** erstellt haben, in das App-Verzeichnis. Die Datei `google-service.json` enthält den Paketnamen, den Sie hinzugefügt haben.		
		
 5. Kompilieren Sie das SDK. Erstellen Sie die Anwendung.




