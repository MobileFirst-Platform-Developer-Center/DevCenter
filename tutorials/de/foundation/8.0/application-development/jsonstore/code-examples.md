---
layout: tutorial
title: JSONStore-Codebeispiele
breadcrumb_title: Codebeispiele
relevantTo: [ios,android,cordova]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Cordova
{: #cordova }
#### Verbindungen initialisieren und öffnen, Zugriffsmechanismus abrufen und Daten hinzufügen
{: #initialize-and-open-connections-get-an-accessor-and-add-data }
```javascript
var collectionName = 'people';
// Objekt, das alle Sammlungen definiert
var collections = {

  // Objekt, das die Sammlung 'people' definiert
  people : {

    // Objekt, das die Suchfelder für die Sammlung 'people' definiert
    searchFields : {name: 'string', age: 'integer'}
  }
};

// Optionales Optionsobjekt
var options = {

  // Optionaler Benutzername. Standardwert: 'jsonstore'
  username : 'carlos',

  // Optionales Kennwort. Standardwert: kein Kennwort
  password : '123',

  // Optionale Option für lokale Schlüsselgenerierung. Standardwert: false
  localKeyGen : false
};

WL.JSONStore.init(collections, options)

.then(function () {

  // Hinzuzufügende Daten, die Sie wahrscheinlich mit einem
  // Netzaufruf (z. B. einem Adapter) abrufen werden
  var data = [{name: 'carlos', age: 10}];

  // Optionale Hinzufügeoptionen
  var addOptions = {

    // Daten als vorläufig markieren (true = ja, false = nein). Standardwert: true
    markDirty: true
  };

  // Zugriffsmechanismus für Sammlung 'people' abrufen und Daten hinzufügen
  return WL.JSONStore.get(collectionName).add(data, addOptions);
})

.then(function (numberOfDocumentsAdded) {
  // Das Hinzufügen war erfolgreich.
})

.fail(function (errorObject) {
   // Fehler für alle bisherigen JSONStore-Operationen (init, add) behandeln
});
```

#### Find - Dokumente im Store finden
{: #find-locate-documents-inside-the-store }
```javascript
var collectionName = 'people';
// Alle übereinstimmenden Dokumente für Abfragen finden
var queryPart1 = WL.JSONStore.QueryPart()
                   .equal('name', 'carlos')
                   .lessOrEqualThan('age', 10)

var options = {
  // Rückgabe von maximal 10 Dokumenten. Standardwert: kein Limit
  limit: 10,

  // Überspringen von 0 Dokumenten. Standard: kein Offset
  offset: 0,

  // Zurückzugebende Suchfelder. Standard: ['_id', 'json']
  filter: ['_id', 'json'],

  // Art der Sortierung für zurückgegebene Werte. Standard: keine Sortierung
  sort: [{name: WL.constant.ASCENDING}, {age: WL.constant.DESCENDING}]
};

WL.JSONStore.get(collectionName)

// Alternativen:
// - findById(1, options) zum Suchen von Dokumenten nach ihrem Feld _id
// - findAll(options) zum Zurückgeben aller Dokumente
// - find({'name': 'carlos', age: 10}, options) zum Finden aller Dokumente,
// die mit der Abfrage übereinstimmen
.advancedFind([queryPart1], options)

.then(function (arrayResults) {
  // arrayResults = [{_id: 1, json: {name: 'carlos', age: 99}}]
})

.fail(function (errorObject) {
  // Fehlerbehandlung
});
```

#### Replace - Bereits in einer Sammlung gespeicherte Dokumente ändern

```javascript 
var collectionName = 'people';
// Dokumente werden über ihr Feld '_id' gefunden
// und durch die Daten im Feld 'json' ersetzt.
var docs = [{_id: 1, json: {name: 'carlitos', age: 99}}];

var options = {

  // Daten als vorläufig markieren (true = ja, false = nein). Standardwert: true
  markDirty: true
};

WL.JSONStore.get(collectionName)

.replace(docs, options)

.then(function (numberOfDocumentsReplaced) {
  // Behandlung bei Erfolg
})

.fail(function (errorObject) {
  // Fehlerbehandlung
});
```

#### Remove - Alle mit der Abfrage übereinstimmenden Dokumente löschen
{: #remove-delete-all-documents-that-match-the-query }
```javascript
var collectionName = 'people';
// Alle übereinstimmenden Dokumente für Abfragen entfernen
var queries = [{_id: 1}];

var options = {

  // Suche nach exakter Übereinstimmung (true) oder grober Übereinstimmung (false). Standardwert: Suche nach grober Übereinstimmung
  exact: true,

  // Daten als vorläufig markieren (true = ja, false = nein). Standardwert: true
  markDirty: true
};

WL.JSONStore.get(collectionName)

.remove(queries, options)

.then(function (numberOfDocumentsRemoved) {
  // Erfolg behandeln
})

.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Count - Gesamtzahl der mit einer Abfrage übereinstimmenden Dokumente abrufen
{: #count-gets-the-total-number-of-documents-that-match-a-query }
```javascript
var collectionName = 'people';
// Übereinstimmende Dokumente für Abfrage zählen
// Mit der Standardabfrage '{}' wird jedes Dokument
// in der Sammlung gezählt.
var query = {name: 'carlos'}; 
var options = {

  // Suche nach exakter Übereinstimmung (true) oder grober Übereinstimmung (false). Standardwert: Suche nach grober Übereinstimmung
  exact: true
};

WL.JSONStore.get(collectionName)

.count(query, options)

.then(function (numberOfDocumentsThatMatchedTheQuery) {
  // Erfolg behandeln
})

.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Destroy - Daten aller Benutzer bereinigen, internen Speicher löschen und Sicherheitsartefakte entfernen
{: #destroy-wipes-data-for-all-users-destroys-the-internal-storage-and-clears-security-artifacts }
```javascript
WL.JSONStore.destroy()
.then(function () {
  // Erfolg behandeln
})

.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Sicherheit - Zugriff auf alle geöffneten Sammlungen für aktuellen Benutzer beenden
{: #security-close-access-to-all-opened-collections-for-the-current-user }
```javascript
WL.JSONStore.closeAll()
.then(function () {
  // Erfolg behandeln
})

.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Sicherheit - Kennwort für Zugriff auf einen Store ändern
{: #security-change-the-password-that-is-used-to-access-a-store }
```javascript
// Das Kennwort sollte eine Benutzereingabe sein. 
// Der Kürze halber ist es als Klartext angegeben.
var oldPassword = '123';
var newPassword = '456';

var clearPasswords = function () {
  oldPassword = null;
  newPassword = null;
};

// Wenn kein Benutzername übergeben wird, wird der Standardbenutzername 'jsonstore' verwendet.
var username = 'carlos';

WL.JSONStore.changePassword(oldPassword, newPassword, username)

.then(function () {

  // Sicherstellen, dass keine Kennwörter im Speicher bleiben
  clearPasswords();

  // Erfolg behandeln
})

.fail(function (errorObject) {

  // Sicherstellen, dass keine Kennwörter im Speicher bleiben
  clearPasswords();

  // Fehler behandeln
});
```

#### Push - Alle als vorläufig markierten Objekte abrufen, an einen Adapter senden und dann als bereinigt markieren
{: #push-get-all-documents-that-are-marked-as-dirty-send-them-to-an-adapter-and-mark-them-clean }
```javascript
var collectionName = 'people';
var dirtyDocs;
 
WL.JSONStore.get(collectionName)
 
.getAllDirty()
 
.then(function (arrayOfDirtyDocuments) {
  // Behandlung bei Erfolg von getAllDirty

  dirtyDocs = arrayOfDirtyDocuments;
 
  var procedure = 'procedure-name-1';
  var adapter = 'adapter-name';
 
  var resource = new WLResourceRequest("adapters/" + adapter + "/" + procedure, WLResourceRequest.GET);
  resource.setQueryParameter('params', [dirtyDocs]);
  return resource.send();	
})
 
.then(function (responseFromAdapter) {
  // Behandlung bei Erfolg von invokeProcedure

  // Sie können die Antwort vom Adapter prüfen und entscheiden,
  // ob Dokumente als vorläufig markiert werden sollen.
  return WL.JSONStore.get(collectionName).markClean(dirtyDocs);
})
 
.then(function () {
  // Behandlung bei Erfolg von markClean
})
 
.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Pull - Neue Daten von einem Adapter abrufen
{: #pull-get-new-data-from-an-adapter }
```javascript
var collectionName = 'people';
var adapter = 'adapter-name';
var procedure = 'procedure-name-2';
 
var resource = new WLResourceRequest("adapters/" + adapter + "/" + procedure, WLResourceRequest.GET);
 
resource.send()
 
.then(function (responseFromAdapter) {
  // Behandlung bei Erfolg von invokeProcedure

  // Im folgenden Beispiel wird angenommen, dass der Adapter als Teil des
  // invocationResult-Objekts ein arrayOfData mit den Daten zurückgibt,
  // die Sie zu der Sammlung hinzufügen möchten. (Standardmäßig
  // wird kein solches Array zurückgegeben.)
  var data = responseFromAdapter.responseJSON
 
  // Beispiel:
  // data = [{id: 1, ssn: '111-22-3333', name: 'carlos'}];

  var changeOptions = {
 
    // Im folgenden Beispiel wir vorausgesetzt, dass 'id' und 'ssn' Suchfelder sind.
    // Standardmäßig werden alle Suchfelder verwendet und
    // sind Teil der empfangenen Daten.
    replaceCriteria : ['id', 'ssn'],
 
    // Nicht in der Sammlung vorhandene Daten werden hinzugefügt. Standardwert: false
    addNew : true,
 
    // Daten als vorläufig markieren (true = ja, false = nein). Standardwert: false
    markDirty : false
  };
 
  return WL.JSONStore.get(collectionName).change(data, changeOptions);
})
 
.then(function () {
  // Behandlung bei Erfolg von change
})
 
.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Vorläufigkeit eines Dokuments überprüfen
{: #check-whether-a-document-is-dirty }
```javascript
var collectionName = 'people';
var doc = {_id: 1, json: {name: 'carlitos', age: 99}};

WL.JSONStore.get(collectionName)

.isDirty(doc)

.then(function (isDocumentDirty) {
  // Erfolg behandeln

  // isDocumentDirty - true bei Vorläufigkeit, sonst false
})

.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Anzahl vorläufiger Dokumente überprüfen
{: #check-the-number-of-dirty-documents }
```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName)

.countAllDirty()

.then(function (numberOfDirtyDocuments) {
  // Erfolg behandeln
})

.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Sammlung entfernen
{: #remove-a-collection }
```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName)

.removeCollection()

.then(function () {
  // Erfolg behandeln.

  // Hinweis: Sie müssen die API 'init' aufrufen, um die leere Sammlung wiederzuverwenden.
  // Wenn Sie nur alle enthaltenen Daten entfernen möchten, lesen Sie die Infos zur API 'clear'.
})

.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Alle Daten in einer Sammlung löschen
{: #clear-all-data-that-is-inside-a-collection }
```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName)

.clear()

.then(function () {
  // Erfolg behandeln.

  // Hinweis: Wenn Sie die Suchfelder ändern möchten, könnten Sie
  // stattdessen die API 'removeCollection' verwenden.
})

.fail(function (errorObject) {
  // Fehler behandeln
});
```

#### Transaktion starten, Daten hinzufügen, ein Dokument entfernen, Transaktion festschreiben und im Falle eines Fehlers rückgängig machen
{: transaction }
```javascript
WL.JSONStore.startTransaction()
.then(function () {
  // Behandlung bei Erfolg von startTransaction
  // Sie können jede Methode der JSONStore-API außer init,
  // destroy, removeCollection und closeAll aufrufen.

  var data = [{name: 'carlos'}];

  return WL.JSONStore.get(collectionName).add(data);
})

.then(function () {

  var docs = [{_id: 1, json: {name: 'carlos'}}];

  return WL.JSONStore.get(collectionName).remove(docs);
})

.then(function () {

  return WL.JSONStore.commitTransaction();
})

.fail(function (errorObject) {
  // Fehler für bisherige JSONStore-Operationen behandeln
  //(startTransaction, add, remove)

  WL.JSONStore.rollbackTransaction()

  .then(function () {
    // Behandlung bei Erfolg von rollback
  })

  .fail(function () {
    // Behandlung bei Fehlschlag von rollback
  })

});
```

#### Dateiinformationen abrufen
{: #get-file-information }
```javascript
WL.JSONStore.fileInfo()
.then(function (res) {
  //res => [{isEncrypted : true, name : carlos, size : 3072}]
})

  .fail(function () {
  // Fehler behandeln
});
```

#### Suche mit like, rightLike und leftLike
{: #search-with-like-rightlike-and-leftlike }
```javascript
// Alle Datensätze abgleichen, die den Suchbegriff auf beiden Seiten enthalten
// %searchString%
var arr1 = WL.JSONStore.QueryPart().like('name', 'ca');  // returns {name: 'carlos', age: 10}
var arr2 = WL.JSONStore.QueryPart().like('name', 'los');  // returns {name: 'carlos', age: 10}

// Alle Datensätze abgleichen, die den Suchbegriff auf der linken Seite und eine beliebige Zeichenfolge auf der rechten Seite enthalten
// searchString%
var arr1 = WL.JSONStore.QueryPart().rightLike('name', 'ca');  // Rückgabe {name: 'carlos', age: 10}
var arr2 = WL.JSONStore.QueryPart().rightLike('name', 'los');  // Keine Rückgabe

// Alle Datensätze abgleichen, die den Suchbegriff auf der rechten Seite und eine beliebige Zeichenfolge auf der linken Seite enthalten
// %searchString
var arr = WL.JSONStore.QueryPart().leftLike('name', 'ca');  // Keine Rückgabe
var arr2 = WL.JSONStore.QueryPart().leftLike('name', 'los');  // Rückgabe von {name: 'carlos', age: 10}
```

## iOS
{: #ios }
#### Verbindungen initialisieren und öffnen, Zugriffsmechanismus abrufen und Daten hinzufügen
{: #ios-initialize-and-open-connections-get-an-accessor-and-add-data }
```objc
// Sammlungsobjekt erstellen, das initialisiert wird
JSONStoreCollection* people = [[JSONStoreCollection alloc] initWithName:@"people"];
[people setSearchField:@"name" withType:JSONStore_String];
[people setSearchField:@"age" withType:JSONStore_Integer];

// Optionales Optionsobjekt
JSONStoreOpenOptions* options = [JSONStoreOpenOptions new];
[options setUsername:@"carlos"]; //Optional username, default 'jsonstore'
[options setPassword:@"123"]; //Optional password, default no password

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Sammlungen öffnen
[[JSONStore sharedInstance] openCollections:@[people] withOptions:options error:&error];

// Daten zur Sammlung hinzufügen
NSArray* data = @[ @{@"name" : @"carlos", @"age": @10} ];
int newDocsAdded = [[people addData:data andMarkDirty:YES withOptions:nil error:&error] intValue];
Initialize with a secure random token from the server
[WLSecurityUtils getRandomStringFromServerWithBytes:32
                 timeout:1000
                 completionHandler:^(NSURLResponse *response,
                                     NSData *data,
                                     NSError *connectionError) {

  // Bevor Sie fortfahren, möchten Sie vielleicht die Antwort
  // und den Verbindungsfehler sehen.

  // Mit den vom Generator des Servers zurückgegebenen Daten die
  // sichere willkürliche Zeichenfolge abrufen
  NSString* secureRandom = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

  JSONStoreCollection* ppl = [[JSONStoreCollection alloc] initWithName:@"people"];
  [ppl setSearchField:@"name" withType:JSONStore_String];
  [ppl setSearchField:@"age" withType:JSONStore_Integer];

  // Optionales Optionsobjekt
  JSONStoreOptions* options = [JSONStoreOptions new];
  [options setUsername:@"carlos"]; //Optional username, default 'jsonstore'
  [options setPassword:@"123"]; //Optional password, default no password
  [options setSecureRandom:secureRandom]; //Optional, default one will be generated locally

  // Zeigt auf einen Fehler, wenn er auftritt
  NSError* error = nil;

  [[JSONStore sharedInstance] openCollections:@[ppl] withOptions:options error:&error];

  // Hier folgen weitere JSONStore-Operationen (z. B. add, remove, replace usw.)
}];
```

#### Find - Dokumente im Store finden
{: #ios-find-locate-documents-inside-the-store }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Weitere find-Optionen hinzufügen (optional)
JSONStoreQueryOptions* options = [JSONStoreQueryOptions new];
[options setLimit:@10]; // Returns a maximum of 10 documents, default no limit.
[options setOffset:@0]; // Skip 0 documents, default no offset.

// Zurückzugebende Suchfelder. Standard: ['_id', 'json']
[options filterSearchField:@"_id"];
[options filterSearchField:@"json"];

// Art der Sortierung für zurückgegebene Werte. Standard: keine Sortierung
[options sortBySearchFieldAscending:@"name"];
[options sortBySearchFieldDescending:@"age"];

// Alle Dokumente finden, die mit dem Abfrageabschnitt übereinstimmen
JSONStoreQueryPart* queryPart1 = [[JSONStoreQueryPart alloc] init];
[queryPart1 searchField:@"name" equal:@"carlos"];
[queryPart1 searchField:@"age" lessOrEqualThan:@10];

NSArray* results = [people findWithQueryParts:@[queryPart1] andOptions:options error:&error];

// results = @[ @{@"_id" : @1, @"json" : @{ @"name": @"carlos", @"age" : @10}} ];

for (NSDictionary* result in results) {

  NSString* name = [result valueForKeyPath:@"json.name"]; // carlos
  int age = [[result valueForKeyPath:@"json.age"] intValue]; // 10
  NSLog(@"Name: %@, Age: %d", name, age);
}
```

#### Replace - Bereits in einer Sammlung gespeicherte Dokumente ändern
{: #ios-replace-change-the-documents-that-are-already-stored-inside-a-collection }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Alle übereinstimmenden Dokumente für Abfragen finden
NSArray* docs = @[ @{@"_id" : @1, @"json" : @{ @"name": @"carlitos", @"age" : @99}} ];


// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Ersetzung durchführen
int docsReplaced = [[people replaceDocuments:docs andMarkDirty:NO error:&error] intValue];
```

#### Remove - Alle mit der Abfrage übereinstimmenden Dokumente löschen
{: #ios-remove-delete-all-documents-that-match-the-query }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Dokument finden, dessen _id auf 1 gesetzt ist, und Dokument entfernen
int docsRemoved = [[people removeWithIds:@[@1] andMarkDirty:NO error:&error] intValue];
```

#### Count - Gesamtzahl der mit einer Abfrage übereinstimmenden Dokumente abrufen
{: #ios-count-gets-the-total-number-of-documents-that-match-a-query }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Übereinstimmende Dokumente für Abfrage zählen
// Mit der Standardabfrage @{} wird jedes Dokument
// in der Sammlung gezählt.
JSONStoreQueryPart *queryPart = [[JSONStoreQueryPart alloc] init];
[queryPart searchField:@"name" equal:@"carlos"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Zählung durchführen
int countResult = [[people countWithQueryParts:@[queryPart] error:&error] intValue];
```

#### Destroy - Daten aller Benutzer bereinigen, internen Speicher löschen und Sicherheitsartefakte entfernen
{: #ios-destroy-wipes-data-for-all-users-destroys-the-internal-storage-and-clears-security-artifacts }
```objc
// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Löschung durchführen
[[JSONStore sharedInstance] destroyDataAndReturnError:&error];
```

#### Sicherheit - Zugriff auf alle geöffneten Sammlungen für aktuellen Benutzer beenden
{: #ios-security-close-access-to-all-opened-collections-for-the-current-user }
```objc
// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Zugriff auf alle Sammlungen im Store beenden
[[JSONStore sharedInstance] closeAllCollectionsAndReturnError:&error];
```

#### Sicherheit - Kennwort für Zugriff auf einen Store ändern
{: #ios-security-change-the-password-that-is-used-to-access-a-store }
```objc
// Das Kennwort sollte eine Benutzereingabe sein.
// Der Kürze halber ist es als Klartext angegeben.
NSString* oldPassword = @"123";
NSString* newPassword = @"456";
NSString* username = @"carlos";

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Kennwortänderung durchführen
[[JSONStore sharedInstance] changeCurrentPassword:oldPassword withNewPassword:newPassword forUsername:username error:&error];

// Kennwörter aus dem Speicher entfernen
oldPassword = nil;
newPassword = nil;
```

#### Push - Alle als vorläufig markierten Objekte abrufen, an einen Adapter senden und dann als bereinigt markieren
{: #ios-push-get-all-documents-that-are-marked-as-dirty-send-them-to-an-adapter-and-mark-them-clean }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Alle als vorläufig markierten Dokumente zurückgeben
NSArray* dirtyDocs = [people allDirtyAndReturnError:&error];

// ERFORDERLICHE MASSNAHME: Hier vorläufige Dokumente behandeln
// (z. B. an einen Adapter senden)

// Vorläufige Dokumente als bereinigt markieren
int numCleaned = [[people markDocumentsClean:dirtyDocs error:&error] intValue];
```

#### Pull - Neue Daten von einem Adapter abrufen
{: #ios-pull-get-new-data-from-an-adapter }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;


// ERFORDERLICHE MASSNAHME: Daten abrufen (z. B. Adapter)
// In diesem Beispiel sind die Daten im Klartext angegeben.
NSArray* data = @[ @{@"id" : @1, @"ssn": @"111-22-3333", @"name": @"carlos"} ];


int numChanged = [[people changeData:data withReplaceCriteria:@[@"id", @"ssn"] addNew:YES markDirty:NO error:&error] intValue];
```

#### Vorläufigkeit eines Dokuments überprüfen
{: #ios-check-whether-a-document-is-dirty }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Prüfen, ob Dokument mit _id '1' vorläufig ist
BOOL isDirtyResult = [people isDirtyWithDocumentId:1 error:&error];
```

#### Anzahl vorläufiger Dokumente überprüfen
{: #ios-check-the-number-of-dirty-documents }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Prüfen, ob Dokument mit _id '1' vorläufig ist
int dirtyDocsCount = [[people countAllDirtyDocumentsWithError:&error] intValue];
```

#### Sammlung entfernen
{: #ios-remove-a-collection }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Sammlung entfernen
[people removeCollectionWithError:&error];
```

#### Alle Daten in einer Sammlung löschen
{: #ios-clear-all-data-that-is-inside-a-collection }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Sammlung entfernen
[people clearCollectionWithError:&error];
```

#### Transaktion starten, Daten hinzufügen, ein Dokument entfernen, Transaktion festschreiben und im Falle eines Fehlers rückgängig machen
{: #ios-transaction }
```objc
// Zugriffsmechanismus für eine bereits initialisierte Sammlung abrufen
JSONStoreCollection* people = [[JSONStore sharedInstance] getCollectionWithName:@"people"];

// Diese Objekte zeigen auf Fehler, wenn sie auftreten.
NSError* error = nil;
NSError* addError = nil;
NSError* removeError = nil;

// Innerhalb einer Transaktion können Sie jede Methode der JSONStore-API
// außer open, destroy, removeCollection und closeAll aufrufen.
[[JSONStore sharedInstance] startTransactionAndReturnError:&error];

[people addData:@[ @{@"name" : @"carlos"} ] andMarkDirty:NO withOptions:nil error:&addError];

[people removeWithIds:@[@1] andMarkDirty:NO error:&removeError];

if (addError != nil || removeError != nil) {

  // Store auf den Zustand zurücksetzen, den er vor dem Aufruf von startTransaction hatte
  [[JSONStore sharedInstance] rollbackTransactionAndReturnError:&error];
} else {
  // Transaktion festschreiben, um die Atomizität sicherzustellen
  [[JSONStore sharedInstance] commitTransactionAndReturnError:&error];
}
```

#### Dateiinformationen abrufen
{: #ios-get-file-information }
```objc
// Dieses Objekt zeigt auf einen Fehler, wenn er auftritt.
NSError* error = nil;

// Gibt Informationen zu Dateien zurück, die JSONStore verwendet, um Daten auf Platte zu speichern
NSArray* results = [[JSONStore sharedInstance] fileInfoAndReturnError:&error];
// => [{@"isEncrypted" : @(true), @"name" : @"carlos", @"size" : @3072}]
```

## Android
{: #android }
#### Verbindungen initialisieren und öffnen, Zugriffsmechanismus abrufen und Daten hinzufügen
{: #android-initialize-and-open-connections-get-an-accessor-and-add-data }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  // Sammlungsobjekt erstellen, das initialisiert wird
  JSONStoreCollection peopleCollection = new JSONStoreCollection("people");
  peopleCollection.setSearchField("name", SearchFieldType.STRING);
  peopleCollection.setSearchField("age", SearchFieldType.INTEGER);
  collections.add(peopleCollection);

  // Optionales Optionsobjekt
  JSONStoreInitOptions initOptions = new JSONStoreInitOptions();
  // Optionaler Benutzername. Standardwert: 'jsonstore'
  initOptions.setUsername("carlos");
  // Optionales Kennwort. Standardwert: kein Kennwort
  initOptions.setPassword("123");

  // Sammlung öffnen

  WLJSONStore.getInstance(ctx).openCollections(collections, initOptions);

  // Daten zur Sammlung hinzufügen
  JSONObject newDocument = new JSONObject("{name: 'carlos', age: 10}");
  JSONStoreAddOptions addOptions = new JSONStoreAddOptions();
  addOptions.setMarkDirty(true);
  peopleCollection.addData(newDocument, addOptions);
}
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen (init, add) behandeln
  throw ex;
} catch (JSONException ex) {
  // Fehler für JSON-Parsing behandeln
throw ex;
}
```

#### Initialisierung mit einem sicheren willkürlichen Token vom Server
{: #android-initialize-with-a-secure-random-token-from-the-server }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

// AsyncTask ausführen, weil innerhalb der Aktivität kein Netzbetrieb möglich ist
AsyncTask<Context, Void, Void> aTask = new AsyncTask<Context, Void, Void>() {
  protected Void doInBackground(Context... params) {
    final Context context = params[0];

    Anforderungs-Listener mit onSuccess-
    // und onFailure-Callback erstellen:
    WLRequestListener listener = new WLRequestListener() {
      public void onFailure(WLFailResponse failureResponse) {
        // Fehler behandeln
      }

      public void onSuccess(WLResponse response) {
        String secureRandom = response.getResponseText();

        try {
          List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
          // Sammlungsobjekt erstellen, das initialisiert wird
          JSONStoreCollection peopleCollection = new JSONStoreCollection("people");
          peopleCollection.setSearchField("name", SearchFieldType.STRING);
          peopleCollection.setSearchField("age", SearchFieldType.INTEGER);
          collections.add(peopleCollection);

          // Optionales Optionsobjekt
          JSONStoreInitOptions initOptions = new JSONStoreInitOptions();

          // Optionaler Benutzername. Standardwert: 'jsonstore'
          initOptions.setUsername("carlos");

          // Optionales Kennwort. Standardwert: kein Kennwort
          initOptions.setPassword("123");

          initOptions.setSecureRandom(secureRandom);

          // Sammlung öffnen
          WLJSONStore.getInstance(context).openCollections(collections, initOptions);

          // Hier folgen weitere JSONStore-Operationen (z. B. add, remove, replace usw.)
        }
        catch (JSONStoreException ex) {
          // Fehler für alle bisherigen JSONStore-Operationen (init, add) behandeln
          ex.printStackTrace();        }
      }
    };

    // Sichere willkürliche Zeichenfolge vom Server abrufen.
    // Länge der willkürlichen Zeichenfolge in Bytes (maximal 64 Bytes)
    int byteLength = 32;
    SecurityUtils.getRandomStringFromServer(byteLength, context, listener);
    return null;
  }
};
aTask.execute(ctx);
```

#### Find - Dokumente im Store finden
{: #android-find-locate-documents-inside-the-store }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  JSONStoreQueryParts findQuery = new JSONStoreQueryParts();
  JSONStoreQueryPart part = new JSONStoreQueryPart();
  part.addLike("name", "carlos");
  part.addLessThan("age", 99);
  findQuery.addQueryPart(part);

  // Weitere find-Optionen hinzufügen (optional)
  JSONStoreFindOptions findOptions = new JSONStoreFindOptions();

  // Rückgabe von maximal 10 Dokumenten. Standardwert: kein Limit
  findOptions.setLimit(10);
  // Überspringen von 0 Dokumenten. Standard: kein Offset
  findOptions.setOffset(0);

  // Zurückzugebende Suchfelder. Standard: ['_id', 'json']
  findOptions.addSearchFilter("_id");
  findOptions.addSearchFilter("json");

  // Art der Sortierung für zurückgegebene Werte. Standard: keine Sortierung
  findOptions.sortBySearchFieldAscending("name");
  findOptions.sortBySeachFieldDescending("age");

  // Übereinstimmende Dokumente für Abfrage finden
  List<JSONObject> results = peopleCollection.findDocuments(findQuery, findOptions);
}
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Replace - Bereits in einer Sammlung gespeicherte Dokumente ändern
{: #android-replace-change-the-documents-that-are-already-stored-inside-a-collection }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Dokumente werden über ihr Feld '_id' gefunden
  // und durch die Daten im Feld 'json' ersetzt.
  JSONObject replaceDoc = new JSONObject("{_id: 1, json: {name: 'carlitos', age: 99}}");

  // Daten als vorläufig markieren (true = ja, false = nein). Standardwert: true
  JSONStoreReplaceOptions replaceOptions = new JSONStoreReplaceOptions();
  replaceOptions.setMarkDirty(true);

  // Dokument ersetzen
  peopleCollection.replaceDocument(replaceDoc, replaceOptions);
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Remove - Alle mit der Abfrage übereinstimmenden Dokumente löschen
{: #android-remove-delete-all-documents-that-match-the-query }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Dokumente werden über ihr Feld '_id' gefunden
  int id = 1;

  JSONStoreRemoveOptions removeOptions = new JSONStoreRemoveOptions();

  // Daten als vorläufig markieren (true = ja, false = nein). Standardwert: true
  removeOptions.setMarkDirty(true);

  // Dokument ersetzen
  peopleCollection.removeDocumentById(id, removeOptions);
}
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
catch (JSONException ex) {
  // Fehler für JSON-Parsing behandeln
  throw ex;
}
```

#### Count - Gesamtzahl der mit einer Abfrage übereinstimmenden Dokumente abrufen
{: android-count-gets-the-total-number-of-documents-that-match-a-query }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Übereinstimmende Dokumente für Abfrage zählen
  JSONStoreQueryParts countQuery = new JSONStoreQueryParts();
  JSONStoreQueryPart part = new JSONStoreQueryPart();

  // Exakte Übereinstimmung
  part.addEqual("name", "carlos");
  countQuery.addQueryPart(part);

  // Dokument ersetzen
  int resultCount = peopleCollection.countDocuments(countQuery);
  JSONObject doc = peopleCollection.findDocumentById(resultCount);
  peopleCollection.replaceDocument(doc);
}
catch (JSONStoreException ex) {
  throw ex;
}
```

#### Destroy - Daten aller Benutzer bereinigen, internen Speicher löschen und Sicherheitsartefakte entfernen
{: #android-destory-wipes-data-for-all-users-destroys-the-internal-storage-and-clears-security-artifacts }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Store löschen
  WLJSONStore.getInstance(ctx).destroy();
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Sicherheit - Zugriff auf alle geöffneten Sammlungen für aktuellen Benutzer beenden
{: #android-security-close-access-to-all-opened-collections-for-the-current-user }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Zugriff auf alle Sammlungen beenden
  WLJSONStore.getInstance(ctx).closeAll();
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Sicherheit - Kennwort für Zugriff auf einen Store ändern
{: #android-security-change-the-password-that-is-used-to-access-a-store }
```java 
// Das Kennwort sollte eine Benutzereingabe sein. 
// Der Kürze halber ist es als Klartext angegeben.
String username = "carlos";
String oldPassword = "123";
String newPassword = "456";

// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  WLJSONStore.getInstance(ctx).changePassword(oldPassword, newPassword, username);
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
} 
finally {
  // Kennwörter sollten nicht im Speicher verbleiben.
  oldPassword = null;
  newPassword = null;
}
```

#### Push - Alle als vorläufig markierten Objekte abrufen, an einen Adapter senden und dann als bereinigt markieren
{: #android-push-get-all-documents-that-are-marked-as-dirty-send-them-to-an-adapter-and-mark-them-clean }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Prüfen, ob Dokument mit _id 3 vorläufig ist
  List<JSONObject> allDirtyDocuments = peopleCollection.findAllDirtyDocuments();

  // Behandlung vorläufiger Dokumente (z. B. durch Aufruf eines Adapters)

  peopleCollection.markDocumentsClean(allDirtyDocuments);
}  catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Pull - Neue Daten von einem Adapter abrufen
{: #android-pull-get-new-data-from-an-adapter }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Daten hier mit Pull-Operation extrahieren und in newDocs stellen. Für dieses Beispiel sind die Daten fest codiert.
  List<JSONObject> newDocs = new ArrayList<JSONObject>();
  JSONObject doc = new JSONObject("{id: 1, ssn: '111-22-3333', name: 'carlos'}");
  newDocs.add(doc);

  JSONStoreChangeOptions changeOptions = new JSONStoreChangeOptions();

  // Nicht in der Sammlung vorhandene Daten werden hinzugefügt. Standardwert: false
  changeOptions.setAddNew(true); 

  // Daten als vorläufig markieren (true = ja, false = nein). Standardwert: false
  changeOptions.setMarkDirty(true);

  // Im folgenden Beispiel wir vorausgesetzt, dass 'id' und 'ssn' Suchfelder sind.
  // Standardmäßig werden alle Suchfelder verwendet und
  // sind Teil der empfangenen Daten.
  changeOptions.addSearchFieldToCriteria("id");
  changeOptions.addSearchFieldToCriteria("ssn");

  int changed = peopleCollection.changeData(newDocs, changeOptions);
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
catch (JSONException ex) {
  // Fehler für JSON-Parsing behandeln
  throw ex;
}
```

#### Vorläufigkeit eines Dokuments überprüfen
{: #android-check-whetther-a-document-is-dirty }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Prüfen, ob Dokument mit ID '3' vorläufig ist
  boolean isDirty = peopleCollection.isDocumentDirty(3); 
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Anzahl vorläufiger Dokumente überprüfen
{: #android-check-the-number-of-dirty-documents }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Anzahl aller vorläufigen Dokumente in der Sammlung 'people' abrufen
  int totalDirty = peopleCollection.countAllDirtyDocuments();
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Sammlung entfernen
{: #android-remove-a-collection }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Sammlung entfernen. Das Sammlungsobjekt ist
  // ncht mehr verwendbar.
  peopleCollection.removeCollection();
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Alle Daten in einer Sammlung löschen
{: #android-clear-all-data-that-is-inside-a-collection }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  // Inhalt der Sammlung löschen
  peopleCollection.clearCollection();    
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln
  throw ex;
}
```

#### Transaktion starten, Daten hinzufügen, ein Dokument entfernen, Transaktion festschreiben und im Falle eines Fehlers rückgängig machen
{: #android-transaction }
```java
// Leeren Bereich füllen, um den Android-Anwendungskontext abzurufen
Context ctx = getContext();

try {
  // Bereits initialisierte Sammlung abrufen
  JSONStoreCollection peopleCollection  = WLJSONStore.getInstance(ctx).getCollectionByName("people");

  WLJSONStore.getInstance(ctx).startTransaction();

  JSONObject docToAdd = new JSONObject("{name: 'carlos', age: 99}");
  // Mit der Abfrage übereinstimmende Dokumente finden
  peopleCollection.addData(docToAdd);


  // Hinzugefügtes Dokument entfernen
  int id = 1;
  peopleCollection.removeDocumentById(id);

  WLJSONStore.getInstance(ctx).commitTransaction();
} 
catch (JSONStoreException ex) {
  // Fehler für alle bisherigen JSONStore-Operationen behandeln

  // Ausnahme eingetreten, die behandelt werden muss, um Schaden abzuwenden
  WLJSONStore.getInstance(ctx).rollbackTransaction();

  throw ex;
}
catch (JSONException ex) {
  // Fehler für JSON-Parsing behandeln

  // Ausnahme eingetreten, die behandelt werden muss, um Schaden abzuwenden
  WLJSONStore.getInstance(ctx).rollbackTransaction();

  throw ex;
}
```

#### Dateiinformationen abrufen
{: #android-get-file-information }
```java
Context ctx = getContext();
List<JSONStoreFileInfo> allFileInfo = WLJSONStore.getInstance(ctx).getFileInfo();

for(JSONStoreFileInfo fileInfo : allFileInfo) {
  long fileSize = fileInfo.getFileSizeBytes();
  String username = fileInfo.getUsername();
  boolean isEncrypted = fileInfo.isEncrypted();
}
```
