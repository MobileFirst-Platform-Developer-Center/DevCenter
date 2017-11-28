---
layout: tutorial
title: MobileFirst-Server-Keystore konfigurieren
breadcrumb_title: Server-Keystore konfigurieren
weight: 14
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Ein
Keystore ist ein Repository mit Sicherheitsschlüsseln und Zertifikaten, das verwendet wird, um
die Gültigkeit der an einer Netztransaktion beteiligten Parteien zu validieren und zu authentifizieren. Der Keystore von {{ site.data.keys.mf_server }}
definiert die Identität von MobileFirst-Server-Instanzen und wird zum digitalen Signieren von OAuth-Token und Paketen für direkte Aktualisierung
verwendet. Wenn ein
Adapter unter Verwendung der gegenseitigen HTTPS-Authentifizierung
(SSL) mit einem Back-End-Server kommuniziert, wird der Keystore auch verwendet, um die SSL-Clientidentität der
MobileFirst-Server-Instanz zu validieren. 

Beim Wechsel von der Entwicklung zur Produktion muss der Administrator für die Produktionssicherheit
{{ site.data.keys.mf_server }} für die Verwendung eines benutzerdefinierten
Keystores konfigurieren. Der Standard-Keystore von {{ site.data.keys.mf_server }} ist nur zur Verwendung
während der Entwicklung bestimmt. 

### Hinweise
{: #notes }
* Wenn Sie den Keystore verwenden möchten, um die Authentizität eines Pakets für direkte Aktualisierung zu verifizieren, binden Sie die
Anwendung statisch an den öffentlichen Schlüssel der MobileFirst-Server-Identität, die
im Keystore definiert ist (siehe [Sichere direkte Aktualisierung auf der Clientseite implementieren](../../application-development/direct-update)).
* Ein Rekonfigurieren des MobileFirst-Server-Keystores nach der Produktion muss gründlich überlegt werden. Eine Änderung der Konfiguation kann folgende
Auswirkungen haben: 
    * Unter Umständen muss der Client als Ersatz für ein mit dem vorherigen Keystore signiertes Token ein neues OAuth-Token anfordern. In den meisten Fällen ist dieser Prozess für die Anwendung
transparent. 
    * Wenn die Clientanwendung an einen öffentlichen Schlüssel gebunden ist, der nicht mit der MobileFirst-Server-Identität in der neuen Keystore-Konfiguration
übereinstimmt, schlägt die direkte Aktualisierung fehl. Binden Sie die Anwendung an den neuen öffentlichen Schlüssel und veröffentlichen Sie die Anwendung erneut, damit
die Anwendung weiterhin Aktualisierungen empfangen kann. Alternativ dazu können Sie die Keystore-Konfiguration erneut ändern und wieder an den öffentlichen Schlüssel anpassen, an den die Anwendung gebunden
ist (siehe [Sichere direkte Aktualisierung auf der Clientseite implementieren](../../application-development/direct-update)).
    *  Wenn bei gegenseitiger SSL-Authentifzierung der im Adapter konfigurierte Alias für die SSL-Clientidentiät und das zugehörige Kennwort
nicht im neuen Keystore gefunden werden oder nicht mit SSL-Zertifizierungen übereinstimmen, schlägt die SSL-Authentifizierung fehl. Lesen Sie hierzu die Informationen zur
Adapterkonfiguration in Schritt
2 der folgenden Prozedur. 

## Setup
{: #setup }
1. Erstellen Sie eine Java-Keystore-Datei (JKS) oder eine PKCS-12-Keystore-Datei mit einem Alias. Der Keystore muss ein Schlüsselpaar enthalten, das
die Identität Ihres
{{ site.data.keys.mf_server }} definiert.
Wenn Sie bereits eine passende Keystore-Datei haben, übergehen Sie den nächsten Schritt. 

   > **Hinweis:** Der Algorithmus für das Schlüsselpaar mit dem Alias muss vom Typ RSA sein. Nachfolgend ist erklärt, wie der
Algorithmustyp bei Verwendung des Dienstprogramms **keytool** auf RSA gesetzt wird. 

   Sie können die Keystore-Datei mit einem Tool eines anderen Anbieters erstellen. Sie können beispielsweise eine JKS-Datei generieren, indem Sie den folgenden Befehl des Java-Dienstprogramms **keytool** ausführen. (Im Befehl steht `<Keystore-Name>` für den Namen Ihres Keystores und `<Alias>` für Ihren gewählten Alias.)


   ```bash
   keytool -keystore <Keystore-Name> -genkey -alias <Alias> -keylag RSA
   ```

   Der folgende Beispielbefehl generiert eine JKS-Datei **my_company.keystore** mit dem Alias `my_alias`: 

   ```bash
   keytool -keystore my_company.keystore -genkey -alias my_alias -keyalg RSA
   ```

   Das Dienstprogramm fordert Sie zur Eingabe verschiedener Eingabeparameter auf. Sie müssen unter anderem das Kennwort für Ihre Keystore-Datei und für den Alias angeben. 

   > **Hinweis:** Sie müssen die Option `-keyalg RSA` festlegen, damit der Algorithmus für die Schlüsselgenerierung auf den Typ RSA und nicht auf den Standardtyp DSA gesetzt wird. 

   Wenn Sie den Keystore für die gegenseitige SSL-Authentifizierung zwischen
einem Adapter und einem Back-End-Server
verwenden möchten, fügen Sie außerdem
einen Alias für die SSL-Clientidentität der {{ site.data.keys.product }}
zum Keystore hinzu. Dafür können Sie dieselbe Methode wie beim Erstellen der Keystore-Datei
mit dem
Alias für die MobileFirst-Server-Identität verwenden, nur dass Sie jetzt den Alias und das Kennwort für die SSL-Clientidentität angeben müssen. 

2. Konfigurieren Sie {{ site.data.keys.mf_server }} wie folgt für die Verwendung Ihres Keystores:
   Führen Sie die unten stehenden Schritte aus, um {{ site.data.keys.mf_server }} für die Verwendung Ihres Keystores zu konfigurieren. 

      * **Javascript-Adapter**
        Wählen Sie in der Navigationsseitenleiste der {{ site.data.keys.mf_console }} **Laufzeiteinstellungen** aus. Wählen Sie dann die Registerkarte **Keystore** aus. Folgen Sie den Anweisungen auf dieser Registerkarte, um Ihren
benutzerdefinierten MobileFirst-Server-Keystore zu konfigurieren.
Unter anderem müssen Sie Ihre Keystore-Datei hochladen und folgende Angaben machen:
Typ des Keystores, Ihr Keystore-Kennwort,
Alias für Ihre
MobileFirst-Server-Identität und Kennwort für den Alias. Bei erfolgreicher Konfiguration ändert sich der **Status** in *Benutzerdefiniert*. Andernfalls wird ein Fehler angezeigt und der Status *Standard* ändert sich nicht.
        Der Alias für die SSL-Clientidentität (falls verwendet) und das zugehörige Kennwort werden in der Deskriptordatei des betreffenden Adapters in den Unterelementen `<sslCertificateAlias>` und `<sslCertificatePassword>` des Elements `<connectionPolicy>` konfiguriert (siehe [Element 'connectionPolicy' des HTTP-Adapters](../../adapters/javascript-adapters/js-http-adapter/#the-xml-file)).

      * **Java-Adapter**
        Zum Konfigurieren der gegenseitigen SSL-Authentifizierung für einen Java-Adapter müssen Sie den Server-Keystore aktualisieren. Dies kann durch die folgenden Schritte geschehen: 

        * Kopieren Sie die Keystore-Datei nach `<Serverinstallationsverzeichnis>/mfp-server/usr/servers/mfp/resources/security`.

        * Bearbeiten Sie die Datei `server.xml` (`<Serverinstallationsverzeichnis>/mfp-server/usr/servers/mfp/server.xml`).

        * Aktualisieren Sie die Keystore-Konfiguration mit dem richtigen Dateinamen, Kennwort und Typ (`<keyStore id=“defaultKeyStore” location=<Keystore-Name> password=<Keystore-Kennwort> type=<Keystore-Typ> />`). 

Wenn Sie für die Implementierung den {{ site.data.keys.mf_bm_short}} Service in Bluemix verwenden, können Sie die Keystore-Datei vor der Implementierung des Servers unter **Erweiterte Einstellungen** hochladen. 
