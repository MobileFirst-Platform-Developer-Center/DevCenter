---
layout: tutorial
title: JSONStore en aplicaciones iOS
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreSwift/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Requisitos previos
{: #prerequisites }
* Lea la [Guía de aprendizaje principal de JSONStore](../)
* Asegúrese de que el SDK nativo de {{ site.data.keys.product_adj }} se haya añadido al proyecto de Xcode.
Siga la guía de aprendizaje [Adición de {{ site.data.keys.product }} SDK para aplicaciones iOS](../../../application-development/sdk/ios/).


#### Ir a:
{: #jump-to }
* [Adición de JSONStore](#adding-jsonstore)
* [Uso básico](#basic-usage)
* [Uso avanzado](#advanced-usage)
* [Aplicación de ejemplo](#sample-application)

## Adición de JSONStore
{: #adding-jsonstore }
1. Añada lo siguiente al `podfile` existente, situado en la raíz del proyecto Xcode:

   ```xml
   pod 'IBMMobileFirstPlatformFoundationJSONStore'
   ```

2. Desde la ventana de **línea de mandatos**, vaya a la raíz del proyecto Xcode y ejecute el mandato: `pod install` (tenga en cuenta que este mandato puede tardar un rato en completarse).


Siempre que desee utilizan JSONStore, asegúrese de importar la cabecera JSONStore:
  
Objective-C:

```objc
#import <IBMMobileFirstPlatformFoundationJSONStore/IBMMobileFirstPlatformFoundationJSONStore.h>
```

Swift:

```swift
import IBMMobileFirstPlatformFoundationJSONStore    
```

## Uso básico
{: #basic-usage }
### Abrir
{: #open }
Utilice `openCollections` para abrir una o varias recopilaciones de JSONStore.


Iniciar o aprovisionar una recopilación significa crear el almacenamiento persistente que contiene la recopilación y los documentos, si este no existe.
  
Este almacenamiento persistente está cifrado y si se pasa una contraseña correcta, se ejecutan los procedimientos de seguridad necesarios para hacer que los datos estén accesibles.


Para obtener más información sobre las características opcionales que es posible habilitar en el tiempo de inicialización, consulte **Seguridad, Soporte a múltiples usuarios** e **Integración de adaptadores de {{ site.data.keys.product_adj }}** en la segunda parte de esta guía de aprendizaje.


```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")

collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

do {
  try JSONStore.sharedInstance().openCollections([collection], withOptions: nil)
} catch let error as NSError {
  // handle error
}
```

### Obtener
{: #get }
Utilice `getCollectionWithName` para crear un accesor a la recopilación.
Es necesario llamar a `openCollections` antes de llamar a `getCollectionWithName`.

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)
```

La variable `collection` se puede utilizar ahora para realizar operaciones en la recopilación `people` como, por ejemplo, `add`, `find` y `replace`.


### Añadir
{: #add }
Utilice `addData` para almacenar datos como documentos dentro de una recopilación.


```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

let data = ["name" : "yoel", "age" : 23]

do  {
  try collection.addData([data], andMarkDirty: true, withOptions: nil)
} catch let error as NSError {
  // handle error
}
```

### Encontrar
{: #find }
Utilice `findWithQueryParts` para encontrar documentos dentro de una recopilación utilizando una consulta.
Utilice `findAllWithOptions` para recuperar todos los documentos dentro de una recopilación.
Utilice `findWithIds` para buscar documentos según su identificador exclusivo de documento.


```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

let options:JSONStoreQueryOptions = JSONStoreQueryOptions()
// returns a maximum of 10 documents, default: returns every document
options.limit = 10

let query:JSONStoreQueryPart = JSONStoreQueryPart()
query.searchField("name", like: "yoel")

do  {
  let results:NSArray = try collection.findWithQueryParts([query], andOptions: options)
} catch let error as NSError {
  // handle error
}
```

### Sustituir
{: #replace }
Utilice `replaceDocuments` para modificar documentos dentro de una recopilación.
El campo que se utiliza para realizar la sustitución es `_id,` el identificador exclusivo de documento.


```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

var document:Dictionary<String,AnyObject> = Dictionary()
document["name"] = "chevy"
document["age"] = 23

var replacement:Dictionary<String, AnyObject> = Dictionary()
replacement["_id"] = 1
replacement["json"] = document

do {
  try collection.replaceDocuments([replacement], andMarkDirty: true)
} catch let error as NSError {
  // handle error
}
```

En este ejemplo se supone que el documento `{_id: 1, json: {name: 'yoel', age: 23} }` está en la recopilación.


### Eliminar
{: #remove }
Utilice `removeWithIds` para suprimir un documento de una recopilación.
Los documentos no se quitan de la recopilación hasta que no llame a `markDocumentClean`.
Para obtener más información, consulte la sección **Integración de adaptadores de {{ site.data.keys.product_adj }}** más adelante en esta guía de aprendizaje.


```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
  try collection.removeWithIds([1], andMarkDirty: true)
} catch let error as NSError {
  // handle error
}
```

### Eliminar recopilación
{: #remove-collection }
Utilice `removeCollection` para suprimir todos los documentos que se almacenan dentro de una recopilación.
Esta operación es similar a descartar una tabla en términos de una base de datos.

```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
  try collection.removeCollection()
} catch let error as NSError {
  // handle error
}
```

### Destruir
{: #destroy }
Utilice `destroyData` para eliminar los siguientes datos:

* Todos los documentos
* Todas las recopilaciones
* Todos los almacenes - Consulte **Soporte a múltiples usuarios** más adelante en esta guía de aprendizaje

* Todos los artefactos de seguridad y metadatos de JSONStore - Consulte **Seguridad** más adelante en esta guía de aprendizaje 

```swift
do {
  try JSONStore.sharedInstance().destroyData()
} catch let error as NSError {
  // handle error
}
```

## Uso avanzado
{: #advanced-usage }
### Seguridad
{: #security }
Proteja todas las recopilaciones en un almacén pasando un objeto `JSONStoreOpenOptions` con una contraseña para la función `openCollections`.
Si no se pasa una contraseña, los documentos de todas las recopilaciones en el almacén no se cifran.


Algunos metadatos de seguridad se almacenan en la cadena de claves (iOS).  
El almacén se cifra con una clave AES (Advanced Encryption Standard) de 256 bits.
Todas las claves están reforzadas mediante PBKDF2 (Password-Based Key Derivation Function 2).


Utilice `closeAllCollections` para bloquear el acceso a las recopilaciones hasta que llame a `openCollections` de nuevo.
Si interpreta `openCollections` como una función de inicio de sesión, puede interpretar `closeAllCollections` como la correspondiente función de finalización de sesión.


Utilice `changeCurrentPassword` para cambiar la contraseña.

```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")
collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

let options:JSONStoreOpenOptions = JSONStoreOpenOptions()
options.password = "123"

do {
  try JSONStore.sharedInstance().openCollections([collection], withOptions: options)
} catch let error as NSError {
  // handle error
}
```

### Soporte a múltiples usuarios
{: #multiple-user-support }
Es posible crear varios almacenes con varias recopilaciones en una única aplicación de {{ site.data.keys.product_adj }}.
La función `openCollections` puede tomar un objeto de opciones con un nombre de usuario.
Si no se proporciona un nombre de usuario, el nombre de usuario predeterminado es "jsonstore".


```swift
let collection:JSONStoreCollection = JSONStoreCollection(name: "people")
collection.setSearchField("name", withType: JSONStore_String)
collection.setSearchField("age", withType: JSONStore_Integer)

let options:JSONStoreOpenOptions = JSONStoreOpenOptions()
options.username = "yoel"

do {
  try JSONStore.sharedInstance().openCollections([collection], withOptions: options)
} catch let error as NSError {
  // handle error
}
```

### Integración de adaptadores de {{ site.data.keys.product_adj }}
{: #mobilefirst-adapter-integration }
En esta sección se presupone que está familiarizado con los adaptadores.
La integración del adaptador es opcional y proporciona formas de enviar datos desde una recopilación a un adaptador y obtener datos de dicho adaptador para la recopilación.


Puede lograrlo utilizando funciones como, por ejemplo, `WLResourceRequest`.


#### Implementación de adaptador
{: #adapter-implementation }
Cree un adaptador con el nombre "**People**".
Defina sus procedimientos `addPerson`, `getPeople`, `pushPeople`, `removePerson` y `replacePerson`.

```javascript
function getPeople() {
	var data = { peopleList : [{name: 'chevy', age: 23}, {name: 'yoel', age: 23}] };
	WL.Logger.debug('Adapter: people, procedure: getPeople called.');
	WL.Logger.debug('Sending data: ' + JSON.stringify(data));
	return data;
}
function pushPeople(data) {
	WL.Logger.debug('Adapter: people, procedure: pushPeople called.');
	WL.Logger.debug('Got data from JSONStore to ADD: ' + data);
	return;
}
function addPerson(data) {
	WL.Logger.debug('Adapter: people, procedure: addPerson called.');
	WL.Logger.debug('Got data from JSONStore to ADD: ' + data);
	return;
}
function removePerson(data) {
	WL.Logger.debug('Adapter: people, procedure: removePerson called.');
	WL.Logger.debug('Got data from JSONStore to REMOVE: ' + data);
	return;
}
function replacePerson(data) {
	WL.Logger.debug('Adapter: people, procedure: replacePerson called.');
	WL.Logger.debug('Got data from JSONStore to REPLACE: ' + data);
	return;
}
```

#### Cargar datos desde el adaptador de {{ site.data.keys.product_adj }} 
{: #load-data-from-mobilefirst-adapter }
Para cargar los datos desde un adaptador MobileFirst utilice `WLResourceRequest`.


```swift
// Start - LoadFromAdapter
class LoadFromAdapter: NSObject, WLDelegate {
  func onSuccess(response: WLResponse!) {
    let responsePayload:NSDictionary = response.getResponseJson()
    let people:NSArray = responsePayload.objectForKey("peopleList") as! NSArray
    // handle success
  }

  func onFailure(response: WLFailResponse!) {
    // handle failure
  }
}
// End - LoadFromAdapter

let pull = WLResourceRequest(URL: NSURL(string: "/adapters/People/getPeople"), method: "GET")

let loadDelegate:LoadFromAdapter = LoadFromAdapter()
pull.sendWithDelegate(loadDelegate)
```

#### Obtener push necesario (documentos sucios)
{: #get-push-required-dirty-documents }
Al llamar a `allDirty` se obtiene una matriz de los denominados "documentos sucios", documentos con modificaciones locales que no existen en el sistema de fondo.


```swift
let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
  let dirtyDocs:NSArray = try collection.allDirty()
} catch let error as NSError {
  // handle error
}
```

Para evitar que JSONStore marque los documentos como "sucios", pase la opción `andMarkDirty:false` a `add`, `replace` y `remove`.


#### Hacer push a los cambios
{: #push-changes }
Para hacer push a los cambios para un adaptador, llame a `allDirty` para obtener una lista de documentos con modificaciones y, a continuación, utilizar `WLResourceRequest`.
Después de enviar los datos y recibir una respuesta satisfactoria asegúrese de llamar a `markDocumentsClean`.


```swift
// Start - PushToAdapter
class PushToAdapter: NSObject, WLDelegate {
  func onSuccess(response: WLResponse!) {
    // handle success
  }

  func onFailure(response: WLFailResponse!) {
    // handle failure
  }
}
// End - PushToAdapter

let collectionName:String = "people"
let collection:JSONStoreCollection = JSONStore.sharedInstance().getCollectionWithName(collectionName)

do {
  let dirtyDocs:NSArray = try collection.allDirty()
  let pushData:NSData = NSKeyedArchiver.archivedDataWithRootObject(dirtyDocs)

  let push = WLResourceRequest(URL: NSURL(string: "/adapters/People/pushPeople"), method: "POST")

  let pushDelegate:PushToAdapter = PushToAdapter()
  push.sendWithData(pushData, delegate: pushDelegate)

} catch let error as NSError {
  // handle error
}
```

<img alt="Imagen de la aplicación de ejemplo" src="jsonstore-ios-screen.png" style="float:right; width:240px;"/>
## Aplicación de ejemplo
{: #sample-application }
El proyecto JSONStoreSwift contiene una aplicación Swift iOS nativa que utiliza el conjunto de API de JSONStore.
  
También hay disponible un proyecto Maven de adaptador JavaScript.


[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreSwift/tree/release80) el proyecto iOS nativo.
  
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80) el proyecto Maven del adaptador.    

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.
