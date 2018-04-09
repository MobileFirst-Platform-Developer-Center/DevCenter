---
layout: tutorial
title: Demostración iOS de principio a fin
breadcrumb_title: iOS
relevantTo: [ios]
weight: 2
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
* Xcode
* *Opcional*. {{ site.data.keys.mf_cli }} ([descargar]({{site.baseurl}}/downloads))
* *Opcional*. {{ site.data.keys.mf_server }} autónomo ([descargar]({{site.baseurl}}/downloads))

### 1. Cómo iniciar {{ site.data.keys.mf_server }}
{: #1-starting-the-mobilefirst-server }
Asegúrese de haber [creado una instancia de Mobile Foundation](../../bluemix/using-mobile-foundation), o  
Si está utilizando [{{ site.data.keys.mf_dev_kit }}](../../installation-configuration/development/mobilefirst), vaya hasta la carpeta del servidor y ejecute el mandato `./run.sh` en Mac y Linux o `run.cmd` en Windows.

### 2. Creación de una aplicación
{: #2-creating-an-application }
En una ventana de navegador, abra {{ site.data.keys.mf_console }} cargando el URL:
`http://su-host-servidor:su-puerto-servidor/mfpconsole`. Si lo está ejecutando de forma local, utilice [http://localhost:9080/mfpconsole](http://localhost:9080/mfpconsole). El nombre de usuario y la contraseña son *admin/admin*.

1. Pulse el botón **Nuevo** junto a **Aplicaciones**
    * Seleccione la plataforma **iOS**
    * Especifique **com.ibm.mfpstarteriosobjectivec** o **com.ibm.mfpstarteriosswift** como **identificador de aplicación** (dependiendo del armazón de la aplicación lo descargará en el siguiente paso)
    * Especifique **1.0** como valore de **versión**
    * Pulse **Registrar aplicación**

    <img class="gifplayer" alt="Registrar una aplicación" src="register-an-application-ios.png"/>

2. Pulse en la ventana **Obtener código de inicio** para seleccionar y descargar la aplicación iOS de ejemplo.

    <img class="gifplayer" alt="Descargar aplicación de ejemplo" src="download-starter-code-ios.png"/>

### 3. Edición de la lógica de la aplicación
{: #3-editing-application-logic }
1. Abra el proyecto Xcode efectuando una doble pulsación sobre el archivo **.xcworkspace**.

2. Seleccione el archivo **[project-root]/ViewController.m/swift** y pegue el siguiente fragmento de código, sustituyendo la función `getAccessToken()` existente:

   En Objective-C:

   ```objc
   - (IBAction)getAccessToken:(id)sender {
   _testServerButton.enabled = NO;
   NSURL *serverURL = [[WLClient sharedInstance] serverUrl];
   _connectionStatusLabel.text = [NSString stringWithFormat:@"Connecting to server...\n%@", serverURL];

   NSLog(@"Testing Server Connection");
   [[WLAuthorizationManager sharedInstance] obtainAccessTokenForScope:@"" withCompletionHandler:^(AccessToken *token, NSError *error) {
        if (error != nil) {
            _titleLabel.text = @"Bummer...";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Failed to connect to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Did not receive an access token from server: %@", error.description);
        } else {
            _titleLabel.text = @"Yay!";
            _connectionStatusLabel.text = [NSString stringWithFormat:@"Connected to {{ site.data.keys.mf_server }}\n%@", serverURL];
            NSLog(@"Received the following access token value: %@", token.value);

            NSURL* url = [NSURL URLWithString:@"/adapters/javaAdapter/resource/greet/"];
            WLResourceRequest* request = [WLResourceRequest requestWithURL:url method:WLHttpMethodGet];

            [request setQueryParameterValue:@"world" forName:@"name"];
            [request sendWithCompletionHandler:^(WLResponse *response, NSError *error) {
                if (error != nil){
                    NSLog(@"Failure: %@",error.description);
                }
                else if (response != nil){
                    // Will print "Hello world" in the Xcode Console.
                    NSLog(@"Success: %@",response.responseText);
                }
            }];
        }

        _testServerButton.enabled = YES;
    }];
}
   ```

   En Swift:

   ```swift
   @IBAction func getAccessToken(sender: AnyObject) {
        self.testServerButton.enabled = false

        let serverURL = WLClient.sharedInstance().serverUrl()

        connectionStatusLabel.text = "Connecting to server...\n\(serverURL)"
        print("Testing Server Connection")
        WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope(nil) { (token, error) -> Void in

            if (error != nil) {
                self.titleLabel.text = "Bummer..."
                self.connectionStatusLabel.text = "Failed to connect to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Did not recieve an access token from server: " + error.description)
            } else {
                self.titleLabel.text = "Yay!"
                self.connectionStatusLabel.text = "Connected to {{ site.data.keys.mf_server }}\n\(serverURL)"
                print("Recieved the following access token value: " + token.value)

                let url = NSURL(string: "/adapters/javaAdapter/resource/greet/")
                let request = WLResourceRequest(URL: url, method: WLHttpMethodGet)

                request.setQueryParameterValue("world", forName: "name")
                request.sendWithCompletionHandler { (response, error) -> Void in
                    if (error != nil){
                        NSLog("Failure: " + error.description)
                    }
                    else if (response != nil){
                        NSLog("Success: " + response.responseText)
                    }
                }
            }

            self.testServerButton.enabled = true
        }
   }
   ```

### 4. Despliegue un adaptador
{: #4-deploy-an-adapter }
Descargue [this prepared .adapter artifact](../javaAdapter.adapter) y despliéguelo desde {{ site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**.

Como alternativa, pulse el botón **Nuevo** junto a **Adaptadores**.  

1. Seleccione la opción **Acciones → Descargar ejemplo**. Descargue el ejemplo de adaptador **Java** de ejemplo "Hello World".

   > Si Maven y {{ site.data.keys.mf_cli }} no están instalados, siga las instrucciones de **Definir su entorno de desarrollo** en la pantalla.

2. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto Maven del adaptador y ejecute el mandato:

   ```bash
   mfpdev adapter build
   ```

3. Cuando finalice la construcción, despliéguelo desde {{ site.data.keys.mf_console }} con la acción **Acciones → Desplegar adaptador**. El adaptador se puede encontrar en la carpeta **[adapter]/target**.

    <img class="gifplayer" alt="Desplegar un adaptador" src="create-an-adapter.png"/>   

<img src="iosQuickStart.png" alt="Aplicación de ejemplo" style="float:right"/>
### 5. Prueba de la aplicación
{: #5-testing-the-application }
1. En Xcode, seleccione el archivo **mfpclient.plist** y edite las propiedades **protocol**, **host** y **port** con los valores correctos para su instancia de {{ site.data.keys.mf_server }}.
    * Si está utilizando una instancia de {{ site.data.keys.mf_server }} local, los valores habitualmente son **http**, **localhost** y **9080**.
    * Si está utilizando una instancia remota de {{ site.data.keys.mf_server }} (en IBM Cloud), los valores habitualmente son **https**, **dirección-su-servidor** y **443**.
    * Si está utilizando un clúster Kubernetes en IBM Cloud Private y si el despliegue es de tipo **NodePort**, el valor del puerto será en general **NodePort** expuesto por el servicio en el clúster Kubernetes.

    Como alternativa, si ha instalado {{ site.data.keys.mf_cli }}, navegue hasta la carpeta raíz del proyecto y ejecute el mandato `mfpdev app register`. Si se utiliza una instancia remota de {{ site.data.keys.mf_server }}, [ejecute el mandato `mfpdev server add`](../../application-development/using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadir el servidor, seguido por ejemplo por `mfpdev app register myIBMCloudServer`.
    
2. Pulse el botón **Reproducir**.

<br clear="all"/>
### Resultados
{: #results }
* Pulsando el botón **Ping {{ site.data.keys.mf_server }}** visualizará **Conectado a {{ site.data.keys.mf_server }}**.
* Si la aplicación se pudo conectar a {{ site.data.keys.mf_server }}, tendrá lugar una llamada de solicitud de recurso con el adaptador Java desplegado.

La respuesta del adaptador se visualiza entonces en la consola de Xcode.

![Imagen de una aplicación que ha llamado de forma satisfactoria a un recurso desde {{ site.data.keys.mf_server }} ](success_response.png)

## Siguientes pasos
{: #next-steps }
Aprenda más sobre cómo utilizar adaptadores en aplicaciones, y cómo integrar servicios adicionales como, por ejemplo, notificaciones push, utilizando la infraestructura de seguridad de {{ site.data.keys.product_adj }} entre otras cosas:

- Revise las guías de aprendizaje de [Desarrollo de aplicaciones](../../application-development/)
- Revise las guías de aprendizaje de [Desarrollo de adaptadores](../../adapters/)
- Revise las guías de aprendizaje de [Autenticación y seguridad](../../authentication-and-security/)
- Revise las guías de aprendizaje de [Notificaciones](../../notifications/)
- Revise [Todas las guías de aprendizaje](../../all-tutorials)
