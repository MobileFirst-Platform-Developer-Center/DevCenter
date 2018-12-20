---
layout: tutorial
title: Demostración de Ionic de principio a fin
breadcrumb_title: Ionic
relevantTo: [ionic]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Información general
{: #overview }
El propósito de esta demostración es explicar un flujo de principio a fin. Se llevan a cabo los pasos siguientes.

1. Desde {{ site.data.keys.mf_console }} se registrará y descargará una aplicación de ejemplo que está empaquetada de forma previa con el SDK de cliente de {{ site.data.keys.product_adj }}
2. Se desplegará un adaptador nuevo o uno que se proporcione en {{ site.data.keys.mf_console }}.  
3. Se cambiará la lógica de la aplicación para realizar una solicitud de recurso.

**Resultado final**:

* Ping satisfactorio a {{ site.data.keys.mf_server }}.
* Recuperación satisfactoria de datos utilizando un adaptador.

### Requisitos previos:
{: #prerequisites }
* Xcode for iOS, Android Studio for Android o Visual Studio 2015 o superior para Windows 10 UWP
* CLI de Ionic
* *Opcional*. {{ site.data.keys.mf_cli }} ([descargar]({{site.baseurl}}/downloads)).
* *Opcional*. {{ site.data.keys.mf_server }} autónomo ([descargar]({{site.baseurl}}/downloads)).

### Paso 1. Cómo iniciar {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Asegúrese de haber [creado una instancia de Mobile Foundation](../../bluemix/using-mobile-foundation), o si está utilizando [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), vaya hasta la carpeta del servidor y ejecute el mandato: `./run.sh` en Mac y Linux o `run.cmd` en Windows.

### Paso 2. Creación y registro de una aplicación
{: #2-creating-and-registering-an-application }
Abra {{ site.data.keys.mf_console }} cargando el URL: `http://your-server-host:server-port/mfpconsole` en un navegador. Si el servidor se está ejecutando de forma local, utilice `http://localhost:9080/mfpconsole`. El *nombre de usuario/contraseña* es **admin/admin**.

1. Pulse el botón **Nuevo** junto a **Aplicaciones**
    * Seleccione una plataforma de la lista de plataformas: **Android, iOS, Windows, Navegador**
    * Especifique **com.ibm.mfpstarterionic** como el **identificador de aplicación**
    * Especifique **1.0.0** como la **versión**
    * Pulse **Registrar aplicación**

    <img class="gifplayer" alt="Registrar una aplicación" src="register-an-application-ionic.png"/>

2. Descargue la aplicación de ejemplo de Ionic desde [Github](https://github.ibm.com/MFPSamples/MFPStarterIonic).

### Paso 3: Adición del SDK de MobileFirst a la aplicación de Ionic
{: #adding_mfp_ionic_sdk}

Siga estos pasos para añadir el SDK de MobileFirst Ionic a la aplicación de ejemplo de Ionic descargada.

1. Vaya hasta la raíz del proyecto de Ionic existente y añada el plug-in de Ionic Cordova de núcleo de {{ site.data.keys.product_adj }}.

2. Cambie el directorio a la raíz del proyecto de Ionic: `cd MFPStarterIonic`

3. Añada los plugins de MobileFirst utilizando el mandato de CLI de Ionic: `ionic cordova plugin add cordova-plugin-name`
Por ejemplo:

   ```bash
   ionic cordova plugin add cordova-plugin-mfp
   ```

   > El mandato anterior añade el plugin de SDK de MobileFirst Core al proyecto de Ionic.

4. Añada una o varias plataformas soportadas al proyecto de Cordova utilizando el mandato de CLI de Ionic: `ionic cordova platform add ios|android|windows|browser`. Por ejemplo:

   ```bash
   cordova platform add ios
   ```

5. Prepare los recursos de aplicación ejecutando el `mandato ionic cordova prepare`:

   ```bash
   ionic cordova prepare
   ```

### Paso 4. Edición de la lógica de aplicación
{: #3-editing-application-logic }
1. Abra el proyecto de Ionic en el editor de código de su elección.

2. Seleccione el archivo **src/js/index.js** y pegue el siguiente fragmento de código, sustituyendo la función `WLAuthorizationManager.obtainAccessToken()` existente:

```javascript
WLAuthorizationManager.obtainAccessToken("").then(
      (token) => {
        console.log('-->  pingMFP(): Success ', token);
        this.zone.run(() => {
          this.title = "Yay!";
          this.status = "Connected to MobileFirst Server";
        });
        var resourceRequest = new WLResourceRequest( "/adapters/javaAdapter/resource/greet/",
        WLResourceRequest.GET
        );

        resourceRequest.setQueryParameter("name", "world");
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
        this.zone.run(() => {
         this.title = "Bummer...";
         this.status = "Failed to connect to MobileFirst Server";
        });
      }
    );
```

### Paso 5. Desplegar un adaptador
{: #4-deploy-an-adapter }
Descargue este [.adapter artifact](../javaAdapter.adapter) y despliéguelo desde la {{ site.data.keys.mf_console }} utilizando la acción **Acciones → Desplegar adaptador**.

Como alternativa, pulse el botón **Nuevo** junto a **Adaptadores**.  

1. Seleccione la opción **Acciones → Descargar ejemplo**. Descargue el ejemplo de adaptador **Java** de ejemplo *Hello World*.

    > Si Maven y {{ site.data.keys.mf_cli }} no están instalados, siga las instrucciones de **Definir su entorno de desarrollo** en la pantalla.

2. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto Maven del adaptador y ejecute el mandato:

    ```bash
   mfpdev adapter build
   ```

3. Cuando finalice la construcción, despliéguelo desde {{ site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**. El adaptador se puede encontrar en la carpeta **[adapter]/target**.

    <img class="gifplayer" alt="Desplegar un adaptador" src="create-an-adapter.png"/>   


<img src="ionicQuickStart.png" alt="aplicación de ejemplo" style="float:right"/>

### Paso 6. Prueba de la aplicación
{: #5-testing-the-application }
1. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto Cordova.
2. Ejecute el mandato: `ionic cordova platform add ios|android|windows|browser` para añadir una plataforma.
3. En el proyecto Ionic, seleccione el archivo **config.xml** y edite el valor `<mfp:server ... url=" "/>` con las propiedades **protocol**, **host** y **port** con los valores correctos para su instancia de {{ site.data.keys.mf_server }}.
    * Si está utilizando una instancia de {{ site.data.keys.mf_server }} local, los valores habitualmente son **http**, **localhost** y **9080**.
    * Si está utilizando una instancia remota de {{ site.data.keys.mf_server }} (en IBM Cloud), los valores habitualmente son **https**, **dirección-su-servidor** y **443**.
    * Si está utilizando un clúster Kubernetes en IBM Cloud Private y si el despliegue es de tipo **NodePort**, el valor del puerto será en general **NodePort** expuesto por el servicio en el clúster Kubernetes.

    Como alternativa, si ha instalado {{ site.data.keys.mf_cli }}, navegue hasta la carpeta raíz del proyecto y ejecute el mandato `mfpdev app register`. Si se utiliza un {{ site.data.keys.mf_server }} remoto, [ejecute el mandato](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance)
    ```bash
    mfpdev server add
    ```
     to add the server, followed by the command to register the app, for example:
    ```bash
    mfpdev app register myIBMCloudServer
    ```

Si hay conectado un dispositivo, la aplicación se instala y se inicia en el dispositivo.
De lo contrario, se utilizará el simulador o el emulador.

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
