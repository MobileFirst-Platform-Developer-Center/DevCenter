---
layout: tutorial
title: JSONStore-Sicherheitsdienstprogramme
breadcrumb_title: Sicherheitsdienstprogramme
relevantTo: [ios,android,cordova]
weight: 4
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
Die clientseitige {{ site.data.keys.product_full }}-API stellt einige Sicherheitsdienstprogramme
für den Schutz Ihrer Benutzerdaten bereit.
Ein Feature wie JSONStore ist bestens geeignet, wenn Sie JSON-Objekte schützen möchten.
Für das Speichern großer Binärobjekte (BLOBs) in einer JSONStore-Sammlung ist es jedoch nicht
zu empfehlen.

Speichern Sie Binärdaten stattdessen im Dateisystem und die Dateipfade und andere Metadaten in einer
JSONStore-Sammlung. Wenn Sie beispielsweise Bilddateien schützen möchten, können Sie diese als Base64-Zeichenfolgen codieren, dann verschlüsseln und die Ausgabe
auf die Festplatte schreiben. Ist es notwendig, die Daten zu entschlüsseln, können Sie die Metadaten in einer
JSONStore-Sammlung finden, die verschlüsselten Daten von der Platte lesen und dann mit den gespeicherten Metadaten entschlüsseln. Zu diesen Metadaten können der Schlüssel, das Salt, der IV (Initialisierungsvektor),
der Dateityp, der Pfad zur Datei und andere gehören.

Als übergeordnete API stellt SecurityUtils die folgenden
APIs bereit:

* Schlüsselgenerierung: Die Funktion für Schlüsselgenerierung übergibt ein Kennwort nicht direkt an die Verschlüsselungsfunktion, sondern
generiert mit PBKDF2 (Password Based
Key Derivation Function v2) einen 256-Bit-Schlüssel für die Verschlüsselungs-API. Die Funktion akzeptiert einen Parameter für die Anzahl der Iterationen.
Je größer diese Anzahl ist, desto länger würde ein Angreifer benötigen, um Ihren Schlüssel zu knacken. Verwenden Sie mindestens einen Wert von 1.000. Das Salt
muss eindeutig sein und macht es Angreifern schwer, Ihr Kennwort mit vorhandenen Hashinformationen zu entschlüsseln. Verwenden Sie eine Länge von 32 Bytes.
* Verschlüsselung: Die Eingabe wird nach AES (Advanced Encryption
Standard) verschlüsselt. Die API verwendet einen Schlüssel, der von der API für Schlüsselgenerierung generiert wurde. Intern generiert sie einen sicheren IV, der die Randomisierung der ersten
Blockchiffre verstärkt. Text wird verschlüsselt.
Wenn Sie ein Bild oder ein anderes Binärformat verschlüsseln möchten, wandeln Sie Ihre Binärdaten mit diesen APIs in
Base64-Text um. Diese Verschlüsselungsfunktion gibt ein aus folgenden Teilen bestehendes Objekt zurück:
    * ct (Chiffrentext oder auch verschlüsselter Text)
    * IV
    * v (Version, um die Weiterentwicklung der API bei gleichzeitig weiter bestehender Kompatibilität mit einer früheren Version
zu ermöglichen)
* Entschlüsselung: Die Ausgabe der Verschlüsselungs-API wird als Eingabe verwendet. Die Chiffre oder der verschlüsselte Text wird als
Klartext entschlüsselt.
* Ferne willkürliche Zeichenfolge: Über den Kontakt zu einem Zufallsgenerator auf dem
{{ site.data.keys.mf_server }} wird eine willkürliche hexadezimale Zeichenfolge abgerufen.
Die Standardlänge liegt bei 20 Bytes. Sie können diesen Wert aber auf bis zu
64 Bytes erhöhen.
* Lokale willkürliche Zeichenfolge: Im Gegensatz zur API für die ferne Zeichenfolge, die Netzzugriff erfordert, wird hier lokal eine
willkürliche
hexadezimale Zeichenfolge generiert und abgerufen. Die Standardlänge liegt bei 32 Bytes. Es gibt keinen Maximalwert.
Die Operationszeit steigt proportional mit der Bytezahl.
* Base64-Codierung: Diese API wendet auf eine Zeichenfolge die Base64-Codierung an. Aufgrund des verwendeten Algorithmus bedeutet
eine Base64-Codierung, dass sich die Größe der ursprünglichen Daten um etwa das 1,37-Fache erhöht.
* Base64-Decodierung: Diese API wendet auf eine Base64-codierte Zeichenfolge die Base64-Decodierung an.

## Setup
Sie müssen die folgenden Dateien importieren, um die APIs der JSONStore-Sicherheitsdienstprogramme verwenden zu können.

### iOS

```objc
#import "WLSecurityUtils.h"
```

### Android

```java
import com.worklight.wlclient.api.SecurityUtils
```

### JavaScript
Es ist kein Setup erforderlich.

## Beispiele
### iOS
#### Ver- und Entschlüsselung

```objc
// Vom Benutzer angegebenes Kennwort, aus Gründen der Einfachheit im Klartext
NSString* password = @"HelloPassword";

// Zufälliges Salt mit empfohlener Länge
NSString* salt = [WLSecurityUtils generateRandomStringWithBytes:32];

// Empfohlene Anzahl Iterationen
int iterations = 10000;

// Eintrag eines Fehlers, sofern einer auftritt
NSError* error = nil;

// Aufruf, der den Schlüssel generiert
NSString* key = [WLSecurityUtils generateKeyWithPassword:password
                                 andSalt:salt
                                 andIterations:iterations
                                 error:&error];

// Text, der verschlüsselt wird
NSString* originalString = @"My secret text";
NSDictionary* dict = [WLSecurityUtils encryptText:originalString
                                      withKey:key
                                      error:&error];

// Zurückgegeben werden sollte: 'My secret text'.
NSString* decryptedString = [WLSecurityUtils decryptWithKey:key
                                             andDictionary:dict
                                             error:&error];
```

#### Base64-Codierung und -Decodierung

```objc
// Eingabezeichenfolge
NSString* originalString = @"Hello world!";

// In Base64 codieren
NSData* originalStringData = [originalString dataUsingEncoding:NSUTF8StringEncoding];
NSString* encodedString = [WLSecurityUtils base64StringFromData:originalStringData length:originalString.length];

// Zurückgegeben werden sollte: 'Hello world!'.
NSString* decodedString = [[NSString alloc] initWithData:[WLSecurityUtils base64DataFromString:encodedString] encoding:NSUTF8StringEncoding];
```

#### Ferne willkürliche Zeichenfolge abrufen

```objc
[WLSecurityUtils getRandomStringFromServerWithBytes:32 
                 timeout:1000
                 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

  // Bevor Sie fortfahren, möchten Sie vielleicht die Antwort und den Verbindungsfehler sehen.

  // Sichere willkürliche Zeichenfolge abrufen
  NSString* secureRandom = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}];
```

### Android
#### Ver- und Entschlüsselung

```java
String password = "HelloPassword";
String salt = SecurityUtils.getRandomString(32);
int iterations = 10000;

String key = SecurityUtils.generateKey(password, salt, iterations);

String originalText = "Hello World!";

JSONObject encryptedObject = SecurityUtils.encrypt(key, originalText);

// Der entschlüsselte Text stimmt mit dem ursprünglichen Text überein.
String decipheredText = SecurityUtils.decrypt(key, encryptedObject);
```

#### Base64-Codierung und -Decodierung

```java
import android.util.Base64;

String originalText = "Hello World";
byte[] base64Encoded = Base64.encode(text.getBytes("UTF-8"), Base64.DEFAULT);

String encodedText = new String(base64Encoded, "UTF-8");

byte[] base64Decoded = Base64.decode(text.getBytes("UTF-8"), Base64.DEFAULT);

// Der decodierte Text stimmt mit dem ursprünglichen Text überein.
String decodedText = new String(base64Decoded, "UTF-8");
```

#### Ferne willkürliche Zeichenfolge abrufen

```java
Context context; // Dies ist der Kontext der aktuellen Aktivität.
int byteLength = 32;

// Wenn der Listener die Antwort vom Server erhalten hat, ruft er die Callback-Funktionen auf.
WLRequestListener listener = new WLRequestListener(){
  @Override
  public void onSuccess(WLResponse wlResponse) {
    // Erfolgs-Handler implementieren
  }

  @Override
  public void onFailure(WLFailResponse wlFailResponse) {
    // Fehler-Handler implementieren
    }
};

SecurityUtils.getRandomStringFromServer(byteLength, context, listener);
```

#### Lokale willkürliche Zeichenfolge abrufen

```java
int byteLength = 32;
String randomString = SecurityUtils.getRandomString(byteLength);
```

### JavaScript
#### Ver- und Entschlüsselung

```javascript
// Balassen Sie den Schlüssel in einer Variablen, damit er an die Ver- und Entwchlüsselungs-API übergeben werden kann.
var key;

// Schlüssel generieren
WL.SecurityUtils.keygen({
  password: 'HelloPassword',
  salt: Math.random().toString(),
  iterations: 10000
})

.then(function (res) {

  // Schlüsselvariable aktualisieren
  key = res;

  // Text verschlüsseln
  return WL.SecurityUtils.encrypt({
    key: key,
    text: 'My secret text'
  });
})

.then(function (res) {

  // Schlüssel zum Ergebnisobjekt der Verschlüsselung hinzufügen
  res.key = key;

  // Entschlüsseln
  return WL.SecurityUtils.decrypt(res);
})

.then(function (res) {

  // Schlüssel aus dem Speicher entfernen
  key = null;

  //res => 'My secret text'
})

.fail(function (err) {
  // Fehler in den zuvor aufgerufenen APIs behandeln
});
```

#### Base64-Codierung und -Decodierung

```javascript
WL.SecurityUtils.base64Encode('Hello World!')
.then(function (res) {
  return WL.SecurityUtils.base64Decode(res);
})
.then(function (res) {
  //res => 'Hello World!'
})
.fail(function (err) {
  // Fehlerbehandlung
});
```

#### Ferne willkürliche Zeichenfolge abrufen

```javascript
WL.SecurityUtils.remoteRandomString(32)
.then(function (res) {
  // res => deba58e9601d24380dce7dda85534c43f0b52c342ceb860390e15a638baecc7b
})
.fail(function (err) {
  // Fehlerbehandlung
});
```

#### Lokale willkürliche Zeichenfolge abrufen

```javascript
WL.SecurityUtils.localRandomString(32)
.then(function (res) {
  // res => 40617812588cf3ddc1d1ad0320a907a7b62ec0abee0cc8c0dc2de0e24392843c
})
.fail(function (err) {
  // Fehlerbehandlung
});
```
