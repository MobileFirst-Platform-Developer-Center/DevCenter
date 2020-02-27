---
layout: tutorial
title: Resolución de problemas
weight: 19
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Visión general
{: #troubleshooting }

Encuentre respuestas para algunos de los problemas que puede encontrar al utilizar IBM Digital App Builder.

* En caso de un error, consulte: 

    * El archivo `log.log` en la vía de acceso de la carpeta de la plataforma respectiva: 

        * En mac OS: `~/Library/Logs/IBM Digital App Builder/log.log`.

        * En Windows: `%USERPROFILE%\AppData\Roaming\IBM Digital App Builder\log.log`.

    * `applog.log` para los registros relacionados con la aplicación que se pueden encontrar en `<APP LOCATION>/ibm/applog.log`. 

* No se ha podido crear un conjunto de datos para un microservicio utilizando un archivo swagger.

    Para los usuarios que utilizan por primera vez Builder, la creación del microservicio podría fallar debido a la latencia de red.
    Para evitarlo, siga estos pasos:
    1. Abra el indicador de mandatos y vaya a la ubicación instalada de la aplicación.
    2. `cd ibm\adapterGenerator`
    3. Ejecute el siguiente mandato
        `windows> execute.bat .`
        `mac>./execute.sh .`
    4. Después de ejecutar con éxito el mandato anterior, puede empezar a utilizar el microservicio (archivo swagger) desde Digital App Builder. 

* No se ha podido obtener una vista previa de la aplicación en Windows.

    En Digital App Builder, vaya a **Parámetros > Reparar proyecto** y pulse los botones **Reconstruir dependencias** y **Reconstruir plataformas**. 

* La aplicación de android no funciona después de añadir el componente de Lista a la aplicación. 

    Esto se debe a que la versión de Android WebView es inferior a 68.X.XXXX.XX. Para resolver esto, actualice la versión de Android WebView a 68.X.XXXX.XX o superior. 

* En MacOS, la vista previa de la aplicación en un simulador de Android falla y la aplicación se cuelga. Con el siguiente error:

    `java.lang.RuntimeException: No se ha podido crear la aplicación com.ibm.MFPApplication: java.lang.RuntimeException: No se ha encontrado el archivo mfpclient.properties en los activos de la aplicación. Utilice el mandato MFP CLI 'mfpdev app register' para crear el archivo.`

    Para resolver esto, desde el terminal vaya al directorio ionic de la aplicación y ejecute los mandatos siguientes: 

    `ionic cordova plugin remove cordova-plugin-mfp
    ionic cordova plugin add cordova-plugin-mfp`

    y obtenga de nuevo una vista previa desde Digital App Builder. 

* No se ha podido generar el adaptador al importar el archivo json/yaml swagger. 

    Se produce un error al importar el archivo json/yaml swagger y el error se debe a una dependencia de Maven.

    En principio, todas las dependencias Maven se descargan si no existen y se instalan en un segundo plano. Sin embargo, a veces, Maven falla debido a que conviven varias versiones de Maven en el sistema. Para resolver este problema, siga estos pasos: 

    a. Vaya a la ubicación de la aplicación y abra execute.sh / execute.bat dependiendo del SO. (`<APP_LOCATION>\ibm\adapterGenerator`)

    b. Cambie todas las `call %MAVEN_HOME% clean install` a `call %MAVEN_HOME% -U clean install`.

        Añadir `-U` forzará a maven a que compruebe todas las dependencias externas que sea necesario actualizar en base al archivo POM. 

* La comprobación de requisitos previos falla para Android Studio aunque esté instalado. 

    Asegúrese de que tiene el ejecutable de android (`<path to android sdk>/tools`) en la vía de acceso y compruebe los requisitos previos. 

* Problema de creación de app y de vista previa en Windows 7

    Es posible que reciba un error al intentar crear una app nueva en una ubicación de disco duro distinta de `C:`.

    Asegúrese de crear el proyecto de la app bajo la unidad `C://<your folder name/app name>`.

* Digital App Builder se bloquea con la pantalla en rojo. 

    Si observa un bloqueo con una pantalla en rojo, consulte los registros en esta ubicación: 
    * En MacOS- `/Users/<username>/Library/Logs/IBM Digital App Builder/log.log`
    * En Windows - `C:\\Users\<username>\AppData\Roming\IBM Digital App Builder\log.log`

    Si el error está relacionado con un `getPath` de `rendered.js`,
se considera un [problema de electrón](https://github.com/electron/electron/issues/8205).

    Esto sucede de forma aleatoria. 

    Reinicie Digital App Builder y su caso de uso deberá funcionar. 
