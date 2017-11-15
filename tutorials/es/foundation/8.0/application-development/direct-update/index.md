---
layout: tutorial
title: Utilización de Direct Update en aplicaciones Cordova
breadcrumb_title: Direct Update
relevantTo: [cordova]
weight: 8
downloads:
  - name: Download Cordova project
    url: https://github.com/MobileFirst-Platform-Developer-Center/CustomDirectUpdate/tree/release80
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
Con Direct Update, las aplicaciones Cordova se pueden actualizar mediante mecanismos OTA (Over-The-Air), renovando recursos web como, por ejemplo, la lógica de aplicación cambiada, corregida o nueva (JavaScript), HTML, CSS o imágenes.
Las organizaciones pueden por lo tanto asegurarse de que los usuarios finales siempre tendrán la última versión de la aplicación.


Con el propósito de actualizar una aplicación, los recursos web actualizados de la aplicación se deben empaquetar y subir a {{ site.data.keys.mf_server }} mediante {{ site.data.keys.mf_cli }} o desplegando un archivo de archivado que se haya generado.
Direct Update se activará entonces de forma automática y, una vez activado, se forzará en cada solicitud para un recurso protegido.


**Plataformas de Cordova soportadas**  
Se da soporte a Direct Update en las plataformas Cordova iOS y Cordova Android.


**Direct Update en las fases de desarrollo, pruebas y producción**  
A efectos de desarrollo y pruebas, los desarrolladores habitualmente utilizarán Direct Update simplemente subiendo un archivador al servidor de desarrollo.
Todo y que este proceso es fácil de implementar, no es muy seguro.
En esta fase, se utiliza una pareja de clave RSA interna que se extrae de un certificado autofirmado que {{ site.data.keys.product_adj }} incluye.


Sin embargo, en las fases de producción o incluso en las pruebas anteriores a la fase de producción, es altamente recomendable implementar un Direct Update seguro antes de publicar su aplicación en la tienda de aplicaciones.
Una versión de Direct Update segura necesita una pareja de claves RSA extraídas de un certificado de servidor firmado por una autoridad de certificación (CA) real.


**Nota:**
Hay que proceder con precaución para no modificar la configuración del almacén de claves después de que se haya publicado la aplicación, con una nueva clave pública las actualizaciones que se descargan ya no se podrán autenticar sin volver a configurar la aplicación y será necesario volver a publicar la aplicación.
Sin estos dos pasos, Direct Update fallará en el cliente.


> Obtenga más información en [Direct Update seguro](#secure-direct-update).

**Velocidades de transferencia de Direct Update**  
En condiciones óptimas, una instancia de {{ site.data.keys.mf_server }} individual puede enviar datos a los clientes a una velocidad de 250 MB por segundo.
Si son necesarias velocidades más elevadas, considere la posibilidad de utilizar un clúster o un servicio de una CDN.
  

> Obtenga más información en [Dar servicio a Direct Update desde una CDN](cdn-support)

### Notas
{: #notes }

* Direct Update solo actualiza recursos web de la aplicación.
Si desea actualizar recursos nativos, se debe enviar una nueva versión de la aplicación a las respectivas tiendas de aplicaciones.

* Cuando se utiliza la característica Direct Update y la [suma de comprobación de recursos web](../cordova-apps/securing-apps/#enabling-the-web-resources-checksum-feature), se establece una nueva base de suma de comprobación con cada actualización de Direct Update.

* Si {{ site.data.keys.mf_server }} se actualizó con un fixpack, continuará sirviendo actualizaciones directas de forma adecuada.
Sin embargo, si se sube un archivador de Direct Update compilado recientemente (archivo .zip), puede detener las actualizaciones en los clientes antiguos.
La razón está en que el archivador contiene la versión del plugin de cordova-plugin-mfp.
Antes de servir dicho archivador a un cliente móvil, el servidor compara la versión del cliente con la versión del plugin.
Si ambas versiones son lo suficientemente cercanas (los tres dígitos más significativos son los mismos), Direct Update funcionará de forma normal.
De lo contrario, {{ site.data.keys.mf_server }} omitirá de forma silenciosa la actualización.
Una solución para la discrepancia en la versión es la de descargar el plugin cordova-plugin-mfp con la misma versión que la del proyecto Cordova original y volver a generar el archivador de Direct Update.


#### Ir a:
{: #jump-to}

- [Como funciona Direct Update](#how-direct-update-works)
- [Creación y despliegue de recursos web actualizados ](#creating-and-deploying-updated-web-resources)
- [Experiencia de usuario](#user-experience)
- [Personalización de la interfaz de usuario de Direct Update](#customizing-the-direct-update-ui)
- [Actualizaciones directas completas y delta](#delta-and-full-direct-update)
- [Direct Update seguro](#secure-direct-update)
- [Aplicación de ejemplo](#sample-application)

## Como funciona Direct Update
{: #how-direct-update-works }
Los recursos web de la aplicación inicialmente de empaquetan con la aplicación para asegurar primero una disponibilidad fuera de línea.
Después, la aplicación comprueba si hay actualizaciones en cada solicitud a {{ site.data.keys.mf_server }}.

> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Nota:** después de que se realice una actualización de Direct Update, se comprueba de nuevo al cabo de 60 minutos.



Después de una actualización de Direct Update, la aplicación deja de utilizar los recursos web empaquetados de forma previa.
En su lugar se utilizarán los recursos web descargados desde el recinto de seguridad de la aplicación.
Si se borra la caché de la aplicación en el dispositivo, se utilizarán de nuevo los recursos web empaquetados originales.


![Diagrama sobre el funcionamiento de Direct Update](internal_function.jpg)

### Creación de versiones
{: #versioning }
Una actualización de Direct Update se aplica únicamente a una versión específica.
En otras palabras, las actualizaciones generadas para una aplicación con la versión 2.0 no se pueden aplicar a otra versión de la misma aplicación.


## Creación y despliegue de recursos web actualizados 
{: #creating-and-deploying-updated-web-resources }
Una vez se haya realizado el trabajo en los nuevos recursos web como, por ejemplo, arreglos para errores o cambios menores, es necesario volver a empaquetar dichos recursos web actualizados y subirlos a {{ site.data.keys.mf_server }}.


1. Abra la ventana de **línea de mandatos** y vaya a la raíz del proyecto Cordova.

2. Ejecute el mandato: `mfpdev app webupdate`.

El mandato `mfpdev app webupdate` empaqueta los recursos web actualizados en un archivo .zip y lo sube a la instancia de {{ site.data.keys.mf_server }} predeterminada en ejecución en la estación de trabajo del desarrollador.
Los recursos web empaquetados se pueden encontrar en la carpeta **[cordova-project-root-folder]/mobilefirst/**.


Alternativas: 

* Compile el archivo .zip y súbalo a una instancia de {{ site.data.keys.mf_server }} diferente:
`mfpdev app webupdate [server-name] [runtime-name]`. Por ejemplo: 

  ```bash
  mfpdev app webupdate myQAServer MyBankApps
  ```

* Actualice un archivo .zip generado de forma previa:
`mfpdev app webupdate [server-name] [runtime-name] --file [path-to-packaged-web-resources]`. Por ejemplo: 

  ```bash
  mfpdev app webupdate myQAServer MyBankApps --file mobilefirst/ios/com.mfp.myBankApp-1.0.1.zip
  ```

* Suba manualmente los recursos web empaquetados a {{ site.data.keys.mf_server }}:
 1. Compile el archivo .zip sin subirlo: 

    ```bash
    mfpdev app webupdate --build
    ```
 2. Cargue {{ site.data.keys.mf_console }} y pulse en la entrada de la aplicación.

 3. Pulse en **Subir archivo de recursos web** para subir los recursos web empaquetados.


    ![Subir el archivo .zip de Direct Update desde la consola](upload-direct-update-package.png)

> Ejecute el mandato `mfpdev help app webupdate` para obtener más información.


## Experiencia del usuario
{: #user-experience }
De forma predeterminada, después de que se reciba una actualización de Direct Update se visualiza un diálogo donde se solicita al usuario a que empiece el proceso de actualización.
Después de que el usuario lo apruebe, se visualiza un diálogo con una barra de progreso y los recursos web se descargan.
La aplicación se recarga de forma automática cuando la actualización finaliza.


![Ejemplo de Direct Update](direct-update-flow.png)

## Personalización de la interfaz de usuario de Direct Update
{: #customizing-the-direct-update-ui }
La interfaz de usuario predeterminada de Direct Update que se presenta al usuario final se puede personalizar.
  
Añada el siguiente código dentro de la función `wlCommonInit()` en **index.js**:

```javascript
wl_DirectUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext) {
    // Implement custom Direct Update logic
};
```

- `directUpdateData` - Objeto JSON que contiene la propiedad `downloadSize` que representa el tamaño del archivo (en bytes) del paquete de actualización a descargar desde {{ site.data.keys.mf_server }}.
- `directUpdateContext` - Objeto JavaScript que expone las funciones `.start()` y `.stop()`, que inician y detienen el flujo de Direct Update.


Si los recursos web son más recientes en {{ site.data.keys.mf_server }} que en la aplicación, los datos necesarios de Direct Update se añaden a la respuesta del servidor.
Siempre que la infraestructura de datos del lado del cliente de {{ site.data.keys.product_adj }} detecte esta necesidad de una actualización directa, la invoca mediante la función `wl_directUpdateChallengeHandler.handleDirectUpdate`.


La función proporciona una funcionalidad de Direct Update predeterminada: un diálogo con un mensaje predeterminado que se visualiza cuando Direct Update está disponible y una pantalla de progreso predeterminada que se visualiza al iniciarse dicho proceso.
Se pueden implementar un comportamiento de interfaz de usuario de Direct Update personalizado o personalizar el recuadro de diálogo de Direct Update modificando esta función e implementando su propia lógica.


<img alt="Imagen de diálogo de Direct Update personalizado" src="custom-direct-update-dialog.jpg" style="float:right; margin-left: 10px"/>
En el siguiente código de ejemplo, una función `handleDirectUpdate` implementa un mensaje personalizado en el diálogo de Direct Update.
Añada este código al archivo **www/js/index.js** del proyecto Cordova.
  
Ejemplos adicionales para una interfaz de usuario (UI) de Direct Update personalizada:


- Diálogo que se crea mediante una infraestructura de JavaScript de un tercero (como, por ejemplo, Dojo, jQuery Mobile, Ionic, ...)
- Interfaz de usuario nativa completa mediante la ejecución de un plugin de Cordova
- HTML alternativo que se presenta al usuario con opciones
- Y otras más...

```javascript
wl_directUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext) {        
    navigator.notification.confirm(  // Creates a dialog.
        'Custom dialog body text',
        // Handle dialog buttons.
          directUpdateContext.start();
        },
        'Custom dialog title text',
        ['Update']
    );
};
```

El proceso de Direct Update se inicia ejecutando el método `directUpdateContext.start()` siempre que el usuario pulsa el botón de diálogo.
Se muestra la pantalla de progreso predeterminada, que es parecida a la existente en versiones anteriores de {{ site.data.keys.mf_server }}.


Este método da soporte a los siguientes tipos de invocación:

* Cuando no se especifican los parámetros, {{ site.data.keys.mf_server }} utiliza la pantalla de progreso predeterminada.

* Cuando se proporciona una función de escucha como, por ejemplo, `directUpdateContext.start(directUpdateCustomListener)`, el proceso de Direct Update se ejecuta en un segundo plano mientras envía sucesos de ciclo de vida al escucha.
El escucha personalizado debe implementar los siguientes métodos:


```javascript
var  directUpdateCustomListener  = {
    onStart : function ( totalSize ){ },
    onProgress : function ( status , totalSize , completedSize ){ },
    onFinish : function ( status ){ }
};
```

Los métodos del escucha se inician durante el proceso de actualización directa de acuerdo a las siguientes reglas:

* Se llama a `onStart` con el parámetro `totalSize` que contiene el tamaño del archivo de actualización.

* Se llama varias veces a `onProgress` con el estado `DOWNLOAD_IN_PROGRESS`, `totalSize` y `completedSize` (volumen de lo descargado hasta el momento).

* Se llama a `onProgress` con el estado `UNZIP_IN_PROGRESS`.
* Se llama a `onFinish` con uno de los siguientes códigos de estado final:


| Código de estado | Descripción |
|-------------|-------------|
| `SUCCESS` | La actualización directa finalizó sin errores. |
| `CANCELED` | Se canceló la actualización directa (por ejemplo, debido a que se llamó al método `stop()`). |
| `FAILURE_NETWORK_PROBLEM` | Se produjo un problema con una conexión de red durante la actualización. |
| `FAILURE_DOWNLOADING` | El archivo no se ha descargado completamente. |
| `FAILURE_NOT_ENOUGH_SPACE` | No hay espacio suficiente en el dispositivo para descargar y desempaquetar el archivo de actualización. |
| `FAILURE_UNZIPPING` | Se ha producido un problema desempaquetar el archivo de actualización. |
| `FAILURE_ALREADY_IN_PROGRESS` | Se ha llamado al método de inicio mientras ya se estaba ejecutando una actualización directa. |
| `FAILURE_INTEGRITY` | No se ha podido verificar el archivo de actualización.  |
| `FAILURE_UNKNOWN` | Error interno inesperado. |

Si implementa un escucha de actualización directa personalizado, debe asegurarse de que la aplicación se recarga cuando se complete el proceso de dicha actualización directa y se haya llamado al método `onFinish()`. También se debe llamar a `wl_directUpdateChalengeHandler.submitFailure()` si el proceso de actualización directa no se completa de forma satisfactoria.


En el siguiente ejemplo se muestra una implementación de un escucha de actualización directa personalizado:


```javascript
var directUpdateCustomListener = {
  onStart: function(totalSize){
    //show custom progress dialog
  },
  onProgress: function(status,totalSize,completedSize){
    //update custom progress dialog
  },
  onFinish: function(status){

    if (status == 'SUCCESS'){
      //show success message
      WL.Client.reloadApp();
    }
    else {
      //show custom error message

      //submitFailure must be called is case of error
      wl_directUpdateChallengeHandler.submitFailure();
    }
  }
};

wl_directUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext){

  WL.SimpleDialog.show('Update Avalible', 'Press update button to download version 2.0', [{
    text : 'update',
    handler : function() {
      directUpdateContext.start(directUpdateCustomListener);
    }
  }]);
};
```

### Escenario: Ejecución de actualizaciones directas sin una interfaz de usuario
{: #scenario-running-ui-less-direct-updates }
{{ site.data.keys.product_full }} da soporte a las actualizaciones directas sin una interfaz de usuario cuando la aplicación se encuentra en un segundo plano.


Para ejecutar las actualizaciones directas sin interfaz de usuario, implemente `directUpdateCustomListener`.
Proporcione implementaciones de función vacías para los métodos `onStart` y `onProgress`.
Las implementaciones vacías harán que el proceso de la actualización directa se ejecute en un segundo plano.


Para completar el proceso de la actualización directa, se debe recargar la aplicación.
Las siguientes opciones están disponibles:

* El método `onFinish` también puede estar vacío.
En este caso, la actualización directa se aplicará después de que se haya reiniciado la aplicación.

* Se puede implementar un diálogo personalizado que informe o solicite al usuario el reiniciar la aplicación.
(Consulte el siguiente ejemplo:)
* El método `onFinish` puede forzar la recarga de la aplicación llamando a `WL.Client.reloadApp()`.


A continuación se muestra una implementación de ejemplo de `directUpdateCustomListener`:

```javascript
var directUpdateCustomListener = {
  onStart: function(totalSize){
  },
  onProgress: function(status,totalSize,completeSize){
  },
  onFinish: function(status){
    WL.SimpleDialog.show('New Update Available', 'Press reload button to update to new version', [ {
      text : WL.ClientMessages.reload,
      handler : WL.Client.reloadApp
    }]);
  }
};
```

Implemente la función `wl_directUpdateChallengeHandler.handleDirectUpdate`.
Pase la implementación de `directUpdateCustomListener` que haya creado como un parámetro para la función.
Asegúrese de que se llama a `directUpdateContext.start(directUpdateCustomListener)`.
A continuación se muestra la implementación de `wl_directUpdateChallengeHandler.handleDirectUpdate` de ejemplo:


```javascript
wl_directUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext){

  directUpdateContext.start(directUpdateCustomListener);
};
```

**Nota:** Cuando la aplicación se envía a un segundo plano, se suspende el proceso de actualización directa.


### Escenario: Cómo manejar una anomalía de una actualización directa
{: #scenario-handling-a-direct-update-failure }
Este escenario muestra cómo manejar una anomalía en una actualización directa que puede ser originada, por ejemplo, por una pérdida de conectividad.
En este escenario, el usuario deja de poder utilizar la aplicación incluso en la modalidad de fuera de línea.
Se visualiza un diálogo ofreciendo al usuario la opción de intentarlo de nuevo.


Cree una variable global para almacenar el contexto de la actualización directa de forma que lo puede utilizar más tarde cuando el proceso de actualización directa falle.
Por ejemplo: 

```javascript
var savedDirectUpdateContext;
```

Implemente un manejador de desafío de actualización directa.
Aquí se guarda el contexto de la actualización directa.
Por ejemplo: 

```javascript
wl_directUpdateChallengeHandler.handleDirectUpdate = function(directUpdateData, directUpdateContext){

  savedDirectUpdateContext = directUpdateContext; // save direct update context

  var downloadSizeInMB = (directUpdateData.downloadSize / 1048576).toFixed(1).replace(".", WL.App.getDecimalSeparator());
  var directUpdateMsg = WL.Utils.formatString(WL.ClientMessages.directUpdateNotificationMessage, downloadSizeInMB);

  WL.SimpleDialog.show(WL.ClientMessages.directUpdateNotificationTitle, directUpdateMsg, [{
    text : WL.ClientMessages.update,
    handler : function() {
      directUpdateContext.start(directUpdateCustomListener);
    }
  }]);
};
```

Cree una función que inicie el proceso de actualización directa utilizando el contexto de la actualización directa.
Por ejemplo: 

```javascript
restartDirectUpdate = function () {
  savedDirectUpdateContext.start(directUpdateCustomListener); // use saved direct update context to restart direct update
};
```

Implemente `directUpdateCustomListener`.
Añada una comprobación de estado en el método `onFinish`.
Si el estado empieza con "FAILURE", se abre un diálogo modal con la opción de intentarlo de nuevo.
Por ejemplo: 

```javascript
var directUpdateCustomListener = {
  onStart: function(totalSize){
    alert('onStart: totalSize = ' + totalSize + 'Byte');
  },
  onProgress: function(status,totalSize,completeSize){
    alert('onProgress: status = ' + status + ' completeSize = ' + completeSize + 'Byte');
  },
  onFinish: function(status){
    alert('onFinish: status = ' + status);
    var pos = status.indexOf("FAILURE");
    if (pos > -1) {
      WL.SimpleDialog.show('Update Failed', 'Press try again button', [ {
        text : "Try Again",
        handler : restartDirectUpdate // restart direct update
      }]);
    }
  }
};
```

Cuando el usuario pulsa el botón **Try Again**, la aplicación reinicia el proceso de actualización directa.


## Actualizaciones directas completas y delta
{: #delta-and-full-direct-update }
Las actualizaciones directas de tipo delta (actualizaciones de diferencias) permiten que una aplicación descargue solo los archivos que han cambiado desde la última actualización en lugar de descargar todos los recursos web de la aplicación.
Esto reduce el tiempo de descarga, conserva el ancho de banda y mejora la experiencia global del usuario.


> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> **Importante:** Una **actualización delta** solo es posible si los recursos web de la aplicación del cliente están una versión por debajo de versión de la aplicación actualmente desplegada en el servidor.
Las aplicaciones de cliente que están más de una versión por detrás de la aplicación desplegada actualmente (es decir, la aplicación se desplegó en el servidor al menos dos veces desde que la aplicación de cliente se actualizó), recibirán una **actualización completa** (es decir, se descargarán y actualizarán todos los recursos web).


## Direct Update seguro
{: #secure-direct-update }
Inhabilitado de forma predeterminada, Direct Update seguro impide que un atacante modifique los recursos web que se transmiten desde {{ site.data.keys.mf_server }} (o desde una CDN (Content Delivery Network) a la aplicación de cliente.


**Para habilitar la autenticación de Direct Update:
**  
Con la ayuda de su herramienta preferida, extraiga la clave pública del almacén de claves de {{ site.data.keys.mf_server }} y conviértala a base64.
  
El valor generado se debería utilizar entonces tal como se indica a continuación:


1. Abra la ventana de **línea de mandatos** y vaya a la raíz del proyecto Cordova.

2. Ejecute el mandato: `mfpdev app config` y seleccione la opción de "clave pública de autenticidad de Direct Update".

3. Proporcione la clave pública y confirme. 

Cualquier entrega futura de Direct Update a aplicaciones de cliente estarán protegidas mediante la autenticidad de Direct Update.


> Para configurar el servidor de aplicaciones con el archivo del almacén de claves actualizado, consulte [Implementación de Direct Update seguro](secure-direct-update)

## Aplicación de ejemplo
{: #sample-application }
[
Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/CustomDirectUpdate/tree/release80) el proyecto de Cordova.
  

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.
