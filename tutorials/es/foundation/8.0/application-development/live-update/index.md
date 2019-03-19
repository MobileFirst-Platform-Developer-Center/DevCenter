---
layout: tutorial
title: Live Update
relevantTo: [ios,android,cordova]
weight: 11
downloads:
  - name: Download Xcode project
    url: https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateSwift/tree/release80
  - name: Download Android Studio project
    url: https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateAndroid/tree/release80
  - name: Download Live Update adapter
    url: https://github.com/mfpdev/resources/blob/master/liveUpdateAdapter.adapter?raw=true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
La segmentación de usuarios es la práctica de dividir los usuarios en grupos que reflejen su parecido respecto a otros usuarios en cada grupo. Un ejemplo habitual sería una [segmentación geográfica](https://en.wikipedia.org/wiki/Market_segmentation#Geographic_segmentation), esto es, la división de los usuarios en base a ubicación geográfica. El objetivo de la segmentación de usuarios es relacionarlos entre sí en cada segmento con el propósito de maximizar valores.

La característica Live Update en {{ site.data.keys.product }} proporciona una forma simple de definir y ofrecer distintas configuraciones para cada segmento de usuarios de una aplicación. Incluye un componente en {{ site.data.keys.mf_console }} para definir la estructura de la configuración así como los valores de la configuración para cada segmento. También se proporciona un SDK de cliente (disponible para Android e iOS **nativas** y Cordova) para consumir la configuración.

#### Casos de uso comunes
{: #common-use-cases }
Live Update da soporte a la definición y utilización de configuraciones basadas en segmentos, haciendo más fácil realizar personalizaciones basadas en segmentos para la aplicación. Los casos de uso comunes pueden ser:

* Trenes de releases y cambios de características
* Realización de pruebas A/B
* Personalización basada en el contexto de la aplicación (por ejemplo, segmentación geográfica)

#### Demostración
{: #demonstration }
En el siguiente vídeo se proporciona una demostración de la característica Live Update.

<div class="sizer">
    <div class="embed-responsive embed-responsive-16by9">
        <iframe src="https://www.youtube.com/embed/TjbC9thSfmM"></iframe>
    </div>
</div>

#### Ir a:
{: #jump-to }
* [Arquitectura de Live Update](#live-update-architecture)
* [Adición de Live Update a {{ site.data.keys.mf_server }}](#adding-live-update-to-mobilefirst-server)
* [Configuración de la seguridad de las aplicaciones](#configuring-application-security)
* [Esquema y segmentos](#schema-and-segments)
* [Adición de Live Update SDK a aplicaciones](#adding-live-update-sdk-to-applications)
* [Utilización de Live Update SDK](#using-the-live-update-sdk)
* [Temas avanzados](#advanced-topics)
* [Aplicación de ejemplo](#sample-application)


## Arquitectura de Live Update
{: #live-update-architecture }
Los siguientes componentes de sistema funcionan de forma conjunta con el propósito de proporcionar la funcionalidad de Live Update.

![Visión general de la arquitectura](architecture_overview.png)

* **Adaptador de Live Update:** adaptador que proporciona:
 - Gestión de segmentos y esquema de aplicación
 - Aprovisionamiento de configuraciones a las aplicaciones
* **Adaptador resolvedor de segmentos: ** *Opcional*. Se trata de un adaptador que implementan los desarrolladores. El adaptador recibe un contexto de aplicación (como por ejemplo, un contexto de usuario y dispositivo, así como parámetros personalizados) y devuelve el ID de un segmento que corresponde al contexto.
* **SDK del lado de cliente:** Live Update SDK sirve para recuperar y acceder a elementos de configuración como, por ejemplo, las propiedades y características desde {{ site.data.keys.mf_server }}.
* **{{ site.data.keys.mf_console }}:** Se utiliza para configurar los valores y el adaptador de Live Update.
* **Servicio de configuración:** *Interno*. Proporciona servicios de gestión de configuración para el adaptador de Live Update.

## Adición de Live Update a {{ site.data.keys.mf_server }}
{: #adding-live-update-to-mobilefirst-server }
De forma predeterminada, los valores de Live Update en {{ site.data.keys.mf_console }} no se visualizan. Para ello, es necesario desplegar el adaptador de Live Update.  

1. Abra {{ site.data.keys.mf_console }}. Desde la navegación lateral, pulse el separador **Centro de descargas → Herramientas**.
2. Descargue y despliegue el adaptador Live Update.

Una vez desplegado, aparecerá la pantalla **Valores de Live Update** para cada aplicación registrada.

<img class="gifplayer" alt="Desplegar Live Update" src="deploy-live-update.png"/>

## Configuración de la seguridad de las aplicaciones
{: #configuring-application-security }
Con el propósito de permitir la integración con Live Update, se necesita un elemento de ámbito. Sin este elemento, el adaptador rechazará las solicitudes de las aplicaciones de cliente.  

Cargue {{ site.data.keys.mf_console }} y pulse **[su aplicación] → separador Seguridad → Correlaciones de elementos de ámbito**. Pulse **Nuevo** y especifique el elemento de ámbito **configuration-user-login**. A continuación, pulse **Añadir**.

También puede correlacionar el elemento de ámbito con una comprobación de seguridad en el caso de que utilice una en su aplicación.

> [Aprenda más sobre la infraestructura de seguridad de {{ site.data.keys.product_adj }}](../../authentication-and-security/)

<img class="gifplayer" alt="Añadir una correlación de ámbito" src="scope-mapping.png"/>

## Esquema y segmentos
{: #schema-and-segments }
En la pantalla de Valores de Live Update hay disponibles dos separadores:

#### Qué es un esquema
{: #what-is-schema }
Un esquema es el elemento donde se definen sus propiedades y características.  

* Mediante las "características" se definen características de aplicación configurables y se establecen sus valores predeterminados.  
* Mediante las "propiedades" se definen propiedades de aplicación configurables y se establecen sus valores predeterminados.

#### Segmentos
{: #segments }
Los segmentos definen comportamientos de aplicación únicos al personalizar las características y las propiedades predeterminadas que el esquema define.

### Adición de esquema y segmentos
{: #adding-schema-and-segments }
Antes de añadir un esquema y segmentos para una aplicación, el equipo de gestión del producto o los desarrolladores necesitan decidir sobre los distintos aspectos:

* El conjunto de **características** que utilizar con Live Update así como su estado predeterminado.
* El conjunto de series **properties** configurables y sus valores predeterminados
* Los segmentos de mercado para la aplicación

Para cada segmento de mercado se debería decidir:

* El estado de cada característica, y de cómo este estado puede cambiar durante el tiempo de vida de la aplicación.
* El estado de cada propiedad, y de cómo esta propiedad puede cambiar durante el tiempo de vida de la aplicación.

<br/>
Una vez los parámetros estén decididos, se podrán añadir características y propiedades de esquema.  
Para añadir, pulse **Nuevo** y proporcione los valores solicitados.

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="schema">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#terminology" data-target="#collapseSchema" aria-expanded="false" aria-controls="collapseSchema">Pulse para revisar la terminología del esquema</a>
            </h4>
        </div>

        <div id="collapseSchema" class="panel-collapse collapse" role="tabpanel" aria-labelledby="schema">
            <div class="panel-body">
                <ul>
                    <li><b>Característica:</b> Una característica determina si alguna parte de la funcionalidad de la aplicación se habilita o inhabilita. Al definir una característica en el esquema de una aplicación se deben proporcionar los siguientes elementos:
                        <ul>
                            <li><i>id</i> – Identificador de característica exclusivo. Serie no editable.</li>
                            <li><i>name</i> - Nombre descriptivo de la característica. Serie editable.</li>
                            <li><i>description</i> - Descripción breve de la característica. Serie editable.</li>
                            <li><i>defaultValue</i> – Valor predeterminado de la característica que se ofrecerá mientras no sea modificado dentro del segmento (consulte segmento más abajo). Booleano editable.</li>
                        </ul>
                    </li>
                    <li><b>Propiedad:</b> Una propiedad es una entidad clave:valor que se puede utilizar para personalizar aplicaciones. Al definir una propiedad en el esquema de una aplicación se deben proporcionar los siguientes elementos:
                        <ul>
                            <li><i>id</i> – Identificador de propiedad exclusivo. Serie no editable.</li>
                            <li><i>name</i> - Nombre descriptivo de una propiedad. Serie editable.</li>
                            <li><i>description</i> - Descripción breve de la propiedad. Serie editable.</li>
                            <li><i>defaultValue</i> – Valor predeterminado de la propiedad que se ofrecerá mientras no sea modificado dentro del segmento (consulte segmento más abajo). Serie editable.</li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="segment">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#terminology" data-target="#collapseSegment" aria-expanded="false" aria-controls="collapseSegment">Pulse para revisar la terminología de segmento</a>
            </h4>
        </div>

        <div id="collapseSegment" class="panel-collapse collapse" role="tabpanel" aria-labelledby="segment">
            <div class="panel-body">
                <ul>
                    <li><b>Segmento:</b> Un segmento es una entidad que corresponde a un segmento del mercado. Contiene características y propiedades que se definieron en el esquema y que potencialmente pueden modificar valores. Al definir un segmento se deben proporcionar los siguientes elementos:
                        <ul>
                            <li><i>id</i> - Identificador de segmento exclusivo. Serie no editable.</li>
                            <li><i>name</i> - Nombre descriptivo de un segmento. Serie editable.</li>
                            <li><i>description</i> - Descripción breve del segmento. Serie editable.</li>
                            <li><i>Característica</i>  - En la lista de características tal como se definen en el esquema, el usuario puede establecer un valor estático para una característica que difiera del valor predeterminado del esquema.</li>
                            <li><i>Propiedades</i> - En la lista de propiedades tal como se definen en el esquema, el usuario puede establecer un valor estático para una propiedad que difiera del valor predeterminado del esquema.</li>
                        </ul>
                    </li>
                </ul>

                <blockquote><b>Nota:</b><br/>
                    <ul>
                        <li>Cuando una característica o propiedad se añade a un esquema, la correspondiente propiedad o característica se añade de forma automática a todos los segmentos de una aplicación (con el valor predeterminado)</li>
                        <li>Cuando una característica o propiedad se elimina de un esquema, la correspondiente característica o propiedad se elimina de forma automática de todos los segmentos de una aplicación.</li>
                    </ul>
                </blockquote>
            </div>
        </div>
    </div>
</div>

#### Definición de propiedades y características de esquema con los valores predeterminados
{: #define-schema-features-and-properties-with-default-values }
<img class="gifplayer" alt="Añadir propiedad y característica de esquema" src="add-feature-property.png"/>

#### Definición de segmentos que corresponden a segmentos de mercado
{: #define-degments-that-correspond-to-market-segments }
<img class="gifplayer" alt="Añadir un segmento" src="add-segment.png"/>

#### Modificación de los valores predeterminados de características y propiedades
{: #override-default-values-of-features-and-properties }
Habilite una característica y cambie su estado predeterminado.
<img class="gifplayer" alt="Habilitar una característica" src="feature-enabling.png"/>

Modifique el valor predeterminado de una propiedad.
<img class="gifplayer" alt="Modificar una propiedad" src="property-override.png"/>

## Adición de Live Update SDK a las aplicaciones
{: #adding-live-update-sdk-to-applications}
Live Update SDK proporciona a los desarrolladores una API para consultar propiedades y características de configuración de tiempo de ejecución de consulta que con anterioridad estaban definidas en la pantalla de Valores de Live Update de la aplicación registrada en {{ site.data.keys.mf_console }}.

* [Documentación del plugin de Cordova](https://github.com/mfpdev/mfp-live-update-cordova-plugin)
* [Documentación de iOS Swift SDK ](https://github.com/mfpdev/mfp-live-update-ios-sdk)
* [Documentación de Android SDK ](https://github.com/mfpdev/mfp-live-update-android-sdk)

### Adición del plugin de Cordova
{: #adding-the-cordova-plugin }
En la carpeta de la aplicación de Cordova ejecute:

```bash
cordova plugin add cordova-plugin-mfp-liveupdate
```

### Adición de iOS SDK
{: #adding-the-ios-sdk }
1. Edite el podfile de la aplicación añadiendo el pod `IBMMobileFirstPlatformFoundationLiveUpdate`.  
 Por ejemplo:

   ```xml
   use_frameworks!

   target 'your-Xcode-project-target' do
      pod 'IBMMobileFirstPlatformFoundation'
      pod 'IBMMobileFirstPlatformFoundationLiveUpdate'
   end
   ```

2. Desde una ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto Xcode y ejecute el mandato:
`pod install`.

### Adición de Android SDK
{: #adding-the-android-sdk }
1. En Android Studio, seleccione **Android → Scripts de Gradle** y, a continuación, seleccione el archivo **build.gradle (Módulo: app)**.
2. Añada `ibmmobilefirstplatformfoundationliveupdate` dentro de `dependencies`:

   ```xml
   dependencies {
        compile group: 'com.ibm.mobile.foundation',
        name: 'ibmmobilefirstplatformfoundation',
        version: '8.0.+',
        ext: 'aar',
        transitive: true

        compile group: 'com.ibm.mobile.foundation',
        name: 'ibmmobilefirstplatformfoundationliveupdate',
        version: '8.0.0',
        ext: 'aar',
        transitive: true
   }   
   ```

## Utilización de Live Update SDK
{: #using-the-live-update-sdk }
Existen varias maneras de utilizar Live Update SDK.

### Segmentos predeterminados
{: #pre-determined-segment }
Lógica de implementación para recuperar una configuración de un segmento concreto.  
Sustituya "segment-name", "property-name" y "feature-name" con sus propios valores.

#### Cordova
{: #cordova }
```javascript
    var input = { segmentId :'segment-name' };
    LiveUpdateManager.obtainConfiguration(input,function(configuration) {
        // do something with configration (JSON) object, for example,
        // if you defined in the server a feature named 'feature-name':
        // if (configuration.features.feature-name) {
        //   console.log(configuration.properties.property-name);
	// }
    } ,
    function(err) {
        if (err) {
           alert('liveupdate error:'+err);
        }
  });
```

#### iOS
{: #ios }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration("segment-name", completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})
```

#### Android
{: #android }
```java
LiveUpdateManager.getInstance().obtainConfiguration("segment-name", new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
        Log.i("LiveUpdateDemo", configuration.getProperty("property-name"));
        Log.i("LiveUpdateDemo", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateDemo", wlFailResponse.getErrorMsg());
    }
});
```

Con la configuración de Live Update recuperada, la lógica de la aplicación y el flujo de la aplicación se basará en el estado de las características y propiedades. Por ejemplo, si hoy es una fiesta nacional, se presentará una nueva promoción de marketing en la aplicación.

### Adaptador resolvedor de segmentos
{: #segment-resolver-adapter }
En el tema [Arquitectura de Live Update](#live-update-architecture), se mencionó un adaptador "resolvedor de segmentos".  
El propósito de este adaptador es proporcionar una lógica empresarial personalizada para recuperar un segmento base al contexto de usuario/aplicación/dispositivo y los parámetros personalizados del aplicativo.

Para utilizar un adaptador resolvedor de segmentos:

1. [Cree un nuevo adaptador Java](../../adapters/creating-adapters/).
2. Defina el adaptador como un adaptador resolvedor de segmentos en **Adaptadores → Adaptador de Live Update → segmentResolverAdapterName**.
3. Cuando se haya completado el desarrollo, recuerde también [compilarlo y desplegarlo](../../adapters/creating-adapters/).

El adaptador resolvedor de segmentos define una interfaz REST. La solicitud a este adaptador contiene en su cuerpo toda la información necesaria para decidir el segmento al que pertenece el usuario final y lo envía de vuelta a la aplicación.

Si desea obtener la configuración mediante parámetros, utilice la API Live Update para enviar la solicitud:

#### Resolvedor de Cordova
{: cordova-resolver }
```javascript
var input = { params : { 'paramKey': 'paramValue'} ,useClientCache : true };                                                                                                    
LiveUpdateManager.obtainConfiguration(input,function(configuration) {
        // do something with configration (JSON) object, for example:
        // console.log(configuration.properties.property-name);                                                                                                             // console.log(configuration.data.features.feature-name);                                                                                                        
    } ,
    function(err) {
        if (err) {
           alert('liveupdate error:'+err);
        }
  });
```

#### iOS
{: #ios-resolver }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration(["paramKey":"paramValue"], completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})
```

#### Android
{: #android-resolver }
```java
Map <String,String> params = new HashMap<>();
params.put("paramKey", "paramValue");

LiveUpdateManager.getInstance().obtainConfiguration(params , new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
        Log.i("LiveUpdateDemo", configuration.getProperty("property-name"));
        Log.i("LiveUpdateDemo", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateDemo", wlFailResponse.getErrorMsg());
    }
});
```

#### Implementación de adaptador
{: #adapter-implementation }
Los argumentos que la aplicación proporciona mediante el SDK de cliente de Live Update se pasan entonces al adaptador de Live Update y desde allí al adaptador resolvedor de segmentos. Esto lo realiza de forma automática el adaptador de Live Update sin que se necesite acción alguna por parte del desarrollador.

Actualice la implementación del adaptador resolvedor de segmentos recién creado para manejar estos argumentos para devolver el segmento relevante.  
A continuación se muestra el código de ejemplo que puede utilizar.

**Nota:** Asegúrese de añadir la dependencia Gson en su `pom.xml` del adaptador:

```xml
<dependency>
    <groupId>com.google.code.gson</groupId>
    <artifactId>gson</artifactId>
    <version>2.7</version>
</dependency>
```

**SampleSegmentResolverAdapterApplication.java**  

```java
@Api(value = "Sample segment resolver adapter")
@Path("/")
public class SampleSegmentResolverAdapter {

    private static final Gson gson = new Gson();
    private static final Logger logger = Logger.getLogger(SampleSegmentResolverAdapter.class.getName());

    @POST
    @Path("segment")
    @Produces("text/plain;charset=UTF-8")
    @OAuthSecurity(enabled = true, scope = "configuration-user-login")
    public String getSegment(String body) throws Exception {
        ResolverAdapterData data = gson.fromJson(body, ResolverAdapterData.class);
        String segmentName = "";

        // Get the custom arguments
        Map<String, List<String>> arguments = data.getQueryArguments();

        // Get the authenticatedUser object
        AuthenticatedUser authenticatedUser = data.getAuthenticatedUser();
        String name = authenticatedUser.getDisplayName();

        // Get registration data such as device and application
        RegistrationData registrationData = data.getRegistrationData();
        ApplicationKey application = registrationData.getApplication();
        DeviceData deviceData = registrationData.getDevice();

        // Based on the above context (arguments, authenticatedUser and registrationData) resolve the segment name.
        // Write your custom logic to resolve the segment name.

        return segmentName;
    }
}
```

**SampleSegmentResolverAdapter.java**

```java
public class ResolverAdapterData {
    public ResolverAdapterData() {
    }

    public ResolverAdapterData(AdapterSecurityContext asc, Map<String, List<String>> queryArguments)
    {
        ClientData cd = asc.getClientRegistrationData();

        this.authenticatedUser = asc.getAuthenticatedUser();
        this.registrationData = cd == null ? null : cd.getRegistration();
        this.queryArguments = queryArguments;
    }

    public AuthenticatedUser getAuthenticatedUser() {
        return authenticatedUser;
    }

    public RegistrationData getRegistrationData() {
        return registrationData;
    }

    public Map<String, List<String>> getQueryArguments() {
        return queryArguments;
    }

    private AuthenticatedUser authenticatedUser;
    private RegistrationData registrationData;
    private Map<String, List<String>> queryArguments;
}
```

#### Interfaz REST del adaptador resolvedor de segmentos
{: #rest-interface-of-the-segment-resolver-adapter }
**Solicitud**

| **Atributo** |  **Valor**                                                                                     |  
|:----------------|:--------------------------------------------------------------------------------------------------|
| *URL*           | /segment                                                                                          |
| *Método*        | POST                                                                                              |               
| *Tipo de contenido*  | application/json                                                                                  |
| *Cuerpo*          | &lt;objeto JSON con toda la información necesaria para la resolución de segmentos&gt;                     |

**Respuesta**

|  **Atributo**   |  **Valor**                                |
|:-------------------|:--------------------------------------------|
| *Tipo de contenido*     | text/plain                                  |                                                                          
| *Cuerpo*             |  &lt;serie que describe el ID de segmento&gt;   |


## Temas avanzados
{: #advanced-topics }
### Importación/Exportación
{: #importexport }
Una vez se hayan definido esquemas y segmentos, el administrador del sistema puede exportarlos e importarlos a otras instancias de servidor.

#### Exportación de esquema
{: #export-schema }
```bash
curl --user admin:admin http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/schema > schema.txt
```

#### Importación de esquema
{: #import-schema }
```bash
curl -X PUT -d @schema.txt --user admin:admin -H "Content-Type:application/json" http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/schema
```

* Sustituya "admin:admin" con su propio valor (el valor predeterminado es "admin")
* Sustituya "localhost" y el número de puerto con el suyo propio si es necesario
* Sustituya el identificador de aplicación "com.sample.HelloLiveUpdate" con el de su propia aplicación.

#### Exportación de segmentos
{: #export-segments }
```bash
curl --user admin:admin http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/segment?embedObjects=true > segments.txt
```

#### Importación de segmentos
{: #import-segments }
```bash
#!/bin/bash
segments_number=$(python -c 'import json,sys;obj=json.load(sys.stdin);print len(obj["items"]);' < segments.txt)
counter=0
while [ $segments_number -gt $counter ]
do
    segment=$(cat segments.txt | python -c 'import json,sys;obj=json.load(sys.stdin);data_str=json.dumps(obj["items"]['$counter']);print data_str;')
    echo $segment | curl -X POST -d @- --user admin:admin --header "Content-Type:application/json" http://localhost:9080/mfpadmin/management-apis/2.0/runtimes/mfp/admin-plugins/liveUpdateAdapter/com.sample.HelloLiveUpdate/segment
    ((counter++))
done
```

* Sustituya "admin:admin" con su propio valor (el valor predeterminado es "admin")
* Sustituya "localhost" y el número de puerto con el suyo propio si es necesario
* Sustituya el identificador de aplicación "com.sample.HelloLiveUpdate" con el de su propia aplicación.

### Colocación en caché
{: #caching }
De forma predeterminada está habilitada la colocación en caché para evitar la latencia de red. Esto significa que es posible que las actualizaciones no se realicen de forma inmediata.  
La colocación en caché se puede inhabilitar si se necesitan actualizaciones más frecuentes.

#### Cordova
{: #cordova-caching }
Controle la caché del lado del cliente mediante la utilización del distintivo booleano _useClientCache_ opcional:

```javascript
	var input = { segmentId :'18' ,useClientCache : false };
        LiveUpdateManager.getConfiguration(input,function(configuration) {
                // do something with resulting configuration, for example:
                // console.log(configuration.data.properties.property-name);  
                // console.log(configuration.data.features.feature-name);
        } ,
        function(err) {
                if (err) {
                   alert('liveupdate error:'+err);
                }
  });
```

#### iOS
{: #ios-caching }
```swift
LiveUpdateManager.sharedInstance.obtainConfiguration("segment-name", useCache: false, completionHandler: { (configuration, error) in
  if error == nil {
    print (configuration?.getProperty("property-name"))
    print (configuration?.isFeatureEnabled("feature-name"))
  } else {
    print (error)
  }
})
```

#### Android
{: #android-caching }
```java
LiveUpdateManager.getInstance().obtainConfiguration("segment-name", false, new ConfigurationListener() {

    @Override
    public void onSuccess(final Configuration configuration) {
      Log.i("LiveUpdateSample", configuration.getProperty("property-name"));
      Log.i("LiveUpdateSample", configuration.isFeatureEnabled("feature-name").toString());
    }

    @Override
    public void onFailure(WLFailResponse wlFailResponse) {
        Log.e("LiveUpdateSample", wlFailResponse.getErrorMsg());
    }
});
```

### Caducidad de caché
{: #cache-expiration }
El valor `expirationPeriod` que se define en **Adaptadores → Adaptador de Live Update** determina la longitud hasta que la colocación en caché caduca.

<img alt="Imagen de aplicación de ejemplo" src="live-update-app.png" style="margin-left: 10px;float:right"/>

## Aplicación de ejemplo
{: #sample-application }
En la aplicación de ejemplo seleccione una bandera de un país y, a continuación, con la ayuda de Live Update la aplicación a continuación genera texto de salida en el idioma que corresponde al país seleccionado. Si se habilita la característica de mapa y se proporciona un mapa, se visualizará el correspondiente país.

[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateSwift/tree/release80) el proyecto de Xcode.  
[Pulse para descargar](https://github.com/MobileFirst-Platform-Developer-Center/LiveUpdateAndroid/tree/release80) el proyecto de Android Studio.

### Uso de ejemplo
{: #sample-usage }
Siga el archivo README.md de ejemplo para obtener instrucciones.

#### Cómo cambiar los valores de Live Update
{: #changing-live-update-settings }
Cada segmento obtiene el valor predeterminado del esquema. Cambie cada uno de ellos según el idioma. Por ejemplo, para el francés, añada: **helloText** - **Bonjour le monde**.

En **{{ site.data.keys.mf_console }} → [su aplicación] → Valores de Live Update → separador Segmentos**, pulse en el enlace **Propiedades** que le corresponde, por ejemplo para **FR**.

* Pulse el icono **Editar** y proporcione un enlace a una imagen que se representa por ejemplo para el mapa geográfico de Francia.
* Para ver el mapa mientras se utiliza la aplicación, necesita habilitar la característica `includeMap`.
