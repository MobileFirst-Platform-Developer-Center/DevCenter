---
layout: tutorial
title: JSONStore en aplicaciones React Native
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
downloads:
  - name: Download React Native project
    url: https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative
---
<!-- NLS_CHARSET=UTF-8 -->
## Requisitos previos
{: #prerequisites }
* Lea la [Guía de aprendizaje principal de JSONStore](../)
* Asegúrese de que el SDK básico de {{ site.data.keys.product_adj }} React Native se haya añadido al proyecto. Siga la guía de aprendizaje de [Adición del SDK de Mobile Foundation a aplicaciones React-Native](https://mobilefirstplatform.ibmcloud.com/tutorials/en/foundation/8.0/reactnative-tutorials/).

#### Ir a:
{: #jump-to}
* [Adición de JSONStore](#adding-jsonstore)
* [Uso básico](#basic-usage)
* [Aplicación de ejemplo](#sample_app_for_jsonstore)

## Adición de JSONStore
{: #adding-jsonstore }
Para añadir el plugin JSONStore a su aplicación React Native:

1. Abra una ventana **Línea de mandatos** y vaya a la carpeta del proyecto de React Native.
2. Ejecute el mandato:
    ```bash
    npm install react-native-ibm-mobilefirst-jsonstore --save
    ```

## Uso básico
{: #basic-usage }
### Creación de una nueva recopilación JSONStore
{: #create_new_jsonstore_collection}
1.  Utilizamos la clase `JSONStoreCollection` para crear instancias de JSONStore. También podemos establecer configuración adicional para esta recopilación JSONStore que se acaba de crear (por ejemplo, estableciendo campos de búsqueda).
2.  Para empezar a interactuar con una recopilación JSONStore existente (por ejemplo: añadiendo o eliminando datos) debemos *Abrir* la recopilación. Utilizamos la API `openCollections()` para hacer lo siguiente.
    ```javascript
    var collection = new JSONStoreCollection('people');
    WLJSONStore.openCollections(['people'])
    .then(res => {
    	// handle success
    }).catch(err => {
    	// handle failure
});
    ```

### Añadir
{: #add}
Utilice la API `addData()` para añadir datos JSON en una recopilación.

```javascript
var data = { "name": "John", age: 28 };
var collection = new JSONStoreCollection('people');
collection.addData(data)
.then(res => {
  // handle success
}).catch(err => {
  // handle failure
});
```

> Puede añadir un único objeto JSON o una matriz de objetos JSON mediante esta API.

### Encontrar
{: #find}
1.  Utilice `find` para encontrar documentos dentro de una recopilación utilizando una consulta.
2.  Utilice la API `findAllDocuments()` para recuperar todos los documentos de una recopilación.
3.  Utilice las API `findDocumentById()` y `findDocumentsById()` para utilizar el identificador de documento exclusivo.
4.  Utilice la API `findDocuments()` para consultar la recopilación. Para la consulta, puede utilizar los objetos de clase `JSONStoreQueryPart` para filtrar los datos.

> Pase una matriz de objetos `JSONStoreQueryPart` como parámetro a la API `findDocuments`.

```javascript
var collection = new JSONStoreCollection('people');
var query = new JSONStoreQueryPart();
query.addEqual("name", "John");
collection.findDocuments([query])
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

### Eliminar
{: #remove}
Utilice `remove` para suprimir un documento de una recopilación.

```javascript
var id = 1; // for example
var collection = new JSONStoreCollection('people');
collection.removeDocumentById(id)
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

### Eliminar recopilación
{: #removecollection}
Utilice `removeCollection` para suprimir todos los documentos que se almacenan dentro de una recopilación. Esta operación es similar a descartar una tabla en términos de una base de datos.

```javascript
var collection = new JSONStoreCollection('people');
collection.removeCollection()
.then(res => {
	// handle success
}).catch(err => {
	// handle failure
});
```

## Aplicación de ejemplo de JSONStore de IBM MobileFirst
{: #sample_app_for_jsonstore}
Descargue el ejemplo [aquí](https://github.com/MobileFirst-Platform-Developer-Center/JSONStoreReactNative).

### Ejecución del ejemplo
{: #running_sample}
En el directorio raíz del ejemplo, ejecute el mandato siguiente, que instala todas las dependencias de proyecto:

```bash
npm install
```

>**Nota:** Asegúrese de que *mfpclient.properties* y *mfpclient.plist* apuntan a la instancia correcta de  MobileFirst Server.

1. Registre la aplicación. Vaya al directorio `android` y ejecute el mandato siguiente:
    ```bash
    mfpdev app register
    ```

2. Configuración de la aplicación.
    (Para Android solamente)
   *  Abra el archivo `android/app/src/main/AndroidManifest.xml` desde el directorio raíz del proyecto de React Native.<br/>
    	 Añada la línea siguiente a la etiqueta `<manifest>`:<br/>
    	`xmlns:tools="http://schemas.android.com/tools"`<br/>
    	 Añada la línea siguiente a la etiqueta `<application>`:<br/>
    	`tools:replace="android:allowBackup"`<br/><br/>
    	 Este paso lo requiere la biblioteca *react-native-ibm-mobilefirst*.<br/>

	 *  Abra el archivo `android/app/build.gradle` desde el directorio raíz del proyecto de React Native.<br/>
      Añada el código siguiente en *android {}*:<br/>

        ```
        packagingOptions{
        	exclude 'META-INF/ASL2.0'
        }
        ```
      Este paso lo requiere la biblioteca *react-native-ibm-mobilefirst-jsonstore*.

3. Ejecución de la aplicación. Vuelva al directorio raíz y vaya al directorio `iOS` y ejecute el mandato:
    `mfpdev app register`

Ahora estamos listos para ejecutar la aplicación.
Para la ejecución android, ejecute el mandato siguiente:
```bash
react-native run-android
```
