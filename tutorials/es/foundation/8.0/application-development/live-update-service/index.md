---
layout: tutorial
title: Servicio Live Update
relevantTo: [ios,android,cordova]
weight: 11
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }

La característica Live Update en {{ site.data.keys.product }} proporciona una forma simple de definir y ofrecer distintas configuraciones para los usuarios de una aplicación. Incluye un componente en la {{ site.data.keys.mf_console }} para definir la estructura de la configuración así como los valores de la configuración. Se proporciona un SDK de cliente (disponible para aplicaciones Android e iOS **nativas** para Cordova) para consumir la configuración. 

>**Nota**: Para obtener detalles sobre cómo utilizar Live Update con un {{ site.data.keys.mf_server }} tradicional local, consulte la documentación [aquí](live-update/).


### Casos de uso comunes
{: #common-use-cases }
Live Update da soporte a la definición y utilización de configuraciones, lo que facilita las personalizaciones basadas en segmentos para la aplicación. El siguiente es un ejemplo de casos de uso comunes: 

* Trenes de releases y cambios de características

En los releases futuros se dará soporte a los casos de uso siguientes. 

* Realización de pruebas A/B
* Personalización basada en el contexto de la aplicación (por ejemplo, segmentación geográfica)

### Ir a:
{: #jump-to }
* [Concepto](#concept)
* [Arquitectura de Live Update](#live-update-architecture)
* [Adición de Live Update a {{ site.data.keys.mf_server }}](#adding-live-update-to-mobilefirst-server)
* [Configuración de la seguridad de las aplicaciones](#configuring-application-security)
* [Adición de Live Update SDK a aplicaciones](#adding-live-update-sdk-to-applications)
* [Utilización de Live Update SDK](#using-the-live-update-sdk)
* [Temas avanzados](#advanced-topics)

## Concepto
{: #concept }

El servicio Live Update añade las funciones siguientes a cada aplicación.

1. **Características**: Utilizando las características puede definir características de aplicación configurables y establecer sus valores predeterminados. 
2. **Propiedades**: Utilizando las propiedades puede definir las propiedades de las aplicaciones configurables y establecer sus valores predeterminados. 

El desarrollador o el equipo de gestión de aplicaciones debe tomar decisiones sobre lo siguiente.
* El conjunto de características y su estado predeterminado donde se puede utilizar Live Update.
* El conjunto de propiedades de series configurables y sus valores predeterminados.

Cuando haya decidido los parámetros, añada las características y propiedades a la aplicación utilizando la sección Live Update. 

<div class="panel-group accordion" id="terminology" role="tablist" aria-multiselectable="false">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="schema">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#terminology" data-target="#collapseSchema" aria-expanded="false" aria-controls="collapseSchema">Pulse para revisar la terminología</a>
            </h4>
        </div>

        <div id="collapseSchema" class="panel-collapse collapse" role="tabpanel" aria-labelledby="schema">
            <div class="panel-body">
                <ul>
                    <li><b>Característica:</b> Una característica determina si alguna parte de la funcionalidad de la aplicación se habilita o inhabilita. Cuando define una característica en el esquema de una aplicación se deben proporcionar los siguientes elementos:
                        <ul>
                            <li><i>id</i> – Identificador de característica exclusivo. Serie no editable.</li>
                            <li><i>name</i> - Nombre descriptivo de la característica. Serie editable.</li>
                            <li><i>description</i> - Descripción breve de la característica. Serie editable.</li>
                            <li><i>defaultValue</i> – Valor predeterminado de la característica que se ofrecerá mientras no sea modificado dentro del segmento (consulte segmento más abajo). Booleano editable.</li>
                        </ul>
                    </li>
                    <li><b>Propiedad:</b> Una propiedad es una entidad clave:valor que se puede utilizar para personalizar aplicaciones. Cuando define un segmento se deben proporcionar los siguientes elementos:
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
</div>


## Arquitectura de Live Update
{: #live-update-architecture }
Los siguientes componentes de sistema funcionan de forma conjunta con el propósito de proporcionar la funcionalidad de Live Update.

![Visión general de la arquitectura](LU-arch.png)

* **Servicio Live Update:** Un servicio independiente que proporciona: 
   - Gestión de aplicaciones
   - Aprovisionamiento de configuraciones a las aplicaciones
* **SDK del lado de cliente:** Live Update SDK sirve para recuperar y acceder a elementos de configuración como, por ejemplo, las propiedades y características desde {{ site.data.keys.mf_server }}.
* **{{ site.data.keys.mf_console }}:** Se utiliza para configurar los valores y el adaptador de Live Update.

## Adición de Live Update a {{ site.data.keys.mf_server }}
{: #adding-live-update-to-mobilefirst-server }
De forma predeterminada, el servicio Live Update está empaquetado en Mobile Foundation DevKit.

> Para la instalación de OCP (OpenShift Container Platform) consulte la documentación
[aquí](../../ibmcloud/mobilefoundation-on-openshift/).  

Cuando está activado el servicio Live Update, se muestra la página **Valores de Live Update** para cada aplicación registrada. 

## Configuración de la seguridad de las aplicaciones
{: #configuring-application-security }
Con el propósito de permitir la integración con Live Update, se necesita un elemento de ámbito. Sin el elemento de ámbito, el servicio rechazará las solicitudes de las aplicaciones de cliente.   

1. Cargue {{ site.data.keys.mf_console }}.
2. Pulse **[su aplicación] → Separador Seguridad → Correlación de elementos de ámbito**.
3. Pulse **Nuevo** y especifique el elemento de ámbito `liveupdate.mobileclient`.
4. Pulse **Añadir**.

También puede correlacionar el elemento de ámbito con una comprobación de seguridad en el caso de que utilice una en su aplicación.

> [Aprenda más sobre la infraestructura de seguridad de {{ site.data.keys.product_adj }}](../../authentication-and-security/)

<img class="gifplayer" alt="Añadir una correlación de ámbito" src="liveupdate-scopemapping.gif"/>
<br/>

## Definir características y propiedades con valores 
{: #define-features-and-properties-with-values }

Vea la demostración siguiente para definir características y propiedades con valores. 

<img class="gifplayer" alt="Añadir característica y propiedad" src="add-feature-property.png"/>

## Adición de Live Update SDK a las aplicaciones
{: #adding-live-update-sdk-to-applications}
Live Update SDK proporciona a los desarrolladores una API para consultar propiedades y características de configuración de tiempo de ejecución de consulta que con anterioridad estaban definidas en la pantalla de Valores de Live Update de la aplicación registrada en {{ site.data.keys.mf_console }}.

Para **Cordova**, utilice la versión del SDK *8.0.202003051505* o anterior. 
* [Documentación del plugin de Cordova](https://github.com/mfpdev/mfp-live-update-cordova-plugin)

Para **Android**, utilice la versión de SDK *8.0.202003051505*.
* [Documentación de Android SDK ](https://github.com/mfpdev/mfp-live-update-android-sdk)

Para **iOS**, utilice la versión de SDK *8.0.202003051505* o anterior.
* [Documentación de iOS Swift SDK ](https://github.com/mfpdev/mfp-live-update-ios-sdk)

### Adición del plugin de Cordova
{: #adding-the-cordova-plugin }

En la carpeta de la aplicación Cordova, ejecute el mandato siguiente. 

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

2. En la ventana de **línea de mandatos**, vaya a la carpeta raíz del proyecto XCode y ejecute el mandato siguiente. 
  ```bash
  pod install
  ```

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

### Obtenga la configuración 
{: #obtain-config }
Lógica de implementación para recuperar una configuración.   
Sustituya `property-name` y `feature-name` por sus propios valores. 

#### Cordova
{: #cordova }
```javascript
    var input = { };
    LiveUpdateManager.obtainConfiguration({useClientCache :false },function(configuration) {
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
LiveUpdateManager.sharedInstance.obtainConfiguration(completionHandler: { (configuration, error) in
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
LiveUpdateManager.getInstance().obtainConfiguration(new ConfigurationListener() {

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

## Temas avanzados
{: #advanced-topics }

### Colocación en caché
{: #caching }
De forma predeterminada está habilitada la colocación en caché para evitar la latencia de red. Esto significa que es posible que las actualizaciones no se realicen de forma inmediata.  
La colocación en caché se puede inhabilitar si se necesitan actualizaciones más frecuentes.

#### Cordova
{: #cordova-caching }
Controle la caché del lado del cliente utilizando el distintivo booleano _useClientCache_ opcional:

```javascript
var input = {useClientCache : false };
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
LiveUpdateManager.sharedInstance.obtainConfiguration(useCache: false, completionHandler: { (configuration, error) in
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
LiveUpdateManager.getInstance().obtainConfiguration(false, new ConfigurationListener() {

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
El valor `expirationPeriod` es de 30 minutos, que es el periodo de tiempo hasta que caduca la memoria caché. 
