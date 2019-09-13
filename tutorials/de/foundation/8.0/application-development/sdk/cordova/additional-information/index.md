---
layout: tutorial
title: Weitere Informationen
breadcrumb_title: Additional information
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### TLS-gesicherte Verbindungen in iOS-Apps erzwingen
{: #enforcing-tls-secure-connections-in-ios-apps }
Ab iOS 9 muss in allen Apps TLS (Transport Layer Security) Version 1.2 umgesetzt werden. Für Entwicklungszwecke können Sie dieses
Protokoll inaktivieren und diese Anforderung von iOS 9 umgehen. 

Apple ATS (App Transport Security) ist ein neues Feature von iOS 9, das für Verbindungen zwischen der App und dem Server
bewährte Verfahren umsetzt. Standardmäßig werden mit diesem Feature bestimmte Verbindungsvoraussetzungen
zur Erhöhung der Sicherheit durchgesetzt. Dazu gehören clientseitige HTTPS-Anforderungen
und serverseitige Zertifikate und Verbindungsschlüssel gemäß Transport Layer Security (TLS) Version 1.2 mit zukunftssicherer Geheimhaltung. 

Für **Entwicklungszwecke** können Sie das Standardverhalten außer Kraft setzen und in der Datei info.plist Ihrer App eine Ausnahme angeben (siehe "App Transport Security Technote"). In einer **reinen Produktionsumgebung** funktionieren jedoch sämtliche iOS-Apps nur,
wenn sie TLS-gesicherte Verbindungen umsetzen. 

Wenn Nicht-TLS-Verbindungen
ermöglicht werden sollen, muss in der Datei
**Projektname-info.plist** im Ordner
**Projektname\Resources** die folgende Ausnahme erscheinen: 

```xml
<key>NSExceptionDomains</key>
    <dict>
        <key>yourserver.com</key>
    
            <dict>
            <!-- Aufnehmen, um Unterdomänen zu ermöglichen -->
            <key>NSIncludesSubdomains</key>
            <true/>

            <!-- Aufnehmen, um nicht gesicherte HTTP-Anforderungen zu ermöglichen -->
            <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
```

Vorbereitung für die Produktion: 

1. Entfernen Sie Teile des oben aufgeführten Codes oder setzen Sie Teile des Codes auf Kommentar.   
2. Konfigurieren Sie den Client mit dem folgenden Verzeichniseintrag, sodass er HTTPS-Anforderungen sendet:   

   ```xml
   <key>protocol</key>
   <string>https</string>

   <key>port</key>
   <string>10443</string>
   ```
   
   Die SSL-Portnummer wird auf dem Server
in der
`httpEndpoint`-Definition der Datei **server.xml** festgelegt. 
    
3. Konfigurieren Sie einen Server mit aktiviertem Protokoll TLS 1.2.
Weitere Informationen finden Sie unter [How to configure {{ site.data.keys.mf_server }}  to enable TLS V1.2](http://www-01.ibm.com/support/docview.wss?uid=swg21965659). 
4. Legen Sie Einstellungen für Verschlüsselungen und Zertifikate fest, soweit sie in Ihrem Setup anwendbar sind. Weitere Informationen finden Sie im [technischen Hinweis zu ATS (App Transport Security)](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/) unter [Secure communications using Secure Sockets Layer (SSL)](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/csec_sslsecurecom.html?cp=SSAW57_8.5.5%2F1-8-2-33-4-0&lang=en) und unter [Enabling SSL communication in Liberty](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_sec_ssl.html?cp=SSAW57_8.5.5%2F1-3-11-0-4-1-0).

## OpenSSL in Cordova-Anwendungen aktivieren
{: #enabling-openssl-in-cordova-applications }
Das {{ site.data.keys.product_adj }}-Cordova-SDK für iOS verwendet
für die Verschlüsselung native iOS-APIs. Sie können
die Anwendung
so konfigurieren, dass
in Ihrer Cordova-iOS-App stattdessen die OpenSSL-Verschlüsselungsbibliothek verwendet wird. 

Die Funktionalität für Verschlüsselung/Entschlüsselung wird mit folgenden JavaScript-APIs bereitgestellt: 

* WL.SecurityUtils.encryptText
* WL.SecurityUtils.decryptWithKey

### Option 1: Native Verschlüsselung/Entschlüsselung
{: #option-1-native-encryptiondecryption }
Standardmäßig verwendet {{ site.data.keys.product_adj }} die native Verschlüsselung/Entschlüsselung ohne OpenSSL. Dies entspricht folgender Einstellung für das
Verschlüsselungs-/Entschlüsselungsverhalten: 

* WL.SecurityUtils.enableNativeEncryption(true)

## Option 2: OpenSSL aktivieren
{: #option-2-enabling-openssl }
{{ site.data.keys.product_adj }} OpenSSL ist standardmäßig inaktiviert. 

Wenn Sie die erforderlichen Frameworks zur Unterstützung von OpenSSL installieren möchten, müssen Sie zuvor das
Cordova-Plug-in installieren. 

```bash
cordova plugin add cordova-plugin-mfp-encrypt-utils
```

Mit dem folgenden Code wird die OpenSSL-Option für die Verschlüsselung/Entschlüsselung aktiviert: 

* WL.SecurityUtils.enableNativeEncryption(false)

Bei diesem Setup verwenden die Verschlüsselungs-/Entschlüsselungsaufrufe OpenSSL wie in
früheren Versionen von {{ site.data.keys.product }}.

### Migrationsoptionen
{: #migration-options }
Wenn Sie ein {{ site.data.keys.product_adj }}-Projekt mit einer früheren Version des Produkts
geschrieben haben, müssen Sie möglicherweise einige Änderungen vornehmen, um OpenSSL weiter verwenden zu können. 

* Wenn die Anwendung keine Verschlüsselungs-/Entschlüsselungs-APIs verwendet, und keine verschlüsselten Daten auf dem Gerät zwischengespeichert werden, ist keine
Aktion erforderlich. 
* Verwendet die Anwendung Verschlüsselungs-/Enschlüsselungs-APIs, können Sie diese APIs mit oder ohne OpenSSL nutzen. 
    - **Umstellung auf native Verschlüsselung:**
        1. Stellen Sie sicher, dass die Standardoption für native Verschlüsselung/Entschlüsselung ausgewählt ist (siehe **Option 1**). 
        2. **Umstellung zwischengespeicherter Daten:** Wenn in der bisherigen Installation des Produkts
verschlüsselte Daten mit OpenSSL
auf dem Gerät gespeichert wurden, jetzt aber die Option für native Verschlüsselung/Entschlüsselung gewählt wird, müsssen die
gespeicherten Daten entschlüsselt werden. Wenn die Anwendung zum ersten Mal versucht, Daten zu entschlüsseln, wird sie wie gewohnt auf
OpenSSL zurückgreifen, für die Verschlüsselung dann aber die native Verschlüsselung verwenden. Auf diese Weise werden
die Daten automatisch auf die native Verschlüsselung umgestellt.

**Hinweis:** Für eine Entschlüsselung mit
OpenSSL müssen Sie die OpenSSL-Frameworks hinzufügen. Installieren Sie dazu wie folgt das Cordova-Plug-in: `cordova plugin add cordova-plugin-mfp-encrypt-utils`. 
    - **Weiterverwendung von OpenSSL:** Wenn OpenSSL erforderlich ist, verwenden Sie das unter **Option
2** beschriebene Setup. 
