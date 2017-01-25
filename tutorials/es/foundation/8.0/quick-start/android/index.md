---
layout: tutorial
title: Demostración de principio a fin en Android
breadcrumb_title: Android
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Información general
{: #overview }
El propósito de esta demostración es presentar un flujo de principio a fin: 

1. Desde {{site.data.keys.mf_console }} se registrará y descargará una aplicación de ejemplo que está empaquetada de forma previa con el SDK de cliente de {{site.data.keys.product_adj }} 
2. Se desplegará un adaptador nuevo o uno que se proporcione en {{site.data.keys.mf_console }}.   
3. Se cambiará la lógica de la aplicación para realizar una solicitud de recurso. 

**Resultado final**:

* Ping satisfactorio a {{site.data.keys.mf_server }}.
* Recuperación satisfactoria de datos utilizando un adaptador. 

#### Requisitos previos: 
{: #prerequisites }
* Android Studio
* *Opcional*. {{site.data.keys.mf_cli }} ([descargar]({{site.baseurl}}/downloads))
* *Opcional*. {{site.data.keys.mf_server }} autónomo ([descargar]({{site.baseurl}}/downloads))

### 1. Cómo iniciar {{site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Asegúrese de haber [creado una instancia de Mobile Foundation](../../bluemix/using-mobile-foundation), o  
Si está utilizando [{{site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), vaya hasta la carpeta del servidor y ejecute el mandato `./run.sh` en Mac y Linux o `run.cmd` en Windows.


### 2. Creación de una aplicación
{: #2-creating-an-application }
En una ventana de navegador, abra {{site.data.keys.mf_console }} cargando el URL:
`http://su-host-servidor:su-puerto-servidor/mfpconsole`.
Si lo está ejecutando de forma local, utilice [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole).
El nombre de usuario y la contraseña son *admin/admin*.
 
1. Pulse el botón **Nuevo** junto a **Aplicaciones**
    * Seleccione la plataforma **Android** 
    * Especifique **com.ibm.mfpstarterandroid** como el **identificador de aplicación**
    * Especifique **1.0** como valore de **versión**
    * Pulse **Registrar aplicación**

    <img class="gifplayer" alt="Registrar una aplicación" src="register-an-application-android.png"/>
 
2. Pulse en la ventana **Obtener código de inicio** para seleccionar y descargar la aplicación Android de ejemplo. 

    <img class="gifplayer" alt="Descargar aplicación de ejemplo" src="download-starter-code-android.png"/>

### 3. Edición de la lógica de la aplicación
{: #3-editing-application-logic }
1. Abra el proyecto de Android Studio e importe el proyecto. 

2. Desde el menú de la barra lateral **Proyecto**, seleccione el archivo **app → java → com.ibm.mfpstarterandroid → ServerConnectActivity.java** y:


* Añada las siguientes sentencias import:


  ```java
  import java.net.URI;
  import java.net.URISyntaxException;
  import android.util.Log;
  ```
    
* Pegue el siguiente fragmento de código, sustituyendo la llamada para `WLAuthorizationManager.getInstance().obtainAccessToken`:

  ```java
  WLAuthorizationManager.getInstance().obtainAccessToken("", new WLAccessTokenListener() {
                @Override
                public void onSuccess(AccessToken token) {
                    System.out.println("Received the following access token value: " + token);
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Yay!");
                            connectionStatusLabel.setText("Connected to {{ site.data.keys.mf_server }}");
                        }
                    });

                    URI adapterPath = null;
                    try {
                        adapterPath = new URI("/adapters/javaAdapter/resource/greet");
                    } catch (URISyntaxException e) {
                        e.printStackTrace();
                    }

                    WLResourceRequest request = new WLResourceRequest(adapterPath, WLResourceRequest.GET);
                    
                    request.setQueryParameter("name","world");
                    request.send(new WLResponseListener() {
                        @Override
                        public void onSuccess(WLResponse wlResponse) {
                            // Will print "Hello world" in LogCat.
                            Log.i("MobileFirst Quick Start", "Success: " + wlResponse.getResponseText());
                        }

                        @Override
                        public void onFailure(WLFailResponse wlFailResponse) {
                            Log.i("MobileFirst Quick Start", "Failure: " + wlFailResponse.getErrorMsg());
                        }
                    });
                }

                @Override
                public void onFailure(WLFailResponse wlFailResponse) {
                    System.out.println("Did not receive an access token from server: " + wlFailResponse.getErrorMsg());
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            titleLabel.setText("Bummer...");
                            connectionStatusLabel.setText("Failed to connect to {{ site.data.keys.mf_server }}");
                        }
                    });
                }
            });
  ```

### 4. Despliegue un adaptador
{: #4-deploy-an-adapter }
Descargue [this prepared .adapter artifact](../javaAdapter.adapter) y despliéguelo desde {{site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**.


Como alternativa, pulse el botón **Nuevo** junto a **Adaptadores**.  
        
1. Seleccione la opción **Acciones → Descargar ejemplo**.
Descargue el ejemplo de adaptador **Java** de ejemplo "Hello World".


   > Si Maven y {{site.data.keys.mf_cli }} no están instalados, siga las instrucciones de **Definir su entorno de desarrollo** en la pantalla.
2. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto Maven del adaptador y ejecute el mandato:


   ```bash
   mfpdev adapter build
   ```

3. Cuando finalice la construcción, despliéguelo desde {{site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**.
El adaptador se puede encontrar en la carpeta **[adapter]/target**.

    
    <img class="gifplayer" alt="Desplegar un adaptador" src="create-an-adapter.png"/>   

<img src="androidQuickStart.png" alt="Aplicación de ejemplo" style="float:right"/>
### 5. Prueba de la aplicación
{: #5-testing-the-application }

1. En Android Studio, desde el menú de la barra lateral **Proyecto**, seleccione el archivo **app → src → main →assets → mfpclient.properties** y edite las propiedades **protocol**, **host** y **port** con los valores correctos para su instancia de {{site.data.keys.mf_server }}.

    * Si está utilizando una instancia de {{site.data.keys.mf_server }} local, los valores habitualmente son **http**, **localhost** y **9080**.
    * Si está utilizando una instancia remota de {{site.data.keys.mf_server }} (en Bluemix), los valores habitualmente son **https**, **dirección-su-servidor** y **443**.

    Como alternativa, si ha instalado {{site.data.keys.mf_cli }}, navegue hasta la carpeta raíz del proyecto y ejecute el mandato `mfpdev app register`.
Si se utiliza una instancia remota de {{site.data.keys.mf_server }}, [ejecute el mandato `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadir el servidor, seguido por ejemplo por `mfpdev app register myBluemixServer`.

2. Pulse en el botón **Ejecutar aplicación**.
  

<br clear="all"/>
### Resultados
{: #results }
* Pulsando el botón **Ping {{site.data.keys.mf_server }}** visualizará **Conectado a {{site.data.keys.mf_server }}**.
* Si la aplicación se pudo conectar a {{site.data.keys.mf_server }}, tendrá lugar una llamada de solicitud de recurso con el adaptador Java desplegado.


La respuesta del adaptador se imprimirá entonces en la vista LogCat de Android Studio.


![Imagen de una aplicación que llamó de forma satisfactoria a un recurso desde {{site.data.keys.mf_server }}](success_response.png)

## Siguientes pasos
{: #next-steps }
Aprenda más sobre cómo utilizar adaptadores en aplicaciones, y cómo integrar servicios adicionales como, por ejemplo, notificaciones push, utilizando la infraestructura de seguridad de {{site.data.keys.product_adj }} entre otras cosas:


- Revise las guías de aprendizaje de [Desarrollo de aplicaciones](../../application-development/)
- Revise las guías de aprendizaje de [Desarrollo de adaptadores](../../adapters/)
- Revise las guías de aprendizaje de [Autenticación y seguridad](../../authentication-and-security/)
- Revise las guías de aprendizaje de [Notificaciones](../../notifications/)
- Revise [Todas las guías de aprendizaje](../../all-tutorials)
