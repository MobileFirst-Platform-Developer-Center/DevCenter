---
layout: tutorial
title: Protección de aplicaciones Cordova
breadcrumb_title: Securing applications
relevantTo: [cordova]
weight: 1
---
<!-- NLS_CHARSET=UTF-8 -->
### Cifrado de recursos web de sus paquetes Cordova
{: #encrypting-the-web-resources-of-your-cordova-packages }
Para minimizar el riesgo que un tercero visualice y modifique sus recursos web mientras están en el paquete .apk o .ipa, utilice el mandato {{ site.data.keys.mf_cli }} `mfpdev app webencrypt` o el distintivo `mfpwebencrypt` para cifrar la información.
Este procedimiento no proporciona un cifrado inviolable, pero sí proporciona un nivel básico de enmascaramiento.


**Requisitos previos:**

* Las herramientas de desarrollo de Cordova deben estar instaladas.
Este ejemplo utiliza la interfaz de línea de mandatos (CLI) de Cordova.
Si utiliza otras herramientas de desarrollo de Cordova, algunos de sus pasos serán diferentes.
Consulte la documentación de su herramienta de Cordova para obtener instrucciones.

* {{ site.data.keys.mf_cli }} debe estar instalado. 
* El plugin in de Cordova {{ site.data.keys.product_adj }} debe estar instalado.

El mejor momento para completar este procedimiento es al finalizar el desarrollo de su aplicación y antes de desplegarla.
Si ejecuta cualquiera de los siguientes mandatos después de completar el procedimiento de cifrado de los recursos web, el contenido que estaba cifrado pasará a estar descifrado:


* cordova prepare
* cordova build
* cordova run
* cordova emulate
* mfpdev app webupdate
* mfpdev app preview

Si ejecuta alguno de los mandatos de la lista después de cifrar los recursos web, debe completar este procedimiento de nuevo para cifrar los recursos web.


1. Abra una ventana de terminal y vaya al directorio raíz de la aplicación Cordova que desea cifrar.

2. Prepare la aplicación especificando uno de los siguientes mandatos:

    - cordova prepare
    - mfpdev app webupdate
3. Complete uno de los siguientes procedimientos para cifrar el contenido:

    - Especifique el siguiente mandato: `mfpdev app webencrypt`. **Sugerencia:** Visualice información sobre el mandato `mfpdev app webencrypt` especificando `mfpdev help app webencrypt`.

    - Los recursos web de sus paquetes de Cordova también se pueden cifrar añadiendo el distintivo `mfpwebencrypt` al mandato `cordova compile` o `cordova build` al compilar sus paquetes.

        - `cordova compile -- --mfpwebencrypt` | `cordova build -- --mfpwebencrypt`
    <br/>
La información sobre el sistema operativo en la carpeta **www**
se sustituye por un archivo **resources.zip** que contiene el contenido cifrado.
  
Si su aplicación está dirigida al sistema operativo Android y el archivo **resources.zip** es mayor de 1 MB, el archivo **resources.zip** se divide en archivos .zip de 768 KB más pequeños denominados **resources.zip.nnn**.
La variable nnn es un número de 001 a 999.
4. Pruebe la aplicación con los recursos cifrados mediante el emulador que se proporciona con las herramientas específicas de la plataforma.
Por ejemplo, se puede utilizar el emulador en Android Studio para Android o Xcode para iOS.

**Nota:** No utilice los siguientes mandatos Cordova para probar la aplicación después de cifrarla:


* `cordova run`
* `cordova emulate`

Estos mandatos renuevan el contenido cifrado en la carpeta www y lo guardan de nuevo como contenido descifrado.
Si utiliza estos mandatos, recuerde completar el procedimiento de nuevo para cifrar antes de publicar la aplicación.


### Habilitación de la característica de suma de comprobación de recursos web
{: #enabling-the-web-resources-checksum-feature }
Cuando se habilita, la característica de suma de comprobación de recursos web compara los recursos web originales de una aplicación cuando se inicia con una línea base almacenada que se capturó la primera vez que se inicio la aplicación.
Es una buena forma de identificar diferencias en la aplicación que podrían indicar que ha sido modificada.
Este procedimiento es compatible con la característica Direct Update.


**Requisitos previos:**

* Las herramientas de desarrollo de Cordova deben estar instaladas.
Este ejemplo utiliza la interfaz de línea de mandatos (CLI) de Cordova.
Si utiliza otras herramientas de desarrollo de Cordova, algunos de sus pasos serán diferentes.
Consulte la documentación de su herramienta de Cordova para obtener instrucciones.

* {{ site.data.keys.mf_cli }} debe estar instalado. 
* El plugin {{ site.data.keys.product_adj }} debe estar instalado. 
* Debe añadir la plataforma a su proyecto de Cordova antes de habilitar la característica de suma de comprobación de recursos web para el sistema operativo especificando el mandato `cordova platform add [android|ios|windows|browser]`.


Para habilitar la característica de suma de comprobación para una aplicación de Cordova, complete los siguientes pasos: 

1. En una ventana de terminal, vaya al directorio raíz de su aplicación de destino. 
2. Especifique el mandato siguiente para habilitar la característica de suma de comprobación de recursos web para un entorno de sistema operativo de su aplicación Cordova:


   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_test_web_resources_checksum true
   ```

   Por ejemplo:

  

   ```bash
   mfpdev app config android_security_test_web_resources_checksum true
   ```

   Inhabilite la característica sustituyendo **true** en el mandato por **false**.


   > **Sugerencia:** Visualice información sobre el mandato `mfpdev app config` especificando `mfpdev help app config`.


3. Especifique el siguiente mandato para identificar los tipos de archivo que desea ignorar durante la prueba de suma de comprobación:


   ```bash
   mfpdev app config [android|ios|windows10|windows8|windowsphone8]_security_ignore_file_extensions [ file_extension1,file_extension2 ]
   ```

   Separe las distintas extensiones con una coma y sin espacios entre las mismas.
Por ejemplo:



   ```bash
   mfpdev app config android_security_ignore_file_extensions jpg,png,pdf
   ```

**Importante:** Al ejecutar este mandato se sobrescriben los valores establecidos.


Cuantos más archivos tenga que explorar la suma de comprobación de recursos web en su prueba, más tardará en abrirse la aplicación.
Tiene la posibilidad de especificar la extensión de un tipo de archivo para omitirla, lo que podría mejorar el tiempo en que tarda en iniciarse la aplicación.


Su aplicación tiene la característica de suma de comprobación de recursos web.


1. Ejecute el mandato siguiente para integrar los cambios en la aplicación: `cordova prepare`
2. Compile la aplicación especificando el siguiente mandato: `cordova build`
3. Ejecute la aplicación especificando el siguiente mandato: `cordova run`
