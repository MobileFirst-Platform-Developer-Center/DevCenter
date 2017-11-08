---
layout: tutorial
title: Resolución de problemas
relevantTo: [ios,android,windows,javascript]
weight: 3
---
<!-- NLS_CHARSET=UTF-8 -->
### Resolución de problemas con {{ site.data.keys.product_full }} en el tiempo de ejecución de Liberty for Java	
{: resolving-problems-with-ibm-mobilefirst-foundation-on-liberty-for-java-runtime }
Cuando no pueda solucionar un problema que ha surgido cuando trabajaba con IBM MobileFirst Foundation en el tiempo de ejecución de Liberty for Java, asegúrese de recopilar esta información clave antes de contactar a IBM Support.

Para agilizar el proceso de resolución de problemas, recopile la información siguiente: 

* La versión de IBM MobileFirst Foundation que utiliza (debe ser V8.0.0 o superior) y cualquier arreglo temporal que se haya aplicado.
* El tamaño del tiempo de ejecución de Liberty for Java seleccionado. Por ejemplo, 2GB.
* El tipo de plan de base de datos Bluemix dashDB. Por ejemplo, Enterprise Transactional 2.8.500.
* La ruta mfpconsole 
* Versiones de Cloud Foundry: `cf -v` 
* La información devuelta por los siguientes mandatos de Cloud Foundry CLI ejecutados desde la organización y espacio en que se ha desplegado su servidor de MobileFirst Foundation: 
 - `cf app APP_NAME`

### No se ha podido crear el archivo mfpfsqldb.xml
{: #unable-to-create-the-mfpfsqldbxml-file }
Se produce un error al final de la ejecución del script **prepareserverdbs.sh**:

> Error: No se puede crear mfpfsqldb.xml

**Cómo se resuelve**  
Es posible que se trate de un problema intermitente de conexión de base de datos. Intente ejecutar de nuevo el script.

### El script falla y devuelve un mensaje relacionado con las señales 	
{: #script-fails-and-returns-message-about-tokens }
Un script no se ejecuta correctamente y devuelve un mensaje similar a: Renovando las señales o Ha fallado la renovación de la señal.

**Descripción**  
Es posible que se haya superado el tiempo de espera de la sesión Bluemix. El usuario debe haber iniciado sesión en Bluemix antes de ejecutar los scripts.

**Cómo se resuelve**
Vuelva a ejecutar el script initenv.sh para iniciar sesión en Bluemix y, a continuación, vuelva a ejecutar el script que ha fallado.

### La base de datos de administración, Live Update y Push Service se muestran como inactivos	
{: #administration-db-live-update-and-push-service-show-up-as-inactive }
La base de datos de administración, Live Update y Push Service se muestran como inactivos o no figura listado ningún tiempo de ejecución en MobileFirst Foundation Operations Console, a pesar de que el script **prepareserver.sh** se ha completado correctamente.

**Descripción**  
Es posible que no se haya podido establecer una conexión con el servicio de base de datos o que se haya producido un problema de formato en el archivo server.env cuando se han añadido valores adicionales durante el despliegue .

Si se han añadido valores adicionales al archivo server.env sin caracteres de nueva línea, las propiedades no se resuelven. Puede validar este problema potencial comprobando si hay errores en los archivos de registro debido a propiedades no resueltas similares a este error:

> FWLSE0320E: No se ha podido comprobar si los servicios de administración están preparados. Causa: [project Sample] java.net.MalformedURLException: Host anómalo: "${env.IP_ADDRESS}"

**Cómo se resuelve**  
Reinicie manualmente la aplicación Liberty. Si el problema persiste, compruebe si el número de conexiones con el servicio de base de datos supera el número de conexiones suministrado por su plan de base de datos. Si es así, realice los ajustes necesarios antes de continuar.

Si el problema es debido a propiedades no resueltas, asegúrese de que su editor añade el carácter de salto de línea (LF) para marcar el fin de una línea, cuando edite cualquier archivo suministrado. Por ejemplo, la aplicación TextEdit en macOS puede utilizar el carácter CR para marcar el final de la línea, en lugar de LF, lo que puede ser la causa del problema.

