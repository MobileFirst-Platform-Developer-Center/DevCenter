---
layout: tutorial
title: Adición de datos a una recopilación de JSONStore
breadcrumb_title: Add data to JSONStore collection
relevantTo: [reactnative]
weight: 1
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

## Adición de datos a una recopilación de JSONStore

En `App.js` debe importar los siguientes paquetes:

```javascript
import { JSONStoreCollection, WLJSONStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

Hay tres pasos para añadir datos a una recopilación de JSONStore:

1. Crear una nueva recopilación: puede crear una nueva recopilación llamando al constructor `JSONStoreCollection` tal como se muestra a continuación:
    ```javascript
    var favourites = new JSONStoreCollection('favourites');
    ```
2.  Abrir una recopilación: no podrá realizar ninguna acción con una recopilación recién creada a menos que la abra. Para abrir la recopilación, llame a la API `openCollections` de WLJSONStore. Consulte el siguiente código de ejemplo.
    ```javascript
    WLJSONStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```
3. Añadir datos a una recopilación: tras abrir una recopilación, inicie transacciones de datos hacia dentro y hacia fuera. Puede añadir datos a una recopilación abierta mediante la API siguiente.
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.addData(myJsonData)
    .then(data => {
    	console.log("Succesfully added data to collection!"));
    .catch(err => {
    	console.log("Error while adding data to collection. Reason : " + err);
    });
    ```    
