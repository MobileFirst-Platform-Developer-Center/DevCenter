---
layout: tutorial
title: Demostración de principio a fin en Cordova
breadcrumb_title: Cordova
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Información general
{: #overview }
El propósito de esta demostración es presentar un flujo de principio a fin: 

1. Desde {{ site.data.keys.mf_console }} se registrará y descargará una aplicación de ejemplo que está empaquetada de forma previa con el SDK de cliente de {{ site.data.keys.product_adj }} 
2. Se desplegará un adaptador nuevo o uno que se proporcione en {{ site.data.keys.mf_console }}.   
3. Se cambiará la lógica de la aplicación para realizar una solicitud de recurso. 

**Resultado final**:

* Ping satisfactorio a {{ site.data.keys.mf_server }}.
* Recuperación satisfactoria de datos utilizando un adaptador. 

#### Requisitos previos: 
{: #prerequisites }
* Xcode para iOS, Android Studio para Android o Visual Studio 2013/2015 para Windows 8.1 Universal / Windows 10 UWP
* Cordova CLI 6.x.
* *Opcional*. {{ site.data.keys.mf_cli }} ([descargar]({{site.baseurl}}/downloads))
* *Opcional*. {{ site.data.keys.mf_server }} autónomo ([descargar]({{site.baseurl}}/downloads))

### 1. Cómo iniciar {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Asegúrese de haber [creado una instancia de Mobile Foundation](../../bluemix/using-mobile-foundation), o  
Si está utilizando [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), vaya hasta la carpeta del servidor y ejecute el mandato `./run.sh` en Mac y Linux o `run.cmd` en Windows.


### 2. Creación y registro de una aplicación
{: #2-creating-and-registering-an-application }
En una ventana de navegador, abra {{ site.data.keys.mf_console }} cargando el URL:
`http://su-host-servidor:su-puerto-servidor/mfpconsole`.
Si lo está ejecutando de forma local, utilice [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole).
El nombre de usuario y la contraseña son *admin/admin*.
 
1. Pulse el botón **Nuevo** junto a **Aplicaciones**
    * Seleccione una plataforma: **Android, iOS, Windows**
    * Especifique **com.ibm.mfpstartercordova** como el **identificador de aplicación**
    * Especifique **1.0.0** como la **versión**
    * Pulse **Registrar aplicación**

    <img class="gifplayer" alt="Registrar una aplicación" src="register-an-application-cordova.png"/>
 
2. Pulse en la ventana **Obtener código de inicio** para seleccionar y descargar la aplicación Cordova de ejemplo. 

    <img class="gifplayer" alt="Descargar la aplicación de ejemplo" src="download-starter-code-cordova.png"/>
 
### 3. Edición de la lógica de la aplicación
{: #3-editing-application-logic }
1. Abra el proyecto Cordova en el editor de código de su elección. 

2. Seleccione el archivo **www/js/index.js** y pegue el siguiente fragmento de código, sustituyendo la función `WLAuthorizationManager.obtainAccessToken()` existente:


```javascript
WLAuthorizationManager.obtainAccessToken()
    .then(
        function(accessToken) {
            titleText.innerHTML = "Yay!";
            statusText.innerHTML = "Connected to {{ site.data.keys.mf_server }}";
            
            var resourceRequest = new WLResourceRequest(
                "/adapters/javaAdapter/resource/greet/",
                WLResourceRequest.GET
            );
            
            resourceRequest.setQueryParameter("name", "world");
            resourceRequest.send().then(
                function(response) {
                    // Will display "Hello world" in an alert dialog.
                    alert("Success: " + response.responseText);
                },
                function(response) {
                    alert("Failure: " + JSON.stringify(response));
                }
            );
        },

        function(error) {
            titleText.innerHTML = "Bummer...";
            statusText.innerHTML = "Failed to connect to {{ site.data.keys.mf_server }}";
        }
    );
```
    
### 4. Despliegue un adaptador
{: #4-deploy-an-adapter }
Descargue [this prepared .adapter artifact](../javaAdapter.adapter) y despliéguelo desde {{ site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**.


Como alternativa, pulse el botón **Nuevo** junto a **Adaptadores**.  
        
1. Seleccione la opción **Acciones → Descargar ejemplo**.
Descargue el ejemplo de adaptador **Java** de ejemplo "Hello World".


    > Si Maven y {{ site.data.keys.mf_cli }} no están instalados, siga las instrucciones de **Definir su entorno de desarrollo** en la pantalla.
2. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto Maven del adaptador y ejecute el mandato:


    ```bash
    mfpdev adapter build
    ```

3. Cuando finalice la construcción, despliéguelo desde {{ site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**.
El adaptador se puede encontrar en la carpeta **[adapter]/target**.

    
    <img class="gifplayer" alt="Desplegar un adaptador" src="create-an-adapter.png"/>   


<img src="cordovaQuickStart.png" alt="Aplicación de ejemplo" style="float:right"/>
### 5. Prueba de la aplicación
{: #5-testing-the-application }
1. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto Cordova. 
2. Ejecute el mandato: `cordova platform add ios|android|windows` para añadir una plataforma. 
3. En el proyecto Cordova, seleccione el archivo **config.xml** y edite el valor `<mfp:server ... url=" "/>` con las propiedades **protocol**, **host** y **port** con los valores correctos para su instancia de {{ site.data.keys.mf_server }}.

    * Si está utilizando una instancia de {{ site.data.keys.mf_server }} local, los valores habitualmente son **http**, **localhost** y **9080**.
    * Si está utilizando una instancia remota de {{ site.data.keys.mf_server }} (en Bluemix), los valores habitualmente son **https**, **dirección-su-servidor** y **443**.

    Como alternativa, si ha instalado {{ site.data.keys.mf_cli }}, navegue hasta la carpeta raíz del proyecto y ejecute el mandato `mfpdev app register`.
Si se utiliza una instancia remota de {{ site.data.keys.mf_server }}, [ejecute el mandato `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadir el servidor, seguido por ejemplo por `mfpdev app register myBluemixServer`.
	
Si hay conectado un dispositivo, la aplicación se instalará e iniciará en el dispositivo,  
de lo contrario, se utilizará el Simulador o el Emulador.


<br clear="all"/>
### Resultados
{: #results }
* Pulsando el botón **Ping {{ site.data.keys.mf_server }}** visualizará **Conectado a {{ site.data.keys.mf_server }}**.
* Si la aplicación se pudo conectar a {{ site.data.keys.mf_server }}, tendrá lugar una llamada de solicitud de recurso con el adaptador Java desplegado.


La respuesta del adaptador se visualiza entonces en una alerta.


## Siguientes pasos
{: #next-steps }
Aprenda más sobre cómo utilizar adaptadores en aplicaciones, y cómo integrar servicios adicionales como, por ejemplo, notificaciones push, utilizando la infraestructura de seguridad de {{ site.data.keys.product_adj }} entre otras cosas:


- Revise las guías de aprendizaje de [Desarrollo de aplicaciones](../../application-development/)
- Revise las guías de aprendizaje de [Desarrollo de adaptadores](../../adapters/)
- Revise las guías de aprendizaje de [Autenticación y seguridad](../../authentication-and-security/)
- Revise las guías de aprendizaje de [Notificaciones](../../notifications/)
- Revise [Todas las guías de aprendizaje](../../all-tutorials)
