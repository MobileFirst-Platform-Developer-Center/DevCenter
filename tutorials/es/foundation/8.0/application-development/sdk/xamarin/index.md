---
layout: tutorial
title: Adición del SDK de MobileFirst Foundation a aplicaciones Xamarin
breadcrumb_title: Xamarin
relevantTo: [xamarin]
weight: 6
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
El producto {{ site.data.keys.product }} SDK está formado por un conjunto de dependencias que están disponibles a través de [Xamarin Component Store](https://components.xamarin.com/) y que puede añadir a su proyecto de Xamarin.
  
Los pods corresponden a funciones principales y a otras funciones:


* **MobileFirst.Xamarin** - Implementa la conectividad de cliente a servidor, maneja la autenticación y los aspectos de seguridad, solicitudes de recursos y otras funciones básicas necesarias.

* **MobileFirst.JSONStore** - Contiene la infraestructura de JSONStore.   
* **MobileFirst.Push** - Contiene la infraestructura de notificaciones push.
Para obtener más información, revise las [guías de aprendizajes de notificaciones](../../../notifications/).

En esta guía de aprendizaje aprenderá a añadir {{ site.data.keys.product_adj }} Native SDK mediante Xamarin Component Store a una aplicación iOS o Xamarin Android nueva o existente.
También aprenderá a configurar {{ site.data.keys.mf_server }} para que reconozca la aplicación.


**Requisitos previos:**

- Xamarin Studio instalado en la estación de trabajo del desarrollador.
  
- Una instancia remota o local de {{ site.data.keys.mf_server }} que esté en ejecución.

- Lea las guías de aprendizaje [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/development/) y [Configuración del entorno de desarrollo de Xamarin](../../../installation-configuration/development/xamarin/).


#### Ir a:
{: #jump-to }
- [Adición de {{ site.data.keys.product_adj }} Native SDK](#adding-the-mobilefirst-native-sdk)
- [Actualización de {{ site.data.keys.product_adj }} Native SDK](#updating-the-mobilefirst-native-sdk)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)

## Adición de {{ site.data.keys.product_adj }} Native SDK
{: #adding-the-mobilefirst-native-sdk }
Siga las instrucciones que hay más abajo para añadir {{ site.data.keys.product_adj }} Native SDK a un proyecto de Xcode nuevo o existente y para registrar la aplicación para {{ site.data.keys.mf_server }}.


Antes de empezar, asegúrese de que {{ site.data.keys.mf_server }} está en ejecución.
  
Si está utilizando un servidor instalado localmente: Desde una ventana de **línea de mandatos**, vaya a la carpeta del servidor y ejecute el mandato: `./run.sh`.

### Creación de una aplicación
{: #creating-an-application }
Cree una solución Xamarin mediante Xamarin Studio, Visual Studio o utilice uno que ya exista.


### Adición del SDK
{: #adding-the-sdk }
1. {{ site.data.keys.product_adj }} Native SDK se proporciona a través de Xamarin Components Store.

2. Expanda el proyecto Android o iOS.

3. En el proyecto Android o iOS, pulse con el botón derecho del ratón sobre **Componentes**.
4. Seleccione **Obtener más componentes**. ![Add-XamarinSDK-tosolution-search](Add-Xamarin-tosolution.png)
5. Busque **IBM MobileFirst SDK**. Cierre y complete **Añadir a aplicación**.
![Add-XamarinSDK-tosolution](Add-XamarinSDK-toApp.png)
6. Pulse con el botón derecho del ratón sobre **Paquetes** y seleccione **Añadir paquetes**. Busque y añada **Json.NET**.
Obtendrá la dependencia Newtonsoft desde Nuget. Esto se debe realizar de forma separada tanto para los proyectos Android como iOS.

7. Pulse con el botón derecho del ratón sobre **Referencias** y seleccione **Editar referencias**.
Vaya al separador **.Net Assembly** y pulse 'Examinar'.
Desde la raíz de las carpetas del proyecto, vaya a `Components -> ibm-worklight-8.0.0.1 -> lib -> pcl`.
Seleccione **Worklight.Core.dll**.

### Registro de la aplicación
{: #registering-the-application }
1. Cargue {{ site.data.keys.mf_console }}.
2. Pulse el botón Nuevo junto a Aplicaciones para registrar una nueva aplicación y seguir las instrucciones en la pantalla.

3. Las aplicaciones Android e iOS se deben registrar de forma independiente.
Así se asegura que tanto la aplicación Android como la aplicación iOS se pueden conectar de forma satisfactoria al servidor.
Los detalles de registro para las aplicaciones Android e iOS se pueden entrar en `AndroidManifest.xml` e `Info.plist` respectivamente.

3. Después de que se registre la aplicación, vaya al separador de Archivos de configuración y copie o descargue los archivos mfpclient.plist y mfpclient.properties.
Siga las instrucciones en la pantalla para añadir el archivo al proyecto.



### Completar el proceso de configuración
{: #completing-the-setup-process }
#### mfpclient.plist
{: #complete-setup-mfpclientplist }
1. Pulse con el botón derecho del ratón sobre el proyecto Xamarin iOS y seleccione **Añadir archivos...**. Navegue hasta encontrar `mfpclient.plist` para añadirlo a la raíz del proyecto.
Elija **Copiar archivo a proyecto** si así se le solicita. 
2. Pulse con el botón derecho sobre el archivo `mfpclient.plist` y seleccione **Acción de compilación**. Elija **Contenido**.

#### mfpclient.properties
{: #mfpclientproperties }
1. Pulse con el botón derecho del ratón sobre la carpeta de *Activos* del proyectoXamarin Android y seleccione **Añadir archivos...**. Navegue hasta encontrar `mfpclient.properties` para la carpeta.
Elija **Copiar archivo a proyecto** si así se le solicita. 
2. Pulse con el botón derecho sobre el archivo `mfpclient.properties` y seleccione **Acción de compilación**. Elija **Activo Android**.

### Cómo hacer referencia al SDK
{: #referencing-the-sdk }
Siempre que utilice el {{ site.data.keys.product_adj }} Native SDK, asegúrese de importar la infraestructura de {{ site.data.keys.product }}:


CommonProject:

```csharp
using Worklight;
```

iOS:

```csharp
using MobileFirst.Xamarin.iOS;
```

Android:

```csharp
using Worklight.Xamarin.Android;
```

## Actualización de {{ site.data.keys.product_adj }} Native SDK
{: #updating-the-mobilefirst-native-sdk }
Para actualizar {{ site.data.keys.product_adj }} Native SDK con el último release, actualice la versión del SDK a través de Xamarin Components Store.


## Artefactos de {{ site.data.keys.product_adj }} Native SDK generados
{: #generated-mobilefirst-native-sdk-artifacts }
### mfpclient.plist
{: #mfpclientplist }
Este archivo define las propiedades del lado del cliente utilizadas para registrar la aplicación iOS en {{ site.data.keys.mf_server }}.


| Propiedad | Descripción | Valores de ejemplo |
|---------------------|---------------------------------------------------------------------|----------------|
| protocol    | Protocolo de comunicación con {{ site.data.keys.mf_server }}.             | http o https  |
| host        | Nombre de host de {{ site.data.keys.mf_server }}.                            | 192.168.1.63   |
| port        | Puerto de {{ site.data.keys.mf_server }}.                           | 9080           |
| wlServerContext     | Vía de acceso de raíz de contexto de la aplicación en {{ site.data.keys.mf_server }}. | /mfp/          |
| languagePreferences | Establece el idioma predeterminado para los mensajes de sistema del SDK de cliente. | en             |

## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }
Con {{ site.data.keys.product_adj }} Native SDK ahora integrado, podrá:


- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar las guías de aprendizaje de [Notificaciones](../../../notifications/) 
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
