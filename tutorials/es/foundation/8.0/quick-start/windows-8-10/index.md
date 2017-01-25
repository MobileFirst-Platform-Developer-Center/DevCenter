---
layout: tutorial
title: Demostración de principio a fin en Windows 8.1 Universal y Windows 10 UWP
breadcrumb_title: Windows
relevantTo: [windows]
weight: 4
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
* Visual Studio 2013/5 configurado
* *Opcional*. {{site.data.keys.mf_cli }} ([descargar]({{site.baseurl}}/downloads))
* *Opcional*. {{site.data.keys.mf_server }} autónomo ([descargar]({{site.baseurl}}/downloads))

### 1. Cómo iniciar {{site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Asegúrese de haber [creado una instancia de Mobile Foundation](../../bluemix/using-mobile-foundation), o  
Si está utilizando [{{site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), vaya a la carpeta del servidor y ejecute el mandato: `./run.cmd`.

### 2. Creación de una aplicación
{: #2-creating-an-application }
En una ventana de navegador, abra {{site.data.keys.mf_console }} cargando el URL:
`http://su-host-servidor:su-puerto-servidor/mfpconsole`.
Si lo está ejecutando de forma local, utilice [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole).
El nombre de usuario y la contraseña son *admin/admin*.

1. Pulse el botón **Nuevo** junto a **Aplicaciones**
    * Seleccione una plataforma **Windows** 
    * Especifique **MFPStarterCSharp.Windows** como el **identificador de aplicación** para Windows o **MFPStarterCSharp.WindowsPhone** para Windows Phone
    * Especifique **1.0.0** como valore de **versión**
    * Pulse **Registrar aplicación**

    <img class="gifplayer" alt="Registrar una aplicación" src="register-an-application-windows.png"/>

2. Pulse en la ventana **Obtener código de inicio** y seleccione descargar la aplicación de ejemplo de Windows 8.1 o Windows 10.


    <img class="gifplayer" alt="Descargar la aplicación de ejemplo" src="download-starter-code-windows.png"/>

### 3. Edición de la lógica de la aplicación
{: #3-editing-application-logic }
1. Abra el proyecto de Visual Studio. 

2. Seleccione el archivo **MainPage.xaml.cs** de la solución y pegue el siguiente fragmento de código en el método GetAccessToken():

   ```csharp
   try
      {
          IWorklightClient _newClient = WorklightClient.CreateInstance();
          accessToken = await _newClient.AuthorizationManager.ObtainAccessToken("");
          if (accessToken.IsValidToken && accessToken.Value != null && accessToken.Value != "")
          {
              System.Diagnostics.Debug.WriteLine("Received the following access token value: " + accessToken.Value);
              titleTextBlock.Text = "Yay!";
              statusTextBlock.Text = "Connected to {{ site.data.keys.mf_server }}";

              Uri adapterPath = new Uri("/adapters/javaAdapter/resource/greet",UriKind.Relative);
              WorklightResourceRequest request = _newClient.ResourceRequest(adapterPath, "GET","");
              request.SetQueryParameter("name", "world");
              WorklightResponse response = await request.Send();

              System.Diagnostics.Debug.WriteLine("Success: " + response.ResponseText);

            }
        }
        catch (Exception e)
        {
            titleTextBlock.Text = "Uh-oh";
            statusTextBlock.Text = "Client failed to connect to {{ site.data.keys.mf_server }}";
            System.Diagnostics.Debug.WriteLine("An error occurred: '{0}'", e);
        }
   ```


### 4. Despliegue un adaptador
{: 4-deploy-an-adapter }
Descargue [this prepared .adapter artifact](../javaAdapter.adapter) y despliéguelo desde {{site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**.


<!-- Alternatively, click the **New** button next to **Adapters**.  

1. Select the **Actions → Download sample** option. Download the "Hello World" **Java** adapter sample.

    > If Maven and {{ site.data.keys.mf_cli }} are not installed, follow the on-screen **Set up your development environment** instructions.

2. From a **Command-line** window, navigate to the adapter's Maven project root folder and run the command:

    ```bash
    mfpdev adapter build
    ```

3. When the build finishes, deploy it from the {{ site.data.keys.mf_console }} using the **Actions → Deploy adapter** action. The adapter can be found in the **[adapter]/target** folder.

    <img class="gifplayer" alt="Deploy an adapter" src="create-an-adapter.png"/>    -->

<img src="windowsQuickStart.png" alt="Aplicación de ejemplo" style="float:right"/>
### 5. Prueba de la aplicación
{: 5-testing-the-application }
1. En Visual Studio, seleccione el archivo **mfpclient.resw** y edite las propiedades **protocol**, **host** y **port** con los valores correctos para su instasncia de {{site.data.keys.mf_server }}.
    * Si está utilizando una instancia de {{site.data.keys.mf_server }} local, los valores habitualmente son **http**, **localhost** y **9080**.
    * Si está utilizando una instancia remota de {{site.data.keys.mf_server }} (en Bluemix), los valores habitualmente son **https**, **dirección-su-servidor** y **443**.

    Como alternativa, si ha instalado {{site.data.keys.mf_cli }}, navegue hasta la carpeta raíz del proyecto y ejecute el mandato `mfpdev app register`.
Si se utiliza una instancia remota de {{site.data.keys.mf_server }}, [ejecute el mandato `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadir el servidor, seguido por ejemplo por `mfpdev app register myBluemixServer`.

2. Pulse el botón **Ejecutar aplicación**.


### Resultados
{: #results }
* Pulsando el botón **Ping {{site.data.keys.mf_server }}** visualizará **Conectado a {{site.data.keys.mf_server }}**.
* Si la aplicación se pudo conectar a {{site.data.keys.mf_server }}, tendrá lugar una llamada de solicitud de recurso con el adaptador Java desplegado.


La respuesta del adaptador se imprimirá entonces en la consola de salida de Visual Studio.


![Imagen de una aplicación que llamó de forma satisfactoria a un recurso desde {{site.data.keys.mf_server }}](success_response.png)

## Siguientes pasos
{: #next-steps }
Aprenda más sobre cómo utilizar adaptadores en aplicaciones, y cómo integrar servicios adicionales como, por ejemplo, notificaciones push, utilizando la infraestructura de seguridad de {{site.data.keys.product_adj }} entre otras cosas:


- Revise las guías de aprendizaje de [Desarrollo de aplicaciones](../../application-development/)
- Revise las guías de aprendizaje de [Desarrollo de adaptadores](../../adapters/)
- Revise las guías de aprendizaje de [Autenticación y seguridad](../../authentication-and-security/)
- Revise las guías de aprendizaje de [Notificaciones](../../notifications/)
- Revise [Todas las guías de aprendizaje](../../all-tutorials)
