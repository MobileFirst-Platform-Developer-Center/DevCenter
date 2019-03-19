---
layout: tutorial
title: Sincronización de datos de la recopilación JSONStore con Cloudant DB
breadcrumb_title: Sync data of JSONStore collection to a Cloudant DB
relevantTo: [reactnative]
weight: 4
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

## Sincronización de datos de la recopilación JSONStore con Cloudant DB
La desventaja de tener todos los datos de la aplicación localmente es que al desinstalar la aplicación los perderá. Para contrarrestar este problema, IBM JSONStore proporciona la funcionalidad SYNC con Cloudant DB.

```javascript
import { JSONStoreCollection, WLJSONStore, JSONStoreInitOptions, JSONStoreSyncPolicy, JSONStoreAddOptions } from 'react-native-ibm-mobilefirst-jsonstore';
```

Hay dos pasos para sincronizar los datos de una recopilación de JSONStore:

1. Al abrir una recopilación, la única diferencia entre una `JSONStoreCollection` normal y una `JSONStoreCollection` sincronizada es la manera en que se abren. Las JSONStoreCollections sincronizadas se abren con las `JSONStoreInitOptions` correspondientes. JSONStoreInitOptions es donde decidirá la política de sincronización y el adaptador con el que se sincronizarán los datos. Este adaptador básicamente es Cloudant Sync Adapter. Encuentre más información [aquí](https://mobilefirstplatform.ibmcloud.com/blog/2018/02/23/jsonstoresync-couchdb-databases/). JSONStoreInitOptions proporciona una API `setSyncOptions(syncPolicy, adapterName)`. JSONStoreSyncPolicy debe ser uno de los valores siguientes [‘SYNC_NONE’, ‘SYNC_DOWNSTREAM’, ‘SYNC_UPSTREAM’]. **adapterName** es el nombre del adaptador desplegado en su instancia de MobileFirst Server que funciona con Cloudant DB. Asegúrese de que se especifique correctamente la información de Cloudant DB para que la sincronización funcione correctamente.

    ```javascript
    var initOptions = new JSONStoreInitOptions();
    initOptions.setSyncOptions(JSONStoreSyncPolicy.SYNC_UPSTREAM, "JSONStoreCloudantSync");
    var collection = new JSONStoreCollection('favourites');
    WLJSONStore.openCollections(['favourites'], initOptions).then(data => {	console.log("Successfully opened collection with Sync Policy!");
   }).catch(err => {	console.log(err);
   });
    ```

2. Al llamar a la API Sync, todas las JSONStoreCollections abiertas con Sync desencadenarán automáticamente la sincronización cuando la API `openCollection()` se complete satisfactoriamente.<br/>
    Si se ha abierto una JSONStoreCollection con la política **JSONStoreSyncPolicy.SYNC_DOWNSTREAM**, puede llamar explícitamente a la API `sync()` para captar la última obtención.<br/>
    Si se ha abierto una JSONStoreCollection con la política **JSONStoreSyncPolicy.SYNC_UPSTREAM**, el proceso de sincronización se desencadena automáticamente al añadir, actualizar o eliminar un documento de la recopilación. Aún puede llamar a la API `sync()` para desencadenar automáticamente la sincronización.<br/>
    ```javascript
    var favCollection = new JsonStoreCollection('favourites');
    favCollection.sync();
    ```    
