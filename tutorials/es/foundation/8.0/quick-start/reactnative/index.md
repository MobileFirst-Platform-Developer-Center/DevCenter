---
layout: tutorial
title: Demostración de React Native de principio a fin
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Información general
{: #overview }
El propósito de esta demostración es explicar un flujo de principio a fin:

1. Desde {{ site.data.keys.mf_console }} se registrará y descargará una aplicación de ejemplo que está empaquetada de forma previa con el SDK de cliente de {{ site.data.keys.product_adj }}
2. Se desplegará un adaptador nuevo o uno que se proporcione en {{ site.data.keys.mf_console }}.  
3. Se cambiará la lógica de la aplicación para realizar una solicitud de recurso.

**Resultado final**:

* Ping satisfactorio a {{ site.data.keys.mf_server }}.
* Recuperación satisfactoria de datos utilizando un adaptador.

### Requisitos previos:
{: #prerequisites }
* Xcode para iOS, Android Studio para Android
* CLI de React Native
* *Opcional*. {{ site.data.keys.mf_cli }} ([descargar]({{site.baseurl}}/downloads))
* *Opcional*. {{ site.data.keys.mf_server }} autónomo ([descargar]({{site.baseurl}}/downloads))

### Paso 1. Cómo iniciar {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Asegúrese de haber [creado una instancia de Mobile Foundation](../../bluemix/using-mobile-foundation), o si está utilizando [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), vaya hasta la carpeta del servidor y ejecute el mandato: `./run.sh` en Mac y Linux o `run.cmd` en Windows.

### Paso 2. Creación y registro de una aplicación
{: #2-creating-and-registering-an-application }
Abra {{ site.data.keys.mf_console }} cargando el URL: `http://your-server-host:server-port/mfpconsole` en el navegador. Si el servidor se está ejecutando de forma local, utilice `http://localhost:9080/mfpconsole`. El *nombre de usuario/contraseña* es **admin/admin**.

1. Pulse el botón **Nuevo** junto a **Aplicaciones**
    * Seleccione una plataforma: **Android, iOS**
    * Especifique **com.ibm.mfpstarter.reactnative** como el **identificador de aplicación**
    * Especifique **1.0.0** como la **versión**
    * Pulse **Registrar aplicación**

    <img class="gifplayer" alt="Registrar una aplicación" src="register-an-application-reactnative.png"/>

2. Descargue la aplicación de ejemplo de React Native desde [Github](https://github.ibm.com/MFPSamples/MFPStarterReactNative).

### Paso 3. Edición de la lógica de aplicación
{: #3-editing-application-logic }
1. Abra el proyecto nativo de React en el editor de código de su elección.

2. Seleccione el archivo **app.js**, que está ubicado en la carpeta raíz del proyecto y pegue el siguiente fragmento de código, sustituyendo la función `WLAuthorizationManager.obtainAccessToken()` existente:

```javascript
  WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        var resourceRequest = new WLResourceRequest("/adapters/javaAdapter/resource/greet/",
          WLResourceRequest.GET
        );
        resourceRequest.setQueryParameters({ name: "world" });
        resourceRequest.send().then(
          (response) => {
            // Will display "Hello world" in an alert dialog.
                        alert("Success: " + response.responseText);
          },
          (error) => {
            alert("Failure: " + JSON.stringify(error));
          }
        );
      }, (error) => {
        console.log('-->  pingMFP(): failure ', error.responseText);
        alert("Failed to connect to MobileFirst Server");
      });
```

### Paso 4. Despliegue de un adaptador
{: #4-deploy-an-adapter }
Descargue el [.adapter artifact](../javaAdapter.adapter) y despliéguelo desde la {{ site.data.keys.mf_console }} utilizando la acción **Acciones → Desplegar adaptador**.

Como alternativa, pulse el botón **Nuevo** junto a **Adaptadores**.  

1. Seleccione la opción **Acciones → Descargar ejemplo**. Descargue el ejemplo de adaptador **Java** de ejemplo *Hello World*.

    > Si Maven y {{ site.data.keys.mf_cli }} no están instalados, siga las instrucciones de **Definir su entorno de desarrollo** en la pantalla.

2. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto Maven del adaptador y ejecute el mandato:

    ```bash
   mfpdev adapter build
   ```

3. Cuando finalice la construcción, despliéguelo desde {{ site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**. El adaptador se puede encontrar en la carpeta **[adapter]/target**.

    <img class="gifplayer" alt="Desplegar un adaptador" src="create-an-adapter.png"/>   


<img src="reactnativeQuickStart.png" alt="aplicación de ejemplo" style="float:right"/>

### Paso 5. Prueba de la aplicación
{: #5-testing-the-application }
1.  Asegúrese de que ha instalado la {{ site.data.keys.mf_cli }} y, a continuación, vaya hasta la carpeta raíz de la plataforma en concreto (iOS o Android) y ejecute el mandato `mfpdev app register`. Si se utiliza un {{ site.data.keys.mf_server }} remoto, [ejecute el mandato](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadir el servidor,
```bash
mfpdev server add
```
seguido del mandato para registrar la aplicación, por ejemplo:
```bash
mfpdev app register myIBMCloudServer
```
2. Ejecute el mandato siguiente, para ejecutar la aplicación:
```bash
react-native run-ios|run-android
```

Si hay conectado un dispositivo, la aplicación se instalará y se iniciará en el dispositivo. De lo contrario, se utilizará el simulador o el emulador.

<br clear="all"/>
### Resultados
{: #results }
* Pulsando el botón **Ping {{ site.data.keys.mf_server }}** visualiza **Conectado a {{ site.data.keys.mf_server }}**.
* Si la aplicación se pudo conectar a {{ site.data.keys.mf_server }}, tendrá lugar una llamada de solicitud de recurso con el adaptador Java desplegado. La respuesta del adaptador se visualiza entonces en una alerta.

## Siguientes pasos
{: #next-steps }
Aprenda más sobre cómo utilizar adaptadores en aplicaciones, y cómo integrar servicios adicionales como, por ejemplo, notificaciones push, utilizando la infraestructura de seguridad de {{ site.data.keys.product_adj }} entre otras cosas:

- Revise las guías de aprendizaje de [Desarrollo de aplicaciones](../../application-development/)
- Revise las guías de aprendizaje de [Desarrollo de adaptadores](../../adapters/)
- Revise las guías de aprendizaje de [Autenticación y seguridad](../../authentication-and-security/)
- Revise las guías de aprendizaje de [Notificaciones](../../notifications/)
- Revise [Todas las guías de aprendizaje](../../all-tutorials)
