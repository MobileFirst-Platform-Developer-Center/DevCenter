---
layout: tutorial
title: Sichere Modellaktualisierung implementieren
breadcrumb_title: Secure Model Update
relevantTo: [iOS]
weight: 2
---

## Übersicht
{: #overview }
Wenn die sichere Modellaktualisierung funktionieren soll, muss in {{ site.data.keys.mf_server }} eine benutzerdefinierte Keystore-Datei implementiert werden und in die implementierte Clientanwendung eine Kopie des zugehörigen öffentlichen Schlüssels aufgenommen werden.

Im vorliegenden Abschnitt ist beschrieben,
wie ein öffentlicher Schlüssel an neue Clientanwendungen gebunden wird sowie an vorhandene Clientanwendungen, für die ein Upgrade durchgeführt wurde. Weitere Informationen zum Konfigurieren des
Keystores in {{ site.data.keys.mf_server }} finden Sie
unter [MobileFirst-Server-Keystore konfigurieren](../../../authentication-and-security/configuring-the-mobilefirst-server-keystore/).

Der Server stellt einen integrierten Keystore bereit, der während der Entwicklungsphasen zum Testen der sicheren Modellaktualisierung genutzt werden kann.

>**Hinweis:** Wenn Sie den öffentlichen Schlüssel an die Clientanwendung gebunden und einen neuen Anwendungsbuild erstellt haben, müssen Sie die Anwendung nicht erneut auf den {{ site.data.keys.mf_server }} hochladen. Falls Sie die Anwendung jedoch bereits ohne den öffentlichen Schlüssel auf dem Markt veröffentlicht und allgemein verfügbar gemacht haben, müssen Sie sie erneut veröffentlichen.

Für Entwicklungszwecke wird {{ site.data.keys.mf_server }} mit
dem folgenden, öffentlichen Pseudoschlüssel
bereitgestellt:

```text
-----BEGIN PUBLIC KEY-----
MIIDPjCCAiagAwIBAgIEUD3/bjANBgkqhkiG9w0BAQsFADBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxETA
PBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wgRG
V2MCAXDTEyMDgyOTExMzkyNloYDzQ3NTAwNzI3MTEzOTI2WjBgMQswCQYDVQQGEwJJTDELMAkGA1UECBMCSUwxE
TAPBgNVBAcTCFNoZWZheWltMQwwCgYDVQQKEwNJQk0xEjAQBgNVBAsTCVdvcmtsaWdodDEPMA0GA1UEAxMGV0wg
RGV2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzQN3vEB2/of7KAvuvyoIt0T7cjaSTjnOBm0N3+q
zx++dh92KpNJXj/a3o4YbwJXkJ7jU8ykjCYvjXRf0hme+HGhiIVwxJo54iqh76skDS5m7DaseFdndZUJ4p7NFVw
I5ixA36ZArSZ/Pn/ej56/RRjBeRI7AEGXUSGojBUPA6J6DYkwaXQRew9l+Q1kj4dTigyKL5Os0vNFaQyYu+bT2E
vnOixQ0DXm94IqmHZamZKbZLrWcOEfuAsSjKYOdMSM9jkCiHaKcj7fpEZhUxRRs7joKs1Ri4ihs6JeUvMEiG4gK
l9V3FP/Huy0pfkL0F8xMHgaQ4c/lxS/s3PV0OEg+7wIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAgEhhqRl2Rgkt
MJeqOCRcT3uyr4XDK3hmuhEaE0nOvLHi61PoLKnDUNryWUicK/W+tUP9jkN5xRckdzG6TJ/HPySmZ7Adr6QRFu+
xcIMY+/S8j4PHLXBjoqgtUMhkt7S2/thN/VA6mwZpw4Ol0Pa2hyT2TkhQoYYkRwYCk9pxmuBCoH/eCWpSxquNny
RwrY25x0YzccXUaMI8L3/3hzq3mW40YIMiEdpiD5HqjUDpzN1funHNQdsxEIMYsWmGAwOdV5slFzyrH+ErUYUFA
pdGIdLtkrhzbqHFwXE0v3dt+lnLf21wRPIqYHaEu+EB/A4dLO6hm+IjBeu/No7H7TBFm
-----END PUBLIC KEY-----
```

>**Wichtiger Hinweis**: Verwenden Sie den öffentlichen Schlüssel nicht für Produktionsziele.

## Keystore generieren und implementieren
{: #generating-and-deploying-the-keystore }
Für das Generieren von Zertifikaten und das
Extrahieren öffentlicher Schlüssel aus einem Keystore gibt es diverse Tools. Das folgende Beispiel veranschaulicht die Verwendung
des JDK-Dienstprogramms keytool mit openSSL.

1. Extrahieren Sie den öffentlichen Schlüssel aus der in
{{ site.data.keys.mf_server }} implementierten Keystore-Datei.   
   >**Hinweis:** Der öffentliche Schlüssel muss in Base64-Codierung vorliegen. 

   Angenommen, der Aliasname ist
*mfp-server* und die Keystore-Datei
ist `keystore.jks`.
  
Für das Generieren eines Zertifikats müssten Sie in dem Fall den folgenden Befehl absetzen: 

   ```bash
   keytool -export -alias mfp-server -file certfile.cert
   -keystore keystore.jks -storepass keypassword
   ```

   Eine Zertifikatdatei wird generiert.  
Setzen Sie den folgenden Befehl ab, um den öffentlichen Schlüssel zu extrahieren:

   ```bash
   openssl x509 -inform der -in certfile.cert -pubkey -noout
   ```

   >**Hinweis:** Nur mit keytool können öffentliche Schlüssel im Base64-Format nicht extrahiert werden.

2. Führen Sie die folgenden Schritte aus:
    * Kopieren Sie den resultierenden Text ohne `BEGIN PUBLIC KEY` und `END PUBLIC KEY`.
    * Öffnen Sie in der Clientanwendung die MobileFirst-Konfigurationsdatei (d. h. `mfpclient.plist` für iOS und `mfpclient.properties` für Android).
    * Fügen Sie den neuen Schlüsselwert `wlSecureModelUpdatePublicKey` hinzu.
    * Geben Sie den öffentlichen Schlüssel als Wert an und speichern Sie die Datei.
