---
layout: tutorial
title: Captación de datos de una recopilación de JSONStore
breadcrumb_title: Fetch data from JSONStore collection
relevantTo: [reactnative]
weight: 2
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

## Captación de datos de una recopilación de JSONStore
En `App.js` debe importar los siguientes paquetes:

```javascript
import { JsonStoreCollection, WLJsonStore } from 'react-native-ibm-mobilefirst-jsonstore';
```

Hay dos pasos para captar datos de una recopilación de JSONStore:

1. Abrir una recopilación: abrir una recopilación le permite interactuar con ella.
    ```javascript
    WLJsonStore.openCollections(['favourites']).then(data => { console.log(data); }).catch(err =>{ console.log(err); });
    ```

2. Captar datos de una recopilación: tras abrir una recopilación, puede captar todos los documentos mediante la API siguiente.
    ```javascript
    var favCollection = new JSONStoreCollection('favourites');
    favCollection.findAllDocuments()
    .then(data => {
    	console.log("Succesfully fetched all documents from collection!"));
    	console.log("Data: " + JSON.stringify(data));
    .catch(err => {
    	console.log("Error while fetching data from collection. Reason : " + err);
    });
    ```    
