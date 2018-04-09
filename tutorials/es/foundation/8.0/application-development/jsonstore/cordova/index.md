---
layout: tutorial
title: JSONStore en aplicaciones Cordova
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCordova/tree/release80
  - name: Download Adapter Maven project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Requisitos previos
{: #prerequisites }
* Lea la [Guía de aprendizaje principal de JSONStore](../)
* Asegúrese de que {{ site.data.keys.product_adj }} Cordova SDK se ha añadido al proyecto.
Siga la guía de aprendizaje [Adición de {{ site.data.keys.product }} SDK para aplicaciones Cordova](../../../application-development/sdk/cordova/).
 

#### Ir a:
{: #jump-to}
* [Adición de JSONStore](#adding-jsonstore)
* [Uso básico](#basic-usage)
* [Uso avanzado](#advanced-usage)
* [Aplicación de ejemplo](#sample-application)

## Adición de JSONStore
{: #adding-jsonstore }
Para añadir el plugin JSONStore a su aplicación Cordova:


1. Abra una ventana de **indicador de mandatos** y vaya hasta la carpeta del proyecto de Cordova.

2. Ejecute el mandato: `cordova plugin add cordova-plugin-mfp-jsonstore`.

![Añadir característica JSONStore](jsonstore-add-plugin.png)

## Uso básico
{: #basic-usage }
### Inicializar
{: #initialize }
Utilice `init` para iniciar una o varias recopilaciones JSONStore.
  

Iniciar o aprovisionar una recopilación significa crear el almacenamiento persistente que contiene la recopilación y los documentos, si este no existe.
Este almacenamiento persistente está cifrado y si se pasa una contraseña correcta, se ejecutan los procedimientos de seguridad necesarios para hacer que los datos estén accesibles.


```javascript
var collections = {
    people : {
        searchFields: {name: 'string', age: 'integer'}
    }
};

WL.JSONStore.init(collections).then(function (collections) {
    // handle success - collection.people (people's collection)
}).fail(function (error) {
    // handle failure
});
```

> Para obtener más información sobre las características opcionales que es posible habilitar en el tiempo de inicialización, consulte **Seguridad**, **Soporte a múltiples usuarios** e **Integración de adaptadores de {{ site.data.keys.product_adj }}** en la segunda parte de esta guía de aprendizaje.


### Obtener
{: #get }
Utilice `get` para crear un accesor a la recopilación.
Debe llamar a `init` antes de llamar a `get`, de lo contrario el resultado de esta llamada no estará definido.


```javascript
var collectionName = 'people';
var people = WL.JSONStore.get(collectionName);
```

La variable `people` se puede utilizar ahora para realizar operaciones en la recopilación `people` como, por ejemplo, `add`, `find` y `replace`.


### Añadir
{: #add }
Utilice `add` para almacenar datos como documentos dentro de la recopilación. 

```javascript
var collectionName = 'people';
var options = {};
var data = {name: 'yoel', age: 23};

WL.JSONStore.get(collectionName).add(data, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### Encontrar
{: #find }
* Utilice `find` para encontrar documentos dentro de una recopilación utilizando una consulta.
  
* Utilice `findAll` para recuperar todos los documentos dentro de una recopilación.
  
* Utilice `findById` para buscar documentos según su identificador exclusivo de documento.   

El comportamiento predeterminado para encontrar es realizar una búsqueda "difusa" ("fuzzy"). 

```javascript
var query = {name: 'yoel'};
var collectionName = 'people';
var options = {
  exact: false, //default
  limit: 10 // returns a maximum of 10 documents, default: return every document
};

WL.JSONStore.get(collectionName).find(query, options).then(function (results) {
    // handle success - results (array of documents found)
}).fail(function (error) {
    // handle failure
});
```

```javascript
var age = document.getElementById("findByAge").value || '';

if(age == "" || isNaN(age)){
  alert("Please enter a valid age to find");
}
else {
  query = {age: parseInt(age, 10)};
  var options = {
    exact: true,
    limit: 10 //returns a maximum of 10 documents
  };
  WL.JSONStore.get(collectionName).find(query, options).then(function (res) {
    // handle success - results (array of documents found)
  }).fail(function (errorObject) {
    // handle failure
  });
}
```

### Sustituir
{: #replace }
Utilice `replace` para modificar documentos dentro de una recopilación.
El campo que se utiliza para realizar la sustitución es `_id`, el identificador exclusivo de documento.


```javascript
var document = {
  _id: 1, json: {name: 'chevy', age: 23}
};
var collectionName = 'people';
var options = {};

WL.JSONStore.get(collectionName).replace(document, options).then(function (numberOfDocsReplaced) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

En este ejemplo se supone que el documento `{_id: 1, json: {name: 'yoel', age: 23} }` está en la recopilación.


### Eliminar
{: #remove }
Utilice `remove` para suprimir un documento de una recopilación.
  
Los documentos no se quitan de la recopilación hasta que no llame a push.
  

> Para obtener más información, consulte la sección **Integración de adaptadores de {{ site.data.keys.product_adj }}** más adelante en esta guía de aprendizaje.


```javascript
var query = {_id: 1};
var collectionName = 'people';
var options = {exact: true};
WL.JSONStore.get(collectionName).remove(query, options).then(function (numberOfDocsRemoved) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### Eliminar recopilación
{: #remove-collection }
Utilice `removeCollection` para suprimir todos los documentos que se almacenan dentro de una recopilación.
Esta operación es similar a descartar una tabla en términos de una base de datos.

```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).removeCollection().then(function (removeCollectionReturnCode) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

## Uso avanzado
{: #advanced-usage }
### Destruir
{: #destory }
Utilice `destroy` para eliminar los siguientes datos:

* Todos los documentos
* Todas las recopilaciones
* Todos los almacenes (consulte "**Soporte múltiples usuarios**" más adelante en esta guía de aprendizaje). 
* Todos los artefactos de seguridad y metadatos de JSONStore (Consulte "**Seguridad**" más adelante en esta guía de aprendizaje)

```javascript
var collectionName = 'people';
WL.JSONStore.destroy().then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### Seguridad
{: #security }
Proteja todas las recopilaciones en un almacén pasando una contraseña para la función `init`.
Si no se pasa una contraseña, los documentos de todas las recopilaciones en el almacén no se cifran.


El cifrado de datos solo está disponible en entornos Android, iOS, Windows 8.1 Universal y Windows 10 UWP.
  
Algunos metadatos de seguridad se almacenan la *cadena de claves* (iOS), en las *preferencias compartidas* (Android) o en la *caja de seguridad de credenciales* (Windows 8.1).
  
El almacén se cifra con una clave AES (Advanced Encryption Standard) de 256 bits.
Todas las claves están reforzadas mediante PBKDF2 (Password-Based Key Derivation Function 2).


Utilice `closeAll` para bloquear el acceso a las recopilaciones hasta que llame a `init` de nuevo.
Si interpreta `init` como una función de inicio de sesión, puede interpretar `closeAll` como la correspondiente función de finalización de sesión.
Utilice `changePassword` para cambiar la contraseña.

```javascript
var collections = {
  people: {
    searchFields: {name: 'string'}
  }
};
var options = {password: '123'};
WL.JSONStore.init(collections, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

#### Cifrado
{: #encryption }
*Solo iOS*. De forma predeterminada {{ site.data.keys.product_adj }} Cordova SDK para iOS se basa en las API que proporciona iOS para el cifrado.
Si prefiere utilizar OpenSSL:

1. Añada el plugin cordova-plugin-mfp-encrypt-utils:
`cordova plugin add cordova-plugin-mfp-encrypt-utils`.
2. En la lógica de la aplicación, utilice: `WL.SecurityUtils.enableNativeEncryption(false)` para habilitar la opción OpenSSL.


### Soporte a múltiples usuarios
{: #multiple-user-support }
Es posible crear varios almacenes con varias recopilaciones en una única aplicación de {{ site.data.keys.product_adj }}.
La función `init` puede tomar un objeto de opciones con un nombre de usuario.
Si no se proporciona un nombre de usuario, el predeterminado es **jsonstore**.


```javascript
var collections = {
  people: {
    searchFields: {name: 'string'}
  }
};
var options = {username: 'yoel'};
WL.JSONStore.init(collections, options).then(function () {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

### Integración de adaptadores de {{ site.data.keys.product_adj }}
{: #mobilefirst-adapter-integration }
En esta sección se presupone que está familiarizado con los adaptadores.
  

La integración del adaptador es opcional y proporciona formas de enviar datos desde una recopilación a un adaptador y obtener datos de dicho adaptador para la recopilación.
  
Puede lograr estos objetivos utilizando `WLResourceRequest` o `jQuery.ajax` si necesita más flexibilidad.


### Implementación de adaptador
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
{: #load-data-from-an-adapter }
Para cargar datos desde un adaptador utilice `WLResourceRequest`.

```javascript
try {
      var resource = new WLResourceRequest("adapters/JSONStoreAdapter/getPeople", WLResourceRequest.GET);
     resource.send()
     .then(function (responseFromAdapter) {

  var data = responseFromAdapter.responseJSON.peopleList;
     },function(err){
      	//handle failure
     });
} catch (e) {
    alert("Failed to load data from adapter " + e.Messages);
}
```

#### Obtener push necesario (documentos sucios)
{: #get-push-required-dirty-documents }
Al llamar a `getPushRequired` devuelve una matriz de *"documentos sucios"*,
que son documentos que tienen modificaciones locales que no existen en el sistema de fondo.
Estos documentos se envían al adaptador cuando se llama a `push`.


```javascript
var collectionName = 'people';
WL.JSONStore.get(collectionName).getPushRequired().then(function (dirtyDocuments) {
    // handle success
}).fail(function (error) {
    // handle failure
});
```

Para evitar que JSONStore marque los documentos como "sucios", pase la opción `{markDirty:false}` para `add`, `replace` y `remove`.


Utilice también la API `getAllDirty` para recuperar todos los documentos sucios:


```javascript
WL.JSONStore.get(collectionName).getAllDirty()
.then(function (dirtyDocuments) {
    // handle success
}).fail(function (errorObject) {
    // handle failure
});
```

#### Hacer push a los cambios
{: #push }
Para hacer push a los cambios para un adaptador, llame a `getAllDirty` para obtener una lista de documentos con modificaciones y, a continuación, utilizar `WLResourceRequest`.
Después de enviar los datos y recibir una respuesta satisfactoria asegúrese de llamar a `markClean`.


```javascript
try {
      var collectionName = "people";
     var dirtyDocs;

     WL.JSONStore.get(collectionName)
 
.getAllDirty()
 
.then(function (arrayOfDirtyDocuments) {
  dirtyDocs = arrayOfDirtyDocuments;
 
  var resource = new WLResourceRequest("adapters/JSONStoreAdapter/pushPeople", WLResourceRequest.POST);
        resource.setQueryParameter('params', [dirtyDocs]);
        return resource.send();
     }).then(function (responseFromAdapter) {

  return WL.JSONStore.get(collectionName).markClean(dirtyDocs);
})
 
.then(function (res) {

  // handle success
}).fail(function (errorObject) {
    // Handle failure.
});

} catch (e) {
    alert("Failed To Push Documents to Adapter");
}
```

### Enhance
{: #enhance }
Utilice `enhance` para ampliar el núcleo de API para que se adecúe a sus necesidades añadiendo funciones al prototipo de la recopilación.
En este ejemplo (el fragmento de código que se indica a continuación) se muestra cómo utilizar `enhance` para añadir la función `getValue` que funciona en la recopilación `keyvalue`.
Utiliza `key` (serie) como su único parámetros y devuelve un resultado individual.


```javascript
var collectionName = 'keyvalue';
WL.JSONStore.get(collectionName).enhance('getValue', function (key) {
    var deferred = $.Deferred();
    var collection = this;
    //Do an exact search for the key
    collection.find({key: key}, {exact:true, limit: 1}).then(deferred.resolve, deferred.reject);
    return deferred.promise();
});

//Usage:
var key = 'myKey';
WL.JSONStore.get(collectionName).getValue(key).then(function (result) {
    // handle success
    // result contains an array of documents with the results from the find
}).fail(function () {
    // handle failure
});
```

> Para obtener más información sobre JSONStore, consulte la documentación de usuario.

<img alt="Aplicación de ejemplo JSONStore " src="jsonstore-cordova.png" style="float:right"/>
## Aplicación de ejemplo
{: #sample-application }
El proyecto JSONStoreSwift contiene una aplicación Cordova que utiliza el conjunto de API de JSONStore.
  
Se incluye un proyecto Maven de un adaptador JavaScript.


[
Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreCordova/tree/release80) el proyecto de Cordova.
  
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreAdapter/tree/release80) el proyecto Maven del adaptador.    

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.
