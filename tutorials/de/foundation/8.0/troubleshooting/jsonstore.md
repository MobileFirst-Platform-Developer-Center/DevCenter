---
layout: tutorial
title: Fehlerbehebung für JSONStore
breadcrumb_title: JSONStore
relevantTo: [ios,android,cordova]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Übersicht
{: #overview }
Hier finden Sie Informationen, die Ihnen bei der Lösung von Problemen helfen, die bei Verwendung der JSONStore-API auftreten können.

## Stellen Sie beim Anfordern von Unterstützung Informationen bereit
{: #provide-information-when-you-ask-for-help }
Es ist besser, zu viele Informationen zur Verfügung zu stellen, als zu riskieren, dass nicht genug Informationen bereitgestellt wurden. Die folgende Liste ist ein guter Ausgangspunkt dafür, welche Informationen erforderlich sind, um Ihnen bei der Lösung JSONStore-Problemen behilflich sein zu können.

* Betriebssystem und Version, z. B. virtuelle Maschine mit Windows XP SP3 oder Mac OSX 10.8.3
* Eclipse-Version, z. B. Eclipse Indigo 3.7 Java EE
* JDK-Version, z. B. Java SE Runtime Environment (Build 1.7)
* Version der {{ site.data.keys.product }}, z. B. IBM Worklight Version 5.0.6 Developer Edition
* iOS-Version, z. B. iOS Simulator 6.1 oder iPhone 4S iOS 6.0 (nicht mehr verwendet; siehe "Veraltete Features und API-Elemente")
* Android-Version, z. B. Android Emulator 4.1.1 oder Samsung Galaxy Android 4.0 API-Ebene 14
* Windows-Version, z. B. Windows 8, Windows 8.1 oder Windows Phone 8.1
* ADB-Version, z. B. Android Debug Bridge Version 1.0.31
* Protokolle wie Xcode-Ausgaben unter iOS oder logcat-Ausgaben unter Android

## Versuchen Sie, das Problem zu isolieren
{: #try-to-isolate-the-issue }
Führen Sie die folgenden Schritte aus, um das Problem zu isolieren und möglichst präzise zu melden.

1. Setzen Sie den Emulator (Android) oder Simulator (iOS) zurück und rufen Sie die API "destroy" auf, um mit einem bereinigten System zu beginnen.
2. Stellen Sie sicher, dass Sie in einer unterstützten Produktionsumgebung arbeiten.
    * Android >= 2.3-Emulator oder -Gerät (ARM v7 / ARM v8 / x86)
    * iOS >= 6.0-Simulator oder -Gerät (nicht weiter unterstützt)
    * Windows-8.1/10-Simulator oder -Gerät (ARM / x86 / x64)
3. Versuchen Sie, die Verschlüsselung zu inaktivieren, indem Sie kein Kennwort an die API "init" oder "open" übergeben.
4. Sehen Sie sich die von JSONStore generierte SQLite-Datenbankdatei an. Die Verschlüsselung muss inaktiviert sein.

   * Android-Emulator:

   ```bash
   $ adb shell
   $ cd /data/data/com.<App-Name>/databases/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * iOS-Simulator:

   ```bash
   $ cd ~/Library/Application Support/iPhone Simulator/7.1/Applications/<ID>/Documents/wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```  

   * Windows-8.1-Universal- bzw. Windows-10-UWP-Simulator:

   ```bash
   $ cd C:\Users\<Benutzername>\AppData\Local\Packages\<ID>\LocalState\wljsonstore
   $ sqlite3 jsonstore.sqlite
   ```

   * **Hinweis:** Eine reine JavaScript-Implementierung, die in einem Web-Browser (Firefox, Chrome, Safari, Internet Explorer) ausgeführt wird, verwendet keine SQLite-Datenbank. Die Datei wird im lokalen HTML5-Speicher gespeichert.
   * Sehen Sie sich die Suchfelder (`searchFields`) mit `.schema` an und wählen Sie Daten mit `SELECT * FROM <Sammlungsname>;` aus. Geben Sie `.exit` ein, um sqlite3 zu beenden. Wenn Sie einen Benutzernamen an die Methode "init" übergeben, hat die Datei den Namen **Benutzername.sqlite**. Wenn Sie keinen Benutzernamen übergeben, hat die Datei standardmäßig die Bezeichnung **jsonstore.sqlite**.
5. Aktivieren Sie für JSONStore die Option "verbose" (nur Android).

   ```bash
   adb shell setprop log.tag.jsonstore-core VERBOSE
   adb shell getprop log.tag.jsonstore-core
   ```

6. Verwenden Sie den Debugger.

## Allgemeine Probleme
{: #common-issues }
Wenn Sie die folgenden JSONStore-Merkmale verstehen, können Sie einige allgemeine Probleme lösen, die auftreten könnten.  

* Die einzige Möglichkeit, Binärdaten in JSONStore zu speichern, besteht darin, sie zuerst in Base64 zu codieren. Speichern Sie Dateinamen oder Pfade anstelle der tatsächlichen Dateien in JSONStore.
* Der Zugriff auf JSONStore-Daten von nativem Code azs ist nur in {{site.data.keys.v62_product_full }} Version 6.2.0 möglich.
* Es gibt abgesehen von der Begrenzung des Betriebssystems für mobile Geräte keine Begrenzung hinsichtlich der Datenmenge, die Sie in JSONStore speichern können.
* JSONStore ist ein persistenter Datenspeicher. Die Daten werden nicht nur im Speicher aufbewahrt.
* Die API "init" schlägt fehl, wenn der Sammlungsname mit einer Ziffer oder einem Symbol beginnt. IBM Worklight Version 5.0.6.1 und aktuellere Versionen geben einen entsprechenden Fehler zurück: `4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING`
* In Suchfeldern wird zwischen Zahlen vom Typ "number" und vom Typ "integer" unterschieden. Numerische Werte wie `1` und `2` werden als `1.0` und `2.0` gespeichert, wenn der Typ `number` ist. Sie werden als `1` und `2` gespeichert, wenn der Typ `integer` ist.
* Falls eine Anwendung gestoppt werden muss oder abstürzt, lautet der Fehlercode immer -1, wenn die Anwendung erneut gestartet wird und die API `init` oder `open` aufgerufen wird. Sollte dieses Problem auftreten, rufen Sie zuerst die API `closeAll` auf.
* Die JavaScript-Implementierung von JSONStore erwartet, dass Code seriell aufgerufen wird. Warten Sie, bis eine Operation beendet ist, bevor Sie die nächste Operation aufrufen.
* Transaktionen werden nicht in Android 2.3.x für Cordova-Anwendungen unterstützt.
* Wenn Sie JSONStore auf einem 64-Bit-Gerät verwenden, wird möglicherweise der folgende Fehler angezeigt: `java.lang.UnsatisfiedLinkError: dlopen failed: "..." is 32-bit instead of 64-bit`
* Dieser Fehler bedeutet, dass es in Ihrem Android-Projekt native 64-Bit-Bibliotheken gibt. JSONStore funktioniert momentan nicht, wenn Sie diese Bibliotheken verwenden. Navigieren Sie zur Bestätigung in Ihrem Android-Projekt zu **src/main/libs** oder **src/main/jniLibs** und überprüfen Sie, ob es einen Ordner x86_64 oder arm64-v8a gibt. Ist das der Fall, löschen Sie diese Ordner, damit JSONStore wieder funktioniert.
* In einigen Fällen (oder Umgebungen) wird im Ablauf `wlCommonInit()` eingegeben, bevor das JSONStore-Plug-in initialisiert wird. Dadurch scheitern JSONStore-bezogene API-Aufrufe. Das Bootprogramm `cordova-plugin-mfp` ruft automatisch `WL.Client.init` auf, wonach die Funktion `wlCommonInit` ausgelöst wird. Dieser Initialisierungsprozess unterscheidet sich für das JSONStore-Plug-in. Das JSONStore-Plug-in hat keine Möglichkeit, den Aufruf von `WL.Client.init` zu stoppen. In verschiedenen Umgebungen kann es vorkommen, dass im Ablauf `wlCommonInit()` eingegeben wird, bevor `mfpjsonjslloaded` abgeschlossen ist. Der Entwickler kann die richtige Reihenfolge von `mfpjsonjsloaded` und `mfpjsloaded` sicherstellen, indem er `WL.CLient.init` manuell aufruft. Dadurch entfällt die Notwendigkeit für plattformspezifischen Code.

  Führen Sie die folgenden Schritte aus, um den manuellen Aufruf von `WL.CLient.init` zu konfigurieren:                             

  1. Setuem Sie in der Datei `config.xml` die Eigenschaft `clientCustomInit` auf **true**.

  + Gehen Sie in der Datei `index.js` wie folgt vor:                                    
    * Fügen Sie am Anfang der Datei die folgende Zeile hinzu:                
      ```javascript
      document.addEventListener('mfpjsonjsloaded', initWL, false);
      ```           
    * Übernehmen Sie den Aufruf von `WL.JSONStore.init` in `wlCommonInit()`.                    

    * Fügen Sie die folgende Funktion hinzu:  
    ```javascript                                         
function initWL(){                                                     
                                                             
var options = typeof wlInitOptions !== 'undefined' ? wlInitOptions
        : {};                                                                
        WL.Client.init(options);                                           
}                                                                      
```                                                                       

Auf diese Weise wird (außerhalb von 'wlCommonInit') auf das Ereignis `mfpjsonjsloaded` gewartet.
So wird sichergestellt, dass das Script geladen wurde und nachfolgend `WL.Client.init` aufruft, was wiederum `wlCommonInit` auslöst und dann `WL.JSONStore.init` aufruft.

## Store-Interna
{: #store-internals }
Es folgt ein Beispiel für die Speicherung von JSONStore-Daten.

Dieses vereinfachte Beispiel enthält folgende Schlüsselelemente:

* '_id' ist die eindeutige Kennung (z. B. AUTO INCREMENT PRIMARY KEY).
* 'json' enthält eine exakte Darstellung des zu speichernden JSON-Objekts.
* 'name' und 'age' sind Suchfelder.
* 'key' ist ein zusätzliches Suchfeld.

| _id | key | name | age | JSON |
|-----|-----|------|-----|------|
| 1   | c   | carlos | 99 | {name: 'carlos', age: 99} |
| 2   | t   | tim   | 100 | {name: 'tim', age: 100} |

Wenn Sie für die Suche eine der folgenden Abfragen oder eine Kombination dieser Abfragen verwenden: `{_id : 1}, {name: 'carlos'}`, `{age: 99}, {key: 'c'}`, wird das Dokument `{_id: 1, json: {name: 'carlos', age: 99} }` zurückgegeben.

Die übrigen internen JSONStore-Felder sind:

* `_dirty`: Bestimmt, ob das Dokument als vorläufig markiert wurde oder nicht. Dieses Feld ist nützlich, um Änderungen an den Dokumenten zu verfolgen.
* `_deleted`: Markiert, ob ein Dokument gelöscht wurde oder nicht. Dieses Feld ist nützlich, um Objekte aus der Sammlung zu entfernen, die später genutzt werden können, um mit Ihrem Back-End Änderungen zu verfolgen und zu entscheiden, ob diese entfernt werden sollen oder nicht.
* `_operation`: Zeichenfolge, die die letzte für das Dokument auszuführende Operation angibt (z. B. "replace").

## JSONStore-Fehler
{: #jsonstore-errors }
### JavaScript
{: #javascript }
JSONStore verwendet ein Fehlerobjekt, um Nachrichten zur Ursache von Fehlern zurückzugeben.

Wenn während einer JSONStore-Operation (z. B. in den Methoden `find` und `add` der Klasse `JSONStoreInstance`) ein Fehler auftritt, wird ein Fehlerobjekt zurückgegeben. Es stellt Informationen zur Ursache des Fehlers bereit.

```javascript
var errorObject = {
  src: 'find', // Fehlgeschlagene Operation
  err: -50, // Fehlercode
  msg: 'PERSISTENT\_STORE\_FAILURE', // Fehlernachricht
  col: 'people', // Sammlungsname
  usr: 'jsonstore', // Benutzername
  doc: {_id: 1, {name: 'carlos', age: 99}}, // Fehlerbezogenes Dokument
  res: {...} // Antwort vom Server
}
```

Nicht alle Schlüssel-Wert-Paare sind Teil jedes Fehlerobjekts. Der doc-Wert ist beispielsweise nur verfügbar, wenn die Operation wegen eines Dokuments fehlgeschlagen ist (z. B. wenn die Methode `remove` der Klasse `JSONStoreInstance` ein Dokument nicht entfernen konnte).

### Objective-C
{: #objective-c }
Alle APIs, die fehlschlagen können, verwenden einen Fehlerparameter mit der Adresse eines NSError-Objekts. Wenn Sie nicht über Fehler informiert werden möchten, können Sie `nil` übergeben. Wenn eine Operation fehlschlägt, wird als Adresse ein NSError mit einer Fehlerangabe und potenziell mit Benutzerinformationen (`userInfo`) angegeben. Die Benutzerinformationen können zusätzliche Details enthalten (z. B. das Dokument, das den Fehler verursacht hat).

```objc
// Dieser NSError zeigt auf einen Fehler, sobald ein solcher auftritt.
NSError* error = nil;



// Löschung durchführen
[JSONStore destroyDataAndReturnError:&error];
```

### Java
{: #java }
Alle Java-API-Aufrufe lösen je nach aufgetretenem Fehler eine bestimmte Ausnahme aus. Sie können jede Ausnahme einzeln behandeln oder `JSONStoreException` als Umbrella für alle JSONStore-Ausnahmen abfangen.

```java
try {
  WL.JSONStore.closeAll();
}

catch(JSONStoreException e) {
  // Fehlerbedingung behandeln
}
```

### Liste der Fehlercodes
{: #list-of-error-codes }
Es folgt eine Liste der allgemeinen Fehlercodes mit einer Beschreibung:

|Fehlercode | Beschreibung |
|----------------|-------------|
| -100 UNKNOWN_FAILURE | Nicht erkannter Fehler |
| -75 OS\_SECURITY\_FAILURE | Dieser Fehler steht im Zusammenhang mit der Option requireOperatingSystemSecurity. Er kann angezeigt werden, wenn die API destroy die durch die Betriebssystemsicherheit (Touch-ID mit Rückgriff auf einen Kenncode) geschützten Sicherheitsmetadaten nicht entfernen kann oder die API init bzw. open die Sicherheitsmetadaten nicht finden kann. Der Fehler kann auch auftreten, wenn das Gerät keine Unterstützung für die Betriebssystemsicherheit bietet, die Verwendung der Betriebssystemsicherheit jedoch angefordert wurde. | Versuchen Sie, zuerst die Methode open der Klasse JSONStore aufzurufen, um den Zugriff auf den Store zu ermöglichen. |
| -48 TRANSACTION\_FAILURE\_DURING\_ROLLBACK | Es gab ein Problem beim Zurücksetzen der Transaktion. |
| -47 TRANSACTION\\_FAILURE\_DURING\_REMOVE\_COLLECTION | Während einer laufenden Transaktion kann removeCollection nicht aufgerufen werden. |
| -46 TRANSACTION\_FAILURE\_DURING\_DESTROY | Während einer laufenden Transaktion kann destroy nicht aufgerufen werden. |
| -45 TRANSACTION\_FAILURE\_DURING\_CLOSE\_ALL | Wenn Transaktionen vorhanden sind, kann closeAll nicht aufgerufen werden. |
| -44 TRANSACTION\_FAILURE\_DURING\_INIT | Während laufender Transaktionen kann ein Store nicht initialisiert werden. |
| -43 TRANSACTION_FAILURE | Es gab ein Problem bei Transaktionen. |
| -42 NO\_TRANSACTION\_IN\_PROGRESS | Die Rücksetzung einer Transaktion kann nicht festgeschrieben werden, wenn keine laufende Transaktion vorhanden ist. |
| -41 TRANSACTION\_IN\_POGRESS | Während einer laufenden Transaktion kann keine neue Transaktion gestartet werden. |
| -40 FIPS\_ENABLEMENT\_FAILURE | Es gibt ein Problem mit FIPS. |
| -24 JSON\_STORE\_FILE\_INFO\_ERROR | Es gibt ein Problem beim Abrufen der Dateiinformationen aus dem Dateisystem. |
| -23 JSON\_STORE\_REPLACE\_DOCUMENTS\_FAILURE | Es gibt ein Problem beim Ersetzen von Dokumenten aus einer Sammlung. |
| -22 JSON\_STORE\_REMOVE\_WITH\_QUERIES\_FAILURE | Es gibt ein Problem beim Entfernen von Dokumenten aus einer Sammlung. |
| -21 JSON\_STORE\_STORE\_DATA\_PROTECTION\_KEY\_FAILURE | Es gibt ein Problem beim Speichern des Schutzschlüssels für Daten. |
| -20 JSON\_STORE\_INVALID\_JSON\_STRUCTURE | Es gibt ein Problem beim Indexieren der Eingabedaten. |
| -12 INVALID\_SEARCH\_FIELD\_TYPES | Vergewissern Sie sich, dass die an die Suchfelder (searchFields) übergebenen Daten vom Typ string, integer, number ider boolean sind. |
| -11 OPERATION\_FAILED\_ON\_SPECIFIC\_DOCUMENT | Eine Operation für ein Dokument-Array, z. B. die Methode "replace", kann bei der Ausführung für ein bestimmtes Dokument fehlschlagen. Das betreffende Dokument wird zurückgegeben und die Transaktion wird zurückgesetzt. Unter Android tritt dieser Fehler auch auf, wenn versucht wird, JSONStore in nicht unterstützten Architekturen zu verwenden. |
| -10 ACCEPT\_CONDITION\_FAILED | Die vom Benutzer angegebene Funktion "accept" hat "false" zurückgegeben. |
| -9 OFFSET\_WITHOUT\_LIMIT | Wenn Sie ein Offset verwenden möchten, müssen Sie ein Limit angeben. |
| -8 INVALID\_LIMIT\_OR\_OFFSET | Validierungsfehler. Eine positive ganze Zahl ist erforderlich. |
| -7 INVALID_USERNAME | Validierungsfehler (Erlaubt sind nur [A-Z] oder [a-z] oder [0-9].) |
| -6 USERNAME\_MISMATCH\_DETECTED | Für die Abmeldung muss ein JSONStore-Benutzer zuerst die Methode closeAll aufrufen. Es kann immer nur jeweils einen Benutzer geben. |
| -5 DESTROY\_REMOVE\_PERSISTENT\_STORE\_FAILED | Es gab ein Problem, als die Methode "destroy" versucht hat, die Datei mit dem Store-Inhalt zu löschen. |
| -4 DESTROY\_REMOVE\_KEYS\_FAILED | Es gab ein Problem, als die Methode "destroy" versucht hat, die Keychain (iOS) (iOS) oder gemeinsame Benutzervorgaben (Android) zu löschen. |
| -3 INVALID\_KEY\_ON\_PROVISION | An einen verschlüsselten Store wurde das falsche Kennwort übergeben. |
| -2 PROVISION\_TABLE\_SEARCH\_FIELDS\_MISMATCH | Suchfelder sind nicht dynamisch. Es ist nicht möglich, Suchfelder zu ändern, ohne die Methode "destroy" oder "removeCollection" vor der Methode "init" oder "open" mit den neuen Suchfeldern aufzurufen. Dieser Fehler kann auftreten, wenn Sie den Namen oder Typ des Suchfeldes ändern, z. B. {key: 'string'} in {key: 'number'} oder {myKey: 'string'} in {theKey: 'string'}. |
| -1 PERSISTENT\_STORE\_FAILURE | Generischer Fehler. Es gab eine Fehlfunktion im nativen Code, wahrscheinlich beim Aufrufen der Methode "init". |
| 0 SUCCESS | In einigen Fällen gibt der native JSONStore-Code 0 zurück, um Erfolg anzuzeigen. |
| 1 BAD\_PARAMETER\_EXPECTED\_INT | Validierungsfehler |
| 2 BAD\_PARAMETER\_EXPECTED\_STRING | Validierungsfehler |
| 3 BAD\_PARAMETER\_EXPECTED\_FUNCTION | Validierungsfehler |
| 4 BAD\_PARAMETER\_EXPECTED\_ALPHANUMERIC\_STRING | Validierungsfehler |
| 5 BAD\_PARAMETER\_EXPECTED\_OBJECT | Validierungsfehler |
| 6 BAD\_PARAMETER\_EXPECTED\_SIMPLE\_OBJECT | Validierungsfehler |
| 7 BAD\_PARAMETER\_EXPECTED\_DOCUMENT | Validierungsfehler |
| 8 FAILED\_TO\_GET\_UNPUSHED\_DOCUMENTS\_FROM\_DB | Die Abfrage, die alle als vorläufig markierten Dokumente auswählt, ist fehlgeschlagen. SQL-Beispiel für die Abfrage: SELECT * FROM [collection] WHERE _dirty > 0. |
| 9 NO\_ADAPTER\_LINKED\_TO\_COLLECTION | Wenn Funktionen wie die Methoden "push" und "load" der Klasse JSONStoreCollection verwendet werden sollen, muss ein Adapter an die Methode "init" übergeben werden. |
| 10 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ARRAY\_OF\_DOCUMENTS | Validierungsfehler |
| 11 INVALID\_PASSWORD\_EXPECTED\_ALPHANUMERIC\_STRING\_WITH\_LENGTH\_GREATER\_THAN\_ZERO | Validierungsfehler |
| 12 ADAPTER_FAILURE | Es gab ein Problem beim Aufrufen von WL.Client.invokeProcedure, insbesondere beim Herstellen der Verbindung zum Adapter. Dieser Fehler unterscheidet sich von einem Fehler in dem Adapter, der versucht, ein Back-End aufzurufen. |
| 13 BAD\_PARAMETER\_EXPECTED\_DOCUMENT\_OR\_ID | Validierungsfehler |
| 14 CAN\_NOT\_REPLACE\_DEFAULT\_FUNCTIONS | Das Aufrufen der Methode "enhance" der Klasse JSONStoreCollection zum Ersetzen einer vorhandenen Funktion (find und add) ist nicht zulässig. |
| 15 COULD\_NOT\_MARK\_DOCUMENT\_PUSHED | Das Dokument wird per Push-Operation an einen Adapter gesendet, aber JSONStore kann das Dokument nicht als vorläufig markieren. |
| 16 COULD\_NOT\_GET\_SECURE\_KEY | Wenn eine Sammlung mit einem Kennwort initialisiert werden soll, muss eine Verbindung zum {{ site.data.keys.mf_server }} bestehen, der ein sicheres willkürliches Token zurückgibt. Ab IBM Worklight Version 5.0.6 können Entwickler das sichere willkürliche Token generieren, indem sie über das Optionsobjekt {localKeyGen: true} an die Methode "init" übergeben. |
| 17 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER | Es konnten keine Daten geladen werden, weil WL.Client.invokeProcedure das Fehler-Callback aufgerufen hat. |
| 18 FAILED\_TO\_LOAD\_INITIAL\_DATA\_FROM\_ADAPTER\_INVALID\_LOAD\_OBJ | Das an die Methode "init" übergebene Ladeobjekt hat die Gültigkeitsprüfung nicht bestanden. |
| 19 INVALID\_KEY\_IN\_LOAD\_OBJECT | Es gab ein Problem mit dem Schlüssel, der beim Aufrufen der Methode "add" im Ladeobjekt verwendet wurde. |
| 20 UNDEFINED\_PUSH\_OPERATION | Für das Senden vorläufiger Dokumente per Push-Operation an den Server ist keine Prozedur definiert. Beispiel: Die Methoden init (neues Dokument ist vorläufig, operation = 'add') und push (findet das neue Dokument mit operation = 'add') wurden aufgerufen. In dem Adapter, der mit der Sammlung verbunden ist, wurde jedoch kein Schlüssel 'add' mit der Prozedur 'add' gefunden. Das Verbinden eines Adapters wird in der Methode "init" durchgeführt. |
| 21 INVALID\_ADD\_INDEX\_KEY | Es gab ein Problem mit zusätzlichen Suchfeldern. |
| 22 INVALID\_SEARCH\_FIELD | Eines Ihrer Suchfelder sind ungültig. Vergewissern Sie sich, dass keines Ihrer übergebenen Suchfelder _id,json,_deleted oder _operation ist. |
| 23 ERROR\_CLOSING\_ALL | Generischer Fehler. Als der native Code die Methode closeAll aufgerufen hat, trat ein Fehler auf. |
| 24 ERROR\_CHANGING\_PASSWORD | Das Kennwort kann nicht geändert werden. Das übergebene alte Kennwort war beispielsweise falsch. |
| 25 ERROR\_DURING\_DESTROY | Generischer Fehler. Als der native Code die Methode "destroy" aufgerufen hat, trat ein Fehler auf. |
| 26 ERROR\_CLEARING\_COLLECTION | Generischer Fehler. Als der native Code die Methode removeCollection aufgerufen hat, trat ein Fehler auf. |
| 27 INVALID\_PARAMETER\_FOR\_FIND\_BY\_ID | Validierungsfehler |
| 28 INVALID\_SORT\_OBJECT | Das für die Sortierung bereitgestellte Array ist ungültig, weil eines der JSON-Objekte ungültig ist. Die korrekte Syntax ist ein Array mit JSON-Objekten, in dem jedes Objekt nur eine Eigenschaft enthält. Diese Eigenschaft sucht nach dem Feld, das für die Sortierung verwendet werden soll, und prüft, ob die Sortierung auf- oder absteigend sein soll, z. B. {searchField1 : "ASC"}. |
| 29 INVALID\_FILTER\_ARRAY | Das bereitgestellte Array für das Filtern der Ergebnisse ist ungültig. Die richtige Syntax für dieses Array ist ein Array mit Zeichenfolgen, in dem jede Zeichenfolge ein Suchfeld oder ein internes JSONStore-Feld ist. Weitere Informationen enthalten die Store-Interna. |
| 30 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_OBJECTS | Gültigkeitsfehler, weil das Array kein reines Array mit JSON-Objekten ist |
| 31 BAD\_PARAMETER\_EXPECTED\_ARRAY\_OF\_CLEAN\_DOCUMENTS | Validierungsfehler |
| 32 BAD\_PARAMETER\_WRONG\_SEARCH\_CRITERIA | Validierungsfehler |
