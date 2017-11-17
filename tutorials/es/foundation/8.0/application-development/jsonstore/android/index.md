---
layout: tutorial
title: JSONStore en aplicaciones Android
breadcrumb_title: Android
relevantTo: [android]
weight: 3
downloads:
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Requisitos previos
{: #prerequisites }

* Lea la [Guía de aprendizaje principal de JSONStore](../)
* Asegúrese de que el SDK nativo de {{ site.data.keys.product_adj }} se haya añadido al proyecto de Android Studio.
Siga la guía de aprendizaje [Adición de {{ site.data.keys.product }} SDK para aplicaciones Android](../../../application-development/sdk/android/).


#### Ir a:
{: #jump-to }
* [Adición de JSONStore](#adding-jsonstore)
* [Uso básico](#basic-usage)
* [Uso avanzado](#advanced-usage)
* [Aplicación de ejemplo](#sample-application)

## Adición de JSONStore
{: #adding-jsonstore }
1. En **Android → Scripts de Gradle**, seleccione el archivo **build.gradle (Módulo: app)**.


2. Añada lo siguiente a la sección de `dependencies` existente:


```
compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundationjsonstore:8.0.+'
```

## Uso básico
{: #basic-usage }
### Abrir
{: #open }
Utilice `openCollections` para abrir una o varias recopilaciones de JSONStore.


Iniciar o aprovisionar una recopilación significa crear el almacenamiento persistente que contiene la recopilación y los documentos, si este no existe.
Este almacenamiento persistente está cifrado y si se pasa una contraseña correcta, se ejecutan los procedimientos de seguridad necesarios para hacer que los datos estén accesibles.


Para obtener más información sobre las características opcionales que es posible habilitar en el tiempo de inicialización, consulte **Seguridad, Soporte a múltiples usuarios** e **Integración de adaptadores de {{ site.data.keys.product_adj }}** en la segunda parte de esta guía de aprendizaje.


```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  WLJSONStore.getInstance(context).openCollections(collections);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Obtener
{: #get }
Utilice `getCollectionByName` para crear un accesor a la recopilación.
Es necesario llamar a `openCollections` antes de llamar a `getCollectionByName`.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

La variable `collection` se puede utilizar ahora para realizar operaciones en la recopilación `people` como, por ejemplo, `add`, `find` y `replace`.


### Añadir
{: #add }
Utilice `addData` para almacenar datos como documentos dentro de la recopilación. 

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  //Add options.
  JSONStoreAddOptions options = new JSONStoreAddOptions();
  options.setMarkDirty(true);
  JSONObject data = new JSONObject("{age: 23, name: 'yoel'}")
  collection.addData(data, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Encontrar
{: #find }
Utilice `findDocuments` para encontrar documentos dentro de una recopilación utilizando una consulta.
Utilice `findAllDocuments` para recuperar todos los documentos dentro de una recopilación.
Utilice `findDocumentById` para buscar documentos según su identificador exclusivo de documento. 

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreQueryPart queryPart = new JSONStoreQueryPart();
  // fuzzy search LIKE
  queryPart.addLike("name", name);
  JSONStoreQueryParts query = new JSONStoreQueryParts();
  query.addQueryPart(queryPart);
  JSONStoreFindOptions options = new JSONStoreFindOptions();
  // returns a maximum of 10 documents, default: returns every document
  options.setLimit(10);
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> results = collection.findDocuments(query, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Sustituir
{: #replace }
Utilice `replaceDocument` para modificar documentos dentro de una recopilación.
El campo que se utiliza para realizar la sustitución es `_id,` el identificador exclusivo de documento.


```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreReplaceOptions options = new JSONStoreReplaceOptions();
  // mark data as dirty
  options.setMarkDirty(true);
  JSONStore replacement = new JSONObject("{_id: 1, json: {age: 23, name: 'chevy'}}");
  collection.replaceDocument(replacement, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

En este ejemplo se supone que el documento `{_id: 1, json: {name: 'yoel', age: 23} }` está en la recopilación.


### Eliminar
{: #remove }
Utilice `removeDocumentById` para suprimir un documento de una recopilación.
Los documentos no se quitan de la recopilación hasta que no llame a `markDocumentClean`.
Para obtener más información, consulte la sección **Integración de adaptadores de {{ site.data.keys.product_adj }}** más adelante en esta guía de aprendizaje.


```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  JSONStoreRemoveOptions options = new JSONStoreRemoveOptions();
  // Mark data as dirty
  options.setMarkDirty(true);
  collection.removeDocumentById(1, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Eliminar recopilación
{: #remove-collection }
Utilice `removeCollection` para suprimir todos los documentos que se almacenan dentro de una recopilación.
Esta operación es similar a descartar una tabla en términos de una base de datos.

```java
Context context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  collection.removeCollection();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

### Destruir
{: #destroy }
Utilice `destroy` para eliminar los siguientes datos:

* Todos los documentos
* Todas las recopilaciones
* Todos los almacenes - Consulte **Soporte a múltiples usuarios** más adelante en esta guía de aprendizaje 
* Todos los artefactos de seguridad y metadatos de JSONStore - Consulte **Seguridad** más adelante en esta guía de aprendizaje 

```java
Context context = getContext();
try {
  WLJSONStore.getInstance(context).destroy();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

## Uso avanzado
{: #advanced-usage }
### Seguridad
{: #security }
Proteja todas las recopilaciones en un almacén pasando un objeto `JSONStoreInitOptions` con una contraseña para la función `openCollections`.
Si no se pasa una contraseña, los documentos de todas las recopilaciones en el almacén no se cifran.


Algunos metadatos de seguridad se almacenan en las preferencias compartidas (Android).  
El almacén se cifra con una clave AES (Advanced Encryption Standard) de 256 bits.
Todas las claves están reforzadas mediante PBKDF2 (Password-Based Key Derivation Function 2).


Utilice `closeAll` para bloquear el acceso a las recopilaciones hasta que llame a `openCollections` de nuevo.
Si interpreta `openCollections` como una función de inicio de sesión, puede interpretar `closeAll` como la correspondiente función de finalización de sesión.


Utilice `changePassword` para cambiar la contraseña.

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setPassword("123");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

#### Soporte a múltiples usuarios
{: #multiple-user-support }
Es posible crear varios almacenes con varias recopilaciones en una única aplicación de {{ site.data.keys.product_adj }}.
La función `openCollections` puede tomar un objeto de opciones con un nombre de usuario.
Si no se proporciona un nombre de usuario, el predeterminado es ""**jsonstore**"".

```java
Context context = getContext();
try {
  JSONStoreCollection people = new JSONStoreCollection("people");
  people.setSearchField("name", SearchFieldType.STRING);
  people.setSearchField("age", SearchFieldType.INTEGER);
  List<JSONStoreCollection> collections = new LinkedList<JSONStoreCollection>();
  collections.add(people);
  JSONStoreInitOptions options = new JSONStoreInitOptions();
  options.setUsername("yoel");
  WLJSONStore.getInstance(context).openCollections(collections, options);
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

#### Integración de adaptadores de {{ site.data.keys.product_adj }}
{: #mobilefirst-adapter-integration }
En esta sección se presupone que está familiarizado con los adaptadores.
La integración del adaptador es opcional y proporciona formas de enviar datos desde una recopilación a un adaptador y obtener datos de dicho adaptador para la recopilación.
Puede lograrlo utilizando funciones como, por ejemplo, `WLResourceRequest` o su propia instancia de `HttpClient` si necesita más flexibilidad.


#### Implementación de adaptador
{: #adapter-implementation }
Cree un adaptador con el nombre "**JSONStoreAdapter**".
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
Para cargar datos desde un adaptador utilice `WLResourceRequest`.

```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // handle failure
  }
  @Override
  public void onSuccess(WLResponse response) {
    try {
      JSONArray loadedDocuments = response.getResponseJSON().getJSONArray("peopleList");
    } catch(Exception e) {
      // error decoding JSON data
    }
  }
};

try {
  WLResourceRequest request = new WLResourceRequest(new URI("/adapters/JSONStoreAdapter/getPeople"), WLResourceRequest.GET);
  request.send(responseListener);
} catch (URISyntaxException e) {
  // handle error
}
```

#### Obtener push necesario (documentos sucios)
{: #get-push-required-dirty-documents }
Al llamar a `findAllDirtyDocuments` se obtiene una matriz de los denominados "documentos sucios", documentos con modificaciones locales que no existen en el sistema de fondo.


```java
Context  context = getContext();
try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocs = collection.findAllDirtyDocuments();
  // handle success
} catch(JSONStoreException e) {
  // handle failure
}
```

Para evitar que JSONStore marque los documentos como "sucios", pase la opción `options.setMarkDirty(false)` para `add`, `replace` y `remove`.


#### Hacer push a los cambios
{: #push-changes }
Para hacer push a los cambios para un adaptador, llame a `findAllDirtyDocuments` para obtener una lista de documentos con modificaciones y, a continuación, utilizar `WLResourceRequest`.
Después de enviar los datos y recibir una respuesta satisfactoria asegúrese de llamar a `markDocumentsClean`.


```java
WLResponseListener responseListener = new WLResponseListener() {
  @Override
  public void onFailure(final WLFailResponse response) {
    // handle failure
  }
  @Override
  public void onSuccess(WLResponse response) {
    // handle success
  }
};
Context context = getContext();

try {
  String collectionName = "people";
  JSONStoreCollection collection = WLJSONStore.getInstance(context).getCollectionByName(collectionName);
  List<JSONObject> dirtyDocuments = people.findAllDirtyDocuments();

  JSONObject payload = new JSONObject();
  payload.put("people", dirtyDocuments);

  WLResourceRequest request = new WLResourceRequest(new URI("/adapters/JSONStoreAdapter/pushPeople"), WLResourceRequest.POST);
  request.send(payload, responseListener);
} catch(JSONStoreException e) {
  // handle failure
} catch (URISyntaxException e) {
  // handle error
}
```

<img alt="Imagen de la aplicación de ejemplo" src="android-native-screen.jpg" style="float:right; width:240px;"/>
## Aplicación de ejemplo
{: #sample-application }
El proyecto JSONStoreAndroid contiene una aplicación Android nativa que utiliza el conjunto de API de JSONStore.
  
Se incluye un proyecto Maven de un adaptador JavaScript.


[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAndroid) el proyecto Android nativo.
  
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80) el proyecto Maven del adaptador.    

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.
