---
layout: tutorial
title: Demostración Xamarin de principio a fin
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Información general
{: #overview }
El propósito de esta demostración es presentar un flujo de principio a fin:

1. Se registra con {{ site.data.keys.mf_console }} una aplicación de ejemplo que se empaqueta con el SDK de cliente Xamarin de {{ site.data.keys.product_adj }}.
2. Se desplegará un adaptador nuevo o uno que se proporcione en {{ site.data.keys.mf_console }}.  
3. Se cambiará la lógica de la aplicación para realizar una solicitud de recurso.

**Resultado final**:

* Ping satisfactorio a {{ site.data.keys.mf_server }}.

#### Requisitos previos:
{: #prerequisites }
* Xamarin Studio
* *Opcional*. {{ site.data.keys.mf_server }} autónomo ([descargar]({{site.baseurl}}/downloads))

### 1. Cómo iniciar {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Asegúrese de haber [creado una instancia de Mobile Foundation](../../bluemix/using-mobile-foundation), o  
Si está utilizando [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/), vaya hasta la carpeta del servidor y ejecute el mandato `./run.sh` en Mac y Linux o `run.cmd` en Windows.

### 2. Creación de una aplicación
{: #2-creating-an-application }
En una ventana de navegador, abra {{ site.data.keys.mf_console }} cargando el URL:
`http://su-host-servidor:su-puerto-servidor/mfpconsole`. Si lo está ejecutando de forma local, utilice [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). El nombre de usuario y la contraseña son *admin/admin*.

1. Pulse el botón **Nuevo** junto a **Aplicaciones**
    * Seleccione la plataforma **Android**
    * Especifique **com.ibm.mfpstarterxamarin** como el **identificador de aplicación** (dependiendo del armazón de la aplicación lo descargará en el siguiente paso)
    * Especifique **1.0** como valore de **versión**
    * Pulse **Registrar aplicación**

    <img class="gifplayer" alt="Registrar una aplicación" src="register-an-application-xamarin.gif"/>

### 3. Edición de la lógica de la aplicación
{: #3-editing-application-logic }
* Cree un proyecto Xamarin.
* Añada el SDK de Xamarin tal como se menciona en la guía de aprendizaje [Adición del SDK](../../application-development/sdk/xamarin/).
* Añada una propiedad del tipo `IWorklightClient` en cualquier archivo de clase tal como se indica a continuación.

   ```csharp
   /// <summary>
   /// Gets or sets the worklight sample client.
   /// </summary>
   /// <value>The worklight client.</value>
   public static IWorklightClient WorklightClient {get; set;}
   ```
* Si está desarrollando para iOS, pegue el siguiente código dentro del método **FinishedLaunching** del archivo **AppDelegate.cs**:

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance();
  ```
  >Sustituya `<ClassName>` con el nombre de su clase.
* Si está desarrollando para Android, incluya la siguiente línea de código dentro del método **OnCreate** del archivo **MainActivity.cs**:

  ```csharp
   <ClassName>.WorklightClient = WorklightClient.CreateInstance(this);
  ```
  >Sustituya `<ClassName>` con el nombre de su clase.
* Defina un método para obtener la señal de acceso y realizar una solicitud de recurso al servidor MFP tal como se indica a continuación.

    ```csharp
    public async void ObtainToken()
           {
            try
                   {

                       IWorklightClient _newClient = App.WorklightClient;
                       WorklightAccessToken accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");

                       if (accessToken.Value != null &&  accessToken.Value != "")
                       {
                           System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
                           StringBuilder uriBuilder = new StringBuilder().Append("/adapters/javaAdapter/resource/greet");

                           WorklightResourceRequest request = _newClient.ResourceRequest(new Uri(uriBuilder.ToString(), UriKind.Relative), "GET");
                           request.SetQueryParameter("name", "world");
                           WorklightResponse response = await request.Send();

                           System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);
                       }
                   }
                   catch (Exception e)
                   {
                       System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
                   }
               }
           }
    }
   ```

* Invocar al método **ObtainToken** con un constructor de clase o al pulsar un botón.

### 4. Desplegar un adaptador
{: #4-deploy-an-adapter }
Descargue [esta artefacto .adapter preparado](../javaAdapter.adapter) y despliéguelo desde {{ site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**.

Como alternativa, pulse el botón **Nuevo** junto a **Adaptadores**.  

1. Seleccione la opción **Acciones → Descargar ejemplo**. Descargue el ejemplo de adaptador **Java** "Hello World".

   > Si Maven y {{ site.data.keys.mf_cli }} no están instalados, siga las instrucciones de **Definir su entorno de desarrollo**.

2. Desde una ventana de **Línea de mandatos**, vaya a la carpeta raíz del proyecto Maven del adaptador y ejecute el mandato:

   ```bash
   mfpdev adapter build
   ```

3. Cuando finalice la construcción, despliéguelo desde {{ site.data.keys.mf_console }} utilizando la acción **Acciones → Desplegar adaptador**. El adaptador se puede encontrar en la carpeta **[adapter]/target**.

   <img class="gifplayer" alt="Desplegar un adaptador" src="create-an-adapter.png"/>

<!-- <img src="device-screen.png" alt="Aplicación de ejemplo" style="float:right"/>-->
### 5. Probar la aplicación
{: #5-testing-the-application }
1. En Xamarin Studio, seleccione el archivo `mfpclient.properties` y edite las propiedades **protocol**, **host** y **port** con los valores correctos para su instancia de {{ site.data.keys.mf_server }}.
    * Si está utilizando una instancia de {{ site.data.keys.mf_server }} local, los valores habituales son **http**, **localhost** y **9080**.
    * Si está utilizando una instancia de {{ site.data.keys.mf_server }} remota (en IBM Cloud), los valores habituales son **https**, **dirección-su-servidor** y **443**.

* Si está utilizando un clúster Kubernetes en IBM Cloud Private y si el despliegue es de tipo **NodePort**, el valor del puerto será en general **NodePort** expuesto por el servicio en el clúster Kubernetes.

2. Pulse el botón **Reproducir**.

<br clear="all"/>
### Resultados
{: #results }
* Pulse **Hacer ping a MobileFirst Server** para visualizar **Conectado a MobileFirst Server**.
* Si la aplicación se pudo conectar a {{ site.data.keys.mf_server }}, tendrá lugar una llamada de solicitud de recurso con el adaptador Java desplegado.

La respuesta del adaptador se imprime entonces en la consola de Xamarin Studio.

![Imagen de una aplicación que llamó de forma satisfactoria a un recurso desde {{ site.data.keys.mf_server }}](console-output.png)

## Siguientes pasos
{: #next-steps }
Aprenda más sobre cómo utilizar adaptadores en aplicaciones, y cómo integrar servicios adicionales como, por ejemplo, notificaciones push, utilizando la infraestructura de seguridad de {{ site.data.keys.product_adj }} entre otras cosas:

- Revise las guías de aprendizaje de [Desarrollo de adaptadores](../../adapters/) tutorials
- Revise las [guías de aprendizaje de Autenticación y seguridad](../../authentication-and-security/)
- Revise [Todas las guías de aprendizaje](../../all-tutorials)
