---
layout: tutorial
title: Certificate Pinning
relevantTo: [ios,android,cordova]
weight: 13
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Bei der Kommunikation über öffentliche Netze ist es wesentlich, dass Informationen sicher gesendet und empfangen werden können. Ein weit verbreitetes Protokoll für den Schutz der
Kommunikation ist
SSL/TLS. (SSL bedeutet Secure Sockets Layer und TLS, der Nachfolger von SSL, bedeutet
Transport Layer Security.) SSL/TLS
verwendet digitale Zertifikate für Authentifizierung und Verschlüsselung. Damit ein Zertifikat als echt und gültig angesehen werden kann,
wird es mit einem Stammzertifikat einer anerkannten Zertifizierungsstelle digital signiert. Betriebssysteme und Browser führen Listen mit
Stammzertifikaten anerkannter Zertifizierungsstellen, sodass sie ohne großen Aufwand verifizieren können, dass Zertifikate von den
Zertifizierungsstellen ausgegeben und signiert wurden. 

Protokolle wie SSL/TLS, die sich auf die Verifizierung einer Zertifikatkette verlassen müssen, sind anfällig für eine Reihe gefährlicher Attacken, zu denen auch
Man-in-the-Middle-Attacken gehören, bei denen eine nicht autorisierte Partei den gesamten Datenverkehr, der zwischen dem mobilen Gerät und
den Back-End-Systemen übertragen wird, sehen und modifizieren kann. 

Die {{ site.data.keys.product_full }} stellt eine API bereit, die das **Certificate Pinning** ermöglicht. Sie wird in nativen iOS- und nativen Android-{{ site.data.keys.product_adj }}-Anwendungen
sowie in plattformübergreifenden Cordova-MobileFirst-Anwendungen unterstützt. 

## Certificate-Pinning-Prozess
{: #certificate-pinning-process }
Beim Certificate Pinning
wird einem Host sein erwarteter öffentlicher Schlüssel zugeordnet.
Da Sie im Besitz des serverseitigen und clientseitigen Codes sind, können Sie Ihren Clientcode so konfigurieren, dass er nur ein bestimmtes Zertifikat für Ihren Domänennamen akzeptiert und nicht irgendein Zertifikat, das mit einem Stammzertifikat einer anerkannten Zertifizierungsstelle korrespondiert und vom Betriebssystem oder Browser erkannt wurde. Eine Kopie des Zertifikats wird in Ihre Clientanwendung aufgenommen. Beim SSL-Handshake (d. h. bei der ersten Anforderung an den Server) überprüft das {{ site.data.keys.product_adj }}-Client-SDK, ob der öffentliche Schlüssel des Serverzertifikats mit dem öffentlichen Schlüssel des in der App gespeicherten Zertifikats übereinstimmt. 

Sie können auch mehrere Zertifikate mit Ihrer Clientanwendung verknüpfen. Eine Kopie aller Zertifikate sollten Sie in Ihre Clientanwendung aufnehmen. Beim SSL-Handshake (d. h. bei der ersten Anforderung an den Server) überprüft das {{ site.data.keys.product_adj }}-Client-SDK, ob der öffentliche Schlüssel des Serverzertifikats mit dem öffentlichen Schlüssel eines der in der App gespeicherten Zertifikate übereinstimmt. 

#### Wichtiger Hinweis
{: #important }
* Es kann sein, dass einige Betriebssysteme für mobile Geräte das Ergebnis der
Gültigkeitsprüfung des Zertifikats zwischenspeichern. **Bevor** Sie eine geschützte Anforderung senden, sollten Sie daher die Certificate-Pinning-API aufrufen. Andernfalls könnten die Gültigkeitsprüfung für das Zertifikat und die Pinning-Überprüfung
bei nachfolgenden Anforderungen übergangen werden. 
* Sie dürfen für die gesamte Kommunikation mit dem zugehörigen Host, auch nach dem Certificate Pinning, nur {{ site.data.keys.product }}-APIs verwenden. Wenn Sie APIs anderer Anbieter für die Interaktion mit diesem Host verwenden,
kann es zu nicht erwartetem Verhalten kommen, z. B. zum Zwischenspeichern eines nicht verifizierten Zertifikats durch das Betriebssystem für mobile Geräte. 
* Wenn die Certificate-Pinning-API-Methode ein zweites Mal aufgerufen wird, wird die vorherige Pinning-Operation außer Kraft gesetzt. 

Bei erfolgreichem Pinning-Prozess wird der öffentliche Schlüssel aus dem bereitgestellten Zertifikat
verwendet, um die Integrität des MobileFirst-Server-Zertifikats während der geschützten SSL/TLS-Handshakeanforderung zu verifizieren. Schlägt der Pinning-Prozess fehl,
werden alle an den Server gerichteten
SSL/TLS-Anforderungen von der Clientanwendung zurückgewiesen. 

## Zertifikat-Setup
{: #certificate-setup }
Sie müssen ein von einer Zertifizierungsstelle gekauftes Zertifikat verwenden. Selbst signierte Zertifikate werden **nicht unterstützt**. Aus Gründen der Kompatibilität mit den unterstützten
Umgebungen müssen Sie sicherstellen, dass das verwendete Zertifikat im **DER**-Format (Distinguished
Encoding Rules) gemäß Standard X.690 der International Telecommunications
Union codiert ist. 

Das Zertifikat muss wie folgt in
{{ site.data.keys.mf_server }} und in Ihre Anwendung aufgenommen werden: 

* {{ site.data.keys.mf_server }} (WebSphere Application Server, WebSphere Application Server Liberty oder Apache Tomcat): In der Dokumentation zu Ihrem Anwendungsserver finden Sie Informationen zum Konfigurieren von
SSL/TLS und von Zertifikaten. 
* Anwendung: 
    - Natives iOS: Fügen Sie das Zertifikat zum **Anwendungsbundle** hinzu. 
    - Natives Android: Stellen Sie das Zertifikat in den Ordner
**assets**. 
    - Cordova: Stellen Sie das Zertifikat in den Ordner **app-name\www\certificates**. (Wenn es den Ordner noch nicht gibt, erstellen Sie ihn.) 

## Certificate-Pinning-API
{: #certificate-pinning-api }
Das Certificate Pinning ist eine überladene API-Methode, bei der es eine Methode mit einem Parameter `certificateFilename` gibt, d. h. mit dem Namen der Zertifikatdatei, und eine zweite Metode mit einem Parameter `certificateFilenames`, der ein Array mit Zertifikatdateinamen angibt. 

### Android
{: #android }
Einzelnes Zertifikat:
Syntax:
pinTrustedCertificatePublicKeyFromFile(String certificateFilename);
Beispiel: 
```java
WLClient.getInstance().pinTrustedCertificatePublicKey("myCertificate.cer");
```
Mehrere Zertifikate:

Syntax:
pinTrustedCertificatePublicKeyFromFile(String[] certificateFilename);
Beispiel: 
```java
String[] certificates={"myCertificate.cer","myCertificate1.cer"};
WLClient.getInstance().pinTrustedCertificatePublicKey(certificates);
```
Die Certificate-Pinning-Methode löst in zwei Fällen eine Ausnahme aus: * Die Datei ist nicht vorhanden. 
* Die Datei hat das falsche Format. 


### iOS
{: #ios }
Syntax beim Certificate Pinning für ein einzelnes Zertifikat:
pinTrustedCertificatePublicKeyFromFile:(NSString*) certificateFilename;

Die Certificate-Pinning-Methode löst in zwei Fällen eine Ausnahme aus: 
* Die Datei ist nicht vorhanden. 
* Die Datei hat das falsche Format. 

Syntax beim Certificate Pinning für mehrere Zertifikate:
pinTrustedCertificatePublicKeyFromFiles:(NSArray*) certificateFilenames;

Die Certificate-Pinning-Methode löst in zwei Fällen eine Ausnahme aus: 
* Keine der Zertifikatdateien ist vorhanden. 
* Keine der Zertifikatdateien hat das richtige Format. 

**Objective-C:**
Beispiel:
Einzelnes Zertifikat: 
```objc
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFile:@"myCertificate.cer"];

```
Mehrere Zertifikate:
Beispiel:
```objc
NSArray *arrayOfCerts = [NSArray arrayWithObjects:@“Cert1”,@“Cert2”,@“Cert3",nil];
[[WLClient sharedInstance]pinTrustedCertificatePublicKeyFromFiles:arrayOfCerts];
```

**Swift:**

Einzelnes Zertifikat:
Beispiel:

```swift
WLClient.sharedInstance().pinTrustedCertificatePublicKeyFromFile("myCertificate.cer")
```
Mehrere Zertifikate:
Beispiel:
```swift
let arrayOfCerts : [Any] = ["Cert1", "Cert2”, "Cert3”];
WLClient.sharedInstance().pinTrustedCertificatePublicKey( fromFiles: arrayOfCerts)
```

Die Certificate-Pinning-Methode löst in zwei Fällen eine Ausnahme aus: 

* Die Datei ist nicht vorhanden. 
* Die Datei hat das falsche Format. 

### Cordova
{: #cordova }

Certificate Pinning für ein einzelnes Zertifikat: 

```javascript
WL.Client.pinTrustedCertificatePublicKey('myCertificate.cer').then(onSuccess, onFailure);
```

Certificate Pinning für mehrere Zertifikate: 

```javascript
WL.Client.pinTrustedCertificatePublicKey(['Cert1.cer','Cert2.cer','Cert3.cer']).then(onSuccess, onFailure);
```

Die Certificate-Pinning-Methode gibt eine Zusicherung zurück: 

* Die Certificate-Pinning-Methode ruft die Methode onSuccess auf, wenn das Certificate Pinning erfolgreich
war. 
* Die Certificate-Pinning-Methode löst in zwei Fällen den onFailure-Callback aus: 
* Die Datei ist nicht vorhanden. 
* Die Datei hat das falsche Format. 

Wenn später eine geschützte Anforderung an einen Server ohne fest zugeordnetes Zertifikat (Pinned Certificate) gerichtet wird,
wird der `onFailure`-Callback der jeweiligen Anforderung
(z. B. `obtainAccessToken` oder `WLResourceRequest`)
aufgerufen. 

> Weitere Informationen zur Certificate-Pinning-API-Methode
finden Sie in den [Referenzinformationen zur API](../../api/client-side-api/).
