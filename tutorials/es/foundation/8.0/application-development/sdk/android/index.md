---
layout: tutorial
title: Adición de MobileFirst Foundation SDK a aplicaciones Android
breadcrumb_title: Android
relevantTo: [android]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
El producto {{ site.data.keys.product_full }} SDK está formado por un conjunto de dependencias que están disponibles a través de [Maven Central](http://search.maven.org/) y que puede añadir a su proyecto de Android Studio.
Las dependencias corresponden a funciones principales y a otras funciones:


* **IBMMobileFirstPlatformFoundation** - Implementa la conectividad de cliente a servidor, maneja la autenticación y los aspectos de seguridad, solicitudes de recursos y otras funciones básicas necesarias.

* **IBMMobileFirstPlatformFoundationJSONStore** - Contiene la infraestructura de JSONStore. Para obtener más información, revise la [guía de aprendizaje JSONStore para Android](../../jsonstore/android/).

* **IBMMobileFirstPlatformFoundationPush** - Contiene la infraestructura de notificaciones push.
Para obtener más información, revise las [guías de aprendizajes de notificaciones](../../../notifications/).

En esta guía de aprendizaje, aprenderá a añadir {{ site.data.keys.product_adj }} Native SDK mediante Gradle para una aplicación Android nueva o existente.
También aprenderá a configurar {{ site.data.keys.mf_server }} para que reconozca la aplicación, y para encontrar información sobre los archivos de configuración {{ site.data.keys.product_adj }} que se añaden al proyecto.


**Requisitos previos:**

- Android Studio y {{ site.data.keys.mf_cli }} instalado en la estación de trabajo del desarrollador.
  
- Una instancia remota o local de {{ site.data.keys.mf_server }} que esté en ejecución.

- Consulte las guías de aprendizaje de [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/development/mobilefirst) y [Configuración del entorno de desarrollo Android](../../../installation-configuration/development/android).


#### Ir a:
{: #jump-to }
- [Adición de {{ site.data.keys.product_adj }} Native SDK](#adding-the-mobilefirst-native-sdk)
- [Adición manual de {{ site.data.keys.product_adj }} Native SDK](#manually-adding-the-mobilefirst-native-sdk)
- [Actualización de {{ site.data.keys.product_adj }} Native SDK](#updating-the-mobilefirst-native-sdk)
- [Artefactos de {{ site.data.keys.product_adj }} Native SDK generados](#generated-mobilefirst-native-sdk-artifacts)
- [Soporte para Javadoc y el servicio Android](#support-for-javadoc-and-android-service)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Adición de {{ site.data.keys.product_adj }} Native SDK
{: #adding-the-mobilefirst-native-sdk }
Siga las instrucciones que hay más abajo para añadir {{ site.data.keys.product_adj }} Native SDK a un proyecto de Android Studio nuevo o existente y para registrar la aplicación para la instancia de {{ site.data.keys.mf_server }}.


Antes de empezar, asegúrese de que {{ site.data.keys.mf_server }} se encuentra en ejecución.
  
Si utiliza un servidor instalado de forma local: desde la ventana de **línea de mandatos**, vaya hasta la carpeta del servidor y ejecute el mandato `./run.sh` en los sistemas operativos Mac o Linux o `run.cmd` en Windows.


### Creación de una aplicación Android
{: #creating-an-android-application }
Cree un proyecto de Android Studio o utilice uno existente.
  

### Adición del SDK
{: #adding-the-sdk }
1. En **Android → Scripts de Gradle**, seleccione el archivo **build.gradle (Módulo: app)**.


2. Añada las siguientes líneas después de `apply plugin: 'com.android.application'`:

   ```xml
   repositories{
        jcenter()
   }
   ```

3. Añada lo siguiente dentro de la sección `android`: 

   ```xml
   packagingOptions {
        pickFirst 'META-INF/ASL2.0'
        pickFirst 'META-INF/LICENSE'
        pickFirst 'META-INF/NOTICE'
   }
   ```

4. Añada las siguientes líneas dentro de la sección `dependencies`:


   ```xml
   compile group: 'com.ibm.mobile.foundation',
   name: 'ibmmobilefirstplatformfoundation',
   version: '8.0.+',
   ext: 'aar',
   transitive: true
   ```

   O en una única línea: 

   ```xml
   compile 'com.ibm.mobile.foundation:ibmmobilefirstplatformfoundation:8.0.+'
   ```

5. En **Android → app → manifiestos**, abra el archivo `AndroidManifest.xml`.
Añada los siguientes permisos por encima del elemento **application**:


   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
   ```

6. Añada la actividad de interfaz de usuario de {{ site.data.keys.product_adj }} junto al elemento **activity** existente:


   ```xml
   <activity android:name="com.worklight.wlclient.ui.UIActivity" />
   ```

> Si aparece una solicitud de Gradle Sync, acéptela. 

### Adición manual de {{ site.data.keys.product_adj }} Native SDK
{: #manually-adding-the-mobilefirst-native-sdk }
También es posible añadir el SDK de {{ site.data.keys.product_adj }}:


<div class="panel-group accordion" id="adding-the-sdk-manually" role="tablist">
    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="android-sdk">
            <h4 class="panel-title">
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>Pulse para obtener instrucciones</b></a>
            </h4>
        </div>

        <div id="collapse-android-sdk" class="panel-collapse collapse" role="tabpanel" aria-labelledby="android-sdk">
            <div class="panel-body">
                <p>Para añadir de forma manual el SDK de {{ site.data.keys.product_adj }}, descargue primero el archivo .zip SDK desde el separador <b>{{ site.data.keys.mf_console }} → Centro de descargas → SDK</b>. Después de completar los pasos anteriores, siga también más abajo. </p>

                <ul>
                    <li>Extraiga el archivo .zip descargado y coloque los archivos relevantes en la carpeta <b>app\libs</b>. </li>
                    <li>Añada lo siguiente al cierre de <b>dependencies</b>:
{% highlight xml %}
compile(name:'ibmmobilefirstplatformfoundation', ext:'aar')
compile 'com.squareup.okhttp3:okhttp-urlconnection:3.4.1'   
compile 'com.squareup.okhttp3:okhttp:3.4.1'
{% endhighlight %}
                    </li>
                    <li>
Añada lo siguiente al cierre de <b>repositories</b>:
{% highlight xml %}
repositories {
    flatDir {
        dirs 'libs'
    }
}
{% endhighlight %}
                    </li>
                </ul>

                <br/>
                <a class="preventScroll" role="button" data-toggle="collapse" data-parent="#android-sdk" data-target="#collapse-android-sdk" aria-expanded="false" aria-controls="collapse-android-sdk"><b>Sección de cierre</b></a>
            </div>
        </div>
    </div>
</div>



### Registro de la aplicación
{: #registering-the-application }
1. Abra una ventana de **línea de mandatos** y vaya a la raíz del proyecto Android Studio.
  

2. Ejecute el mandato:


    ```bash
    mfpdev app register
    ```
    - Si se utiliza un servidor remoto, [utilice el mandato `mfpdev server add`](../../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) para añadirlo.


El mandato de interfaz de línea de mandatos `mfpdev app register` se conecta primero a {{ site.data.keys.mf_server }} para registrar la aplicación y después genera el archivo **mfpclient.properties** en la carpeta **[raíz proyecto]/app/src/main/assets/** del proyecto Android Studio y para añadirlo en los metadatos que identifican a {{ site.data.keys.mf_server }}.


> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Sugerencia:** También es posible registrar aplicaciones desde {{ site.data.keys.mf_console }}:    
>
> 1. Cargue {{ site.data.keys.mf_console }}.  
> 2. Pulse el botón **Nuevo** junto a **Aplicaciones** para registrar una nueva aplicación y seguir las instrucciones en la pantalla.
  
> 3. Después de que se registre la aplicación, vaya al separador **Archivos de configuración** y copie o descargue el archivo **mfpclient.properties**.
Siga las instrucciones en la pantalla para añadir el archivo al proyecto.



### Creación de una instancia de WLClient 
{: #creating-a-wlclient-instance }
Antes de utilizar las API de {{ site.data.keys.product_adj }}, cree una instancia de `WLClient`:


```java
WLClient.createInstance(this);
```

**Nota:** La creación de una instancia de `WLClient` solo debería ocurrir una vez en todo el ciclo de vida de la aplicación.
Es recomendable para ello utilizar la clase Application de Android.


## Actualización de {{ site.data.keys.product_adj }} Native SDK
{: #updating-the-mobilefirst-native-sdk }
Para actualizar {{ site.data.keys.product_adj }} Native SDK con el último release, encuentre el número de versión de release y actualice la propiedad `version` según corresponda en el archivo **build.gradle**.
  
Consulte el paso 4 anterior.


Los releases de SDK se pueden encontrar en el [repositorio JCenter ](https://bintray.com/bintray/jcenter/com.ibm.mobile.foundation%3Aibmmobilefirstplatformfoundation/view#) de SDK.


## Artefactos de {{ site.data.keys.product_adj }} Native SDK generados
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.properties
{: #mfpclient.properties }
Ubicado en la carpeta **./app/src/main/assets/** del proyecto Android Studio, este archivo define las propiedades utilizadas del lado del cliente para registrar su aplicación Android en {{ site.data.keys.mf_server }}.


|Propiedad |Descripción |Valores de ejemplo |
|---------------------|---------------------------------------------------------------------|----------------|
|wlServerProtocol    |Protocolo de comunicación con {{ site.data.keys.mf_server }}.             |http o https  |
|wlServerHost        |Nombre de host de {{ site.data.keys.mf_server }}.                            |192.168.1.63   |
|wlServerPort        |Puerto de {{ site.data.keys.mf_server }}.                           |9080           |
|wlServerContext     |Vía de acceso de raíz de contexto de la aplicación en {{ site.data.keys.mf_server }}. |/mfp/          |
|languagePreferences |Establece el idioma predeterminado para los mensajes de sistema del SDK de cliente. |en             |

## Soporte para Javadoc y el servicio Android
{: #support-for-javadoc-and-android-service }
Para obtener información sobre el soporte para Javadoc y el servicio Android, consulte la página [Información adicional](additional-information).


## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }
Con {{ site.data.keys.product_adj }} Native SDK ahora integrado, podrá:


- Revisar las guías de aprendizaje de [Utilización de {{ site.data.keys.product }} SDK](../)
- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar las guías de aprendizaje de [Notificaciones](../../../notifications/) 
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
