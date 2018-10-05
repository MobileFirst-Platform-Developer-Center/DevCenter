---
layout: tutorial
title: Adición del SDK de MobileFirst Foundation a aplicaciones React Native
breadcrumb_title: React Native
relevantTo: [reactnative]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #overview }
En esta guía de aprendizaje, aprenderá a añadir el SDK de {{ site.data.keys.product_adj }} a una aplicación React Native nueva o existente, creada con la CLI de React Native. También aprenderá a configurar {{ site.data.keys.mf_server }} para que reconozca la aplicación, y a buscar información sobre los archivos de configuración de {{ site.data.keys.product_adj }} que se cambian en el proyecto.

El SDK de {{ site.data.keys.product_adj }} React Native se proporciona como un plug-in de npm de react native, que se registra en [NPM](https://www.npmjs.com/package/react-native-ibm-mobilefirst).  

Los plugins disponibles son:


* **react-native-ibm-mobilefirst** - El plug-in de SDK de núcleo

#### Ir a:
{: #jump-to }
- [Componentes del SDK de React Native](#react-native-sdk-components)
- [Adición del SDK de {{ site.data.keys.product_adj }} React Native](#adding-the-mobilefirst-react-native-sdk)
- [Actualización del SDK de {{ site.data.keys.product_adj }} React Native](#updating-the-mobilefirst-react-native-sdk)
- [Artefactos generados del SDK de {{ site.data.keys.product_adj }} React Native](#generated-mobilefirst-reactnative-sdk-artifacts)
- [Guías de aprendizaje con las que continuar](#tutorials-to-follow-next)


## Componentes del SDK de React Native
{: #react-native-sdk-components }
#### react-native-ibm-mobilefirst
{: #react-native-ibm-mobilefirst }
El plug-in react-native-ibm-mobilefirst es el plug-in de {{ site.data.keys.product_adj }} central para React Native y es necesario. Si instala cualquier otro plug-in de {{ site.data.keys.product_adj }}, también se instala automáticamente el plug-in react-native-ibm-mobilefirst en el caso de que todavía no lo esté.

**Requisitos previos:**

- [CLI de React Native](https://www.npmjs.com/package/react-native) y {{ site.data.keys.mf_cli }} están instalados en la estación de trabajo del desarrollador.
- Una instancia remota o local de {{ site.data.keys.mf_server }} que esté en ejecución.

- Lea las guías de aprendizaje [Configuración del entorno de desarrollo de {{ site.data.keys.product_adj }}](../../../installation-configuration/development/mobilefirst) y [Configuración del entorno de desarrollo de React Native](../../../installation-configuration/development/reactnative).

## Adición del SDK de {{ site.data.keys.product }} React Native
{: #adding-the-mobilefirst-react-native-sdk }
Siga las instrucciones siguientes para añadir el SDK de {{ site.data.keys.product }} React Native a un proyecto nuevo o existente de React Native, y regístrelo en {{ site.data.keys.mf_server }}.

Antes de empezar, asegúrese de que {{ site.data.keys.mf_server }} está en ejecución.
  
Si está utilizando un servidor instalado localmente: Desde una ventana de **línea de mandatos**, vaya a la carpeta del servidor y ejecute el mandato: `./run.sh`.

### Adición del SDK
{: #adding-the-sdk }

#### Nueva aplicación
{: #new-application }
1. Crear un proyecto de React Native: `react-native init projectName`.  
Por ejemplo:


   ```bash
   react-native init Hello
   ```
     - *Hello* es el nombre de carpeta y el nombre de la aplicación.

    El archivo **index.js** de la plantilla permite utilizar características de {{ site.data.keys.product_adj }} adicionales como, por ejemplo, la [traducción de aplicación multilingüe](../../translation) y opciones de inicialización (consulte la documentación del usuario para obtener más información).



2. Cambie el directorio a la raíz del proyecto de React Native: `cd hello`

3. Añada los plug-ins de MobileFirst utilizando el mandato de la CLI de NPM: `npm install react-native-plugin-name`
Por ejemplo:

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

   > El mandato anterior añade el plug-in del SDK de MobileFirst Core al proyecto de React native.


4. Enlace las bibliotecas del plugin ejecutando el mandato:

   ```bash
   react-native link
   ```

#### Aplicación existente
{: #existing-application }

1. Vaya a la raíz de su proyecto React Native existente y añada el plug-in de React Native central de {{ site.data.keys.product_adj }}:

   ```bash
   npm install react-native-ibm-mobilefirst
   ```

2. Enlace las bibliotecas del plugin ejecutando el mandato:

   ```bash
   react-native link
   ```

### Registro de la aplicación
{: #registering-the-application }

1. Abra una ventana **Línea de mandatos** y vaya a la raíz de la plataforma en concreto (iOS o Android) del proyecto.  

2. Registre la aplicación en {{ site.data.keys.mf_server }}:

   ```bash
   mfpdev app register
   ```

  * **iOS**:

    Si su plataforma es iOS, se le solicitará que proporcione el BundleID de la aplicación. **Importante**: El BundleID es **sensible a las mayúsculas y minúsculas**.


    El mandato de interfaz de línea de mandatos (CLI) `mfpdev app register` se conecta primero al MobileFirst Server para registrar la aplicación, a continuación genera el archivo **mfpclient.plist** en la raíz del proyecto Xcode y le añade los metadatos que identifican al MobileFirst Server.

  *  **Android**:

      Si su plataforma es Android, se le solicitará que proporcione el nombre del paquete de la aplicación. **Importante**: El nombre de paquete es **sensible a las mayúsculas y minúsculas**.

       El mandato de la CLI `mfpdev app register` se conecta primero al MobileFirst Server para registrar la aplicación y después genera el archivo **mfpclient.properties** en la carpeta **[raíz proyecto]/app/src/main/assets/** del proyecto Android Studio y para añadirlo en los metadatos que identifican al MobileFirst Server.


Si se utiliza un servidor remoto, [utilice el mandato ](../using-mobilefirst-cli-to-manage-mobilefirst-artifacts/#add-a-new-server-instance) `mfpdev server add` para añadirlo.


El mandato de CLI `mfpdev app register` primero se conecta al {{ site.data.keys.mf_server }} para registrar la aplicación. 	Cada plataforma se registra como una aplicación en {{ site.data.keys.mf_server }}.

> <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> **Sugerencia:** También es posible registrar aplicaciones desde {{ site.data.keys.mf_console }}:    
>
> 1. Cargue {{ site.data.keys.mf_console }}.  
> 2. Pulse el botón **Nuevo** junto a **Aplicaciones** para registrar una nueva aplicación y seguir las instrucciones en la pantalla.
  


## Actualización del SDK de {{ site.data.keys.product_adj }} React Native
{: #updating-the-mobilefirst-react-native-sdk }
Para actualizar el SDK de {{ site.data.keys.product_adj }} React native con el último release, elimine el plug-in **react-native-ibm-mobilefirst**: ejecute el mandato `npm uninstall react-native-ibm-mobilefirst` y, a continuación, ejecute el mandato `npm install react-native-ibm-mobilefirst` para añadirlo de nuevo.

Los releases de SDK se pueden encontrar en el [repositorio NPM ](https://www.npmjs.com/package/react-native-ibm-mobilefirst) de SDK.


## Artefactos generados del SDK de {{ site.data.keys.product_adj }} React Native
{: #generated-mobilefirst-reactnative-sdk-artifacts }

### Entorno Android

#### mfpclient.properties
{: #mfpclient.properties }
Ubicado en la carpeta **./app/src/main/assets/** del proyecto Android Studio, este archivo define las propiedades utilizadas del lado del cliente para registrar su aplicación Android en {{ site.data.keys.mf_server }}.


|Propiedad |Descripción |Valores de ejemplo |
|---------------------|---------------------------------------------------------------------|----------------|
|wlServerProtocol    |Protocolo de comunicación con {{ site.data.keys.mf_server }}.             |http o https  |
|wlServerHost        |Nombre de host de {{ site.data.keys.mf_server }}.                            |192.168.1.63   |
|wlServerPort        |Puerto de {{ site.data.keys.mf_server }}.                           |9080           |
|wlServerContext     |Vía de acceso de raíz de contexto de la aplicación en {{ site.data.keys.mf_server }}. |/mfp/          |
|languagePreferences |Establece el idioma predeterminado para los mensajes de sistema del SDK de cliente. |en             |


### Entorno iOS

#### mfpclient.plist
{: #mfpclientplist }
Ubicado en la raíz del proyecto, este archivo define las propiedades del lado del cliente utilizadas para registrar la aplicación iOS en {{ site.data.keys.mf_server }}.


|Propiedad |Descripción |Valores de ejemplo |
|---------------------|---------------------------------------------------------------------|----------------|
|protocol    |Protocolo de comunicación con {{ site.data.keys.mf_server }}.             |http o https  |
|host        |Nombre de host de {{ site.data.keys.mf_server }}.                            |192.168.1.63   |
|port        |Puerto de {{ site.data.keys.mf_server }}.                           |9080           |
|wlServerContext     |Vía de acceso de raíz de contexto de la aplicación en {{ site.data.keys.mf_server }}. |/mfp/          |
|languagePreferences |Establece el idioma predeterminado para los mensajes de sistema del SDK de cliente. |en             |


## Guías de aprendizaje con las que continuar 
{: #tutorials-to-follow-next }
Con el SDK de {{ site.data.keys.product_adj }} React Native ahora integrado, podrá:

- Revisar las guías de aprendizaje de [Utilización de {{ site.data.keys.product }} SDK](../)
- Revisar las guías de aprendizaje de [Desarrollo de adaptadores](../../../adapters/)
- Revisar las guías de aprendizaje de [Autenticación y seguridad](../../../authentication-and-security/)
- Revisar las guías de aprendizaje de [Notificaciones](../../../notifications/) 
- Revisar [Todas las guías de aprendizaje](../../../all-tutorials)
