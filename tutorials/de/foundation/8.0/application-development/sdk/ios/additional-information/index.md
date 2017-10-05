---
layout: tutorial
title: Zusätzliche Informationen
breadcrumb_title: Zusätzliche Informationen
relevantTo: [ios]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Bitcode in iOS-Apps verwenden
{: #working-with-bitcode-in-ios-apps }
* Die Sicherheitsüberprüfung der Anwendungsauthentizität wird nicht
mit Bitcode unterstützt. 
* Für watchOS-Anwendungen muss Bitcode aktiviert sein. 

Navigieren Sie zum Aktivieren von Bitcode in Ihrem Xcode-Projekt zur Registerkarte **Build Settings** und setzen Sie **Enable Bitcode** auf **Yes**.

### TLS-gesicherte Verbindungen in iOS-Apps erzwingen
{: #enforcing-tls-secure-connections-in-ios-apps }
Ab iOS 9 muss in allen Apps TLS (Transport Layer Security) Version 1.2 umgesetzt werden. Für Entwicklungszwecke können Sie dieses
Protokoll inaktivieren und diese Anforderung von iOS 9 umgehen. 

Apple ATS (App Transport Security) ist ein neues Feature von iOS 9, das für Verbindungen zwischen der App und dem Server
bewährte Verfahren umsetzt. Standardmäßig werden mit diesem Feature bestimmte Verbindungsvoraussetzungen
zur Erhöhung der Sicherheit durchgesetzt. Dazu gehören clientseitige HTTPS-Anforderungen
und serverseitige Zertifikate und Verbindungsschlüssel gemäß Transport Layer Security (TLS) Version 1.2 mit zukunftssicherer Geheimhaltung. 

Für **Entwicklungszwecke** können Sie das Standardverhalten außer Kraft setzen und in der Datei info.plist Ihrer App eine
Ausnahme angeben (siehe "App Transport Security Technote"). In einer **reinen Produktionsumgebung** funktionieren jedoch sämtliche iOS-Apps nur,
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
4. Legen Sie Einstellungen für Verschlüsselungen und Zertifikate fest, soweit sie in Ihrem Setup anwendbar sind. Weitere Informationen
finden Sie im [technischen Hinweis zu ATS (App Transport Security)](https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/),
unter [Secure communications using Secure Sockets
Layer (SSL)](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.nd.doc/ae/csec_sslsecurecom.html?cp=SSAW57_8.5.5%2F1-8-2-33-4-0&lang=en) und unter [Enabling SSL communication
in Liberty](http://www-01.ibm.com/support/knowledgecenter/SSAW57_8.5.5/com.ibm.websphere.wlp.nd.doc/ae/twlp_sec_ssl.html?cp=SSAW57_8.5.5%2F1-3-11-0-4-1-0). 

### OpenSSL für iOS aktivieren
{: #enabling-openssl-for-ios }
Das {{ site.data.keys.product_adj }}-iOS-SDK verwendet
für die Verschlüsselung native iOS-APIs. Sie können
die {{ site.data.keys.product_full }} so konfigurieren, dass
in iOS-Apps die OpenSSL-Verschlüsselungsbibliothek verwendet wird. 

Die Verschlüsselung/Entschlüsselung erfolgt mit den
APIs
`WLSecurityUtils.encryptText()` und
`WLSecurityUtils.decryptWithKey()`. 

#### Option 1: Native Verschlüsselung und Entschlüsselung
{: #option-1-native-encryption-and-decryption }
Für die native Ver- und Entschlüsselung wird standardmäßig kein OpenSSL verwendet. Die entspricht der folgenden expliziten Festlegung des
Ver- und Entschlüsselungsverhaltens: 

```xml
WLSecurityUtils enableOSNativeEncryption:YES
```

#### Option 2: OpenSSL aktivieren
{: #option-2-enabling-openssl }
OpenSSL
ist standardmäßig inaktiviert. Gehen Sie für die Aktivierung wie folgt vor: 

1. Installieren Sie die OpenSSL-Frameworks:
    * CocoaPods: Installieren Sie mit CocoaPods den Pod `IBMMobileFirstPlatformFoundationOpenSSLUtils`. 
    * Xcode: Verbinden Sie die Frameworks `IBMMobileFirstPlatformFoundationOpenSSLUtils` und "openssl" manuell im Abschnitt "Link Binary With Libraries" der Registerkarte "Build Phases".
2. Mit dem folgenden Code wird die OpenSSL-Option für die Verschlüsselung/Entschlüsselung aktiviert:

   ```xml
   WLSecurityUtils enableOSNativeEncryption:NO
   ```
    
   Wenn der Code jetzt die
OpenSSL-Implementierung findet, wird er sie verwenden. Sind die Frameworks nicht ordnungsgemäß installiert, gibt der Code einen Fehler aus. 

Bei diesem Setup verwenden
die Verschlüsselungs-/Entschlüsselungsaufrufe OpenSSL wie in
früheren Vorgängerversionen des Produkts. 

### Migrationsoptionen
{: #migration-options }
Wenn Sie ein Projekt in einer früheren Version der {{ site.data.keys.product_adj }}
geschrieben haben, müssen Sie möglicherweise einige Änderungen vornehmen, um OpenSSL weiter verwenden zu können. 
    * Wenn die Anwendung keine Verschlüsselungs-/Entschlüsselungs-APIs verwendet, und keine verschlüsselten Daten auf dem Gerät zwischengespeichert werden, ist keine
Aktion erforderlich. 
    * Verwendet die Anwendung Verschlüsselungs-/Enschlüsselungs-APIs, können Sie diese APIs mit oder ohne OpenSSL nutzen. 

#### Umstellung auf native Verschlüsselung
{: #migrating-to-native-encryption }
1. Stellen Sie sicher, dass die Standardoption für native Verschlüsselung/Entschlüsselung ausgewählt ist (siehe Option 1). 
2. Umstellung zwischengespeicherter Daten: Wenn in der bisherigen Installation der
{{ site.data.keys.product_full }} verschlüsselte Daten mit OpenSSL
auf dem Gerät gespeichert wurden, müssen die OpenSSL-Frameworks wie unter
Option 2 beschrieben installiert werden. Wenn die Anwendung zum ersten Mal versucht, Daten zu entschlüsseln, wird sie wie gewohnt auf
OpenSSL zurückgreifen, für die Verschlüsselung dann aber die native Verschlüsselung verwenden. Wenn das OpenSSL-Framework nicht installiert ist, wird ein Fehler
ausgelöst. Auf diese Weise werden die Daten automatisch auf die native Verschlüsselung umgestellt. Außerdem ist es so möglich, dass spätere Releases ohne das OpenSSL-Framework
funktionieren können. 

#### Weiterverwendung von OpenSSL
{: #continuing-with-openssl }
Wenn OpenSSL erforderlich ist, verwenden Sie das unter Option
2 beschriebene Setup. 
