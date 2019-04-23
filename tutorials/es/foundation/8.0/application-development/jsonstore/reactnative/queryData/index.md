---
layout: tutorial
title: Consulta de datos desde la recopilación de JSONStore
breadcrumb_title: Query data from JSONStore collection
relevantTo: [reactnative]
weight: 3
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
##  Configuración del entorno de desarrollo de React Native
Siga las instrucciones que se proporcionan en la [página de iniciación](https://facebook.github.io/react-native/docs/getting-started.html) de React Native para configurar la máquina para el desarrollo de React Native.

##  Adición de un SDK JSONStore en la aplicación React Native
El SDK de JSONStore para React Native está disponible como módulo de React Native en [npm](https://www.npmjs.com/package/react-native-mobilefirst-jsonstore).

### Iniciación con un nuevo proyecto de React Native
1. Cree un nuevo proyecto de React Native.
    ```bash
    react-native init MyReactApp
    ```

2. Añada el SDK de MobileFirst a la aplicación.
    ```bash
    cd MyReactApp
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

3.  Enlace todas las dependencias nativas a su aplicación.
    ```bash
    react-native link
    ```

## Consulta de datos desde la recopilación de JSONStore
Raramente deseará obtener todos los documentos de una colección al mismo tiempo. En general, necesita la capacidad de consultar los datos existentes en su recopilación.

En `App.js` debe importar los siguientes paquetes:

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

Hay dos pasos para consultar los datos de una recopilación de JSONStore:

1. Abrir una recopilación: abrir una recopilación le permite interactuar con ella.
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. Captar datos de una recopilación: tras abrir una recopilación, puede captar los documentos según una consulta determinada. Para consultar JSONStore, se proporcionan dos clases con las que trabajar: `JSONStoreQuery` y `JSONStoreQueryPart`.<br/>
    Puede utilizar varios objetos JSONStoreQueryPart para la misma llamada pasando cada objeto JSONStoreQueryPart en una matriz.
    Los distintos objetos JSONStoreQueryPart se unen mediante una sentencia OR.
    Las distintas condiciones de un objeto JSONStoreQueryPart se unen mediante una sentencia AND.

    Consulte el código siguiente:

    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    var queryPart1 = new JSONStoreQueryPart();
    queryPart1.addBetween("age", 21, 50);

    var queryPart2 = new JSONStoreQueryPart();
    queryPart2.addEqual("gender", "female");

    // Tenga en cuenta cómo varios objetos JSONStoreQueryPart se pasan en una matriz para crear una consulta completa
    // La llamada siguiente devolverá todos los documentos que tienen
    // "gender" establecido en "female" OR "age" entre 21 y 50

    favCollection.findDocuments([queryPart1, queryPart2])
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
